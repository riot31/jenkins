@isTest(SeeallData=true)
public class MassCreateUserBatchTest {
	private static final String NEED_USERS_BY_CASTOM_SETTING = 'Users';
    
    @isTest static void checkContactSize() {
        Map<String, Mass_Objects_Creation_Settings__c> instances = Mass_Objects_Creation_Settings__c.getAll();
        Integer needContacts = instances.get(NEED_USERS_BY_CASTOM_SETTING).Number_of_Records__c.intValue();        
        Integer existContacts = [SELECT COUNT() FROM User];
        System.assert(existContacts >= needContacts);
    }
}