public class LightningApplicationController extends LightningApplicationControllerBase  {

    public LightningComponentControllerBase myComponentController { get; set; }
    
    public final String MY_VALUE = 'ABS';   
    
    @AuraEnabled
    public static String getInstance(){
        //return (LightningApplicationController) super.getThis();
        return 'abc';
    }
}