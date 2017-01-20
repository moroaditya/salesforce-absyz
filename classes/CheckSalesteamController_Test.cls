@isTest
public class CheckSalesteamController_Test {
	public static testMethod void myUnitTest() {
        profile p = [select id from Profile where name = 'Standard User'];
        User u = new User(alias = 'testme', email = 'testme@noemail.com', emailencodingkey = 'UTF-8', lastname = 'test', languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = p.Id, country = 'United Kingdom', timezonesidkey = 'Europe/London', username = 'testme@noemail.com');
        insert u;

        list < Zip_Codes_Master__c > lstzipCode = new list < Zip_Codes_Master__c > ();
        Zip_Codes_Master__c zipCode1 = new Zip_Codes_Master__c();
        zipCode1.City__c = 'Stow';
        zipCode1.Country__c = 'United States';
        zipCode1.State__c = 'Maine';
        zipCode1.Zip_Code__c = '12345';
        zipcode1.User__c = u.id;
        lstzipCode.add(zipCode1);
        insert lstzipCode;

        Account acc = new Account();
        acc.Name = 'test';
        acc.Phone = '12345678';
        acc.BillingState = 'New York';
        acc.BillingCountry = 'United States';
        acc.BillingPostalCode = '12345';
        acc.Certified_Installer__c = true;
        insert acc;

        contact con = new contact();
        con.Accountid = acc.id;
        con.FirstName = 'john';
        con.LastName = 'doe';
        con.address_1__c = 'abcd';
        con.Address_2__c = 'hyd';
        con.City__c = 'abc';
        con.State_Abbr__c = 'asd';
        con.State__c = 'ALASKA';
        con.Zip__c = '12345';
        con.Country__c = 'Anguilla';
        con.Last_Mailbook_Sent__c = system.now();
        con.Last_Booklet_Sent__c = null;
        con.Last_Binder_Sent__c = system.now();
        con.Send_Booklet__c = false;
        con.Phone = '563256';
        con.Fax = '563256';
        con.Email = 'test@test.com';
        con.MailingStreet = 'street';
        con.MailingCity = 'city';
        con.Mailingstate = 'Utah';
        con.MailingPostalCode = '12345';
        con.MailingCountryCode = 'US';
        con.OwnerId = u.id;
        insert con;

        list < Project__c > proList = new list < Project__c > ();
        Project__c pro = new Project__c();
        pro.RecordTypeId = Schema.SObjectType.Project__c.getRecordTypeInfosByName().get('Residential Project').getRecordTypeId();
        pro.Name = 'xyz enterprise';
        pro.Project_Zip_Code__c = '12345';
        pro.Project_Country__c = 'United States';
        pro.Close_Date__c = Date.newInstance(2015, 12, 12);
        pro.Stage__c = 'Prospecting';
        proList.add(pro);
        insert proList;

        set<id> oppIds=new set<id>();
        list < Opportunity > lstOpps = TestDataUtility.createOppTestData();
        Opportunity testOpp = lstOpps[0];
        testOpp.Name='test opp';
        testopp.Nana_Create_Date__c=system.today();
        testopp.Nana_Edit_Date__c=system.today();
        testopp.StageName='Order - Requested';
        testOpp.AccountId = acc.id;
        testOpp.Project_Name__c = proList[0].id;
        insert lstOpps;
        for(opportunity o: lstOpps)
        {
            oppIds.add(o.id);
        }
        //oppIds.addAll(lstOpps[0].id);

              
        List < nrOpportunityContactRole__c > lstOppConRole = new List < nrOpportunityContactRole__c > ();
        nrOpportunityContactRole__c nrOppConRole = new nrOpportunityContactRole__c();
        nrOppConRole.Primary__c = true;
        nrOppConRole.Opportunity__c = lstOpps[0].id;
        nrOppConRole.Role__c = 'Architect';
        lstOppConRole.add(nrOppConRole);
        try {
            insert lstOppConRole;
        } catch (exception e) {}
        
            list<nrOpportunityTeamMember__c> nroppList=new list<nrOpportunityTeamMember__c>();
            nrOpportunityTeamMember__c no=new nrOpportunityTeamMember__c();
            no.User__c=u.Id;
            no.TeamMemberRole__c='Account Manager';
            //no.UsersName__c='abc';
            no.Credit__c='LoPu';
            no.Credit1__c='ShSp';
            no.Commission__c=10.00;
            no.OpportunityAccessLevel__c='Owner';
            no.Opportunity__c=lstOpps[0].id;
            no.Commission__c=100;
        	nroppList.add(no);
            insert nroppList;
    	
            CheckSalesteamController cs=new CheckSalesteamController();
            cs.runCheck();
    }
}