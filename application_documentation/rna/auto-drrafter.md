#auto-DRRAFTER: Automatically model RNA coordinates into cryo-EM maps

##Metadata

Author: Kalli Kappel (kappel at stanford dot edu)  
Last updated: December 2019

##Application purpose

auto-DRRAFTER is used to build RNA coordinates into cryo-EM maps. Unlike DRRAFTER, it does not require initial manual helix placement. Currently, auto-DRRAFTER works only for systems that only RNA.

##Reference
auto-DRRAFTER is described in [this paper](https://www.biorxiv.org/content/10.1101/717801v1):  
Kappel, K.\*, Zhang, K.\*, Su, Z.\*, Kladwang, W., Li, S., Pintilie, G., Topkar, V.V., Rangan, R., Zheludev, I.N., Watkins, A.M., Yesselman, J.D., Chiu, W., Das, R. (2019). Ribosolve: Rapid determination of three-dimensional RNA-only structures. bioRxiv.

##Code and demo
auto-DRRAFTER code will be available in the Rosetta weekly releases after 2019.47 (it is not available in 2019.47). **auto-DRRAFTER is NOT available in Rosetta 3.11**.

All of the auto-DRRAFTER scripts are located in `ROSETTA_HOME/demos/public/DRRAFTER/`.

##Setting up auto-DRRAFTER
  
1. Download Rosetta here <https://www.rosettacommons.org/software/license-and-download>. You will need to get a license before downloading Rosetta (free for academic users). auto-DRRAFTER will be available starting in Rosetta weekly releases *after* 2019.47. **auto-DRRAFTER is NOT available in Rosetta 3.11 (it will be available in 3.12)**.  
2. If you're not using the precompiled binaries (these are available for Mac and Linux and you can access them by downloading source+binaries in Step 1), install Rosetta following the instructions available [here] (https://www.rosettacommons.org/docs/latest/build_documentation/Build-Documentation).  
3. Make sure you have python installed and install networkx and mrcfile. For example, type: pip install networkx mrcfile
4. Install EMAN2 version 2.22 (https://blake.bcm.edu/emanwiki/EMAN2/Install). Confirm that e2proc3d.py and e2segment3d.py are installed by typing:   
`e2proc3d.py –h`
`e2segment3d.py –h` 
You should see usage instructions for each of these commands.  
5. Install Rosetta RNA tools. See instructions and documentation [here] (https://www.rosettacommons.org/docs/latest/application_documentation/rna/RNA-tools).  
6. Check that the ROSETTA environmental variable is set (you should have set this up during RNA tools installation). Type echo $ROSETTA. This should return the path to your Rosetta directory. If it does not return anything, go back to step 5 and make sure that you follow the steps for RNA tools setup.  
7. Add the path to the auto-DRRAFTER scripts to your $PATH (alternatively, you can type the full path to the scripts each time that you use them). They are found in main/source/src/apps/public/DRRAFTER/ in your Rosetta directory. An example for bash:  
`export PATH=$PATH:$ROSETTA/main/source/src/apps/public/DRRAFTER/` 