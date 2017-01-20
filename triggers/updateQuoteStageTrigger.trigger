trigger updateQuoteStageTrigger on Order (after insert , after update) {
    
    /********************
    Created to Update stages on Quote/Opportunity/Project object based on Changes on Order object
    *********************/
   if(trigger.isAfter){
        Set<ID> qIdList = new Set<ID>();
         Set<ID> pSetIds = new Set<ID>();
         Set<ID> oSetIds = new Set<ID>();
         set<ID> p = trigger.newmap.keyset();
        map<Id,String> mapStatus = new  map<Id,String>();
        for(Order ord : trigger.New){
        if(trigger.isInsert || (trigger.isUpdate && trigger.oldMap !=  null && trigger.oldMap.get(ord.id).Status!=ord.Status ) ){
        system.debug('HEREYOUARE');
        system.debug('The status is::'+ord.Status);
             if(((ord.Status!=null||ord.Status!='')&& ord.Status != 'Draft') ){
                 qIdList.add(ord.NanaQuote__c);
                 pSetIds.add(ord.Project__c);
                 oSetIds.add(ord.OpportunityID);
                 mapStatus.put(ord.id,ord.Status);
             }
           }
        }
        system.debug('The mapstatus is::'+mapStatus);
        system.debug('The oSetIds is:'+oSetIds);
        if(qIdList.size()>0 && oSetIds.size()>0 && pSetIds.size()>0 ){
        OrderTriggerStagesHelper.UpdateQuoteStages(qIdList,mapStatus);
        OrderTriggerStagesHelper.UpdateOppStages(oSetIds,mapStatus);
        OrderTriggerStagesHelper.UpdateProjStagesFromOpportunity(pSetIds,mapStatus);
        }
         
         
        
    }
    
    //Below logic is for creating Entitlements when the order is Delivered and Balance amount is received
   
   try{
     set<id> orderidset = new set<id>();
     if((trigger.isAfter && trigger.isUpdate)||(trigger.isAfter && trigger.isInsert)){
        for(Order od:trigger.new){           
            if(trigger.oldmap.get(od.id).Status != null && trigger.oldmap.get(od.id).status != 'Paid/Delivered' && od.Status == 'Paid/Delivered' && od.Balance_Received_Date__c != null){
                orderidset.add(od.id);
            }
        }     
        //Checking null pointer exception
        if(orderidset.size()>0){
          OrderHandler.createEntitlement(orderidset); //Calling the createEntitlement method by passing the orders as parameters
        }
     }    
    }catch(Exception e){} 

    
}