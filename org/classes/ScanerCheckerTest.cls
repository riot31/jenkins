@isTest
public class ScanerCheckerTest {
    @isTest static void testCheck() {
        Contact c = new Contact();
        c.LastName = 'Test1';
        c.Email = 'test@Example.com';
        c.AssistantName = 'Test Assistant';
        insert c;
        Contact c2 = new Contact(LastName = 'Test2', Email = 'test2@example.com', AssistantName = 'Test Assistant');
        insert c2;
        Integer contactRecords = [SELECT COUNT() FROM Contact];
        System.assertEquals(2, contactRecords);
    }
}