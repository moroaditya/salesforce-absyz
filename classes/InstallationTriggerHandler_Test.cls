/*************************************************************************
    @ Author        : Absyz Software Consulting Pvt. Ltd.
    @ Date          : June-2016
    @ Description   : 
    @ Audit Trial   : 
    @ Last Modified Date : 02-June-2016
  
****************************************************************************/
@isTest(SeeAllData = false)
public class InstallationTriggerHandler_Test {
    public static list < Project__c > olstProject;
    public static list < Opportunity > olstOpportunity;
    public static list < Quote__c > olstQuote;
    public static list < Account > accounts;
    public static list < Zip_Codes_Master__c > territorymaster;
    public static User testUser;
    public static list < Country_codes__c > countrys;
    public static list < state_codes__c > states;
    public static list < Contact> contacts;
    public static list < Project__c > projects;
    public static list < Order > ordersList;
    public static list < Product2> productList;
    public static list < orderItem > orderItemList;
    public static List < Installation__c > Installation = new List < Installation__c > ();
    public static list < Manufacturing_Order__c> mOrderList;
    public static list < Manufacturing_Order_Position__c > morderPositonList;
    public static list < Shipping_Order__c > sOrderList;

    public static testMethod void myUnitTest() {
        
         territorymaster = TestDataUtility.getTerritoryMaster();
        try {
            insert territorymaster;
        } catch (exception e) {
            system.debug('Exception is:' + e);
        }
        
        //Creating test data for user
        testUser = TestDataUtility.createUser('Standard User', 'testUserName@testing.com');
        try {
            insert testUser;
        } catch (exception e) {
            system.debug('Exception is:' + e);
        }
        
        //Creating test data for Accounts 
       accounts = testDataUtility.createAccountTestData();
        accounts[0].certified_installer__c = true;
       insert accounts;
       test.startTest();
       List<Installation__c> instalList = new List<Installation__c>();
       Installation__c inst = new Installation__c();
       inst.Status__c = 'Open';
       inst.Account__c =  accounts[0].id ;
       instalList.add(inst);
       insert instalList;       
       instalList[0].Status__c = 'Accepted by Installer' ;
       instalList[0].Installation_Date__c = system.today(); 
       update instalList[0];   
        
        
       Installation__c instNew = new Installation__c();
       instNew.Status__c = 'Open';
       instNew.Account__c =  accounts[0].id ;
       instNew.Installation_Date__c = system.today() ; 
       insert instNew;       
       instNew.Status__c = 'Accepted by Installer' ;
       instNew.Installation_Date__c = system.today(); 
       update instNew ;
       test.stopTest();
        
    }
  
    /*****
     Method:myUnitTest2
     Purpose: To cover the code coverage for Installation trigger
     *****/
    public static testMethod void myUnitTest2(){
        //creating test data for territorymaster
        territorymaster = TestDataUtility.getTerritoryMaster();
        try {
            insert territorymaster;
        } catch (exception e) {
            system.debug('Exception is:' + e);
        }
        
        //Creating test data for user
        testUser = TestDataUtility.createUser('Standard User', 'testUserName@testing.com');
        try {
            insert testUser;
        } catch (exception e) {
            system.debug('Exception is:' + e);
        }
        
        //Creating test data for Accounts 
       accounts = testDataUtility.createAccountTestData();
        accounts[0].certified_installer__c = true;
       insert accounts;
       
       //Creating test data for contacts
       /*contacts = testDataUtility.createConTestData();
       Contacts[0].Accountid=accounts[0].id;
       insert contacts;*/
       
       
       list<contact> con=new list<contact>();
       contact co=new contact();
         //con.Name='test contact';
         co.Accountid=accounts[0].id;
         co.FirstName = 'john';
         co.LastName = 'CAD EMAIL RECIPIENT';
         co.MailingStreet = 'street';
         co.MailingCity = 'city'; 
         co.Mailingstate = 'Utah';
         co.MailingPostalCode = '12345';
         co.MailingCountryCode = 'US';
         co.Address_1__c='hyderabad';
         co.Address_2__c='hyder guda';
         co.AIA_Lunch_and_Learn__c=true;
         co.AssistantName='contact assistant';
         co.Birthdate=system.today();
         co.Fax='123456';
         co.Email='abc@abc.com';
         co.Phone='125869';
         co.Country__c='Aruba';
         con.add(co);
         insert con;
       
       //Creating test data for projects
       list<Project__c> Pro= new list<Project__c>();
       Pro=TestDataUtility.createProjectTestData();
       insert Pro[0];
        
        //Creating test data for Opportunities 
        olstOpportunity = TestDataUtility.createOppTestData();
            olstOpportunity[0].Accountid=accounts[0].id;
            olstOpportunity[0].Project_Name__c =Pro[0].Id ;
            olstOpportunity[0].OwnerId=testuser.id;
            insert olstOpportunity;
        system.assert(olstOpportunity.size()>0);
           
        //Creating test data for countrys
        countrys = TestDataUtility.getTestCountryCodes();
        try {
            insert countrys;
        } catch (exception e) {
            system.debug('Exception is:' + e);
        }
        
        //Creating test data for States
        states = TestDataUtility.getTestStateCodes();
        try {
            insert states;
        } catch (exception e) {
            system.debug('Exception is:' + e);
        }
                
        test.starttest();

       //Creating test data for products
       productList = TestDataUtility.createProductData();
       productList[0].Name = 'WA67';
       insert productList;
        system.assert(productList.size()>0);
      
       //Creating test data for Pricebook
       Pricebook2 pb2 = new Pricebook2();
       pb2.Name = 'Models';
       insert pb2;
       
       //Create test data for Orders
       Order o = new Order(
            AccountId = accounts[0].id,
            EffectiveDate = system.today(),
            OpportunityId = olstOpportunity[0].id,
            Pricebook2Id = Test.getStandardPricebookId(),
            status='Draft',
            Balance_Received_Date__c = system.today()       
        );
        insert o;
       
       //Creating test data for PriceBookEntry
       PricebookEntry pbe = new PricebookEntry();
       pbe.Product2Id = productList[0].id;
       pbe.UnitPrice = 7092;
       pbe.Pricebook2Id = Test.getStandardPricebookId();
       insert pbe;
           
        //Creating test data for OrderItem
       OrderItem otm = new orderitem();
       otm.OrderId = o.id;
       otm.PricebookEntryId = pbe.id;
       otm.Quantity = 1;
       otm.UnitPrice = 5532;
       insert otm;
        
        //Creating test data for entitlements
        Entitlement ent = new Entitlement();
        ent.Name = '0001sl';
        ent.AccountId = accounts[0].id;
        ent.StartDate = system.today();
        ent.Order__c = o.id;
        ent.Order_Product__c = otm.id;
        insert ent;
        
       //Creating test data for Installation 
       List<Installation__c> instalList = new List<Installation__c>();
       Installation__c inst = new Installation__c();
       inst.Status__c = 'Open';
       inst.Order__c = o.id;
       inst.Installer_Account__c = accounts[0].id;
       instalList.add(inst);
       insert instalList;       
       instalList[0].Installation_Date__c =system.today();
       update instalList[0];   
       
        //Updating the order item
       otm.Installation__c = instalList[0].id;
       update otm;        
   }
    /*****
     Method:myUnitTest3
     Purpose: To cover the code coverage for Entitlement part in Installation trigger
     *****/
    public static testMethod void myUnitTest3(){
        //creating test data for territorymaster
        territorymaster = TestDataUtility.getTerritoryMaster();
        try {
            insert territorymaster;
        } catch (exception e) {
            system.debug('Exception is:' + e);
        }
        
        //Creating test data for user
        testUser = TestDataUtility.createUser('Standard User', 'testUserName@testing.com');
        try {
            insert testUser;
        } catch (exception e) {
            system.debug('Exception is:' + e);
        }
        
        //Creating test data for Accounts 
       accounts = testDataUtility.createAccountTestData();
        accounts[0].certified_installer__c = False;
       insert accounts;
       
       //Creating test data for contacts
       /*contacts = testDataUtility.createConTestData();
       Contacts[0].Accountid=accounts[0].id;
       insert contacts;*/
       
       
       list<contact> con=new list<contact>();
       contact co=new contact();
         //con.Name='test contact';
         co.Accountid=accounts[0].id;
         co.FirstName = 'john';
         co.LastName = 'CAD EMAIL RECIPIENT';
         co.MailingStreet = 'street';
         co.MailingCity = 'city'; 
         co.Mailingstate = 'Utah';
         co.MailingPostalCode = '12345';
         co.MailingCountryCode = 'US';
         co.Address_1__c='hyderabad';
         co.Address_2__c='hyder guda';
         co.AIA_Lunch_and_Learn__c=true;
         co.AssistantName='contact assistant';
         co.Birthdate=system.today();
         co.Fax='123456';
         co.Email='abc@abc.com';
         co.Phone='125869';
         co.Country__c='Aruba';
         con.add(co);
         insert con;
       
       //Creating test data for projects
       list<Project__c> Pro= new list<Project__c>();
       Pro=TestDataUtility.createProjectTestData();
       insert Pro[0];
        
        //Creating test data for Opportunities 
        olstOpportunity = TestDataUtility.createOppTestData();
            olstOpportunity[0].Accountid=accounts[0].id;
            olstOpportunity[0].Project_Name__c =Pro[0].Id ;
            olstOpportunity[0].OwnerId=testuser.id;
            insert olstOpportunity;
        system.assert(olstOpportunity.size()>0);
           
        //Creating test data for countrys
        countrys = TestDataUtility.getTestCountryCodes();
        try {
            insert countrys;
        } catch (exception e) {
            system.debug('Exception is:' + e);
        }
        
        //Creating test data for States
        states = TestDataUtility.getTestStateCodes();
        try {
            insert states;
        } catch (exception e) {
            system.debug('Exception is:' + e);
        }
                
        test.starttest();

       //Creating test data for products
       productList = TestDataUtility.createProductData();
       productList[0].Name = 'WA67';
       insert productList;
        system.assert(productList.size()>0);
      
       //Creating test data for Pricebook
       Pricebook2 pb2 = new Pricebook2();
       pb2.Name = 'Models';
       insert pb2;
       
       //Create test data for Orders
       Order o = new Order(
            AccountId = accounts[0].id,
            EffectiveDate = system.today(),
            OpportunityId = olstOpportunity[0].id,
            Pricebook2Id = Test.getStandardPricebookId(),
            status='Draft',
            Balance_Received_Date__c = system.today()       
        );
        insert o;
       
       //Creating test data for PriceBookEntry
       PricebookEntry pbe = new PricebookEntry();
       pbe.Product2Id = productList[0].id;
       pbe.UnitPrice = 7092;
       pbe.Pricebook2Id = Test.getStandardPricebookId();
       insert pbe;
           
        //Creating test data for OrderItem
       OrderItem otm = new orderitem();
       otm.OrderId = o.id;
       otm.PricebookEntryId = pbe.id;
       otm.Quantity = 1;
       otm.UnitPrice = 5532;
       insert otm;
        
        //Creating test data for entitlements
        Entitlement ent = new Entitlement();
        ent.Name = '0001sl';
        ent.AccountId = accounts[0].id;
        ent.StartDate = system.today();
        ent.Order__c = o.id;
        ent.Order_Product__c = otm.id;
        insert ent;
        
       //Creating test data for Installation 
       List<Installation__c> instalList = new List<Installation__c>();
       Installation__c inst = new Installation__c();
       inst.Status__c = 'Open';
       inst.Order__c = o.id;
       inst.Installer_Account__c = accounts[0].id;
       instalList.add(inst);
       insert instalList;       
       instalList[0].Installation_Date__c =system.today();
       update instalList[0];   
       
        //Updating the order item
       otm.Installation__c = instalList[0].id;
       update otm;        
   }
   /*****
     Method:myUnitTest3
     ******/
    
    public static testMethod void myUnitTest4(){
       
       
          territorymaster = TestDataUtility.getTerritoryMaster();
        try {
            insert territorymaster;
        } catch (exception e) {
            system.debug('Exception is:' + e);
        }
        
        //Creating test data for Accounts 
       accounts = testDataUtility.createAccountTestData();
        accounts[0].certified_installer__c = true;
       insert accounts;
       
          contact co=new contact();
         //con.Name='test contact';
         co.Accountid=accounts[0].id;
         co.FirstName = 'john';
         co.LastName = 'CAD EMAIL RECIPIENT';
         co.MailingStreet = 'street';
         co.MailingCity = 'city'; 
         co.Mailingstate = 'Utah';
         co.MailingPostalCode = '12345';
         co.MailingCountryCode = 'US';
         co.Address_1__c='hyderabad';
         co.Address_2__c='hyder guda';
         co.AIA_Lunch_and_Learn__c=true;
         co.AssistantName='contact assistant';
         co.Birthdate=system.today();
         co.Fax='123456';
         co.Email='abc@abc.com';
         co.Phone='125869';
         co.Country__c='Aruba';
        insert co ; 
        
          //Creating test data for user
        testUser = TestDataUtility.createUser('Standard User', 'testUserName@testing.com');
        try {
            insert testUser;
        } catch (exception e) {
            system.debug('Exception is:' + e);
        }
        
         //Creating test data for projects
       list<Project__c> Pro= new list<Project__c>();
       Pro=TestDataUtility.createProjectTestData();
       insert Pro[0];
        
        //Creating test data for Opportunities 
        olstOpportunity = TestDataUtility.createOppTestData();
            olstOpportunity[0].Accountid=accounts[0].id;
            olstOpportunity[0].Project_Name__c =Pro[0].Id ;
            olstOpportunity[0].OwnerId=testuser.id;
            insert olstOpportunity;
        system.assert(olstOpportunity.size()>0);
        
        Quote__c q = new Quote__c();
            q.Name = 'Test Quote' ;
         q.Opportunity__c = olstOpportunity[0].Id;
            q.Primary_Quote__c=True;
        insert q;
        
        Quote_Detail__c qd = new Quote_Detail__c();
        qd.Quote__c = q.id ; 
        qd.Model__c = 'WA63';  
        insert qd ; 
        
        	 Order o = new Order(
            AccountId = accounts[0].id,
            EffectiveDate = system.today(),
            OpportunityId = olstOpportunity[0].id,
            Pricebook2Id = Test.getStandardPricebookId(),
            status='Draft',
            NanaQuote__c=q.id,
            Balance_Received_Date__c = system.today()       
        );
       
        insert o;
       
       Installation__c inst = new Installation__c();
       inst.Status__c = 'Open';
       inst.Order__c = o.id; 
          test.startTest() ; 
       insert inst ; 
      		  Test.stopTest() ;  
        
    }  
    
}