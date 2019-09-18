# Deploy a KEMP LoadMaster high availability (HA) Pair

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FdaveRendon%2FKEMP%2Fmaster%2FProof-Of-Concept%2FHA-Scenario%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FdaveRendon%2FKEMP%2Fmaster%2FProof-Of-Concept%2FHA-Scenario%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

This template deploys a KEMP LoadMaster high availability (HA) Pair. Once deployed an end-user can setup two KEMP Virtual LoadMasters as outlined in the [LoadMaster Documentation](https://support.kemptechnologies.com/hc/en-us/articles/203859775-HA-for-Azure-Marketplace-Classic-Interface-)

More information can be [found here](https://kemptechnologies.com/solutions/microsoft-load-balancing/loadmaster-azure/).

Specifically, the template provides:
* An Azure Internal LoadBalancer
* Azure ILB Probe
* LB Rules
* NAT Rules 



Topology
--------

<img src="https://github.com/daveRendon/KEMP/blob/master/Proof-Of-Concept/HA-Scenario/HA-Azure-ARMVIZIO.png" >


Notes, Known Issues & Limitations
--------
- To access the individual Virtual Loadmaster, you need to use the publicly accessible endpoint i.e. https://yourip:8443
- SSH key is not yet implemented and the template currently takes a password for the admin user
