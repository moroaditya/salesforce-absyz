public with sharing class NanaQuote_Create_Order_Controller {
    
    protected Quote__c thisQuote = null;
    public Order thisOrder = null;
    public NanaQuote_Create_Order_Controller(ApexPages.StandardController stdController)
    {
        this.thisQuote = (Quote__c)stdController.getRecord();
    
    }
    
    public Id existingOrder { get; set; }
    
    public boolean doTest { get{ if( doTest == null) {doTest = false;} return doTest; } set; }
    
    public PageReference CreateOrder()
    {


        Quote thisq = null;
        System.debug('@@@@@@@'+this.thisQuote.Id);
        for( Quote q : [SELECT Id, Ordered__c, Order__c,  Nana_Quote__r.Order__c  FROM Quote WHERE Nana_Quote__c = :this.thisQuote.Id] )
        {
            thisq = q;
            system.debug('@@@@@@@@'+thisq);
            break; 
        }
//         System.debug('@@@@@@@@@'+thisq.Nana_Quote__r);
         if( thisq.Nana_Quote__r == null )
         {
            Apexpages.addMessage( new Apexpages.Message( Apexpages.Severity.ERROR, 'The SFDC Quote and the Nana Quote do not appear to be linked. Please alert tech support with this quote number. ( '+thisq.Id+' / '+this.thisQuote.Id+')' ) );
            return null;
         
         }
         
         System.debug('@@@@@@@'+thisq.Nana_Quote__r.Order__c );
        if( thisq.Nana_Quote__r.Order__c  != null && !doTest ) 
        {
                     

            existingOrder = thisq.Nana_Quote__r.Order__c;
            Apexpages.addMessage( new Apexpages.Message( Apexpages.Severity.INFO, 'Redirecting to  order ...' ) );
             System.debug('@@@@@@@'+ 'Redirecting to  order ...');
            
            return null;
        }
        
        Apexpages.addMessage( new Apexpages.Message( Apexpages.Severity.INFO, 'creating order for quote...'+this.thisQuote.Quote_ID__c ) );
        Map<String, Object> params = new Map<String, Object>();
        params.put('QuoteID', thisq.Id);        
        Flow.Interview.Quote_to_Order convertFlow = new Flow.Interview.Quote_to_Order(params);
        convertFlow.start();
        
        Apexpages.addMessage( new Apexpages.Message( Apexpages.Severity.INFO, 'created.' ) );


  
        Order thiso = null;
        system.debug('@@@@@@@@'+this.thisQuote.Id);
        for ( Order o :  [SELECT Id, Status FROM Order WHERE NanaQuote__c = :this.thisQuote.Id] )
        {
            thiso = o;
            system.debug('@@@@@@@@@'+thiso);
            break;
        } 

		thisorder = thiso;
		thisorder.Status = 'Order Created';
		update thisorder;


        thisq.Ordered__c = true;
        thisq.Order_Created__c = true;
        thisq.Order_Generated__c = true;        
        
        //
        update thisq;


Apexpages.addMessage( new Apexpages.Message( Apexpages.Severity.INFO, ' SELECT Id FROM Order WHERE NanaQuote__c = :'+this.thisQuote.Id  ) );


        if( thiso != null ) 
        {
			
        	return new PageReference('/' + thiso.Id );    
        }        
        else {
            PageReference pg = new PageReference('/apex/NanaQuote_Create_Order?scontrolCaching=1&id='+this.thisQuote.Id);
            system.debug('Page Ref -- '+pg );
            return pg;
            }
        
        
        
        ///apex/NanaQuote_Create_Order?scontrolCaching=1&id=a0A3B0000006esl

//return null;
    }
}