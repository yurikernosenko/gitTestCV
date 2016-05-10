public class JSON_Test {
    public Attributes attributes;
    public Id parentId;
    public Body body;
    
    public class Attributes {
        public String type{get; set;}
    }
    
    public class Body {
        public Blob asByteArray {get; set;}
    }
        
}