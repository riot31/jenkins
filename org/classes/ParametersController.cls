public class ParametersController {
    
    public PageReference init() {
        for(String key : ApexPages.currentPage().getParameters().keySet()) {
            System.debug('key= ' + key);
            
            String aaa = ApexPages.currentPage().getParameters().get(key);
            ApexPages.currentPage().getParameters().put(key, 'axaxaxa');
            System.debug(aaa); 
        }
		return null;        
    }
}