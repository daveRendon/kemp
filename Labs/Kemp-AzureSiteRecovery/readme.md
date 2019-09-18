# This is a quick guide to perform Azure Site Recovery for a Kemp Virtual LoadMaster on Azure (Azure Region to Region)

## Provision the Kemp LoadMaster on Azure

* Go to the Azure Portal and provision your Kemp LoadMaster, for this specific guide we will select the BYOL version.  

![alt text](https://github.com/daveRendon/kemp/blob/master/images/azure-site-recovery/kemp-tools-asr-deploy-vlm.png)

![alt text](https://github.com/daveRendon/kemp/blob/master/images/azure-site-recovery/kemp-tools-asr-02.png)

* Once the setup is complete go to the VM Overview blade and copy the IP Address

![alt text](https://github.com/daveRendon/kemp/blob/master/images/azure-site-recovery/kemp-tools-asr-03.png)

* Open a new tab in your browser and access to the VLM: 

![alt text](https://github.com/daveRendon/kemp/blob/master/images/azure-site-recovery/kemp-tools-asr-04.png)

* Provide the credentials using "bal" as user

![alt text](https://github.com/daveRendon/kemp/blob/master/images/azure-site-recovery/kemp-tools-asr-05.png)

![alt text](https://github.com/daveRendon/kemp/blob/master/images/azure-site-recovery/kemp-tools-asr-06.png)

![alt text](https://github.com/daveRendon/kemp/blob/master/images/azure-site-recovery/kemp-tools-asr-07.png)

* On the EULA page Click on Agree 

![alt text](https://github.com/daveRendon/kemp/blob/master/images/azure-site-recovery/kemp-tools-asr-08.png)

* Now login using your Kemp ID and password. You can get a Kemp ID here: https://kemptechnologies.com/kemp-id-registration/

* Select your license and click continue twice. 

![alt text](https://github.com/daveRendon/kemp/blob/master/images/azure-site-recovery/kemp-tools-asr-09.png)

![alt text](https://github.com/daveRendon/kemp/blob/master/images/azure-site-recovery/kemp-tools-asr-010.png)




## Enabling Azure Site Recovery for Kemp LoadMaster

* Now that you have access to the LoadMaster let´s go back to the Azure Portal. 

![alt text](https://github.com/daveRendon/kemp/blob/master/images/azure-site-recovery/kemp-tools-asr-011.png)

* Select the region you want to enable as secondary for replication and click on advanced settings

![alt text](https://github.com/daveRendon/kemp/blob/master/images/azure-site-recovery/kemp-tools-asr-012.png)

* Review the replication settings and click next 

![alt text](https://github.com/daveRendon/kemp/blob/master/images/azure-site-recovery/kemp-tools-asr-013.png)

* Check the final validation 

![alt text](https://github.com/daveRendon/kemp/blob/master/images/azure-site-recovery/kemp-tools-asr-014.png)

* 

## Option 2

* Create a backup vault
