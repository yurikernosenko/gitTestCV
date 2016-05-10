public class loadingSpinnerCtrl3 {


    public String dropdown1{get; set;}
    public List<SelectOption> options;

    public PageReference doSave() {
        return null;
    }

    public void spin() {
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error Message.'));
        if(dropdown1 == '1'){
            options = new List<SelectOption>();
            options.add(new SelectOption('1','Value 1'));
            options.add(new SelectOption('2','Value 2'));        
        }else if (dropdown1 == '2'){
            options = new List<SelectOption>();
            options.add(new SelectOption('3','Value 3'));
            options.add(new SelectOption('4','Value 4'));        
        }   
        long now = datetime.now().gettime();
        while(datetime.now().gettime()-now<3000); // Busy loop for 3000 ms to simulate delay
    }
    public List<SelectOption> getItems() {
        return options;
    }    
}