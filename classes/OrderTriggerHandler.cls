public class OrderTriggerHandler {
	 /*  
         Method Name    : CreateInstallation
         Purpose        : Create installation if ETA date is filled in quote
         Input Parameter: List of Quote
         Created Date   : August 2016
         */
    
    public static void CreateInstallation(List < Order > newTrigger){
        list<Installation__c> lstInstallation = new list<Installation__c>();
        list <id> QuoteId = new list<id>();
            
            for(order ord : newTrigger){
				QuoteId.add(ord.NanaQuote__c);
            }
        list <Quote__c> lstQuote = [SELECT id , Shipping_Name__c , Shipping_Company__c , Shipping_Phone__c , Freight_ETA_Jobsite__c , Freight_Tracking_Number__c FROM Quote__c WHERE id IN: QuoteId];
        for(order ord : newTrigger){
            for(Quote__c q : lstQuote ){
                if(Ord.Shipping_Min_from_Quote__c != null && Ord.Order_Finalized_Date__c != null){
                	Decimal d = Ord.Shipping_Min_from_Quote__c * 7 ; 
                	Integer Days = d.intValue();
                	
                 lstInstallation.add(new Installation__c(
                        Account__c = ord.AccountId, 
                        Contact__c = ord.Contact__c,
                     	Installation_Date__c = ord.Order_Finalized_Date__c.addDays(Days),
                        Order__c = ord.id , 
                   	    Status__c = 'Assigned' ,
                        Project__c = ord.Project__c ,
                 		Shipping_Name__c = q.Shipping_Name__c,
                        Shipping_Company__c = q.Shipping_Company__c,
                        Shipping_Phone__c = q.Shipping_Phone__c,
                        Freight_ETA_Jobsite__c = q.Freight_ETA_Jobsite__c,
                        Freight_Tracking_Number__c = q.Freight_Tracking_Number__c
                 )) ; 
            }
            }
            
            try{
 
           insert lstInstallation ; 
        }
        catch(exception e){
            system.debug('Exception is:' +e);
        }
            
        }   
        
    }
}