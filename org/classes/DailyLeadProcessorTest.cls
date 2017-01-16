@isTest
public class DailyLeadProcessorTest {
	@testSetup 
    static void setup() {
        List<Lead> leadList = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            leadList.add(new Lead(lastname = 'Test ' + i,
                                LeadSource = '' + i,
                                 company = ''+ i));
        }
        insert leadList;
    }
    
    @isTest static void testDailyLead() {
        Test.startTest();
        String sch = '20 20 * * * ?';
        String jobId = System.schedule('Reming Opp Owners', sch, new DailyLeadProcessor());
        Test.stopTest();
        List<Lead> leadList = [SELECT Id, LeadSource from Lead LIMIT 200];
        Boolean result = true;
        for (Integer i = 0; i < leadList.size(); i++) {
            if(leadList.get(i).LeadSource != 'DreamForce') {
                result = false;
            }
        }
        System.assertEquals(true, result);
    }
}