public with sharing virtual class LightningComponentControllerBase {
    
    public LightningApplicationControllerBase pageController { get;
        set {
            if (value != null) {
                pageController = value;
                pageController.setComponentController(this);
            }
        }
    }   

}