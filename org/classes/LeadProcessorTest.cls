@isTest
public class LeadProcessorTest {
    @isTest static void testLeadProcessorBatch() {
        List<Lead> leadList = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            leadList.add(new Lead(lastname = 'Test ' + i,
                                LeadSource = '' + i,
                                 company = ''+ i));
        }
        insert leadList;
        Test.startTest();
        Database.executeBatch(new LeadProcessor(), 200);
        Test.stopTest();
        List<Lead> testList = [SELECT Id, LeadSource FROM Lead];
        Boolean testResult = true;
        for(Integer i = 0; i < testList.size(); i++) {
            if(testList.get(i).LeadSource != 'Dreamforce' ) {
                testResult = false;
            }
        }
        System.assertEquals(true, testResult);
    }
}