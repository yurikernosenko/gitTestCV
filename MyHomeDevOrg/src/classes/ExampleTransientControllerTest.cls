@isTest
public class ExampleTransientControllerTest{
    @isTest
    private static void test1(){
        ExampleTransientController testController = new ExampleTransientController();
        
        Test.startTest();
        String tesstDate = testController.getT1();
        Test.stopTest();
        System.assertNotEquals(null, tesstDate );
    }

}