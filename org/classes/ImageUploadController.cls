public  with sharing  class ImageUploadController {
    private static final String PACKAGE_NAME_BY_CASTOM_SETTING = 'packageImages';    
    private static final String TYPE_OBJECT = 'image';
    private static final String FORMAT_MARKER = '.';
    private static final Integer FIRST_ELEMENT = 0;
    
    private String folderId {
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
    
    public Document document {
        get {
            if (document == null) {
                document = new Document();
            }
            return document;
        }
        set;
    }      
    
    public PageReference upload() { 
        if(document.type == null) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Select file'));
            return null;
        }
        if(document.type.contains(TYPE_OBJECT)) {  
            if(Schema.sObjectType.Document.fields.name.isCreateable() 
               && Schema.sObjectType.Document.fields.AuthorId.isCreateable()
               && Schema.sObjectType.Document.fields.FolderId.isCreateable()) {
                document.name = getFileName(document.name);
                document.AuthorId = UserInfo.getUserId();
                document.FolderId = folderId;  
                try {
                    insert document;                         
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'File uploaded successfully')); 
                } catch (DMLException e) {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading file'));
                    return null;
                } finally {
                    document.body = null; // clears the viewstate
                    document = new Document();
                }  
            }
              
        } else {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Invalid image format'));          
        }       
        return null;
    }
    
    private String getFileName(String fullName) {
        return fullName.substring(FIRST_ELEMENT, fullName.lastIndexOf(FORMAT_MARKER));
    }
    
    private String getFolderIdByName(String name) {
        Folder folder = [SELECT id from Folder where name=:name];
        return folder.id;
    }
}