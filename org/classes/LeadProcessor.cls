global class LeadProcessor implements 
    Database.Batchable<sObject>, Database.Stateful {
    
    // instance member to retain state across transactions
    global Integer recordsProcessed = 0;

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id From Lead'
        );
    }

    global void execute(Database.BatchableContext bc, List<Lead> scope){
        for (Lead l : scope) {
            l.LeadSource = 'Dreamforce';
        }
        update scope;
    }    

    global void finish(Database.BatchableContext bc){
        
    }    

}