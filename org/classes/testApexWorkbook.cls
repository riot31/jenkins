@isTest
public class testApexWorkbook {
    static testmethod void testLoadData() {
        // create the test data
        Test.startTest();
        List<Merchandise__c> merchandise = [SELECT Id FROM Merchandise__c];
        List<Invoice_Statement__c> invoices = [SELECT Id FROM Invoice_Statement__c];
        List<Line_Item__c> line_items = [SELECT Id FROM Line_Item__c];
        Test.stopTest();
        // do some asserts
        System.assertEquals(merchandise.size(), 0);
        System.assertEquals(invoices.size(), 0);
        System.assertEquals(line_items.size(), 0);
    }
}