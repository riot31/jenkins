public class ParametersControllerV2 {
   	private String testInit = 'init not run';
    
    public String getTestInit(){
        return testInit;
    }
    
    public ParametersControllerV2() {
        testInit = 'init run';
        for(String key : ApexPages.currentPage().getParameters().keySet()) {
            System.debug('key= ' + key);
            
            String aaa = ApexPages.currentPage().getParameters().get(key);
            ApexPages.currentPage().getParameters().put(key, 'axaxaxa');
            System.debug(aaa); 
        }     
    }
}