public class TestForFun{
    public final String FIRST_STRING = 'TEST';
    public String prop1 {get; set;}
    public TestForFun(){}
    
    public void method1(){if(String.isNotBlank(FIRST_STRING)){prop1 = 'EQ';} else prop1 = 'NOTEQ';} public void method2(){String s = 'ABS'; if(s.equals(FIRST_STRING)){prop1='Yes';} else prop1='No';}
}