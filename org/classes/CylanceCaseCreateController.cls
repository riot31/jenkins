public with sharing class CylanceCaseCreateController{
    public string contactName{get;set;}    
    public String contactEmail{get;set;}
    public String org_id{get;set;}
    public User currentUser{get;set;}
    public Case newcase{get;set;}
    public Boolean isPermit{get;set;}
    
    public Attachment attachmentObj {
    get{
        if (attachmentObj == null)
        attachmentObj = new Attachment();
        return attachmentObj;
    }
    set;}   
    
    public String caseRecordType{
        get{
            return 'qwe'; 
        }set;
    }
    
    public CylanceCaseCreateController(ApexPages.StandardController controller){
        contactName = '';
        contactEmail = '';
        org_id = '';
        newcase = (Case)controller.getRecord();
        String currentUserId = UserInfo.getUserId();
        currentUser = [Select Id, Name, TimeZoneSidKey, ContactId,AccountId, Account.Name, Contact.Name, Contact.Email, Contact.Phone FROM User WHERE Id=:currentUserId];
        if(currentUser!= null){
                newcase.ContactId = currentUser.ContactId;
                newcase.AccountId = currentUser.AccountId;
                contactName  = currentUser.Contact.Name;
                contactEmail = currentUser.Contact.email; 
                org_id = String.valueOf(currentUser.account.name);
        }
        /*
        if(currentUser.ContactId !=null){
            Contact contact = [select Id,Phone,email,account.name from Contact where Id=:currentUser.ContactId];
            if(contact != null){
                contactName = currentUser.Contact.name; 
                contactEmail = contact.email; 
                org_id = String.valueOf(contact.account.name);
                contactPhone = Contact.Phone;
                newcase.AccountId = contact.AccountId;
            }
        }else{
            newcase.ownerId = currentUser.Id;
        }*/
        system.debug('newcase....'+newcase);
    }
   
    public PageReference Save() {
        Case newcaseinsert = newcase;//new case();  
        newcaseinsert.Origin = 'Web';
        newcaseinsert.Status = 'New';
        try{
           system.debug('newcase.Subject-->+ndescription'+newcase.Subject + newcaseinsert.Description);
           if(newcaseinsert.Subject == ''){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please add Subject'));
                return null;
            }
            if(newcase.Subject.contains('"'))
            { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Double quotes not allowed in Subject.Please use single quotes.')); return null; }
            if(newcaseinsert.Description == ''){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please add Description'));
                return null;
            }
            
            if(attachmentObj.BodyLength >= 25971520){ApexPages.addMessage(new Apexpages.Message(ApexPAges.Severity.ERROR, 'Please add attachment less than 24 MB.'));attachmentObj = new Attachment();return null;}
            newcaseinsert.Subject     = newcaseinsert.Subject;
            newcaseinsert.Description = newcaseinsert.Description;
            
            //Fetching the assignment rules on case unless this is a portal user
            if (UserInfo.getUserType() != 'CspLitePortal')
            {
                AssignmentRule AR = new AssignmentRule();
                AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
            
                //Creating the DMLOptions for "Assign using active assignment rules" checkbox
                Database.DMLOptions dmlOpts = new Database.DMLOptions();
                dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;
                //Setting the DMLOption on Case instance
                newcaseinsert.setOptions(dmlOpts);
            }
            newcaseinsert.Id = null;
            ESAPI.securityUtils().validatedInsert(new List<Case>{newcaseinsert}); //Security insert
            
            system.debug(newcaseinsert+'attachmentObj-->'+attachmentObj);
            
            /* add attachment code */
            if(!test.isrunningtest()){
                if(attachmentObj != null && attachmentObj.Body != null ) { 
                    try { attachmentObj.ParentId = newcaseinsert.id; ESAPI.securityUtils().validatedInsert(new List<Attachment>{attachmentObj});} 
                    catch(DMLException e) { ApexPages.addMessage(new Apexpages.Message(ApexPAges.Severity.ERROR, e.getMessage())); return null; }
                    finally { attachmentObj = new Attachment(); }
                }
           }     
            
        }catch(Exception e) {
            ApexPages.addMessages(e);
            system.debug('-->'+e);
            return null;
        }
         /* end of add attachment */
        PageReference pgRef = page.CylanceCaseDetailPage;
        pgRef.getParameters().put('id', newcaseinsert.id);
        pgRef.setRedirect(true);
        return pgRef;     
    }
   
}