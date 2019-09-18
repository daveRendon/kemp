## Deploy a Kemp LoadMaster in 1 minute on Hyper-V using PowerShell

### Steps:
 1. Go to [kemp.ax/vlm-download](https://kemp.ax/vlm-download) and download the latest version of the Kemp LoadMaster
 2. Open PowerShell and convert the VHD to VHDX - execute Line 2 only, provide the directory where the VHD is located and then provide the location where you want to store the vhdx
 3. Execute the rest of the script
 4. Go to Hyper-V manager and connect to the VM

```powershell
#Convert the VHD to VHDX before
#Convert-VHD "C:\Users\Public\Documents\Hyper-V\Virtual hard disks\LoadMaster.vhd" "C:\Users\Public\Documents\Hyper-V\Virtual hard disks\LoadMaster.vhdx"
$name = read-host "Enter VM Name"
$Path = "C:\Users\Public\Documents\Hyper-V\Virtual hard disks\"
New-VHD -Path "$path\$name.vhdx" -ParentPath "$path\LoadMaster.vhdx" -Differencing
New-VM -name $name -vhdpath "$path\$name.vhdx" -computername "localhost" -SwitchName "Default Switch"
$vm = get-vm $name
Set-VM $vm -AutomaticStartAction Nothing
Set-VM $vm -AutomaticStopAction ShutDown
Set-VM $vm -DynamicMemory
Set-VM $vm -MemoryMaximumBytes 2147483648 #2gb -> 2147483648
Set-VM $vm -MemoryStartupBytes 2147483648
Set-VM $vm -ProcessorCount 2

Start-VM $vm
```

Result:

```powershell
Size                    : 17179869184
MinimumSize             : 16779313152
LogicalSectorSize       : 512
PhysicalSectorSize      : 512
BlockSize               : 2097152
ParentPath              : C:\Users\Public\Documents\Hyper-V\Virtual hard disks\LoadMaster.vhdx
DiskIdentifier          : 058C5030-9345-44E5-ACDC-7AABB2286AC9
FragmentationPercentage :
Alignment               : 1
Attached                : False
DiskNumber              :
IsPMEMCompatible        : False
AddressAbstractionType  : None
Number                  :

Name             : kemp-loadmaster
State            : Off
CpuUsage         : 0
MemoryAssigned   : 0
MemoryDemand     : 0
MemoryStatus     :
Uptime           : 00:00:00
Status           : Operating normally
ReplicationState : Disabled
Generation       : 1
```

Any question reach me at @DaveRndn on Twitter 
