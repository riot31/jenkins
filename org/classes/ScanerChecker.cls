public with sharing class ScanerChecker {
    private static final Integer AMOUNT = 10;
    
    public PageReference init() {
        if(Schema.sObjectType.Contact.fields.LastName.isCreateable()
          && Schema.sObjectType.Contact.fields.Email.isCreateable()
          && Schema.sObjectType.Contact.fields.AssistantName.isCreateable()) {
            Contact c = new Contact();
            c.LastName = 'Test1';
            c.Email = 'test@Example.com';
            c.AssistantName = 'Test Assistant';
            insert c;
        }
        
        String lastNamee = 'Test2';
        String emaill = 'test2@example.com';
        String assistantNamee = 'Test Assistant';
        Contact c2 = new Contact(LastName = lastNamee, Email = emaill, AssistantName = assistantNamee);
        ESAPI.securityUtils().validatedInsert(new List<Contact>{c2}); //Security insert
        
        
        List<Contact> contactList = new List<Contact>();
        if(Schema.sObjectType.Contact.fields.LastName.isCreateable()
          && Schema.sObjectType.Contact.fields.Email.isCreateable()
          && Schema.sObjectType.Contact.fields.AssistantName.isCreateable()) {
            for(Integer i = 0; i < AMOUNT; i++) {
                Contact temp = new Contact();
                temp.LastName = 'Test' + i;
                temp.Email = 'test' + i + '@Example.com';
                temp.AssistantName = 'Test Assistant' + i;
                contactList.add(temp);
       		}
        }
        
        insert contactList;
        
        
        
        return null;
    }
}