/**********************************************************************
Apex Class: SuccessRatioDynamicHelperClass
Description: This class is a helper class for successRatioDynamicContorller
Created Date: 4th August,2016            
***********************************************************************/
public class SuccessRatioDynamicHelperClass {
	
/**********************************************************************
Apex Method: projectFetching
Description: This method is used to fetch project having no budget quotes
Created Date: 4th August,2016            
***********************************************************************/ 	
	@RemoteAction
	@ReadOnly
	public static set<id> projectFetching()
	{
		//Local Variables
		set<id> projectIdFinalSet = new set<id>();
 		list<Opportunity> oppList = [select id, Budget_Quote__c, Project_Name__c, Quote_Count__c from Opportunity where Quote_Count__c>0 AND Budget_Quote__c= FALSE AND CALENDAR_YEAR(convertTimezone(Project_Name__r.createdDate))>=2012];            
        
        for(Opportunity opp: oppList)
        {
            projectIdFinalSet.add(opp.Project_Name__c);
        }
		return projectIdFinalSet;
	}
}