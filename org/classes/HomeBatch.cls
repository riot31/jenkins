global class HomeBatch implements Database.Batchable<sObject> {
	global final String QUERY = 'SELECT Id FROM Contact LIMIT 1';
    global final Integer NEED_CONTACTS = 50000;
    global final Integer LIMIT_INSERT = 200;
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(QUERY);
    }
    
    global void execute(Database.BatchableContext BC, List<Contact> contacts) {
        Integer existContacts = [SELECT COUNT() FROM Contact];
        if(existContacts < NEED_CONTACTS) {
            List<Contact> contactsListForInsert = new List<Contact>();
            Integer count_insert = NEED_CONTACTS - existContacts >= LIMIT_INSERT + existContacts ? LIMIT_INSERT + existContacts : NEED_CONTACTS;
            if(Schema.sObjectType.Contact.fields.LastName.isCreateable()) {
                for (Integer i = existContacts; i < count_insert; i++) {
                    Contact temp = new Contact(LastName = 'Jonni ' + String.valueOf(i));
                    contactsListForInsert.add(temp); 
                }
            }
                     
            insert contactsListForInsert;
        }
    }
    
    global void finish(Database.BatchableContext BC) {       
    }
}