public with sharing class CampingListController {
    @AuraEnabled
	public static List<Camping_Item__c> getItems() {
        return [SELECT Id, Name, Price__c, Packed__c, Quantity__c  From Camping_Item__c];
    }
    
    @AuraEnabled
    public static Camping_Item__c saveItem(Camping_Item__c newItem) {
        upsert newItem;
        return newItem;
    }
}