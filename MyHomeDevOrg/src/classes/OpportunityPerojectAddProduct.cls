public class OpportunityPerojectAddProduct{
     
     public Opportunity opportunity{get;set;}
     
     public List<sObject> products {get; set;}
     
     public List<sObject> lineItems{get; set;}
     
     public OpportunityPerojectAddProduct(ApexPages.StandardController con){
        //opportunity = [SELECT Id, Name, (SELECT Id, Name FROM OpportunityLineItems) FROM Opportunity WHERE Id =: ApexPages.currentPage().getParameters().get('id')]; 
     }  

     
     public PageReference  searchProducts(){
        //products = [SELECT Id, Name FROM Product2 WHERE Name =: ApexPages.currentPage().getParameters().get('productName')];
        String searchName = '%' + ApexPages.currentPage().getParameters().get('productName') + '%';
        products = [SELECT Id, Name FROM Product2];
         System.debug(products );
         return null;
     } 
     
     /*public PageReference addLineItem(){
         Integer count;
         for(sObject obj: products){
             count++;
             if(obj.get('Id') == 'id as param'){
                 products.remove(count);
                 break;
             }
         }
         //create new oppLineItem
         //lineItems.add();
     }*/
}