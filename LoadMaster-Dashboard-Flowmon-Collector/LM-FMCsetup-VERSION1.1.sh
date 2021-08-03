#!/usr/bin/bash
# Version: 1.1
# (c) Copyright 2021 Kemp Technologies Inc. All Rights Reserved.
#
# A script that can set up a light-weight Collector configuration that
# monitors a demo web server VS in a default one-armed LM deployment.
# I.e.: a sales demo for someone who just downloaded LM & FMC and wants to
# see them "in action".
#
# NOTE: Script was created and tested on an Ubuntu on Windows 10 deployment:
#    https://www.microsoft.com/en-us/p/ubuntu/9nblggh4msv6?activetab=pivot:overviewtab
# Added to the running ubuntu on windows was the "jq" utility, which is used to
# manipulate JSON:
#    sudo apt-get update -y
#    sudo apt-get install -y jq
#

#
# Process the JSON input file (REQUIRED)
# File MUST be in the same directory from which the script is being run.
#

InputFile=FMCdata.json

JsonIn=`cat $InputFile`
echo;echo "# Kemp Automated LoadMaster Dashboard Installer for Flowmon Collector."
echo;echo "### Processing the LoadMaster Virtual Service data from" $InputFile "..."

#
# Assign the input data to variables
#
LMip4collector=`echo $JsonIn | jq -r .LMip4collector`
LMport4collector=`echo $JsonIn | jq -r .LMport4collector`
LMhostname=`echo $JsonIn | jq -r .LMhostname`
FMCip=`echo $JsonIn | jq -r .FMCip`

# get number of VSs
NumVSs=`echo $JsonIn | jq -r '.VirtualServices | select(.!=null) | length'`

### BEGIN the VS processing loop
# loop thru the VS data VS-by-VS
# !!! JSON ARRAYS ARE NUMBERED STARTING AT ZERO (0) !!!

i=0
while [[ $i -lt $NumVSs ]]; do
	# get the VS data
	declare "VS${i}extip=`echo $JsonIn | jq -r --argjson i $i '.VirtualServices[$i].VSextip'`"
	var="VS${i}extip";echo;echo "VS${i}extip=" "${!var}"
	declare "VS${i}extport=`echo $JsonIn | jq -r --argjson i $i '.VirtualServices[$i].VSextport'`"
	declare "VS${i}intip=`echo $JsonIn | jq -r --argjson i $i '.VirtualServices[$i].VSintip'`"
	declare "VS${i}intport=`echo $JsonIn | jq -r --argjson i $i '.VirtualServices[$i].VSintport'`"
	declare "VS${i}clientip=`echo $JsonIn | jq -r --argjson i $i '.VirtualServices[$i].VSclientexpr'`"
	declare "VS${i}AppName=`echo $JsonIn | jq -r --argjson i $i '.VirtualServices[$i].AppName'`"

	# get the number of Real Servers (RSs)
	NumRSs=`echo $JsonIn | jq -r --argjson i $i '.VirtualServices[$i].Servers | select(.!=null) | length'`
	echo $NumRSs "Servers in VS:" 

	# loop thru the RS data RS-by-RS
	# one-liner echo: i=1;var="RS${i}ip";echo "RS${i}ip=" "${!var}"
	j=0
	while [[ $j -lt $NumRSs ]]; do
		declare "RS${j}ip=`echo $JsonIn | jq -r --argjson i $i --argjson j $j '.VirtualServices[$i].Servers[$j].ip'`"
		var="RS${j}ip";echo "RS${j}ip=" "${!var}"
		declare "RS${j}port=`echo $JsonIn | jq -r --argjson i $i --argjson j $j '.VirtualServices[$i] | .Servers[$j] | .port'`"
		j=`expr $j + 1`
	done
	i=`expr $i + 1`
done

#
# Manage API Tokens
# 3 OPTIONS BELOW: new, refresh, saved
#
while getopts "t:" opt; do
  case "$opt" in
    t )
       case "$OPTARG" in
	    new )
		echo;echo "Getting New API Token..."
		# Get the token originally:
		# Return: {"access_token":"<TOKEN>","expires_in":86400,"token_type":"bearer","refresh_token":"<REFRESH_TOKEN>"}
		# save output to file for later use
		GetTokenCmd='eval curl https://$FMCip/resources/oauth/token -k -s -d "grant_type=password" -d "client_id=invea-tech" -d "username=admin" -d "password=admin"'
		GetTokenOut=`$GetTokenCmd`
		token=`echo $GetTokenOut | jq .access_token | tr -d '"'`
		echo "Token:" $token
		echo $GetTokenOut > FMC-API-TokenInfo.txt
		;;
    	   refresh )
		echo;echo "Refreshing Existing API Token..."
		# Renew existing token (auth not required again):
		# Return: Same as above
		# save output to file for later use
		RefreshToken=`cat FMC-API-TokenInfo.txt | jq .refresh_token | tr -d '"'`
		RenewTokenOut=`eval curl -s -k -X POST -d "grant_type=refresh_token" -d "refresh_token=$RefreshToken" -d "client_id=invea-tech" https://$FMCip/resources/oauth/token`
		token=`echo $RenewTokenOut | jq .access_token | tr -d '"'`
		echo "Token:" $token
		echo $RenewTokenOut > FMC-API-TokenInfo.txt
		;;
    	   saved )
		echo;echo "Using Saved API Token..."
		# Use a token taken from the saved file (see above):
		# File must be a json format string like this:
		# {"access_token":"<TOKEN>","expires_in":86400,"token_type":"bearer","refresh_token":"<REFRESH_TOKEN>"}
		token=`cat FMC-API-TokenInfo.txt | jq .access_token | tr -d '"'`
		echo "Token:" $token
		;;
	   * )
		echo "Error: Invalid option argument."
		exit
		;;
       esac
       ;;
    * )
       echo "Error: Invalid option."
       exit
       ;;
  esac
done

#
# Set Beginning of curl cmdline
#
cmdlinebegin="curl -k -s -H 'Authorization: bearer $token' -H 'accept: application/json' -H 'Content-Type: application/json' "

# Get the LM channel ID from the "Total traffic" profile (always there on FMC)
# This is required to create the Profile for each VS
# FAIL if we cannot get this
LMsourcechannel=`eval $cmdlinebegin https://$FMCip/rest/fmc/profiles/id?id=live | jq -r '.channels | .[] | select(.name|test("'$LMip4collector'")) | .id'`
if [[ -z $LMsourcechannel ]]; then
	echo "Could not get LM source channel for IP address $LMip4collector from the 'live' Profile on Collector; try again later."
	echo "LM Source Channel=" $LMsourcechannel
	echo;exit
else
	echo;echo "LM Source Channel=" $LMsourcechannel
fi

#
# Create the LoadMaster Device Dashboard
#
# Add a new dashboard in the first position for the LM itself; two widgets:
# connection widget (just for LM) and overall traffic (all VSs, etc.)
#
echo "###"
echo "### Create LoadMaster Device Dashboard..."
echo "###"
createdb2cmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"name\":\"LoadMaster ($LMhostname)\",\"tenant\":{\"id\":\"00000000-0000-0000-0001-000000000001\",\"name\":\"Base tenant\"}}}' https://$FMCip/rest/fmd/overview/dashboards"
createdb2out=`$createdb2cmd`
# echo;echo $createdb2cmd
# echo;echo $createdb2out
# get its ID from the cmd output
db2id=`echo $createdb2out | jq -r .id`
db2name=`echo $createdb2out | jq -r .name`
echo;echo "Dashboard Name & ID:" $db2name $db2id

# Make DB2 visible
echo "### Make new dashboard visible..."
makedb2vizcmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"dashboard\":{\"id\":\"$db2id\",\"name\":\"$db2name\",\"isReadOnlyForCurrentUser\":false,\"canBeSetAsPredefinedByUser\":true,\"isAvailableToOtherUsers\":true},\"observingUser\":{\"id\":1,\"login\":\"admin\"},\"order\":0}}' https://$FMCip/rest/fmd/overview/displayed-dashboards"
makedb2vizout=`$makedb2vizcmd`
# echo $makedb2vizcmd
# echo $makedb2vizout
visibleDB2id=`echo $makedb2vizout | jq .id`
echo "Visible DB ID:" $visibleDB2id

# Add Source Connections Widget 
AddLMSrcConnWidgetCmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"dashboard\":{\"id\":\"$db2id\",\"name\":\"$db2name\"},\"options\":{\"name\":\"Sources\",\"clazz\":\"ConnectionsWidget\",\"dataEndpoint\":\"fmc_connectedInterfaces\",\"visualizationSettings\":[{\"index\":0,\"settings\":{\"channel\":\"connectionsStatus\",\"connectionsSettings\":\"todo connections settings at FormService\"},\"channelName\":\"connectionsStatus\"}],\"parametersSettings\":[{\"name\":\"from\",\"value\":\"h12Ago\",\"show\":false,\"relativeToForm\":false,\"useDefault\":1},{\"name\":\"to\",\"value\":\"now\",\"show\":false,\"relativeToForm\":false,\"useDefault\":1}],\"_isNico\":true},\"layouts\":{\"lg\":{\"x\":7,\"y\":0,\"w\":2,\"h\":13,\"i\":null,\"minW\":2,\"minH\":7},\"md\":{\"x\":7,\"y\":0,\"w\":2,\"h\":13,\"i\":null,\"minW\":2,\"minH\":7},\"sm\":{\"x\":0,\"y\":0,\"w\":3,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"xs\":{\"x\":0,\"y\":0,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":0,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
AddLMSrcConnWidgetOut=`$AddLMSrcConnWidgetCmd`
# echo;echo "AddLMSrcConnWidgetCmd:" $AddLMSrcConnWidgetCmd
# echo;echo "AddLMSrcConnWidgetOut:" $AddLMSrcConnWidgetOut
LMSrcConnWidgetID=`echo $AddLMSrcConnWidgetOut | jq -r '.id'`
echo "LMSrcConn Widget ID:" $LMSrcConnWidgetID
# PUT coordinates so they actually take effect!
ModifyLMSrcConnWidgetCmd="eval $cmdlinebegin -X PUT -d '{\"entity\":{\"id\":\"$LMSrcConnWidgetID\",\"layouts\":{\"lg\":{\"x\":7,\"y\":0,\"w\":2,\"h\":13,\"i\":\"$LMSrcConnWidgetID\",\"minW\":2,\"minH\":7},\"md\":{\"x\":4,\"y\":0,\"w\":6,\"h\":14,\"i\":\"$LMSrcConnWidgetID\",\"minW\":2,\"minH\":7},\"sm\":{\"x\":3,\"y\":0,\"w\":3,\"h\":8,\"i\":\"$LMSrcConnWidgetID\",\"minW\":2,\"minH\":7},\"xs\":{\"x\":2,\"y\":0,\"w\":2,\"h\":8,\"i\":\"$LMSrcConnWidgetID\",\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":8,\"w\":2,\"h\":8,\"i\":\"$LMSrcConnWidgetID\",\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
ModifyLMSrcConnWidgetOut=`$ModifyLMSrcConnWidgetCmd`

# Add All Traffic going thru the LM Widget
GetOverallTrafficChapterIDCmd="eval $cmdlinebegin https://$FMCip/rest/fmc/chapters | jq -r '.[] | select(.name == \"Structure of Overall Traffic\") | .id'"
OverallTrafficChapterID=`$GetOverallTrafficChapterIDCmd`
AddAllLMTrafficWidgetCmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"dashboard\":{\"id\":\"$db2id\",\"name\":\"$db2name\"},\"options\":{\"name\":\"LoadMaster Traffic Structure\",\"clazz\":\"TimeSeriesAndTableWidget\",\"dataEndpoint\":\"fmc_chapter_$OverallTrafficChapterID\",\"visualizationSettings\":[{\"index\":0,\"settings\":{\"channel\":\"traffic\",\"series\":\"*\",\"chartOptions\":{\"stacked\":true,\"axis\":\"linear\"}},\"channelName\":\"traffic\"},{\"index\":1,\"settings\":{\"channel\":\"main\",\"percents\":false,\"colorColumn\":true,\"columns\":[\"chapter${OverallTrafficChapterID}col\",\"mbps\",\"95bps\",\"bps\",\"95ibyt\",\"ibyt\"],\"summaries\":[\"total\"]},\"channelName\":\"main\"}],\"parametersSettings\":[{\"name\":\"aggregation\",\"value\":null,\"show\":false,\"relativeToForm\":false,\"useDefault\":1},{\"name\":\"from\",\"value\":\"h12Ago\",\"show\":true,\"relativeToForm\":false,\"useDefault\":false},{\"name\":\"to\",\"value\":\"now\",\"show\":false,\"relativeToForm\":false,\"useDefault\":1}],\"_isNico\":true},\"layouts\":{\"lg\":{\"x\":0,\"y\":0,\"w\":7,\"h\":13,\"i\":null,\"minW\":2,\"minH\":7},\"md\":{\"x\":4,\"y\":0,\"w\":6,\"h\":14,\"i\":null,\"minW\":2,\"minH\":7},\"sm\":{\"x\":0,\"y\":0,\"w\":7,\"h\":13,\"i\":null,\"minW\":2,\"minH\":7},\"xs\":{\"x\":2,\"y\":0,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":8,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
AddAllLMTrafficWidgetOut=`$AddAllLMTrafficWidgetCmd`
# echo;echo "AddAllLMTrafficWidgetCmd:" $AddAllLMTrafficWidgetCmd
# echo;echo "AddAllLMTrafficWidgetOut:" $AddAllLMTrafficWidgetOut
AllLMTrafficWidgetID=`echo $AddAllLMTrafficWidgetOut | jq -r '.id'`
echo "All LM Traffic Widget ID:" $AllLMTrafficWidgetID
# PUT coordinates so they actually take effect!
ModifyAllLMTrafficWidgetCmd="eval $cmdlinebegin -X PUT -d '{\"entity\":{\"id\":\"$AllLMTrafficWidgetID\",\"layouts\":{\"lg\":{\"x\":0,\"y\":0,\"w\":7,\"h\":13,\"i\":\"$AllLMTrafficWidgetID\",\"minW\":2,\"minH\":7},\"md\":{\"x\":4,\"y\":0,\"w\":6,\"h\":14,\"i\":\"$AllLMTrafficWidgetID\",\"minW\":2,\"minH\":7},\"sm\":{\"x\":0,\"y\":0,\"w\":7,\"h\":13,\"i\":\"$AllLMTrafficWidgetID\",\"minW\":2,\"minH\":7},\"xs\":{\"x\":2,\"y\":0,\"w\":2,\"h\":8,\"i\":\"$AllLMTrafficWidgetID\",\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":8,\"w\":2,\"h\":8,\"i\":\"$AllLMTrafficWidgetID\",\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
ModifyAllLMTrafficWidgetOut=`$ModifyAllLMTrafficWidgetCmd`
# echo "ModifyAllLMTrafficWidgetOut=" $ModifyAllLMTrafficWidgetOut

# Add Hosts with Top Flows Widget
GetLiveChapterIDCmd="eval $cmdlinebegin https://$FMCip/rest/fmc/chapters | jq -r '.[] | select(.name == \"Hosts with Top Flows\") | .id'"
LiveChapterID=`$GetLiveChapterIDCmd`
AddHostsWithTopFlowsWidgetCmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"dashboard\":{\"id\":\"$db2id\",\"name\":\"$db2name\"},\"options\":{\"name\":\"Hosts with Top Flows\",\"clazz\":\"TwoPiesAndTableWidget\",\"dataEndpoint\":\"fmc_chapter_$LiveChapterID\",\"visualizationSettings\":[{\"index\":0,\"settings\":{\"channel\":\"main\",\"metric\":\"fl\",\"subject\":\"ip\",\"summaries\":[]},\"channelName\":\"main\"},{\"index\":1,\"settings\":{\"channel\":\"main\",\"metric\":\"fl\",\"summaries\":[\"bl\",\"sum\"]},\"channelName\":\"main\"},{\"index\":2,\"settings\":{\"channel\":\"main\",\"percents\":false,\"colorColumn\":true,\"columns\":[\"ip\",\"fl\"],\"summaries\":[\"bl\",\"sum\"]},\"channelName\":\"main\"}],\"parametersSettings\":[{\"name\":\"from\",\"value\":\"h12Ago\",\"show\":true,\"relativeToForm\":false,\"useDefault\":false},{\"name\":\"to\",\"value\":\"now\",\"show\":false,\"relativeToForm\":false,\"useDefault\":1}],\"_isNico\":true},\"layouts\":{\"lg\":{\"x\":9,\"y\":0,\"w\":3,\"h\":13,\"i\":null,\"minW\":2,\"minH\":7},\"md\":{\"x\":4,\"y\":0,\"w\":6,\"h\":14,\"i\":null,\"minW\":2,\"minH\":7},\"sm\":{\"x\":0,\"y\":0,\"w\":7,\"h\":13,\"i\":null,\"minW\":2,\"minH\":7},\"xs\":{\"x\":2,\"y\":0,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":8,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
AddHostsWithTopFlowsWidgetOut=`$AddHostsWithTopFlowsWidgetCmd`
# echo;echo "AddHostsWithTopFlowsWidgetCmd:" $AddHostsWithTopFlowsWidgetCmd
# echo;echo "AddHostsWithTopFlowsWidgetOut:" $AddHostsWithTopFlowsWidgetOut
HostsWithTopFlowsWidgetID=`echo $AddHostsWithTopFlowsWidgetOut | jq -r '.id'`
echo "Hosts with Top Flows Widget ID:" $HostsWithTopFlowsWidgetID
# PUT coordinates so they actually take effect!
ModifyHostsWithTopFlowsWidgetCmd="eval $cmdlinebegin -X PUT -d '{\"entity\":{\"id\":\"$HostsWithTopFlowsWidgetID\",\"layouts\":{\"lg\":{\"x\":9,\"y\":0,\"w\":3,\"h\":13,\"i\":\"$HostsWithTopFlowsWidgetID\",\"minW\":2,\"minH\":7},\"md\":{\"x\":4,\"y\":0,\"w\":6,\"h\":14,\"i\":\"$HostsWithTopFlowsWidgetID\",\"minW\":2,\"minH\":7},\"sm\":{\"x\":0,\"y\":0,\"w\":7,\"h\":13,\"i\":\"$HostsWithTopFlowsWidgetID\",\"minW\":2,\"minH\":7},\"xs\":{\"x\":2,\"y\":0,\"w\":2,\"h\":8,\"i\":\"$HostsWithTopFlowsWidgetID\",\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":8,\"w\":2,\"h\":8,\"i\":\"$HostsWithTopFlowsWidgetID\",\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
ModifyHostsWithTopFlowsWidgetOut=`$ModifyHostsWithTopFlowsWidgetCmd`
# echo "ModifyHostsWithTopFlowsWidgetOut=" $ModifyHostsWithTopFlowsWidgetOut

# Add Hosts with Top Download Transfers Widget
GetLiveChapterIDCmd="eval $cmdlinebegin https://$FMCip/rest/fmc/chapters | jq -r '.[] | select(.name == \"Hosts with Top Download Transfers in the Network\") | .id'"
LiveChapterID=`$GetLiveChapterIDCmd`
AddHostsWithTopDownloadsWidgetCmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"dashboard\":{\"id\":\"$db2id\",\"name\":\"$db2name\"},\"options\":{\"name\":\"Hosts with Top Downloads\",\"clazz\":\"TwoPiesAndTableWidget\",\"dataEndpoint\":\"fmc_chapter_$LiveChapterID\",\"visualizationSettings\":[{\"index\":0,\"settings\":{\"channel\":\"main\",\"metric\":\"ibyt\",\"subject\":\"dstip\",\"summaries\":[]},\"channelName\":\"main\"},{\"index\":1,\"settings\":{\"channel\":\"main\",\"metric\":\"bps\",\"summaries\":[\"top\",\"other\",\"bl\",\"sum\"]},\"channelName\":\"main\"},{\"index\":2,\"settings\":{\"channel\":\"main\",\"percents\":false,\"colorColumn\":true,\"columns\":[\"dstip\",\"bps\",\"ibyt\"],\"summaries\":[\"top\",\"other\",\"bl\",\"sum\"]},\"channelName\":\"main\"}],\"parametersSettings\":[{\"name\":\"from\",\"value\":\"h12Ago\",\"show\":true,\"relativeToForm\":false,\"useDefault\":false},{\"name\":\"to\",\"value\":\"now\",\"show\":false,\"relativeToForm\":false,\"useDefault\":1}],\"_isNico\":true},\"layouts\":{\"lg\":{\"x\":0,\"y\":29,\"w\":3,\"h\":16,\"i\":null,\"minW\":2,\"minH\":7},\"md\":{\"x\":4,\"y\":0,\"w\":6,\"h\":14,\"i\":null,\"minW\":2,\"minH\":7},\"sm\":{\"x\":0,\"y\":0,\"w\":7,\"h\":13,\"i\":null,\"minW\":2,\"minH\":7},\"xs\":{\"x\":2,\"y\":0,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":8,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
AddHostsWithTopDownloadsWidgetOut=`$AddHostsWithTopDownloadsWidgetCmd`
# echo;echo "AddHostsWithTopDownloadsWidgetCmd:" $AddHostsWithTopDownloadsWidgetCmd
# echo;echo "AddHostsWithTopDownloadsWidgetOut:" $AddHostsWithTopDownloadsWidgetOut
HostsWithTopDownloadsWidgetID=`echo $AddHostsWithTopDownloadsWidgetOut | jq -r '.id'`
echo "Hosts with Top Downloads Widget ID:" $HostsWithTopDownloadsWidgetID
# PUT coordinates so they actually take effect!
ModifyHostsWithTopDownloadsWidgetCmd="eval $cmdlinebegin -X PUT -d '{\"entity\":{\"id\":\"$HostsWithTopDownloadsWidgetID\",\"layouts\":{\"lg\":{\"x\":0,\"y\":29,\"w\":3,\"h\":16,\"i\":\"$HostsWithTopDownloadsWidgetID\",\"minW\":2,\"minH\":7},\"md\":{\"x\":4,\"y\":0,\"w\":6,\"h\":14,\"i\":\"$HostsWithTopDownloadsWidgetID\",\"minW\":2,\"minH\":7},\"sm\":{\"x\":0,\"y\":0,\"w\":7,\"h\":13,\"i\":\"$HostsWithTopDownloadsWidgetID\",\"minW\":2,\"minH\":7},\"xs\":{\"x\":2,\"y\":0,\"w\":2,\"h\":8,\"i\":\"$HostsWithTopDownloadsWidgetID\",\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":8,\"w\":2,\"h\":8,\"i\":\"$HostsWithTopDownloadsWidgetID\",\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
ModifyHostsWithTopDownloadsWidgetOut=`$ModifyHostsWithTopDownloadsWidgetCmd`
# echo "ModifyHostsWithTopDownloadsWidgetOut=" $ModifyHostsWithTopDownloadsWidgetOut

# Add Hosts with Top Upload Transfers Widget
GetLiveChapterIDCmd="eval $cmdlinebegin https://$FMCip/rest/fmc/chapters | jq -r '.[] | select(.name == \"Hosts with Top Upload Transfers in the Network\") | .id'"
LiveChapterID=`$GetLiveChapterIDCmd`
AddHostsWithTopUploadsWidgetCmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"dashboard\":{\"id\":\"$db2id\",\"name\":\"$db2name\"},\"options\":{\"name\":\"Hosts with Top Uploads\",\"clazz\":\"TwoPiesAndTableWidget\",\"dataEndpoint\":\"fmc_chapter_$LiveChapterID\",\"visualizationSettings\":[{\"index\":0,\"settings\":{\"channel\":\"main\",\"metric\":\"ibyt\",\"subject\":\"srcip\",\"summaries\":[]},\"channelName\":\"main\"},{\"index\":1,\"settings\":{\"channel\":\"main\",\"metric\":\"bps\",\"summaries\":[\"top\",\"other\",\"bl\",\"sum\"]},\"channelName\":\"main\"},{\"index\":2,\"settings\":{\"channel\":\"main\",\"percents\":false,\"colorColumn\":true,\"columns\":[\"srcip\",\"bps\",\"ibyt\"],\"summaries\":[\"top\",\"other\",\"bl\",\"sum\"]},\"channelName\":\"main\"}],\"parametersSettings\":[{\"name\":\"from\",\"value\":\"h12Ago\",\"show\":true,\"relativeToForm\":false,\"useDefault\":false},{\"name\":\"to\",\"value\":\"now\",\"show\":false,\"relativeToForm\":false,\"useDefault\":1}],\"_isNico\":true},\"layouts\":{\"lg\":{\"x\":3,\"y\":29,\"w\":3,\"h\":16,\"i\":null,\"minW\":2,\"minH\":7},\"md\":{\"x\":4,\"y\":0,\"w\":6,\"h\":14,\"i\":null,\"minW\":2,\"minH\":7},\"sm\":{\"x\":0,\"y\":0,\"w\":7,\"h\":13,\"i\":null,\"minW\":2,\"minH\":7},\"xs\":{\"x\":2,\"y\":0,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":8,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
AddHostsWithTopUploadsWidgetOut=`$AddHostsWithTopUploadsWidgetCmd`
# echo;echo "AddHostsWithTopUploadsWidgetCmd:" $AddHostsWithTopUploadsWidgetCmd
# echo;echo "AddHostsWithTopUploadsWidgetOut:" $AddHostsWithTopUploadsWidgetOut
HostsWithTopUploadsWidgetID=`echo $AddHostsWithTopUploadsWidgetOut | jq -r '.id'`
echo "Hosts with Top Uploads Widget ID:" $HostsWithTopUploadsWidgetID
# PUT coordinates so they actually take effect!
ModifyHostsWithTopUploadsWidgetCmd="eval $cmdlinebegin -X PUT -d '{\"entity\":{\"id\":\"$HostsWithTopUploadsWidgetID\",\"layouts\":{\"lg\":{\"x\":3,\"y\":29,\"w\":3,\"h\":16,\"i\":\"$HostsWithTopUploadsWidgetID\",\"minW\":2,\"minH\":7},\"md\":{\"x\":4,\"y\":0,\"w\":6,\"h\":14,\"i\":\"$HostsWithTopUploadsWidgetID\",\"minW\":2,\"minH\":7},\"sm\":{\"x\":0,\"y\":0,\"w\":7,\"h\":13,\"i\":\"$HostsWithTopUploadsWidgetID\",\"minW\":2,\"minH\":7},\"xs\":{\"x\":2,\"y\":0,\"w\":2,\"h\":8,\"i\":\"$HostsWithTopUploadsWidgetID\",\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":8,\"w\":2,\"h\":8,\"i\":\"$HostsWithTopUploadsWidgetID\",\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
ModifyHostsWithTopUploadsWidgetOut=`$ModifyHostsWithTopUploadsWidgetCmd`
# echo "ModifyHostsWithTopUploadsWidgetOut=" $ModifyHostsWithTopUploadsWidgetOut

# Add Routing Protocol Traffic Structure Widget
GetLiveChapterIDCmd="eval $cmdlinebegin https://$FMCip/rest/fmc/chapters | jq -r '.[] | select(.name == \"Structure of routing protocol traffic\") | .id'"
LiveChapterID=`$GetLiveChapterIDCmd`
AddRoutingProtoWidgetCmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"dashboard\":{\"id\":\"$db2id\",\"name\":\"$db2name\"},\"options\":{\"name\":\"Routing Protocol Traffic Structure\",\"clazz\":\"TimeSeriesAndTableWidget\",\"dataEndpoint\":\"fmc_chapter_$LiveChapterID\",\"visualizationSettings\":[{\"index\":0,\"settings\":{\"channel\":\"traffic\",\"series\":\"*\",\"chartOptions\":{\"stacked\":true,\"axis\":\"linear\"}},\"channelName\":\"traffic\"},{\"index\":1,\"settings\":{\"channel\":\"main\",\"percents\":false,\"colorColumn\":true,\"columns\":[\"chapter${LiveChapterID}col\",\"mbps\",\"bps\",\"ibyt\"],\"summaries\":[\"total\"]},\"channelName\":\"main\"}],\"parametersSettings\":[{\"name\":\"aggregation\",\"value\":null,\"show\":false,\"relativeToForm\":false,\"useDefault\":1},{\"name\":\"from\",\"value\":\"h12Ago\",\"show\":true,\"relativeToForm\":false,\"useDefault\":false},{\"name\":\"to\",\"value\":\"now\",\"show\":false,\"relativeToForm\":false,\"useDefault\":1}],\"_isNico\":true},\"layouts\":{\"lg\":{\"x\":8,\"y\":13,\"w\":4,\"h\":16,\"i\":null,\"minW\":2,\"minH\":7},\"md\":{\"x\":4,\"y\":0,\"w\":6,\"h\":14,\"i\":null,\"minW\":2,\"minH\":7},\"sm\":{\"x\":0,\"y\":0,\"w\":7,\"h\":13,\"i\":null,\"minW\":2,\"minH\":7},\"xs\":{\"x\":2,\"y\":0,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":8,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
AddRoutingProtoWidgetOut=`$AddRoutingProtoWidgetCmd`
# echo;echo "AddRoutingProtoWidgetCmd:" $AddRoutingProtoWidgetCmd
# echo;echo "AddRoutingProtoWidgetOut:" $AddRoutingProtoWidgetOut
RoutingProtoWidgetID=`echo $AddRoutingProtoWidgetOut | jq -r '.id'`
echo "Routing Protocol Traffic Structure Widget ID:" $RoutingProtoWidgetID
# PUT coordinates so they actually take effect!
ModifyRoutingProtoWidgetCmd="eval $cmdlinebegin -X PUT -d '{\"entity\":{\"id\":\"$RoutingProtoWidgetID\",\"layouts\":{\"lg\":{\"x\":8,\"y\":13,\"w\":4,\"h\":16,\"i\":\"$RoutingProtoWidgetID\",\"minW\":2,\"minH\":7},\"md\":{\"x\":4,\"y\":0,\"w\":6,\"h\":14,\"i\":\"$RoutingProtoWidgetID\",\"minW\":2,\"minH\":7},\"sm\":{\"x\":0,\"y\":0,\"w\":7,\"h\":13,\"i\":\"$RoutingProtoWidgetID\",\"minW\":2,\"minH\":7},\"xs\":{\"x\":2,\"y\":0,\"w\":2,\"h\":8,\"i\":\"$RoutingProtoWidgetID\",\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":8,\"w\":2,\"h\":8,\"i\":\"$RoutingProtoWidgetID\",\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
ModifyRoutingProtoWidgetOut=`$ModifyRoutingProtoWidgetCmd`
# echo "ModifyRoutingProtoWidgetOut=" $ModifyRoutingProtoWidgetOut

# Add Top UDP Hosts Widget
GetLiveChapterIDCmd="eval $cmdlinebegin https://$FMCip/rest/fmc/chapters | jq -r '.[] | select(.name == \"Top Network Services over UDP\") | .id'"
LiveChapterID=`$GetLiveChapterIDCmd`
AddTopUDPServicesWidgetCmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"dashboard\":{\"id\":\"$db2id\",\"name\":\"$db2name\"},\"options\":{\"name\":\"Top UDP Network Services\",\"clazz\":\"TwoPiesAndTableWidget\",\"dataEndpoint\":\"fmc_chapter_$LiveChapterID\",\"visualizationSettings\":[{\"index\":0,\"settings\":{\"channel\":\"main\",\"metric\":\"ibyt\",\"subject\":\"portp\",\"summaries\":[]},\"channelName\":\"main\"},{\"index\":1,\"settings\":{\"channel\":\"main\",\"metric\":\"ibyt\",\"summaries\":[\"bl\",\"sum\"]},\"channelName\":\"main\"},{\"index\":2,\"settings\":{\"channel\":\"main\",\"percents\":false,\"colorColumn\":true,\"columns\":[\"portp\",\"proto\",\"ibyt\"],\"summaries\":[\"bl\",\"sum\"]},\"channelName\":\"main\"}],\"parametersSettings\":[{\"name\":\"from\",\"value\":\"h12Ago\",\"show\":true,\"relativeToForm\":false,\"useDefault\":false},{\"name\":\"to\",\"value\":\"now\",\"show\":false,\"relativeToForm\":false,\"useDefault\":1}],\"_isNico\":true},\"layouts\":{\"lg\":{\"x\":9,\"y\":29,\"w\":3,\"h\":16,\"i\":null,\"minW\":2,\"minH\":7},\"md\":{\"x\":4,\"y\":0,\"w\":6,\"h\":14,\"i\":null,\"minW\":2,\"minH\":7},\"sm\":{\"x\":0,\"y\":0,\"w\":7,\"h\":13,\"i\":null,\"minW\":2,\"minH\":7},\"xs\":{\"x\":2,\"y\":0,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":8,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
AddTopUDPServicesWidgetOut=`$AddTopUDPServicesWidgetCmd`
# echo;echo "AddTopUDPServicesWidgetCmd:" $AddTopUDPServicesWidgetCmd
# echo;echo "AddTopUDPServicesWidgetOut:" $AddTopUDPServicesWidgetOut
TopUDPServicesWidgetID=`echo $AddTopUDPServicesWidgetOut | jq -r '.id'`
echo "Top UDP Services Widget ID:" $TopUDPServicesWidgetID
# PUT coordinates so they actually take effect!
ModifyTopUDPServicesWidgetCmd="eval $cmdlinebegin -X PUT -d '{\"entity\":{\"id\":\"$TopUDPServicesWidgetID\",\"layouts\":{\"lg\":{\"x\":9,\"y\":29,\"w\":3,\"h\":16,\"i\":\"$TopUDPServicesWidgetID\",\"minW\":2,\"minH\":7},\"md\":{\"x\":4,\"y\":0,\"w\":6,\"h\":14,\"i\":\"$TopUDPServicesWidgetID\",\"minW\":2,\"minH\":7},\"sm\":{\"x\":0,\"y\":0,\"w\":7,\"h\":13,\"i\":\"$TopUDPServicesWidgetID\",\"minW\":2,\"minH\":7},\"xs\":{\"x\":2,\"y\":0,\"w\":2,\"h\":8,\"i\":\"$TopUDPServicesWidgetID\",\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":8,\"w\":2,\"h\":8,\"i\":\"$TopUDPServicesWidgetID\",\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
ModifyTopUDPServicesWidgetOut=`$ModifyTopUDPServicesWidgetCmd`
# echo "ModifyTopUDPServicesWidgetOut=" $ModifyTopUDPServicesWidgetOut

# Add Top TCP Services Widget
GetLiveChapterIDCmd="eval $cmdlinebegin https://$FMCip/rest/fmc/chapters | jq -r '.[] | select(.name == \"Top Network Services over TCP\") | .id'"
LiveChapterID=`$GetLiveChapterIDCmd`
AddTopTCPServicesWidgetCmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"dashboard\":{\"id\":\"$db2id\",\"name\":\"$db2name\"},\"options\":{\"name\":\"Top TCP Network Services\",\"clazz\":\"TwoPiesAndTableWidget\",\"dataEndpoint\":\"fmc_chapter_$LiveChapterID\",\"visualizationSettings\":[{\"index\":0,\"settings\":{\"channel\":\"main\",\"metric\":\"ibyt\",\"subject\":\"portp\",\"summaries\":[]},\"channelName\":\"main\"},{\"index\":1,\"settings\":{\"channel\":\"main\",\"metric\":\"ibyt\",\"summaries\":[\"bl\",\"sum\"]},\"channelName\":\"main\"},{\"index\":2,\"settings\":{\"channel\":\"main\",\"percents\":false,\"colorColumn\":true,\"columns\":[\"portp\",\"proto\",\"ibyt\"],\"summaries\":[\"bl\",\"sum\"]},\"channelName\":\"main\"}],\"parametersSettings\":[{\"name\":\"from\",\"value\":\"h12Ago\",\"show\":true,\"relativeToForm\":false,\"useDefault\":false},{\"name\":\"to\",\"value\":\"now\",\"show\":false,\"relativeToForm\":false,\"useDefault\":1}],\"_isNico\":true},\"layouts\":{\"lg\":{\"x\":6,\"y\":29,\"w\":3,\"h\":16,\"i\":null,\"minW\":2,\"minH\":7},\"md\":{\"x\":4,\"y\":0,\"w\":6,\"h\":14,\"i\":null,\"minW\":2,\"minH\":7},\"sm\":{\"x\":0,\"y\":0,\"w\":7,\"h\":13,\"i\":null,\"minW\":2,\"minH\":7},\"xs\":{\"x\":2,\"y\":0,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":8,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
AddTopTCPServicesWidgetOut=`$AddTopTCPServicesWidgetCmd`
# echo;echo "AddTopTCPServicesWidgetCmd:" $AddTopTCPServicesWidgetCmd
# echo;echo "AddTopTCPServicesWidgetOut:" $AddTopTCPServicesWidgetOut
TopTCPServicesWidgetID=`echo $AddTopTCPServicesWidgetOut | jq -r '.id'`
echo "Top TCP Services Widget ID:" $TopTCPServicesWidgetID
# PUT coordinates so they actually take effect!
ModifyTopTCPServicesWidgetCmd="eval $cmdlinebegin -X PUT -d '{\"entity\":{\"id\":\"$TopTCPServicesWidgetID\",\"layouts\":{\"lg\":{\"x\":6,\"y\":29,\"w\":3,\"h\":16,\"i\":\"$TopTCPServicesWidgetID\",\"minW\":2,\"minH\":7},\"md\":{\"x\":4,\"y\":0,\"w\":6,\"h\":14,\"i\":\"$TopTCPServicesWidgetID\",\"minW\":2,\"minH\":7},\"sm\":{\"x\":0,\"y\":0,\"w\":7,\"h\":13,\"i\":\"$TopTCPServicesWidgetID\",\"minW\":2,\"minH\":7},\"xs\":{\"x\":2,\"y\":0,\"w\":2,\"h\":8,\"i\":\"$TopTCPServicesWidgetID\",\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":8,\"w\":2,\"h\":8,\"i\":\"$TopTCPServicesWidgetID\",\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
ModifyTopTCPServicesWidgetOut=`$ModifyTopTCPServicesWidgetCmd`
# echo "ModifyTopTCPServicesWidgetOut=" $ModifyTopTCPServicesWidgetOut

# Add Service Traffic Structure Widget
GetLiveChapterIDCmd="eval $cmdlinebegin https://$FMCip/rest/fmc/chapters | jq -r '.[] | select(.name == \"Structure of Service Traffic\") | .id'"
LiveChapterID=`$GetLiveChapterIDCmd`
AddServiceTrafficWidgetCmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"dashboard\":{\"id\":\"$db2id\",\"name\":\"$db2name\"},\"options\":{\"name\":\"Service Traffic Structure\",\"clazz\":\"TimeSeriesAndTableWidget\",\"dataEndpoint\":\"fmc_chapter_330206dc-8bed-4bb4-b336-e6a5b0746cb3\",\"visualizationSettings\":[{\"index\":0,\"settings\":{\"channel\":\"traffic\",\"series\":\"*\",\"chartOptions\":{\"stacked\":true,\"axis\":\"linear\"}},\"channelName\":\"traffic\"},{\"index\":1,\"settings\":{\"channel\":\"main\",\"percents\":false,\"colorColumn\":true,\"columns\":[\"chapter${LiveChapterID}col\",\"mbps\",\"bps\",\"ibyt\"],\"summaries\":[\"total\"]},\"channelName\":\"main\"}],\"parametersSettings\":[{\"name\":\"aggregation\",\"value\":null,\"show\":false,\"relativeToForm\":false,\"useDefault\":1},{\"name\":\"from\",\"value\":\"h12Ago\",\"show\":true,\"relativeToForm\":false,\"useDefault\":false},{\"name\":\"to\",\"value\":\"now\",\"show\":false,\"relativeToForm\":false,\"useDefault\":1}],\"_isNico\":true},\"layouts\":{\"lg\":{\"x\":0,\"y\":13,\"w\":4,\"h\":16,\"i\":null,\"minW\":2,\"minH\":7},\"md\":{\"x\":4,\"y\":0,\"w\":6,\"h\":14,\"i\":null,\"minW\":2,\"minH\":7},\"sm\":{\"x\":0,\"y\":0,\"w\":7,\"h\":13,\"i\":null,\"minW\":2,\"minH\":7},\"xs\":{\"x\":2,\"y\":0,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":8,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
AddServiceTrafficWidgetOut=`$AddServiceTrafficWidgetCmd`
# echo;echo "AddServiceTrafficWidgetCmd:" $AddServiceTrafficWidgetCmd
# echo;echo "AddServiceTrafficWidgetOut:" $AddServiceTrafficWidgetOut
ServiceTrafficWidgetID=`echo $AddServiceTrafficWidgetOut | jq -r '.id'`
echo "Routing Protocol Traffic Structure Widget ID:" $ServiceTrafficWidgetID
# PUT coordinates so they actually take effect!
ModifyServiceTrafficWidgetCmd="eval $cmdlinebegin -X PUT -d '{\"entity\":{\"id\":\"$ServiceTrafficWidgetID\",\"layouts\":{\"lg\":{\"x\":0,\"y\":13,\"w\":4,\"h\":16,\"i\":\"$ServiceTrafficWidgetID\",\"minW\":2,\"minH\":7},\"md\":{\"x\":4,\"y\":0,\"w\":6,\"h\":14,\"i\":\"$ServiceTrafficWidgetID\",\"minW\":2,\"minH\":7},\"sm\":{\"x\":0,\"y\":0,\"w\":7,\"h\":13,\"i\":\"$ServiceTrafficWidgetID\",\"minW\":2,\"minH\":7},\"xs\":{\"x\":2,\"y\":0,\"w\":2,\"h\":8,\"i\":\"$ServiceTrafficWidgetID\",\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":8,\"w\":2,\"h\":8,\"i\":\"$ServiceTrafficWidgetID\",\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
ModifyServiceTrafficWidgetOut=`$ModifyServiceTrafficWidgetCmd`
# echo "ModifyServiceTrafficWidgetOut=" $ModifyServiceTrafficWidgetOut

# Add Email Traffic Structure Widget
GetLiveChapterIDCmd="eval $cmdlinebegin https://$FMCip/rest/fmc/chapters | jq -r '.[] | select(.name == \"Structure of Email Traffic\") | .id'"
LiveChapterID=`$GetLiveChapterIDCmd`
AddEmailTrafficWidgetCmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"dashboard\":{\"id\":\"$db2id\",\"name\":\"$db2name\"},\"options\":{\"name\":\"Email Traffic Structure\",\"clazz\":\"TimeSeriesAndTableWidget\",\"dataEndpoint\":\"fmc_chapter_$LiveChapterID\",\"visualizationSettings\":[{\"index\":0,\"settings\":{\"channel\":\"traffic\",\"series\":\"*\",\"chartOptions\":{\"stacked\":true,\"axis\":\"linear\"}},\"channelName\":\"traffic\"},{\"index\":1,\"settings\":{\"channel\":\"main\",\"percents\":false,\"colorColumn\":true,\"columns\":[\"chapter${LiveChapterID}col\",\"mbps\",\"bps\",\"ibyt\"],\"summaries\":[\"total\"]},\"channelName\":\"main\"}],\"parametersSettings\":[{\"name\":\"aggregation\",\"value\":null,\"show\":false,\"relativeToForm\":false,\"useDefault\":1},{\"name\":\"from\",\"value\":\"h12Ago\",\"show\":true,\"relativeToForm\":false,\"useDefault\":false},{\"name\":\"to\",\"value\":\"now\",\"show\":false,\"relativeToForm\":false,\"useDefault\":1}],\"_isNico\":true},\"layouts\":{\"lg\":{\"x\":4,\"y\":13,\"w\":4,\"h\":16,\"i\":null,\"minW\":2,\"minH\":7},\"md\":{\"x\":4,\"y\":0,\"w\":6,\"h\":14,\"i\":null,\"minW\":2,\"minH\":7},\"sm\":{\"x\":0,\"y\":0,\"w\":7,\"h\":13,\"i\":null,\"minW\":2,\"minH\":7},\"xs\":{\"x\":2,\"y\":0,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":8,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
AddEmailTrafficWidgetOut=`$AddEmailTrafficWidgetCmd`
# echo;echo "AddEmailTrafficWidgetCmd:" $AddEmailTrafficWidgetCmd
# echo;echo "AddEmailTrafficWidgetOut:" $AddEmailTrafficWidgetOut
EmailTrafficWidgetID=`echo $AddEmailTrafficWidgetOut | jq -r '.id'`
echo "Email Traffic Structure Widget ID:" $EmailTrafficWidgetID
# PUT coordinates so they actually take effect!
ModifyEmailTrafficWidgetCmd="eval $cmdlinebegin -X PUT -d '{\"entity\":{\"id\":\"$EmailTrafficWidgetID\",\"layouts\":{\"lg\":{\"x\":4,\"y\":13,\"w\":4,\"h\":16,\"i\":\"$EmailTrafficWidgetID\",\"minW\":2,\"minH\":7},\"md\":{\"x\":4,\"y\":0,\"w\":6,\"h\":14,\"i\":\"$EmailTrafficWidgetID\",\"minW\":2,\"minH\":7},\"sm\":{\"x\":0,\"y\":0,\"w\":7,\"h\":13,\"i\":\"$EmailTrafficWidgetID\",\"minW\":2,\"minH\":7},\"xs\":{\"x\":2,\"y\":0,\"w\":2,\"h\":8,\"i\":\"$EmailTrafficWidgetID\",\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":8,\"w\":2,\"h\":8,\"i\":\"$EmailTrafficWidgetID\",\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
ModifyEmailTrafficWidgetOut=`$ModifyEmailTrafficWidgetCmd`
# echo "ModifyEmailTrafficWidgetOut=" $ModifyEmailTrafficWidgetOut

#LoadMaster Device Dashboard DONE
################################################################################################

#
# Loop through all the Virtual Services from the input file and create a
# dashboard for each
# N.B.: REMEMBER THAT THE JSON ARRAYS START AT 0 !!!
#

i=0
while [[ $i -lt $NumVSs ]]; do
#
# Add DB
#
VSAppName="VS${i}AppName"
echo;echo "###"
echo "### Create Virtual Service Dashboards..."
echo "###"
createdbcmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"name\":\"${!VSAppName}\",\"tenant\":{\"id\":\"00000000-0000-0000-0001-000000000001\",\"name\":\"Base tenant\"}}}' https://$FMCip/rest/fmd/overview/dashboards"
createdbout=`$createdbcmd`
# get its ID from the cmd output
dbid=`echo $createdbout | jq -r .id`
dbname=`echo $createdbout | jq -r .name`
echo;echo "VS Dashboard Name & ID:" $dbname $dbid

#
# Make new Dashboard visible
#
echo "### Make VS dashboard visible..."
makedbvizcmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"dashboard\":{\"id\":\"$dbid\",\"name\":\"$dbname\",\"isReadOnlyForCurrentUser\":false,\"canBeSetAsPredefinedByUser\":true,\"isAvailableToOtherUsers\":true},\"observingUser\":{\"id\":1,\"login\":\"admin\"},\"order\":1}}' https://$FMCip/rest/fmd/overview/displayed-dashboards"
makedbvizout=`$makedbvizcmd`
# echo $makedbvizcmd
# echo $makedbvizout
visibleDBid=`echo $makedbvizout | jq .id`
echo "Visible DB ID:" $visibleDBid

#
# Add a New Profile for the Virtual Service / Application
# Add Channels for: serverside, clientside, and one for each Real Server (RS)
#

echo;echo "###"
echo "### Creating a Profile for the Virtual Service..."
echo "###"

# Variables needed
VSextip="VS${i}extip"
VSextport="VS${i}extport"
VSclientip="VS${i}clientip"
VSintip="VS${i}intip"
VSintport="VS${i}intport"
VSAppName="VS${i}AppName"

# Create the Profile
echo "LM Source Channel:" $LMsourcechannel
AddVSProfileCmd="eval $cmdlinebegin https://$FMCip/rest/fmc/profiles -X POST -d '{\"entity\":{\"name\":\"${!VSAppName}\",\"parent\":\"live\",\"tenant\":\"00000000-0000-0000-0001-000000000001\",\"description\":\"${!VSAppName} Virtual Service - Application Profile\",\"type\":\"shadow\",\"maxsize\":100,\"group\":\"Applications\",\"channels\":[{\"name\":\"$LMhostname $LMip4collector\",\"sign\":\"+\",\"color\":\"#0000cc\",\"parent\":[\"$LMsourcechannel\"],\"filter\":\"any\"}]}}'"
# echo "AddVSProfileCmd =" $AddVSProfileCmd
AddVSProfileOut=`$AddVSProfileCmd`
# echo "AddVSProfileOut =" $AddVSProfileOut
VSProfileID=`echo $AddVSProfileOut | jq -r '.id'`
echo "VSProfileID =" $VSProfileID

echo;echo "### Creating channels..."
ClientSideChannelSpec="{\"name\":\"${!VSAppName}: Client Side Traffic\",\"sign\":\"+\",\"color\":\"#996633\",\"parent\":[\"$LMsourcechannel\"],\"mode\":{\"enabled\":true,\"npmEnabled\":true,\"trafficEnabled\":true},\"filter\":\"(${!VSclientip}) and (ip ${!VSextip} and port ${!VSextport})\"}"
# Build the serverside Channel Spec
NumRSs=`echo $JsonIn | jq -r --argjson i $i '.VirtualServices[$i].Servers | select(.!=null) | length'`
# ADD if numRSs = 1 then/else one-liner
# Array of colors for servers
declare -a servercolor=( "#00ffff" "#cc0099" "#cccc99" "#666699" "#ff6666" "#ffff66" "#3399ff" "#ffcc00" "#cc0000" "#333333" "#66ff66" "#0000cc" "#9966ff" "#009900" "#666666" "#66cccc" "#ff66ff" "#0066ff" "#999999" "#ff6633" )
ServerSideChannelFilter="(ip ${!VSintip} and port ${!VSintport}) and ("
# RS counter
j=0
while [[ $j -lt $NumRSs ]]; do
	RSip="RS${j}ip"
	RSport="RS${j}port"
	if [[ $j -eq "0" ]]; then
		ServerSideChannelFilter+="(ip ${!RSip})"
	else
		ServerSideChannelFilter+=" or (ip ${!RSip})"
	fi
	# while we're here, create the individual RS channel too
	declare "RS${j}ChannelSpec={\"name\":\"${!VSAppName}: RS ${!RSip} Traffic\",\"sign\":\"+\",\"color\":\"${servercolor[$j]}\",\"parent\":[\"$LMsourcechannel\"],\"mode\":{\"enabled\":true,\"npmEnabled\":true,\"trafficEnabled\":true},\"filter\":\"(ip ${!VSintip} and port ${!VSintport}) and (ip ${!RSip})\"}"
	j=`expr $j + 1`
done
ServerSideChannelFilter+=")"
# echo
# echo $ServerSideChannelFilter
ServerSideChannelSpec="{\"name\":\"${!VSAppName}: Server Side Traffic\",\"sign\":\"-\",\"color\":\"#003399\",\"parent\":[\"$LMsourcechannel\"],\"mode\":{\"enabled\":true,\"npmEnabled\":true,\"trafficEnabled\":true},\"filter\":\"$ServerSideChannelFilter\"}"
# echo $ServerSideChannelSpec
ServerSideChannelSpecPlus="{\"name\":\"${!VSAppName}: All Real Server Traffic\",\"sign\":\"+\",\"color\":\"#003399\",\"parent\":[\"$LMsourcechannel\"],\"mode\":{\"enabled\":true,\"npmEnabled\":true,\"trafficEnabled\":true},\"filter\":\"$ServerSideChannelFilter\"}"

# Create them all in one command

createLMchannelscmd="eval $cmdlinebegin -X PUT -d '{\"entity\":{\"id\":\"$VSProfileID\",\"name\":\"${!VSAppName} Total Traffic\",\"type\":\"real\",\"parent\":\"live\",\"channels\":[{\"name\":\"IPv4\",\"sign\":\"+\",\"color\":\"#1bb500\",\"parent\":\"*\",\"mode\":{\"enabled\":true,\"npmEnabled\":true,\"trafficEnabled\":true},\"filter\":\"inet\"},{\"name\":\"IPv6\",\"sign\":\"+\",\"color\":\"#ffa216\",\"parent\":\"*\",\"mode\":{\"enabled\":true,\"npmEnabled\":true,\"trafficEnabled\":true},\"filter\":\"inet6\"},"
j=0
while [[ $j -lt $NumRSs ]]; do
	RSChannelSpec="RS${j}ChannelSpec"
	createLMchannelscmd+="${!RSChannelSpec},"
	j=`expr $j + 1`
done
createLMchannelscmd+=""$ClientSideChannelSpec","$ServerSideChannelSpecPlus","$ServerSideChannelSpec"]}}' https://$FMCip/rest/fmc/profiles"
# echo; echo $createLMchannelscmd
createLMchannelsout=`$createLMchannelscmd`
# echo
# echo "createLMchannelsout: " $createLMchannelsout
# echo

echo "Extracting channel IDs..."
	
# Extract the Channel IDs from the output so we can use them in the Chapters
# when we create them.

ServerSideChapterChannelID=`echo $createLMchannelsout | jq -r '.channels | .[] | select(.name|test("Server Side Traffic")) | .id'`
echo "ServerSideChapterChannelID:" $ServerSideChapterChannelID

ServerSidePlusChapterChannelID=`echo $createLMchannelsout | jq -r '.channels | .[] | select(.name|test("All Real Server Traffic")) | .id'`
echo "ServerSidePlusChapterChannelID:" $ServerSidePlusChapterChannelID
	
ClientSideChapterChannelID=`echo $createLMchannelsout | jq -r '.channels | .[] | select(.name|test("Client Side Traffic")) | .id'`
echo "ClientSideChapterChannelID:" $ClientSideChapterChannelID
	
#### Loop for RS Chapter Channel IDs
j=0
while [[ $j -lt $NumRSs ]]; do
	RSip="RS${j}ip"
	declare "RS${j}ChapterChannelID=`echo $createLMchannelsout | jq -r --arg RSip "${!RSip}" '.channels | .[] | select(.name|test($RSip)) | .id'`"
	RSChapterChannelID="RS${j}ChapterChannelID"
	echo "RS${j}ChapterChannelID: " ${!RSChapterChannelID}
	j=`expr $j + 1`
done

#
# Add Chapters required for Widgets
#
# Parameters: Name, Description, Channel Column Name (leftmost column
# in widget tables), Profile Channel(s).
# Get from Collector: Profile Channel IDs.
#
# 'jq -r' (raw) is used to avoid double quotes when inserting shell variables
# into JSON: [""SalesA-b12a51"",""SalesA-37456a""]
	
echo;echo "### Adding Chapters..."
echo "Adding chapter for Total VS & RS Traffic..."
# $AppName: Total VS & RS Traffic
AddTotalVSRSChapterCmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"name\":\"${!VSAppName}: Total VS & RS Traffic\",\"description\":\"${!VSAppName}: Total VS & RS Traffic\",\"localization\":{\"name\":{\"en\":\"${!VSAppName}: Total VS & RS Traffic\",\"cz\":\"\",\"jp\":\"\",\"de\":\"\",\"fr\":\"\",\"es\":\"\"},\"description\":{\"en\":\"${!VSAppName}: Total VS & RS Traffic\",\"cz\":\"\",\"jp\":\"\",\"de\":\"\",\"fr\":\"\",\"es\":\"\"},\"channelColumnName\":{\"en\":\"${!VSAppName}: Total VS & RS Traffic\",\"cz\":\"\",\"jp\":\"\",\"de\":\"\",\"fr\":\"\",\"es\":\"\"}},\"type\":\"traffic\",\"profile\":\"$VSProfileID\",\"channels\":[\"$ServerSideChapterChannelID\",\"$ClientSideChapterChannelID\"],\"channelColumnName\":\"${!VSAppName}: Total VS & RS Traffic\",\"outputColumns\":[\"${!VSAppName}: Total VS & RS Traffic\",\"mbps\",\"95bps\",\"bps\",\"95ibyt\",\"ibyt\"],\"channelsOrderBy\":\"ibyt\",\"showPercentile\":1,\"volumetric\":{\"flows\":true,\"bytes\":true,\"packets\":true},\"performance\":{\"rtt\":true,\"srt\":true,\"jitter\":true,\"rtr\":true}}}' https://$FMCip/rest/fmc/chapters"
# echo $AddTotalVSRSChapterCmd
AddTotalVSRSChapterOut=`$AddTotalVSRSChapterCmd`
# echo $AddTotalVSRSChapterOut
# Get Chapter ID for use in Widgets.
TotalVSRSTrafficChapterID=`echo $AddTotalVSRSChapterOut | jq -r '.id'`
# Get Channel IDs for use in Widgets.
# Note: These Channel IDs refer to Channels in the VS Profile.
TotalVSRSTrafficChannels=`echo $AddTotalVSRSChapterOut | jq '.channels'`
echo "Chapter ID:" $TotalVSRSTrafficChapterID
echo "Channels:" $TotalVSRSTrafficChannels

#### Loop for individual RS Chapters
echo "Adding Chapters for RS Traffic..."
j=0
while [[ $j -lt $NumRSs ]]; do
	RSip="RS${j}ip"
	RSChapterChannelID="RS${j}ChapterChannelID"
	declare "AddRS${j}TrafficChapterCmd=eval $cmdlinebegin -X POST -d '{\"entity\":{\"name\":\"${!VSAppName}: Real Server ${!RSip}\",\"description\":\"RS ${!RSip}\",\"localization\":{\"name\":{\"en\":\"${!VSAppName}: Real Server ${!RSip}\",\"cz\":\"\",\"jp\":\"\",\"de\":\"\",\"fr\":\"\",\"es\":\"\"},\"description\":{\"en\":\"${!VSAppName}: RS ${!RSip}\",\"cz\":\"\",\"jp\":\"\",\"de\":\"\",\"fr\":\"\",\"es\":\"\"},\"channelColumnName\":{\"en\":\"${!VSAppName}: RS ${!RSip}\",\"cz\":\"\",\"jp\":\"\",\"de\":\"\",\"fr\":\"\",\"es\":\"\"}},\"type\":\"traffic\",\"profile\":\"$VSProfileID\",\"channels\":[\"${!RSChapterChannelID}\"],\"channelColumnName\":\"${!RSip}\",\"outputColumns\":[\"${!VSAppName}: RS ${!RSip}\",\"mbps\",\"95bps\",\"bps\",\"95ibyt\",\"ibyt\"],\"channelsOrderBy\":\"ibyt\",\"showPercentile\":1,\"volumetric\":{\"flows\":true,\"bytes\":true,\"packets\":true},\"performance\":{\"rtt\":true,\"srt\":true,\"jitter\":true,\"rtr\":true}}}' https://$FMCip/rest/fmc/chapters"
	AddRSTrafficChapterCmd="AddRS${j}TrafficChapterCmd"
	AddRSTrafficChapterOut=`${!AddRSTrafficChapterCmd}`

	# Get Chapter ID for use in Widgets.
	declare "AddRS${j}TrafficChapterID=`echo $AddRSTrafficChapterOut | jq -r '.id'`"
	AddRSTrafficChapterID="AddRS${j}TrafficChapterID"
	# Get Channel IDs for use in Widgets.
	# Channel IDs refer to Channels in the VS Profile.
	declare "AddRS${j}TrafficChannels=`echo $AddRSTrafficChapterOut | jq '.channels'`"
	AddRSTrafficChannels="AddRS${j}TrafficChannels"
	echo "Chapter ID:" ${!AddRSTrafficChapterID}
	echo "Channels:" ${!AddRSTrafficChannels}
	j=`expr $j + 1`
done

echo "Adding chapter for Server Side Traffic...Negative"
# $AppName: Server Side Traffic - Minus (below X line)
AddServerSideTrafficChapterCmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"name\":\"${!VSAppName}: Server Side Traffic Structure\",\"description\":\"Server Side Traffic Structure\",\"localization\":{\"name\":{\"en\":\"${!VSAppName}: Server Side Traffic Structure\",\"cz\":\"\",\"jp\":\"\",\"de\":\"\",\"fr\":\"\",\"es\":\"\"},\"description\":{\"en\":\"${!VSAppName}: Real Server Traffic Structure\",\"cz\":\"\",\"jp\":\"\",\"de\":\"\",\"fr\":\"\",\"es\":\"\"},\"channelColumnName\":{\"en\":\"${!VSAppName}: All Real Servers\",\"cz\":\"\",\"jp\":\"\",\"de\":\"\",\"fr\":\"\",\"es\":\"\"}},\"type\":\"traffic\",\"profile\":\"$VSProfileID\",\"channels\":[\"$ServerSideChapterChannelID\"],\"channelColumnName\":\"${!VSAppName}: All Real Servers\",\"outputColumns\":[\"${!VSAppName}: All Real Servers\",\"mbps\",\"bps\",\"ibyt\"],\"channelsOrderBy\":\"ibyt\",\"showPercentile\":0,\"volumetric\":{\"flows\":true,\"bytes\":true,\"packets\":true},\"performance\":{\"rtt\":true,\"srt\":true,\"jitter\":true,\"rtr\":true}}}' https://$FMCip/rest/fmc/chapters"
AddServerSideTrafficChapterOut=`$AddServerSideTrafficChapterCmd`
# Get Chapter ID for use in Widgets.
AddServerSideTrafficChapterID=`echo $AddServerSideTrafficChapterOut | jq -r '.id'`
# Get Channel IDs for use in Widgets.
# Channel IDs refer to Channels in the VS Profile.
AddServerSideTrafficChannels=`echo $AddServerSideTrafficChapterOut | jq '.channels'`
echo "Chapter ID:" $AddServerSideTrafficChapterID
echo "Channels:" $AddServerSideTrafficChannels

echo "Adding chapter for Server Side Traffic...Positive"
# $AppName: Server Side Traffic - Plus (above X line)
AddServerSidePlusTrafficChapterCmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"name\":\"${!VSAppName}: All Real Server Traffic\",\"description\":\"All Real Server Traffic\",\"localization\":{\"name\":{\"en\":\"${!VSAppName}: All Real Server Traffic\",\"cz\":\"\",\"jp\":\"\",\"de\":\"\",\"fr\":\"\",\"es\":\"\"},\"description\":{\"en\":\"${!VSAppName}: All Real Server Traffic\",\"cz\":\"\",\"jp\":\"\",\"de\":\"\",\"fr\":\"\",\"es\":\"\"},\"channelColumnName\":{\"en\":\"${!VSAppName}: All Real Server Traffic\",\"cz\":\"\",\"jp\":\"\",\"de\":\"\",\"fr\":\"\",\"es\":\"\"}},\"type\":\"traffic\",\"profile\":\"$VSProfileID\",\"channels\":[\"$ServerSidePlusChapterChannelID\"],\"channelColumnName\":\"${!VSAppName}: All Real Servers\",\"outputColumns\":[\"${!VSAppName}: All Real Servers\",\"mbps\",\"bps\",\"ibyt\"],\"channelsOrderBy\":\"ibyt\",\"showPercentile\":0,\"volumetric\":{\"flows\":true,\"bytes\":true,\"packets\":true},\"performance\":{\"rtt\":true,\"srt\":true,\"jitter\":true,\"rtr\":true}}}' https://$FMCip/rest/fmc/chapters"
AddServerSidePlusTrafficChapterOut=`$AddServerSidePlusTrafficChapterCmd`
# Get Chapter ID for use in Widgets.
AddServerSidePlusTrafficChapterID=`echo $AddServerSidePlusTrafficChapterOut | jq -r '.id'`
# Get Channel IDs for use in Widgets.
# Channel IDs refer to Channels in the VS Profile.
AddServerSidePlusTrafficChannels=`echo $AddServerSidePlusTrafficChapterOut | jq '.channels'`
echo "Chapter ID:" $AddServerSidePlusTrafficChapterID
echo "Channels:" $AddServerSidePlusTrafficChannels

echo "Adding Chapter for Client Side Traffic..."
# $AppName: Client Side Traffic
AddClientSideTrafficChapterCmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"name\":\"${!VSAppName}: Client Side Traffic Structure\",\"description\":\"${!VSAppName}: Client Side Traffic chapter.\",\"localization\":{\"name\":{\"en\":\"${!VSAppName}: Client Side Traffic Structure\",\"cz\":\"\",\"jp\":\"\",\"de\":\"\",\"fr\":\"\",\"es\":\"\"},\"description\":{\"en\":\"${!VSAppName}: Client Side Traffic Structure\",\"cz\":\"\",\"jp\":\"\",\"de\":\"\",\"fr\":\"\",\"es\":\"\"},\"channelColumnName\":{\"en\":\"${!VSAppName}: All Clients <> ${!VSextip}\",\"cz\":\"\",\"jp\":\"\",\"de\":\"\",\"fr\":\"\",\"es\":\"\"}},\"type\":\"traffic\",\"profile\":\"$VSProfileID\",\"channels\":[\"$ClientSideChapterChannelID\"],\"channelColumnName\":\"${!VSAppName}: All Clients <> ${!VSextip}\",\"outputColumns\":[\"${!VSAppName}: All Clients <> ${!VSextip}\",\"mbps\",\"bps\",\"ibyt\"],\"channelsOrderBy\":\"ibyt\",\"showPercentile\":0,\"volumetric\":{\"flows\":true,\"bytes\":true,\"packets\":true},\"performance\":{\"rtt\":true,\"srt\":true,\"jitter\":true,\"rtr\":true}}}' https://$FMCip/rest/fmc/chapters"
# echo $AddClientSideTrafficChapterCmd
AddClientSideTrafficChapterOut=`$AddClientSideTrafficChapterCmd`
# echo
# echo $AddClientSideTrafficChapterOut
# Get Chapter ID for use in Widgets.
AddClientSideTrafficChapterID=`echo $AddClientSideTrafficChapterOut | jq -r '.id'`
# Get Channel IDs for use in Widgets.
# Channel IDs refer to Channels in the VS Profile.
AddClientSideTrafficChannels==`echo $AddClientSideTrafficChapterOut | jq '.channels'`
echo "Chapter ID:" $AddClientSideTrafficChapterID
echo "Channels:" $AddClientSideTrafficChannels

#
# Add the Widgets
#
# dataEndpoint=fmc_chapter_<CHAPTER_ID>
# columns in visualisation settings = chapter<CHAPTER_ID>col
# visualization settings > settings > id (e.g.: "Virtua-da507d|Channe-877a36") Profile_ID|Channel_ID
	
echo;echo "### Adding Widgets to Dashboard..."
echo "Adding Widget for Total VS/RS Traffic..."
# "$AppName: Total VS/RS Traffic"
AddTotalVSRSWidgetCmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"dashboard\":{\"id\":\"$dbid\",\"name\":\"$dbname\"},\"options\":{\"name\":\"Total VS / RS Traffic Structure\",\"clazz\":\"TimeSeriesAndTableWidget\",\"dataEndpoint\":\"fmc_chapter_$TotalVSRSTrafficChapterID\",\"visualizationSettings\":[{\"index\":0,\"settings\":{\"channel\":\"traffic\",\"series\":\"*\",\"chartOptions\":{\"stacked\":true,\"axis\":\"linear\"}},\"channelName\":\"traffic\"},{\"index\":1,\"settings\":{\"channel\":\"main\",\"percents\":false,\"colorColumn\":true,\"columns\":[\"chapter${TotalVSRSTrafficChapterID}col\",\"mbps\",\"95bps\",\"bps\",\"95ibyt\",\"ibyt\"],\"summaries\":[\"total\"]},\"channelName\":\"main\"}],\"parametersSettings\":[{\"name\":\"aggregation\",\"value\":null,\"show\":false,\"relativeToForm\":false,\"useDefault\":1},{\"name\":\"from\",\"value\":\"h12Ago\",\"show\":true,\"relativeToForm\":false,\"useDefault\":false},{\"name\":\"to\",\"value\":\"now\",\"show\":false,\"relativeToForm\":false,\"useDefault\":1}],\"_isNico\":true},\"layouts\":{\"lg\":{\"x\":0,\"y\":0,\"w\":7,\"h\":11,\"i\":null,\"minW\":2,\"minH\":7},\"md\":{\"x\":0,\"y\":46,\"w\":4,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"sm\":{\"x\":0,\"y\":40,\"w\":3,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"xs\":{\"x\":0,\"y\":40,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":88,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
AddTotalVSRSWidgetOut=`$AddTotalVSRSWidgetCmd`
# echo
# echo "AddTotalVSRSWidgetCmd:" $AddTotalVSRSWidgetCmd
# echo
# echo "AddTotalVSRSWidgetOut:" $AddTotalVSRSWidgetOut
TotalVSRSWidgetID=`echo $AddTotalVSRSWidgetOut | jq -r '.id'`
echo "Total VS/RS Traffic Widget ID:" $TotalVSRSWidgetID
# PUT coordinates so they actually take effect!
ModifyTotalVSRSWidgetCmd="eval $cmdlinebegin -X PUT -d '{\"entity\":{\"id\":\"$TotalVSRSWidgetID\",\"layouts\":{\"lg\":{\"x\":0,\"y\":0,\"w\":7,\"h\":11,\"i\":\"$TotalVSRSWidgetID\",\"minW\":2,\"minH\":7},\"md\":{\"x\":0,\"y\":46,\"w\":4,\"h\":8,\"i\":\"$TotalVSRSWidgetID\",\"minW\":2,\"minH\":7},\"sm\":{\"x\":0,\"y\":40,\"w\":3,\"h\":8,\"i\":\"$TotalVSRSWidgetID\",\"minW\":2,\"minH\":7},\"xs\":{\"x\":0,\"y\":40,\"w\":2,\"h\":8,\"i\":\"$TotalVSRSWidgetID\",\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":88,\"w\":2,\"h\":8,\"i\":\"$TotalVSRSWidgetID\",\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
ModifyTotalVSRSWidgetOut=`$ModifyTotalVSRSWidgetCmd`
	
echo "Adding Widget for Client Side Traffic..."
# "$AppName: Client Side Traffic"
AddClientSideTrafficWidgetCmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"dashboard\":{\"id\":\"$dbid\",\"name\":\"$dbname\"},\"options\":{\"name\":\"Client Side Traffic Structure\",\"clazz\":\"TimeSeriesAndTableWidget\",\"dataEndpoint\":\"fmc_chapter_$AddClientSideTrafficChapterID\",\"visualizationSettings\":[{\"index\":0,\"settings\":{\"channel\":\"traffic\",\"series\":[{\"id\":\"$VSProfileID|$ClientSideChapterChannelID\",\"name\":\"${!VSextip}\",\"color\":\"#996633\"},{\"id\":\"rtt\",\"name\":\"Round Trip Time (RTT)\",\"color\":\"#65F955\"},{\"id\":\"srt\",\"name\":\"Server Response Time (SRT)\",\"color\":\"#000000\"},{\"id\":\"jitter\",\"name\":\"Jitter\",\"color\":\"#8A2700\"}],\"chartOptions\":{\"stacked\":true,\"axis\":\"linear\"}},\"channelName\":\"traffic\"},{\"index\":1,\"settings\":{\"channel\":\"main\",\"percents\":false,\"colorColumn\":true,\"columns\":[\"chapter${AddClientSideTrafficChapterID}col\",\"mbps\",\"bps\",\"ibyt\",\"njavg\",\"nrtt\",\"nsrt\"],\"summaries\":[]},\"channelName\":\"main\"}],\"parametersSettings\":[{\"name\":\"aggregation\",\"value\":null,\"show\":false,\"relativeToForm\":false,\"useDefault\":1},{\"name\":\"from\",\"value\":\"h12Ago\",\"show\":true,\"relativeToForm\":false,\"useDefault\":false},{\"name\":\"to\",\"value\":\"now\",\"show\":false,\"relativeToForm\":false,\"useDefault\":1}],\"_isNico\":true},\"layouts\":{\"lg\":{\"x\":0,\"y\":10,\"w\":7,\"h\":11,\"i\":null,\"minW\":2,\"minH\":7},\"md\":{\"x\":2,\"y\":0,\"w\":5,\"h\":14,\"i\":null,\"minW\":2,\"minH\":7},\"sm\":{\"x\":3,\"y\":0,\"w\":3,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"xs\":{\"x\":2,\"y\":0,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":8,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
AddClientSideTrafficWidgetOut=`$AddClientSideTrafficWidgetCmd`
# echo
# echo "AddClientSideTrafficWidgetCmd:" $AddClientSideTrafficWidgetCmd
# echo
# echo "AddClientSideTrafficWidgetOut:" $AddClientSideTrafficWidgetOut
ClientSideTrafficWidgetID=`echo $AddClientSideTrafficWidgetOut | jq -r '.id'`
echo "Client Side Widget ID:" $ClientSideTrafficWidgetID
# PUT coordinates so they actually take effect!
ModifyClientSideTrafficWidgetCmd="eval $cmdlinebegin -X PUT -d '{\"entity\":{\"id\":\"$ClientSideTrafficWidgetID\",\"layouts\":{\"lg\":{\"x\":0,\"y\":10,\"w\":7,\"h\":11,\"i\":\"$ClientSideTrafficWidgetID\",\"minW\":2,\"minH\":7},\"md\":{\"x\":2,\"y\":0,\"w\":5,\"h\":14,\"i\":\"$ClientSideTrafficWidgetID\",\"minW\":2,\"minH\":7},\"sm\":{\"x\":3,\"y\":0,\"w\":3,\"h\":8,\"i\":\"$ClientSideTrafficWidgetID\",\"minW\":2,\"minH\":7},\"xs\":{\"x\":2,\"y\":0,\"w\":2,\"h\":8,\"i\":\"$ClientSideTrafficWidgetID\",\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":8,\"w\":2,\"h\":8,\"i\":\"$ClientSideTrafficWidgetID\",\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
ModifyClientSideTrafficWidgetOut=`$ModifyClientSideTrafficWidgetCmd`
	
echo "Adding Widget for Server Side Traffic..."
# Name:"$AppName: Server Side Traffic"
AddServerSideTrafficWidgetCmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"dashboard\":{\"id\":\"$dbid\",\"name\":\"$dbname\"},\"options\":{\"name\":\"Server Side Traffic Structure\",\"clazz\":\"TimeSeriesAndTableWidget\",\"dataEndpoint\":\"fmc_chapter_$AddServerSidePlusTrafficChapterID\",\"visualizationSettings\":[{\"index\":0,\"settings\":{\"channel\":\"traffic\",\"series\":[{\"id\":\"srt\",\"name\":\"Server Response Time (SRT)\",\"color\":\"#000000\"},{\"id\":\"rtt\",\"name\":\"Round Trip Time (RTT)\",\"color\":\"#65F955\"},{\"id\":\"jitter\",\"name\":\"Jitter\",\"color\":\"#8A2700\"},{\"id\":\"$VSProfileID|$ServerSidePlusChapterChannelID\",\"name\":\"All Real Server Traffic\",\"color\":\"#003399\"}],\"chartOptions\":{\"stacked\":true,\"axis\":\"linear\"}},\"channelName\":\"traffic\"},{\"index\":1,\"settings\":{\"channel\":\"main\",\"percents\":true,\"colorColumn\":true,\"columns\":[\"chapter${AddServerSidePlusTrafficChapterID}col\",\"mbps\",\"bps\",\"ibyt\",\"njavg\",\"nrtt\",\"nsrt\"],\"summaries\":[]},\"channelName\":\"main\"}],\"parametersSettings\":[{\"name\":\"aggregation\",\"value\":null,\"show\":false,\"relativeToForm\":false,\"useDefault\":1},{\"name\":\"from\",\"value\":\"h12Ago\",\"show\":true,\"relativeToForm\":false,\"useDefault\":false},{\"name\":\"to\",\"value\":\"now\",\"show\":false,\"relativeToForm\":false,\"useDefault\":1}],\"_isNico\":true},\"layouts\":{\"lg\":{\"x\":0,\"y\":18,\"w\":7,\"h\":11,\"i\":null,\"minW\":2,\"minH\":7},\"md\":{\"x\":0,\"y\":14,\"w\":4,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"sm\":{\"x\":0,\"y\":0,\"w\":3,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"xs\":{\"x\":0,\"y\":0,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":16,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
AddServerSideTrafficWidgetOut=`$AddServerSideTrafficWidgetCmd`
# echo;echo "AddServerSideTrafficWidgetCmd:" $AddServerSideTrafficWidgetCmd
# echo;echo "AddServerSideTrafficWidgetOut:" $AddServerSideTrafficWidgetOut
ServerSideTrafficWidgetID=`echo $AddServerSideTrafficWidgetOut | jq -r '.id'`
echo "ServerSide Widget ID:" $ServerSideTrafficWidgetID
# PUT coordinates so they actually take effect!
ModifyServerSideTrafficWidgetCmd="eval $cmdlinebegin -X PUT -d '{\"entity\":{\"id\":\"$ServerSideTrafficWidgetID\",\"layouts\":{\"lg\":{\"x\":0,\"y\":18,\"w\":7,\"h\":11,\"i\":\"$ServerSideTrafficWidgetID\",\"minW\":2,\"minH\":7},\"md\":{\"x\":0,\"y\":14,\"w\":4,\"h\":8,\"i\":\"$ServerSideTrafficWidgetID\",\"minW\":2,\"minH\":7},\"sm\":{\"x\":0,\"y\":0,\"w\":3,\"h\":8,\"i\":\"$ServerSideTrafficWidgetID\",\"minW\":2,\"minH\":7},\"xs\":{\"x\":0,\"y\":0,\"w\":2,\"h\":8,\"i\":\"$ServerSideTrafficWidgetID\",\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":16,\"w\":2,\"h\":8,\"i\":\"$ServerSideTrafficWidgetID\",\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
ModifyServerSideTrafficWidgetOut=`$ModifyServerSideTrafficWidgetCmd`
	
# Name:"$AppName: Real Server Traffic"
j=0
while [[ $j -lt $NumRSs ]]; do
	AddRSTrafficChapterID="AddRS${j}TrafficChapterID"
	RSChapterChannelID="RS${j}ChapterChannelID"
	AddRSTrafficChannelID="AddRS${j}TrafficChannelID"
	RSip="RS${j}ip"
	declare "AddRS${j}TrafficWidgetCmd=eval $cmdlinebegin -X POST -d '{\"entity\":{\"dashboard\":{\"id\":\"$dbid\",\"name\":\"$dbname\"},\"options\":{\"name\":null,\"clazz\":\"TimeSeriesAndTableWidget\",\"dataEndpoint\":\"fmc_chapter_${!AddRSTrafficChapterID}\",\"visualizationSettings\":[{\"index\":0,\"settings\":{\"channel\":\"traffic\",\"series\":[{\"id\":\"$VSProfileID|${!RSChapterChannelID}\",\"name\":\"RS ${!RSip} Traffic\",\"color\":\"#003399\"},{\"id\":\"jitter\",\"name\":\"Jitter\",\"color\":\"#8A2700\"},{\"id\":\"rtt\",\"name\":\"Round Trip Time (RTT)\",\"color\":\"#65F955\"},{\"id\":\"srt\",\"name\":\"Server Response Time (SRT)\",\"color\":\"#000000\"}],\"chartOptions\":{\"stacked\":true,\"axis\":\"linear\"}},\"channelName\":\"traffic\"},{\"index\":1,\"settings\":{\"channel\":\"main\",\"percents\":false,\"colorColumn\":true,\"columns\":[\"chapter${!AddRSTrafficChannelID}col\",\"mbps\",\"95bps\",\"bps\",\"95ibyt\",\"ibyt\",\"nsrt\",\"nrtt\",\"njavg\"],\"summaries\":[]},\"channelName\":\"main\"}],\"parametersSettings\":[{\"name\":\"aggregation\",\"value\":null,\"show\":false,\"relativeToForm\":false,\"useDefault\":1},{\"name\":\"from\",\"value\":\"h12Ago\",\"show\":true,\"relativeToForm\":false,\"useDefault\":false},{\"name\":\"to\",\"value\":\"now\",\"show\":false,\"relativeToForm\":false,\"useDefault\":1}],\"_isNico\":true},\"layouts\":{\"lg\":{\"x\":0,\"y\":18,\"w\":7,\"h\":11,\"i\":null,\"minW\":2,\"minH\":7},\"md\":{\"x\":0,\"y\":14,\"w\":4,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"sm\":{\"x\":0,\"y\":0,\"w\":3,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"xs\":{\"x\":0,\"y\":0,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":16,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
	AddRSTrafficWidgetCmd="AddRS${j}TrafficWidgetCmd"
	AddRSTrafficWidgetOut=`${!AddRSTrafficWidgetCmd}`
	# echo;echo "AddRSTrafficWidgetCmd:" $AddRSTrafficWidgetCmd
	# echo;echo "AddRSTrafficWidgetOut:" $AddRSTrafficWidgetOut
	RSTrafficWidgetID=`echo $AddRSTrafficWidgetOut | jq -r '.id'`
	echo "RS Traffic Widget ID:" $RSTrafficWidgetID
	# PUT coordinates so they actually take effect!
	ModifyRSTrafficWidgetCmd="eval $cmdlinebegin -X PUT -d '{\"entity\":{\"id\":\"$RSTrafficWidgetID\",\"layouts\":{\"lg\":{\"x\":0,\"y\":18,\"w\":7,\"h\":11,\"i\":\"$RSTrafficWidgetID\",\"minW\":2,\"minH\":7},\"md\":{\"x\":0,\"y\":14,\"w\":4,\"h\":8,\"i\":\"$RSTrafficWidgetID\",\"minW\":2,\"minH\":7},\"sm\":{\"x\":0,\"y\":0,\"w\":3,\"h\":8,\"i\":\"$RSTrafficWidgetID\",\"minW\":2,\"minH\":7},\"xs\":{\"x\":0,\"y\":0,\"w\":2,\"h\":8,\"i\":\"$RSTrafficWidgetID\",\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":16,\"w\":2,\"h\":8,\"i\":\"$RSTrafficWidgetID\",\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
	ModifyRSTrafficWidgetOut=`$ModifyRSTrafficWidgetCmd`
	j=`expr $j + 1`
done
	
# Name:"$AppName: Server Side Retransmissions"
AddServerSideRTRWidgetCmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"dashboard\":{\"id\":\"$dbid\",\"name\":\"$dbname\"},\"options\":{\"name\":\"RS Retransmissions (All Real Servers)\",\"clazz\":\"SummariesWidget\",\"dataEndpoint\":\"fmc_chapter_$AddServerSidePlusTrafficChapterID\",\"visualizationSettings\":[{\"index\":0,\"settings\":{\"channel\":\"metricTileSummary\",\"columns\":[\"nretr\",\"nrtt\",\"nsrt\",\"bps\"]},\"channelName\":\"metricTileSummary\"},{\"index\":1,\"settings\":{\"channel\":\"metricPerformanceBar\"},\"channelName\":\"metricPerformanceBar\"}],\"parametersSettings\":[{\"name\":\"aggregation\",\"value\":null,\"show\":false,\"relativeToForm\":false,\"useDefault\":1},{\"name\":\"from\",\"value\":\"h12Ago\",\"show\":true,\"relativeToForm\":false,\"useDefault\":false},{\"name\":\"to\",\"value\":\"now\",\"show\":false,\"relativeToForm\":false,\"useDefault\":1}],\"_isNico\":true},\"layouts\":{\"lg\":{\"x\":7,\"y\":21,\"w\":4,\"h\":11,\"i\":null,\"minW\":2,\"minH\":7},\"md\":{\"x\":4,\"y\":22,\"w\":4,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"sm\":{\"x\":0,\"y\":16,\"w\":3,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"xs\":{\"x\":0,\"y\":16,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":40,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
AddServerSideRTRWidgetOut=`$AddServerSideRTRWidgetCmd`
# echo
# echo "AddServerSideRTRWidgetCmd:" $AddServerSideRTRWidgetCmd
# echo
# echo "AddServerSideRTRWidgetOut:" $AddServerSideRTRWidgetOut
ServerSideRTRWidgetID=`echo $AddServerSideRTRWidgetOut | jq -r '.id'`
echo "Server Side RTR Widget ID:" $ServerSideRTRWidgetID
# PUT coordinates so they actually take effect!
ModifyServerSideRTRWidgetCmd="eval $cmdlinebegin -X PUT -d '{\"entity\":{\"id\":\"$ServerSideRTRWidgetID\",\"layouts\":{\"lg\":{\"x\":7,\"y\":21,\"w\":4,\"h\":11,\"i\":\"$ServerSideRTRWidgetID\",\"minW\":2,\"minH\":7},\"md\":{\"x\":4,\"y\":22,\"w\":4,\"h\":8,\"i\":\"$ServerSideRTRWidgetID\",\"minW\":2,\"minH\":7},\"sm\":{\"x\":0,\"y\":16,\"w\":3,\"h\":8,\"i\":\"$ServerSideRTRWidgetID\",\"minW\":2,\"minH\":7},\"xs\":{\"x\":0,\"y\":16,\"w\":2,\"h\":8,\"i\":\"$ServerSideRTRWidgetID\",\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":40,\"w\":2,\"h\":8,\"i\":\"$ServerSideRTRWidgetID\",\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
ModifyServerSideRTRWidgetOut=`$ModifyServerSideRTRWidgetCmd`

j=0
while [[ $j -lt $NumRSs ]]; do
	AddRSTrafficChapterID="AddRS${j}TrafficChapterID"
	AddRSRTRWidgetCmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"dashboard\":{\"id\":\"$dbid\",\"name\":\"$dbname\"},\"options\":{\"name\":null,\"clazz\":\"SummariesWidget\",\"dataEndpoint\":\"fmc_chapter_${!AddRSTrafficChapterID}\",\"visualizationSettings\":[{\"index\":0,\"settings\":{\"channel\":\"metricTileSummary\",\"columns\":[\"nretr\",\"nretrmax\",\"nsrt\",\"nsrtmax\"]},\"channelName\":\"metricTileSummary\"},{\"index\":1,\"settings\":{\"channel\":\"metricPerformanceBar\"},\"channelName\":\"metricPerformanceBar\"}],\"parametersSettings\":[{\"name\":\"aggregation\",\"value\":null,\"show\":false,\"relativeToForm\":false,\"useDefault\":1},{\"name\":\"from\",\"value\":\"h12Ago\",\"show\":true,\"relativeToForm\":false,\"useDefault\":false},{\"name\":\"to\",\"value\":\"now\",\"show\":false,\"relativeToForm\":false,\"useDefault\":1}],\"_isNico\":true},\"layouts\":{\"lg\":{\"x\":7,\"y\":21,\"w\":4,\"h\":11,\"i\":null,\"minW\":2,\"minH\":7},\"md\":{\"x\":0,\"y\":30,\"w\":4,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"sm\":{\"x\":3,\"y\":16,\"w\":3,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"xs\":{\"x\":2,\"y\":16,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":48,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
	AddRSRTRWidgetOut=`$AddRSRTRWidgetCmd`
	# echo
	# echo "AddRSRTRWidgetCmd:" $AddRSRTRWidgetCmd
	# echo
	# echo "AddRSRTRWidgetOut:" $AddRSRTRWidgetOut
	RSRTRWidgetID=`echo $AddRSRTRWidgetOut | jq -r '.id'`
	echo "RS RTR Widget ID:" $RSRTRWidgetID
	# PUT coordinates so they actually take effect!
	ModifyRSRTRWidgetCmd="eval $cmdlinebegin -X PUT -d '{\"entity\":{\"id\":\"$RSRTRWidgetID\",\"layouts\":{\"lg\":{\"x\":7,\"y\":21,\"w\":4,\"h\":11,\"i\":\"$RSRTRWidgetID\",\"minW\":2,\"minH\":7},\"md\":{\"x\":0,\"y\":30,\"w\":4,\"h\":8,\"i\":\"$RSRTRWidgetID\",\"minW\":2,\"minH\":7},\"sm\":{\"x\":3,\"y\":16,\"w\":3,\"h\":8,\"i\":\"$RSRTRWidgetID\",\"minW\":2,\"minH\":7},\"xs\":{\"x\":2,\"y\":16,\"w\":2,\"h\":8,\"i\":\"$RSRTRWidgetID\",\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":48,\"w\":2,\"h\":8,\"i\":\"$RSRTRWidgetID\",\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
	ModifyRSRTRWidgetOut=`$ModifyRSRTRWidgetCmd`
	j=`expr $j + 1`
done	
	
# Name:"$AppName: Client Side Retransmissions"
AddClientSideRTRWidgetCmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"dashboard\":{\"id\":\"$dbid\",\"name\":\"$dbname\"},\"options\":{\"name\":\"Client Side Retransmissions\",\"clazz\":\"SummariesWidget\",\"dataEndpoint\":\"fmc_chapter_$AddClientSideTrafficChapterID\",\"visualizationSettings\":[{\"index\":0,\"settings\":{\"channel\":\"metricTileSummary\",\"columns\":[\"nretr\",\"nretrmax\",\"nrttmax\",\"njmax\"]},\"channelName\":\"metricTileSummary\"},{\"index\":1,\"settings\":{\"channel\":\"metricPerformanceBar\"},\"channelName\":\"metricPerformanceBar\"}],\"parametersSettings\":[{\"name\":\"aggregation\",\"value\":null,\"show\":false,\"relativeToForm\":false,\"useDefault\":1},{\"name\":\"from\",\"value\":\"h12Ago\",\"show\":true,\"relativeToForm\":false,\"useDefault\":false},{\"name\":\"to\",\"value\":\"now\",\"show\":false,\"relativeToForm\":false,\"useDefault\":1}],\"_isNico\":true},\"layouts\":{\"lg\":{\"x\":7,\"y\":11,\"w\":4,\"h\":11,\"i\":null,\"minW\":2,\"minH\":7},\"md\":{\"x\":4,\"y\":38,\"w\":4,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"sm\":{\"x\":3,\"y\":32,\"w\":3,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"xs\":{\"x\":2,\"y\":32,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":80,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
AddClientSideRTRWidgetOut=`$AddClientSideRTRWidgetCmd`
# echo
# echo "AddClientSideRTRWidgetCmd:" $AddClientSideRTRWidgetCmd
# echo
# echo "AddClientSideRTRWidgetOut:" $AddClientSideRTRWidgetOut
ClientSideRTRWidgetID=`echo $AddClientSideRTRWidgetOut | jq -r '.id'`
echo "Client Side RTR Widget ID:" $ClientSideRTRWidgetID
# PUT coordinates so they actually take effect!
ModifyClientSideRTRWidgetCmd="eval $cmdlinebegin -X PUT -d '{\"entity\":{\"id\":\"$ClientSideRTRWidgetID\",\"layouts\":{\"lg\":{\"x\":7,\"y\":11,\"w\":4,\"h\":11,\"i\":\"$ClientSideRTRWidgetID\",\"minW\":2,\"minH\":7},\"md\":{\"x\":4,\"y\":38,\"w\":4,\"h\":8,\"i\":\"$ClientSideRTRWidgetID\",\"minW\":2,\"minH\":7},\"sm\":{\"x\":3,\"y\":32,\"w\":3,\"h\":8,\"i\":\"$ClientSideRTRWidgetID\",\"minW\":2,\"minH\":7},\"xs\":{\"x\":2,\"y\":32,\"w\":2,\"h\":8,\"i\":\"$ClientSideRTRWidgetID\",\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":80,\"w\":2,\"h\":8,\"i\":\"$ClientSideRTRWidgetID\",\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
ModifyClientSideRTRWidgetOut=`$ModifyClientSideRTRWidgetCmd`
	
#
# Add the VS Topology Widget
#
# Need to define (in this order): Topology system entity, Nodes, Paths, Topology Widget
echo;echo "### Adding the VS Topology Widget"

AddTopologyCmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"type\":0,\"owningUser\":{\"id\":1,\"login\":\"admin\"},\"owningRole\":{\"id\":1},\"name\":\"${!VSAppName} VS Topology\",\"tenant\":{\"id\":\"00000000-0000-0000-0001-000000000001\",\"name\":\"Base tenant\"},\"ownerCanEdit\":true,\"trafficScale\":50}}' https://$FMCip/rest/fmd/topologies"
AddTopologyOut=`$AddTopologyCmd`
# echo
# echo "AddTopologyCmd:" $AddTopologyCmd
# echo
# echo "AddTopologyOut:" $AddTopologyOut
TopologySystemID=`echo $AddTopologyOut | jq -r '.id'`
echo "Topology System ID:" $TopologySystemID

# Add Nodes (4)

AddVSNodeCmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"coordinates\":{\"x\":\"72.60055108351087\",\"y\":\"-135.35156250000003\"},\"icon\":{\"id\":5,\"name\":\"${!VSAppName} VS\"},\"topology\":{\"id\":\"$TopologySystemID\"},\"name\":\"${!VSAppName} VS\"}}' https://$FMCip/rest/fmd/nodes"
AddVSNodeOut=`$AddVSNodeCmd`
# echo
# echo "AddVSNodeCmd:" $AddVSNodeCmd
# echo
# echo "AddVSNodeOut:" $AddVSNodeOut
VSNodeID=`echo $AddVSNodeOut | jq -r '.id'`
echo "VS Node ID:" $VSNodeID

AddClientNodeCmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"coordinates\":{\"x\":\"72.60055108351087\",\"y\":\"-142.11914062500003\"},\"icon\":{\"id\":4,\"name\":\"Clients\"},\"topology\":{\"id\":\"$TopologySystemID\"},\"name\":\"Clients\"}}' https://$FMCip/rest/fmd/nodes"
AddClientNodeOut=`$AddClientNodeCmd`
# echo
# echo "AddClientNodeCmd:" $AddClientNodeCmd
# echo
# echo "AddClientNodeOut:" $AddClientNodeOut
ClientNodeID=`echo $AddClientNodeOut | jq -r '.id'`
echo "Client Node ID:" $ClientNodeID
	
# Loop thru the servers
j=0
xcoord=72.00000000000001
while [[ $j -lt $NumRSs ]]; do
	RSip="RS${j}ip"
	AddRSNodeCmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"coordinates\":{\"x\":\"$xcoord\",\"y\":\"-130.6274414062500\"},\"icon\":{\"id\":5,\"name\":\"RS ${!RSip}\"},\"topology\":{\"id\":\"$TopologySystemID\"},\"name\":\"RS ${!RSip}\"}}' https://$FMCip/rest/fmd/nodes"
	AddRSNodeOut=`$AddRSNodeCmd`
	# echo
	# echo "AddRSNodeCmd:" $AddRSNodeCmd
	# echo
	# echo "AddRSNodeOut:" $AddRSNodeOut
	declare "RS${j}NodeID=`echo $AddRSNodeOut | jq -r '.id'`"
	RSNodeID="RS${j}NodeID"
	echo "RS${j}NodeID:" ${!RSNodeID}
	j=`expr $j + 1`
	xcoord=`echo $xcoord + 0.7 | bc`
done

# Add Paths (3)
# TODO: Set the path speed to the link speed taken from the source record for
# the LM for the appropriate interface (possible?) OR add to JSON input
	
# Add Client - VS Path
AddClientVSPathCmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"srcNode\":{\"id\":\"$ClientNodeID\",\"name\":\"Client\"},\"dstNode\":{\"id\":\"$VSNodeID\",\"name\":\"Virtual Service\"},\"channelSrcToDst\":{\"speed\":1000,\"profile\":\"$VSProfileID\",\"channel\":\"$ClientSideChapterChannelID\",\"traffic\":null,\"summary\":null},\"channelDstToSrc\":null,\"topology\":{\"id\":\"$TopologySystemID\"},\"type\":\"symmetric\",\"calculationMode\":\"avg\",\"name\":\"Client-VS Link\"}}' https://$FMCip/rest/fmd/paths"
AddClientVSPathOut=`$AddClientVSPathCmd`
# echo
# echo "AddClientVSPathCmd:" $AddClientVSPathCmd
# echo
# echo "AddClientVSPathOut:" $AddClientVSPathOut
ClientVSPathID=`echo $AddClientVSPathOut | jq -r '.id'`
echo "Client-VS Path ID:" $ClientVSPathID
	
# Loop thru the servers to add VS - RS Paths
# TODO: auto-space the servers depending on how many
j=0
while [[ $j -lt $NumRSs ]]; do
	RSip="RS${j}ip"
	RSNodeID="RS${j}NodeID"
	RSChapterChannelID="RS${j}ChapterChannelID"
	declare "AddVSRS${j}PathCmd=eval $cmdlinebegin -X POST -d '{\"entity\":{\"srcNode\":{\"id\":\"$VSNodeID\",\"name\":\"Virtual Service\"},\"dstNode\":{\"id\":\"${!RSNodeID}\",\"name\":\"RS:${!RSip}\"},\"channelSrcToDst\":{\"speed\":1000,\"profile\":\"$VSProfileID\",\"channel\":\"${!RSChapterChannelID}\",\"traffic\":null,\"summary\":null},\"channelDstToSrc\":null,\"topology\":{\"id\":\"$TopologySystemID\"},\"type\":\"symmetric\",\"calculationMode\":\"avg\",\"name\":\"VS-RS:${!RSip} Link\"}}' https://$FMCip/rest/fmd/paths"
	AddVSRSPathCmd="AddVSRS${j}PathCmd"
	AddVSRSPathOut=`${!AddVSRSPathCmd}`
	# echo
	# echo "AddVSRSPathCmd:" $AddVSRSPathCmd
	# echo
	# echo "AddVSRSPathOut:" $AddVSRSPathOut
	VSRSPathID=`echo $AddVSRSPathOut | jq -r '.id'`
	echo "VS-RS (${!RSip}) Path ID:" $VSRSPathID
	j=`expr $j + 1`
done	
	
# Add Topology Widget
AddTopologyWidgetCmd="eval $cmdlinebegin -X POST -d '{\"entity\":{\"dashboard\":{\"id\":\"$dbid\",\"name\":\"$dbname\"},\"options\":{\"name\":\"${!VSAppName} VS Topology\",\"clazz\":\"TopologyWidget\",\"dataEndpoint\":\"TOPOLOGY_$TopologySystemID\",\"visualizationSettings\":[{\"index\":0,\"settings\":{\"channel\":\"TopoVisuChannelId\"},\"channelName\":\"TopoVisuChannelId\"}],\"parametersSettings\":[{\"name\":\"from\",\"value\":\"h12Ago\",\"show\":true,\"relativeToForm\":false,\"useDefault\":false},{\"name\":\"to\",\"value\":\"now\",\"show\":false,\"relativeToForm\":false,\"useDefault\":1}],\"_isNico\":true},\"layouts\":{\"lg\":{\"x\":7,\"y\":0,\"w\":4,\"h\":11,\"i\":null,\"minW\":2,\"minH\":7},\"md\":{\"x\":0,\"y\":30,\"w\":4,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"sm\":{\"x\":3,\"y\":24,\"w\":3,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"xs\":{\"x\":2,\"y\":24,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":64,\"w\":2,\"h\":8,\"i\":null,\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
AddTopologyWidgetOut=`$AddTopologyWidgetCmd`
# echo
# echo "AddTopologyWidgetCmd:" $AddTopologyWidgetCmd
# echo
# echo "AddTopologyWidgetOut:" $AddTopologyWidgetOut
TopologyWidgetID=`echo $AddTopologyWidgetOut | jq -r '.id'`
echo "Topology Widget ID:" $TopologyWidgetID
# PUT coordinates so they actually take effect!
ModifyTopologyWidgetCmd="eval $cmdlinebegin -X PUT -d '{\"entity\":{\"id\":\"$TopologyWidgetID\",\"layouts\":{\"lg\":{\"x\":7,\"y\":0,\"w\":4,\"h\":11,\"i\":\"$TopologyWidgetID\",\"minW\":2,\"minH\":7},\"md\":{\"x\":0,\"y\":30,\"w\":4,\"h\":8,\"i\":\"$TopologyWidgetID\",\"minW\":2,\"minH\":7},\"sm\":{\"x\":3,\"y\":24,\"w\":3,\"h\":8,\"i\":\"$TopologyWidgetID\",\"minW\":2,\"minH\":7},\"xs\":{\"x\":2,\"y\":24,\"w\":2,\"h\":8,\"i\":\"$TopologyWidgetID\",\"minW\":2,\"minH\":7},\"xxs\":{\"x\":0,\"y\":64,\"w\":2,\"h\":8,\"i\":\"$TopologyWidgetID\",\"minW\":2,\"minH\":7}}}}' https://$FMCip/rest/fmd/overview/widgets"
ModifyTopologyWidgetOut=`$ModifyTopologyWidgetCmd`

i=`expr $i + 1` # increment the VS loop counter
done < $InputFile
### END of the VS processing loop

echo;echo "### Collector Setup Completed. Log in to https://$FMCip using admin/admin to see your LoadMaster Dashboards!";echo
#
# Done
#
