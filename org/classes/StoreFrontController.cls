public class StoreFrontController {
    List<DisplayMerchandise> products;
    List<DisplayMerchandise> shoppingcart = new List<DisplayMerchandise>();
    
    public List<DisplayMerchandise> getProducts() {
        if(products == null) {
            products = new List<DisplayMerchandise>();
            for(Merchandise__c item : [SELECT Id, Name, Description__C, Price__c, Total_Inventory__c FROM Merchandise__c]) {
                products.add(new DisplayMerchandise(item));
            }           
        }
        return products;         
    }
    
    public PageReference addToCart() {
        for(DisplayMerchandise p : products) {
            if(0 < p.gtyTobuy) {
                shoppingCart.add(p);
            }
        }
        return null;
    }
    
    public String getCartContents() {
        if (0 == shoppingCart.size()) {
            return '(empty)';
        }
        String msg = '<ul>\n';
        for(DisplayMerchandise p : shoppingCart){
            msg += '<li>' + p.name + ' (' + p.gtyToBuy + ')' + '</li>\n';
        }
        shoppingCart.clear();
        msg += '</ul>';
        return msg;
    }
    
    public class DisplayMerchandise {
        private Merchandise__c merchandise;
        public DisplayMerchandise(Merchandise__c item) {
            this.merchandise = item;
        }
        
        public String name {
            get { return merchandise.Name;}
        }
        
        public String description {
            get {return merchandise.Description__c;}
        }
        
        public Decimal price {
            get { return merchandise.Price__c;}
        }
        
        public Boolean inStock {
            get { return (0 < merchandise.Total_Inventory__c);}
        }
        
        public Integer gtyToBuy {get; set;}
        
    }
}