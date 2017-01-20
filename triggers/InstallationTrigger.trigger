/*********************************************************************************************************************
Trigger Name: InstallationTrigger
Events: before insert ,after insert, after update, before update
Description: To handle different functionalities on Installation in Installation Management
**********************************************************************************************************************/


trigger InstallationTrigger on Installation__c(before insert ,after insert, after update, before update) {

    //Added by Satish Lokinindi For updating Order Product details on to the Installation object
    if(trigger.isInsert && trigger.isAfter){
   
    InstallationTriggerHandler.udpateInstallationPosition(Trigger.new);
    }
   
     List < Installation__c > InstallationUserList = new List < Installation__c > ();
    for(installation__c i : trigger.new){
        if((Trigger.isBefore) && ((trigger.isInsert)||(trigger.isUpdate && (trigger.oldMap.get(i.ID).Installer_Contact__c !=i.Installer_Contact__c)))){
             InstallationUserList.add(i);
           
           
        }
        
        
    }
        
    //for assigning installer user 
     InstallationTriggerHandler.updateInstallerUser(InstallationUserList);
    
    
   
   
    if(trigger.isInsert && trigger.isBefore){
                // for updating Names of Installation Ticket
                 InstallationTriggerHandler.updateInstallationName(Trigger.new);
                 //for creating task for Owner
                 InstallationTriggerHandler.CreateOwnerTask(Trigger.new);
    }
    
       
    
     List < Installation__c > InstallationAccountList = new List < Installation__c > ();
    for(installation__c i : trigger.new){
        if((Trigger.isBefore) && ((trigger.isInsert)||(trigger.isUpdate && (trigger.oldMap.get(i.ID).Project__c !=i.Project__c)))){
            InstallationAccountList.add(i) ; 
            
           
        }
        
        
    }
    //for assigning installer account and contact to installtion record
    
    InstallationTriggerHandler.AssignInstaller(InstallationAccountList);
    
   
   
    
    List < Installation__c > InstallationShareList = new List < Installation__c > ();
    for(installation__c i : trigger.new){
    
       
        if((trigger.isInsert)&&(Trigger.isAfter) && (i.Account__c != null)){
            InstallationShareList = Trigger.newMap.values();
          
            
        }
        
        
        
    }
    
     if(trigger.isInsert && trigger.isAfter){
                    //for creating task for Installer
                 InstallationTriggerHandler.CreateOwnerTask(Trigger.new);
    }

    
    
    //for sharing account and project record to Installer
    InstallationTriggerHandler.manualShareRead(InstallationShareList) ; 
    
    
    

    
    
     /***
      PURPOSE: For updating Entitlements start date,Certified Installer check box based on different conditions
       ***/
       
        //To update the entitlement based on the Installation fields
        try{
        List<Installation__c> instList = new List<Installation__c>();
        if((trigger.isInsert && trigger.isAfter)||(trigger.isupdate && trigger.isAfter)){

            InstallationTriggerHandler.updateEntitlement(trigger.new);
        }
        }catch(exception e){}
        
   

}