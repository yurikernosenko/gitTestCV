public class TaskCustomObj{
    public String testText{get; set;}
    
    public void testStringMethod(){
        System.debug('v testText ' + testText);
    }

    public String renderAttribut {get; set;}
    public String documentName {get; set;}
    public Boolean isDownload {get; set;}
    public String pageContentType {
        get{
            String defaultContentType = 'text/html';
            if(renderAttribut == 'pdf'){
                defaultContentType = 'application/pdf';
                if(isDownload){
                    ApexPages.currentPage().getHeaders().put(
                            'content-disposition', 'attachment; filename=' + documentName + '.pdf');
                }
            }
            return defaultContentType;
        }
        set;
    }

    public List<TaskCustomObj__c> tasks {
        get{
            return [SELECT ID, Name FROM TaskCustomObj__c LIMIT 10];
        }
        set;
    }

    public String recordId {
        get; 
        set {
           recordId = value; 
        }
    }

    public TaskCustomObj(){
    
    }

    public PageReference renderPageAsPDF() {
        isDownload = false;
        renderAttribut = 'pdf';
        return null;
    }

    public PageReference downloadDocument(){
        isDownload = true;
        renderAttribut = 'pdf';
        if(String.isBlank(documentName)){
            documentName = 'default';
        }
        return null;
    }

    public PageReference deleteThisRecord(){
        TaskCustomObj__c taskToDelete = [SELECT ID FROM TaskCustomObj__c WHERE Id = :recordId ];
        delete taskToDelete;

        /*TaskCustomObj__c taskToDelete = null;
        String recordId=Apexpages.currentPage().getParameters().get('recordId');
        System.debug('recordToDeleteId ');
        if(recordId== null) return null;
        for(TaskCustomObj__c task: tasks ){
            if(task.Id == recordId){
                taskToDelete = task;
                break;
            }
        }
        delete taskToDelete;*/
        return null;
    }

}