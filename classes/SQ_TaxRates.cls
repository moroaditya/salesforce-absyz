public class SQ_TaxRates{
    
        public static void updateTaxRate(List<Case> caselst){    
               map < string, string > caseStateMap = new map < string, string > ();
            	system.debug('The caselst is::'+caselst);
               List < Service_Quote__c > sqList = [select id, TaxRate__c, Case__c, Shipping_State__c,RecordType.Name from Service_Quote__c where case__r.id IN: caselst AND RecordType.Name='Custom Service Quote'];
            SYSTEM.debug('the sqList is::'+sqList);   
            string stateList;
               list <Service_Quote__c> sqList2 = new list < Service_Quote__c > ();
               try{
                    for (Case cs: caselst)
                    {
                        if (cs.ship_to__c == 'End Customer') 
                        {
                            statelist = cs.Shipping_Address_State__c;
                        }   else if (cs.ship_to__c == 'Caller Contact') 
                        {
                            statelist = cs.State_Shipping_Address_of_Caller__c;
                        }   else if(cs.ship_to__c=='Project Site')
                        {
                            statelist = cs.Project_Site_States__c;
                        }
                            else if(cs.ship_to__c=='Other'){
                            stateList = cs.Other_Shipping_State__c;
                        }
                            System.debug('%%%%' + stateList);
                            
                            if(stateList != null){
                            stateList = stateList.touppercase();
                            caseStateMap.put(cs.id, stateList);
                            system.debug('The Casestatemap is::::::'+caseStateMap.size());
                            }
                            stateList = '';
                    }
                    
                    list < Service_Quote__c > sqList1 = new list < Service_Quote__c > ();                   
                    if(stateList != null){
                        
                    for (Service_Quote__c sqo: sqList) 
                    {           
                        string stateCaseList = casestatemap.get(sqo.case__c);
                        system.debug('the stateCaseList is:::'+stateCaseList);
                        map < string, TaxRate__c > taxRates = Utility.GetTaxRatesList();
                        system.debug('the taxRates is:::'+taxRates);
                        System.debug('jygjjgjj' + taxRates.containsKey(sqo.Shipping_State__c));
                        if(taxRates.size()>0){
                            if (taxRates.containsKey(stateCaseList)) 
                            {
                                sqo.TaxRate__c = taxRates.get(stateCaseList).Service_Quote_Tax_Rate__c;
                                sqList1.add(sqo);
                            }
                             else if (!taxRates.containsKey(stateCaseList) ) 
                            {
                                sqo.TaxRate__c = 0;
                                sqList1.add(sqo);
                            }
                        }
                            stateCaseList = '';
                    }
                    
                    
                    if(sqList1.size()>0){
                     Database.SaveResult[] srList = Database.update(sqList1, false);
                     ErrorLogUtility.processErrorLogs(srList, sqList1,'SQ_TaxRates','updateTaxRate','Case','update');
                     //update sqList1; 
                     }
                    }
                    
                    if(stateList == null){
                        for(Service_Quote__c sqo: sqList){
                            sqo.TaxRate__c = 0;
                            sqList2.add(sqo);
                        }
                        update sqList2;
                    }                  
                    
           } catch (exception e) {}
        
      }
      
   public static void updateTaxRateOnServiceQuote(List<Service_Quote__c> sQuoteList){
    		system.debug('The sQuoteList is:::::'+sQuoteList);
            string stateList;
            set<id> serviceQuoteId = new set<id>(); 
            list<case> caseList = new list<case>();
            map<string, string> caseStateMap = new map<string, string>();
    
        try
        {
            for(Service_Quote__c sqo: sQuoteList)
            {
                serviceQuoteId.add(sqo.case__c);
            }
    
                caseList= [select id, ship_to__c, State_Shipping_Address_of_Caller__c, Shipping_Address_State__c, Project_Site_States__c from case where id IN: serviceQuoteId];
        		system.debug('The caseList is:::::'+caseList);
            for(case cs: caseList)
            {
                if(cs.ship_to__c=='End Customer')
                {   
                    stateList = cs.Shipping_Address_State__c;
                }
                else if(cs.ship_to__c=='Caller Contact')
                {
                    stateList = cs.State_Shipping_Address_of_Caller__c;
                }
                else if(cs.ship_to__c=='Project Site')
                {
                    stateList = cs.Project_Site_States__c;
                }
                else if(cs.ship_to__c=='Other'){
                     stateList = cs.Other_Shipping_State__c;
                }
                    System.debug('The statelist is:::::::::::'+stateList);
                    stateList = stateList.touppercase();
                    caseStateMap.put(cs.id, stateList);
                    system.debug('The Casestatemap is::::::'+caseStateMap);
                    stateList='';
                }
    
                    System.debug('mapppp'+caseStateMap);
    
                    //list<Service_Quote__c> sq1 = [select id, shipping_state__c, TaxRate__c from Service_Quote__c where id IN: TRIGGER.NEWMAP.KEYSET()];
                    list<Service_Quote__c> sqList = new list<Service_Quote__c>();
    
                     for(Service_Quote__c sqo: sQuoteList)
                     {
                         string stateCaseList = caseStateMap.get(sqo.case__c);               
                         map<string,TaxRate__c> taxRates = Utility.GetTaxRatesList();//Getting the tax rates from the Utility class
                         System.debug('jygjjgjj'+ taxRates.containsKey(sqo.Shipping_State__c ));
                        if(taxRates.size()>0){
                            if( taxRates.containsKey(stateCaseList))
                            {
                                sqo.TaxRate__c = taxRates.get(stateCaseList).Service_Quote_Tax_Rate__c;
                                sqList.add(sqo);
                            }
                            else if(!taxRates.containsKey(stateCaseList) )
                            {
                                sqo.TaxRate__c = 0;
                                sqList.add(sqo);
                            }
                        }
                        stateCaseList='';
                    }
        
                }catch(exception e){}       
        
        }
         
}