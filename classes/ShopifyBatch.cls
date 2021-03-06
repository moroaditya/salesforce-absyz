/**********************************************************************
Apex Class: ShopifyBatch 
Description: This batch class is used to sync orders data between shopify and salesforce
Created Date: 26thApril,2016            
***********************************************************************/
global class ShopifyBatch implements Database.Batchable < sObject > , Database.AllowsCallouts {

    //Global Variable
    global String query;

    //Start method of the batch class
    global Database.QueryLocator start(Database.BatchableContext BC) {

        this.query = 'SELECT Id, Shopify_ID__c, Case__c, Freight_Tracking_Number__c, Tracking_Company__c from Service_Quote__c where (Tracking_Company__c=NULL OR Freight_Tracking_Number__c=NULL) AND Shopify_ID__c!=NULL';

        return Database.getQueryLocator(query);
    }

    //Execute method of the batch class
    global void execute(Database.BatchableContext BC, List < Service_Quote__c > records) {

        //local variable
        string orderData;
        list < string > orderDataList = new list < string > ();
        list < wrapperObjectShopify.Orders > ordList = new list < wrapperObjectShopify.Orders > ();
        map < string, list < wrapperObjectShopify.fulfillments >> orderTrackNumberMap = new map < string, list < wrapperObjectShopify.fulfillments >> ();
        list < Service_Quote__c > sqList = new list < Service_Quote__c > ();

        System.debug('recordsssssss' + records);
        for (Service_Quote__c sq: records) {
        	
        	//Making HTTP Callouts for Shopify admin page
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            
            //Fetching Shopify Admin page URL from label
            String url = label.Shopify_Store_URL;
            string endPointValue = url + '/admin/orders/' + sq.Shopify_ID__c + '.json';
            System.debug('#########' + endPointValue);
            req.setEndpoint(endPointValue);
			
			//Fetching Shopify Admin Credentials from custom settings
            Shopify_Credentials__c ShopCred = Shopify_Credentials__c.getOrgDefaults();
            String username = ShopCred.User_Name__c;
            String password = ShopCred.Password__c;

            Blob headerValue = Blob.valueOf(username + ':' + password);
            String authorizationHeader = 'Basic ' +
                EncodingUtil.base64Encode(headerValue);
            req.setHeader('Authorization', authorizationHeader);
            req.setHeader('content-type', 'application/json');
			
			//Using GET Method to fetch the records in Shopify 
            req.setMethod('GET');
            try {
                HttpResponse res = h.send(req);
                orderData = res.getBody();
            } catch (exception e) {
                System.debug('eee' + e);
            }
        
            // Parse entire JSON response.
            JSONParser parser = JSON.createParser(orderData);
            while (parser.nextToken() != null) {
                parser.nextToken();
                parser.nextToken();
                //parser.nextToken();
                if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                    // Read entire orders object, including its array of line items.
                    wrapperObjectShopify.Orders ord = (wrapperObjectShopify.Orders) parser.readValueAs(wrapperObjectShopify.Orders.class);
                    String emailname = parser.getText();
                    if (ord != NULL)
                        ordList.add(ord);
                    if (ord.id != NULL)
                        orderTrackNumberMap.put(ord.id, ord.fulfillments);
                    // For debugging purposes, serialize again to verify what was parsed.              
                    String ss = JSON.serialize(ord);
                    system.debug('Ordersssssss: ' + ss);
                    // Skip the child start array and start object markers.
                    parser.skipChildren();
                }
            }
        }
        
        //Update the Service Quote tracking and shipping method details with the shopify details
        if (ordList.size() > 0) {
            list < wrapperObjectShopify.fulfillments > fulllist = new list < wrapperObjectShopify.fulfillments > ();
            for (Service_Quote__c sq: records) {
                fulllist = orderTrackNumberMap.get(sq.Shopify_ID__c);
                System.debug('fulllistt' + fulllist);
                if (fulllist.size() > 0) {
                    for (wrapperObjectShopify.fulfillments fl: fulllist) {
                        sq.Freight_Tracking_Number__c = fl.tracking_number;
                        sq.Tracking_Company__c = fl.tracking_company;
                        sqList.add(sq);
                    }
                }
            }
        }
        System.debug('servicequotelist' + sqList);
        //Updating Service Quote
        if (sqList.size() > 0)
        {
              try{
              		update sqList;
              }catch(exception e){
              	System.debug('error message'+e);
              }                    
        }

    }

    //Finish method of the batch class
    global void finish(Database.BatchableContext BC) {

    }    
}