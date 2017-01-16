global class MassCreateUserBatch implements Database.Batchable<SObject>
{
    private static final String QUERY = 'SELECT Id FROM User LIMIT 1';
    private static final String NEED_USERS_BY_CASTOM_SETTING = 'Users';
    private static final String PROFILE_NAME = 'Standard User';
    private static final String USER_EMAIL = '@thd.demo.ldv';
    private static final String LOCALE = 'en_US';
    private static final String FIRST_NAME = 'User';
    private static final String ENCODING = 'UTF-8';
    private static final String TIME_ZONE = 'America/Los_Angeles';
    
    global Integer Number_of_Records;
    global final Integer BATCH_SIZE = 2;
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        Map<String, Mass_Objects_Creation_Settings__c> instances = Mass_Objects_Creation_Settings__c.getAll();
        Number_of_Records = instances.get(NEED_USERS_BY_CASTOM_SETTING).Number_of_Records__c.intValue();        
        return Database.getQueryLocator(QUERY);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
        Integer existUsers = [SELECT COUNT() FROM User];
        if(existUsers < Number_of_Records) { 
            Profile p = [SELECT Id FROM Profile WHERE Name=:PROFILE_NAME];     
            List<User> users_to_create = new List<User>();
            Integer amount_insert = Number_of_Records - existUsers >= BATCH_SIZE + existUsers ? BATCH_SIZE + existUsers : Number_of_Records;
            if(Schema.sObjectType.User.fields.Alias.isCreateable()
              && Schema.sObjectType.User.fields.Email.isCreateable()
              && Schema.sObjectType.User.fields.EmailEncodingKey.isCreateable()
              && Schema.sObjectType.User.fields.FirstName.isCreateable()
              && Schema.sObjectType.User.fields.LastName.isCreateable()
              && Schema.sObjectType.User.fields.UserName.isCreateable()
              && Schema.sObjectType.User.fields.CommunityNickname.isCreateable()
              && Schema.sObjectType.User.fields.LanguageLocaleKey.isCreateable()
              && Schema.sObjectType.User.fields.LocaleSidKey.isCreateable()
              && Schema.sObjectType.User.fields.ProfileId.isCreateable()
              && Schema.sObjectType.User.fields.TimeZoneSidKey.isCreateable()
              && Schema.sObjectType.User.fields.IsActive.isCreateable()) {
               for (Integer i = existUsers; i < amount_insert; i++) {
                    User u = new User(Alias = String.valueOf(i),
                                      Email = i + USER_EMAIL, 
                                      EmailEncodingKey = ENCODING,
                                      FirstName = FIRST_NAME,
                                      LastName = String.valueOf(i),
                                      UserName = USER_EMAIL,
                                      CommunityNickname = String.valueOf(i),
                                      LanguageLocaleKey = LOCALE, 
                                      LocaleSidKey = LOCALE,
                                      ProfileId = p.Id, 
                                      TimeZoneSidKey = TIME_ZONE,
                                      IsActive = true
                                      );
                    users_to_create.add(u);
                }    
            }
                     
            insert users_to_create;
        }       
    }
    
    global void finish(Database.BatchableContext BC){
        Integer existUsers = [SELECT COUNT() FROM User];
        if(existUsers < Number_of_Records) {
            Id batchInstanceId = Database.executeBatch(new MassCreateUserBatch(), 200); 
        }
    }    
}