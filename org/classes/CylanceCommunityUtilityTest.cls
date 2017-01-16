public class CylanceCommunityUtilityTest{
    
      public static CaseComment createCaseCommentInTestClass(Case c){
        CaseComment com = new CaseComment();
        com.ParentId = c.id;
        com.CommentBody= c.Description;
        return com;
    } 
    public static Case createCaseWithEmptyDescriptionInTestClass(){
        Case caseObj = new Case(Status = 'New', Priority = 'High', Subject = 'test1', 
                                SuppliedEmail = 'test@test.com',Description = '', 
                                Origin = 'Web', Product__c='Billing'
                    );
        return caseObj ; 
    }
    public static Case createCaseInTestClass(){
        Contact c = createContact();
        Case caseObj = new Case(Status = 'New', Priority = 'High', Subject = 'Test', 
                                SuppliedEmail = 'test@test.com',Description = 'Test Description', 
                                Origin = 'Web'
                    );
        return caseObj ; 
    }
    
    public static Case createCaseInTestClassstatus(){
        Contact c = createContact();
        Case caseObj1 = new Case(Status = 'Customer Confirmed', Priority = 'High', Subject = 'Test', 
                                SuppliedEmail = 'test@test.com',Description = 'Test Description', 
                                Origin = 'Web'
                    );
        return caseObj1; 
    }
    public static Attachment createAttachment(){
        Attachment attach =new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        return attach;
    }
    public static Case createCaseWithEmptySubjectInTestClass(){
        Case caseObj = new Case(Status = 'New', Priority = 'High', Subject = '', 
                                SuppliedEmail = 'test@test.com',Description = 'Test Description', 
                                Origin = 'Web', Product__c='Billing'
                    );
        return caseObj ; 
    }
    
    public static Case createCaseWithQuoteSubjectInTestClass(){
        Case caseObj = new Case(Status = 'New', Priority = 'High', Subject = '"test"', 
                                SuppliedEmail = 'test@test.com',Description = 'Test Description', 
                                Origin = 'Web', Product__c='Billing'
                    );
        return caseObj ; 
    }
    public static Contact createContact(){
        contact con = new contact();
        con.lastname = 'contact';
        return con;
    }
    public static Account createAccount(){
        Account acc = new Account();
        acc.name = 'account';
        return acc;
    }

}