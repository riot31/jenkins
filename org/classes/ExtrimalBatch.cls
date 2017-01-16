global class ExtrimalBatch implements Database.Batchable<SObject>, Database.Stateful {
    private static final String QUERY = 'SELECT Id, LastName FROM Contact';
    
    private final Integer BATCH_SIZE = 6;
    private  Integer currentSize = 0;
    
    global Database.QueryLocator start(Database.BatchableContext BC){       
        return Database.getQueryLocator(QUERY);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
        if(scope.size() > BATCH_SIZE) {
            currentSize += scope.size();
            return;           
        } else {
            System.debug('Perfect!');
        }
    }
    
    global void finish(Database.BatchableContext BC){
        System.debug('currentSize=' + currentSize);
        if(currentSize != null && currentSize > BATCH_SIZE) {
            System.debug('recursion Start');
            ExtrimalBatch batch = new ExtrimalBatch();
            Database.executeBatch(batch, BATCH_SIZE);           
        }
    }    

}