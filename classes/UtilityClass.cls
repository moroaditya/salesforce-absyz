/***********************************
Apex Class: UtilityClass
Description: This class is used to add reusable components 
                that will be common across the org.
Created Date: 27thMarch,2014
************************************/
global with sharing class UtilityClass {

public static Boolean updateFromQuoteTrigger = false;
public static Boolean updateFromInfluencer = false;
public static Boolean runUpdateCorpAcc= true;
public static Boolean runUpdateResident= true;
public static Boolean runUpdatePrelims= true;
public static Boolean doNotRunOnRecTypeChange= true;
public static Boolean doNotRunonTransfer= true;
public static Boolean runOppTrigger= true;
public static Boolean doNotRun=false;
public static Boolean doNotRunOnOrderOppUpdate=true;
public static String opportunityWonStatus = 'Closed/Won';
public static string QuotOrderStage = 'Ordered';
public static string Projectwonsignedstatus = 'Closed Won - Order Signed';
public static string ProjectwonProcessstatus = 'Closed Won - Order In Process';
public static string ProjectwonCompletestatus = 'Closed Complete - Ordered - Paid';
public static Boolean runQuoteTrigger = true;

/*********************************
Method Name: getStringValue
Description: Getting values from Custom setting HardCodingUtility
Input Parameter: String
*********************************/
public static String getStringValue(String instanceVar){
String value;
HardCodingUtility__c literalValue = HardCodingUtility__c.getInstance(instanceVar);
if(literalValue != null){
value = literalValue.value__c;
} 
return value; 
}


webservice static Boolean checkContactRoles(Id oppId)
{
    List<OpportunityContactRole> oppConList = [Select Id,OpportunityId,Contact.AccountId,Opportunity.AccountId from OpportunityContactRole where OpportunityId=:oppId];
    if(oppConList.size()>0)
     {
     return true ;
     }
     else{
     return false ;
     }
}



webservice static Boolean validateContactRoles(Id oppId)
{
    system.debug('Check for Value::'+oppId);
    List<OpportunityContactRole> oppConList = [Select Id,OpportunityId,Contact.AccountId,Opportunity.AccountId from OpportunityContactRole where OpportunityId=:oppId];
    if(oppConList.size()>0)
    {
     Integer counter=0;
      for(OpportunityContactRole oppCon:oppConList)
      {
          if(oppCon.Contact.AccountId!=oppCon.Opportunity.AccountId)
              {
                  counter++;
              }
       }
       if(counter>0)
       {
       return false;
       }
       else{
      return true;
      }
    }
    else
    {
    return false;
    }
}

}