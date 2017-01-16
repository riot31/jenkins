public class ProcessBuilderBlackList {
      @InvocableMethod(label='run Locked Opportunities')
      public static void lockedOpprtunities(List<Id> ids) {
          List<Account> accountList = [SELECT Id, (SELECT Id FROM Opportunities) FROM Account WHERE oez__isBlackListed__c = :true AND Id IN :ids];
          List<Opportunity> lockList = new List<Opportunity>();
          for(Integer i = 0; i < accountList.size(); i++) {
              lockList.addAll(accountList.get(i).Opportunities);
          }
          
          // Lock the Opportunities
          Approval.LockResult[] lrList = Approval.lock(lockList, false);
          
          // Iterate through each returned result
          for(Approval.LockResult lr : lrList) {
              if (lr.isSuccess()) {
                  // Operation was successful, so get the ID of the record that was processed
                  System.debug('Successfully locked account with ID: ' + lr.getId());
              }
              else {
                  // Operation failed, so get all errors                
                  for(Database.Error err : lr.getErrors()) {
                      System.debug('The following error has occurred.');                    
                      System.debug(err.getStatusCode() + ': ' + err.getMessage());
                      System.debug('Opportunity fields that affected this error: ' + err.getFields());
                  }
              }
          } 
      }
    
}