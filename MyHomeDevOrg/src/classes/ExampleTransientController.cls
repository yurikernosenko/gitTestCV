public class ExampleTransientController{
    private DateTime t1;
    transient  private DateTime t2;
    public ExampleTransientController(){
    System.debug(ApexPages.currentPage().getParameters().get('param1'));
        if (ApexPages.currentPage().getParameters().containsKey('param1'))
        {
        String yourVar = ApexPages.currentPage().getParameters().get('param1');
        }
    }
    public string getT1(){
        if(t1 == null){
            t1 = System.NOW();
        }
        return String.valueOf(t1); 
    }
    
    public String getT2(){
        if(t2 == null){
            t2 = System.NOW();
        }
        return String.valueOf(t2);
    }
    
     public PageReference toHomePage(){
     
      //PageReference p = new PageReference('/home/home.jsp');
      PageReference p = new PageReference(Url.getSalesforceBaseUrl().toExternalForm());
        p.setRedirect(true);
        return p;
    }      
}