@isTest
private class CaseCreateControllerTest{

    static testMethod void createAttachmentInControllerTest() {
        User newUser = createNewUserInTestClass();  
        Test.starttest();
        System.RunAs(newUser){
            Case caseRec = new case();
            caseRec = createCaseInTestClass();
            insert caseRec;
            Attachment attach = new attachment();
            attach =  CylanceCommunityUtilityTest.createAttachment();
            attach.ParentId = caseRec.id;
            ApexPages.StandardController sc = new ApexPages.StandardController(caseRec);
            CylanceCaseCreateController caseCreateController = new CylanceCaseCreateController(sc);
            caseCreateController.isPermit = true;
            caseCreateController.attachmentObj = attach;
            
            PageReference pageRef = Page.CylanceNewCasePage;
            pageRef.getParameters().put('id', String.valueOf(caseRec.Id));
            Test.setCurrentPage(pageRef);   
            System.assertEquals(null, caseCreateController.Save());            
        }
        test.stoptest();
    }

    static testMethod void generateDMLExceptionNegativeTest() {
            User newUser = createNewUserInTestClass();  
        Test.starttest();
        System.RunAs(newUser){
            Case caseRec = new case();
            caseRec = createCaseInTestClass();
            insert caseRec;
            Attachment attach = new Attachment();
            attach =  CylanceCommunityUtilityTest.createAttachment();
            attach.Name = '';
            attach.ParentId = caseRec.id;
            ApexPages.StandardController sc = new ApexPages.StandardController(caseRec);
            CylanceCaseCreateController caseCreateController = new CylanceCaseCreateController(sc);
            caseCreateController.isPermit = true;
            caseCreateController.attachmentObj = attach;
            
            PageReference pageRef = Page.CylanceNewCasePage;
            pageRef.getParameters().put('id', String.valueOf(caseRec.Id));
            Test.setCurrentPage(pageRef);   
            System.assertEquals(null, caseCreateController.Save());            
        }
        test.stoptest();
        }
    static testMethod void generateExceptionNegativeTest() {
        User newUser = createNewUserInTestClass();  
        Test.starttest();
        System.RunAs(newUser){
            Case caseRec = new case();
            caseRec = createCaseInTestClass();
            insert caseRec;
            Attachment attach = new Attachment();
            attach =  CylanceCommunityUtilityTest.createAttachment();
            attach.ParentId = caseRec.id;
            //CylanceCaseCreateController.Save() ->  throw exception
            insert attach;
            ApexPages.StandardController sc = new ApexPages.StandardController(caseRec);
            CylanceCaseCreateController caseCreateController = new CylanceCaseCreateController(sc);
            caseCreateController.isPermit = true;
            caseCreateController.attachmentObj = attach;
            
            PageReference pageRef = Page.CylanceNewCasePage;
            pageRef.getParameters().put('id', String.valueOf(caseRec.Id));
            Test.setCurrentPage(pageRef);   
            System.assertEquals(null, caseCreateController.Save());            
        }
        test.stoptest();
    }

    static testMethod void CylanceCaseCreateControllerfunc(){
        User newUser = createNewUserInTestClass();
        Test.starttest();
        System.RunAs(newUser){
            Case caseRec = new case();
            caseRec = createCaseInTestClass();
            insert caseRec;
            Attachment attach = new attachment();
            attach =  CylanceCommunityUtilityTest.createAttachment();
            attach.ParentId = caseRec.id;
            insert attach;
            ApexPages.StandardController sc = new ApexPages.StandardController(caseRec);
            CylanceCaseCreateController caseCreateController = new CylanceCaseCreateController(sc);
            caseCreateController.isPermit = true;
            //caseCreateController.contactTimeZone = '';
            //caseCreateController.contactPhone = '';
            
            PageReference pageRef = Page.CylanceNewCasePage;
            pageRef.getParameters().put('id', String.valueOf(caseRec.Id));
            Test.setCurrentPage(pageRef);   
            System.assertEquals(null, caseCreateController.Save());
            
            Case caseRec2 = CylanceCommunityUtilityTest.createCaseWithEmptyDescriptionInTestClass();
            insert caseRec2;
            Attachment attach2 =  CylanceCommunityUtilityTest.createAttachment();
            ApexPages.StandardController sc2 = new ApexPages.StandardController(caseRec2);
            CylanceCaseCreateController caseCreateController2 = new CylanceCaseCreateController(sc2);
            caseCreateController2.attachmentObj = attach2;
            PageReference pageRef2 = Page.CylanceNewCasePage;
            pageRef2.getParameters().put('id', String.valueOf(caseRec2.Id));
            Test.setCurrentPage(pageRef2);   
            System.assertEquals(null, caseCreateController2.Save());
            
            Case caseRec1 = CylanceCommunityUtilityTest.createCaseWithEmptySubjectInTestClass();
            insert caseRec1;
            ApexPages.StandardController sc1 = new ApexPages.StandardController(caseRec1);
            CylanceCaseCreateController caseCreateController1 = new CylanceCaseCreateController(sc1);
            caseCreateController1.attachmentObj = null;
            PageReference pageRef1 = Page.CylanceNewCasePage;
            pageRef1.getParameters().put('id', String.valueOf(caseRec1.Id));
            Test.setCurrentPage(pageRef1);   
            System.assertEquals(null, caseCreateController1.Save());
            
            Case caseRec3 = CylanceCommunityUtilityTest.createCaseWithQuoteSubjectInTestClass();
            insert caseRec3;
            ApexPages.StandardController sc3 = new ApexPages.StandardController(caseRec3);
            CylanceCaseCreateController caseCreateController3 = new CylanceCaseCreateController(sc3);
            caseCreateController3.attachmentObj = null;
            PageReference pageRef3 = Page.CylanceNewCasePage;
            pageRef1.getParameters().put('id', String.valueOf(caseRec3.Id));
            Test.setCurrentPage(pageRef1);   
            System.assertEquals(null, caseCreateController3.Save());
        }
        test.stoptest();
    }

	// MDF 11/6/2016 Created test method to run identical code as above but as an internal user.
	// This is a temporary workaround to increase code coverage for the CylanceCaseCreateController Class
	static testMethod void CylanceCaseCreateControllerfunc2(){
        Test.starttest();
        Case caseRec = new case();
        caseRec = createCaseInTestClass();
        insert caseRec;
        Attachment attach = new attachment();
        attach =  CylanceCommunityUtilityTest.createAttachment();
        attach.ParentId = caseRec.id;
        insert attach;
        ApexPages.StandardController sc = new ApexPages.StandardController(caseRec);
        CylanceCaseCreateController caseCreateController = new CylanceCaseCreateController(sc);
        caseCreateController.isPermit = true;
            
        PageReference pageRef = Page.CylanceNewCasePage;
        pageRef.getParameters().put('id', String.valueOf(caseRec.Id));
        Test.setCurrentPage(pageRef);   
        System.assertNotEquals(null, caseCreateController.Save());
            
        Case caseRec2 = CylanceCommunityUtilityTest.createCaseWithEmptyDescriptionInTestClass();
        insert caseRec2;
        Attachment attach2 =  CylanceCommunityUtilityTest.createAttachment();
        ApexPages.StandardController sc2 = new ApexPages.StandardController(caseRec2);
        CylanceCaseCreateController caseCreateController2 = new CylanceCaseCreateController(sc2);
        caseCreateController2.attachmentObj = attach2;
        PageReference pageRef2 = Page.CylanceNewCasePage;
        pageRef2.getParameters().put('id', String.valueOf(caseRec2.Id));
        Test.setCurrentPage(pageRef2);   
        System.assertEquals(null, caseCreateController2.Save());
            
        Case caseRec1 = CylanceCommunityUtilityTest.createCaseWithEmptySubjectInTestClass();
        insert caseRec1;
        ApexPages.StandardController sc1 = new ApexPages.StandardController(caseRec1);
        CylanceCaseCreateController caseCreateController1 = new CylanceCaseCreateController(sc1);
        caseCreateController1.attachmentObj = null;
        PageReference pageRef1 = Page.CylanceNewCasePage;
        pageRef1.getParameters().put('id', String.valueOf(caseRec1.Id));
        Test.setCurrentPage(pageRef1);   
        System.assertEquals(null, caseCreateController1.Save());
            
        Case caseRec3 = CylanceCommunityUtilityTest.createCaseWithQuoteSubjectInTestClass();
        insert caseRec3;
        ApexPages.StandardController sc3 = new ApexPages.StandardController(caseRec3);
        CylanceCaseCreateController caseCreateController3 = new CylanceCaseCreateController(sc3);
        caseCreateController3.attachmentObj = null;
        PageReference pageRef3 = Page.CylanceNewCasePage;
        pageRef1.getParameters().put('id', String.valueOf(caseRec3.Id));
        Test.setCurrentPage(pageRef1);   
        System.assertEquals(null, caseCreateController3.Save());
        Test.stoptest();
    }

    public static Case createCaseInTestClass(){
        Contact c = CylanceCommunityUtilityTest.createContact();
        Case caseObj = new Case(Status = 'New', Priority = 'High', Subject = 'Test', 
                                Description = 'Test Description', 
                                Origin = 'Web'
                    );
        return caseObj; 
    }
    
    public static User createNewUserInTestClass() {
        UserRole r = [SELECT Id,name FROM UserRole WHERE PortalType = 'None' LIMIT 1];
        update new User(Id = UserInfo.getUserId(), UserRoleId = r.Id);

        Contact con;
        System.runAs(new User(Id = UserInfo.getUserId())) {
            Account acc = new Account (Name = 'newAcc1');  
            insert acc;
            con = new Contact (AccountId = acc.id,LastName = 'portalTestUser', Phone='415.555.1212');
            insert con;
        }
        
        // MDF 11/6 Changed to avoid hard-coding Profile Names        Profile p = [select Id,name from Profile where Name ='Cylance Customer Community Login User' limit 1];
        Profile p   = [SELECT 
                          Id,
                          Name 
                       FROM Profile 
                       WHERE UserType ='CspLitePortal' 
                       LIMIT 1];
        User newUser = new User(
            ProfileId            = p.id,
            Username             = 'newUser1@yahoo.com',
            Email                = 'pb@ff.com',
            Emailencodingkey     = 'UTF-8',
            Localesidkey         = 'en_US',
            Languagelocalekey    = 'en_US',
            Timezonesidkey       = 'America/Los_Angeles',
            Alias                ='nuser',
            LastName             ='lastname',
            ContactId            = con.id
        );
        insert newUser;
        return newUser;
    }
    
}