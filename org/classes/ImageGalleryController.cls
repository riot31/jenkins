public with sharing class ImageGalleryController {    
    private static final String PACKAGE_NAME_BY_CASTOM_SETTING = 'packageImages';    
    private static final String PATCH_PREFIX = '/servlet/servlet.FileDownload?file=';
    
    private static String folderId {
        get {
            if(folderId == null) {
                Map<String,oez__Folder_Names__c> instances = oez__Folder_Names__c.getAll();
                String packageName = instances.get(PACKAGE_NAME_BY_CASTOM_SETTING).value__c;
                folderId = getFolderIdByName(packageName);
            }
            return folderId;
        }
        set;
    } 
    
    private static String getFolderIdByName(String name) {
        Folder folder = [SELECT id from Folder where name=:name];
        return folder.id;
    }
    
    @AuraEnabled
    public static List<Document> getImages(String criteria) {
        List<Document> images = new List<Document>();  
        if(!String.isEmpty(criteria)) {
            criteria = criteria.replace('"', '');
        }        
        for(Document image : [SELECT Id,  Name, Url FROM Document where FolderId =:folderId and Type LIKE 'image%']) {           
            if(String.isEmpty(criteria) || image.Name.contains(criteria)) {
                image.url = PATCH_PREFIX + image.id;
                images.add(image);  
            } 
        }
        return images;
    }
    
	@AuraEnabled
    public static List<Document> getImages() {
        return getImages(null);
    }    
}