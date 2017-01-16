public with sharing class SpeakerControllerExtension {

    public Integer counter {get; set;}
	public blob picture { get; set; }
	public String errorMessage { get; set; }
    
    private final Speaker__c speaker;
    private ApexPages.StandardController stdController;

    public SpeakerControllerExtension(ApexPages.StandardController stdController) {
        this.speaker = (Speaker__c)stdController.getRecord();
        this.stdController = stdController;
        counter = 0;
    }

    public void increment() {
        counter++;
    }
    
    public PageReference save() {
    errorMessage = '';
    try {
        upsert speaker;
        if (picture != null) {
            if(Schema.sObjectType.Attachment.fields.body.isCreateable()
              && Schema.sObjectType.Attachment.fields.name.isCreateable()
              && Schema.sObjectType.Attachment.fields.parentid.isCreateable()
              && Schema.sObjectType.Attachment.fields.ContentType.isCreateable()) {
                Attachment attachment = new Attachment();
                attachment.body = picture;
                attachment.name = 'speaker_' + speaker.id + '.jpg';
                attachment.parentid = speaker.id;
                attachment.ContentType = 'application/jpg';
                insert attachment;
            }
            
            speaker.Picture_Path__c = '/servlet/servlet.FileDownload?file='
                                      + attachment.id;
            update speaker;
        }
        return new ApexPages.StandardController(speaker).view();
    } catch(System.Exception ex) {
        errorMessage = ex.getMessage();
        return null;
    }
}

}