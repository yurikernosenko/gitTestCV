public with sharing virtual class LightningApplicationControllerBase {
     
    private LightningComponentControllerBase myComponentController;

    public virtual LightningComponentControllerBase getMyComponentController() {
        return myComponentController;
    }

    public virtual void setComponentController(LightningComponentControllerBase compController) {
        myComponentController = compController;    
    }
     
    public LightningApplicationControllerBase getThis() {
        return this;
    }
}