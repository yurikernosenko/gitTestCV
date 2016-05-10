public with sharing class InputFileController{

    public Blob resume {get; set;}
    public String contentType {get; set;}
    public String fileName {get; set;}

    public List<Attachment> attachments {
    get{
    attachments = [SELECT ID FROM Attachment];
    return attachments;
    }
    set;
    }
    public Attachment attachment {
        get{
            if(attachment == null){
                attachment = new Attachment();
            }
            return attachment;
        }
        set;}
    
    public Document doc {
    get{
        if(doc == null){
            doc = new Document();
        }
        return doc;
    }
    set;}

    public String s{get;set;}
    public Id ids {get;set;}

    public list<Account> acounts {get;set;}

    public InputFileController(ApexPages.StandardController sc){
        ids = sc.getRecord().id;
        acounts = [SELECT Id, Name FROM Account Limit 10];
    }

    public PageReference doAttachment(){

        Account a = [SELECT Id, Photo__c FROM Account WHERE Id = :ids];
        
         Attachment attach=new Attachment();
         attachment.Body=resume;
         attachment.Name=filename;
         attachment.ContentType=contentType;
         attachment.ParentID=a.Id;
System.debug('resume ' + resume);
System.debug('filename  ' + filename);
System.debug('contentType   ' + contentType);
System.debug('attachment  ' + attachment);
         insert attachment;

        //a.Photo__c = Url.getSalesforceBaseUrl().toExternalForm() + 'servlet/servlet.ImageServer?oid=' + UserInfo.getOrganizationId() + '&id=' + attachment.Id;
        //a.Photo__c = '/servlet/servlet.FileDownload?file=' + attachment.Id;
        //update a;

        return null;    
    }

    public PageReference doAttachment2(){
        doc.AuthorId = UserInfo.getUserId();
        doc.FolderId = UserInfo.getUserId();
        insert doc;
        Account a = [SELECT Id, Photo__c FROM Account WHERE Id = :ids];
        a.Photo__c = '/servlet/servlet.FileDownload?file=' + doc.Id;
        update a;
        
        PageReference pref = new PageReference('/'+ids);
        pref.setRedirect(true);
        return pref;    


        //return null;    
    }

    public PageReference toHomePage(){
        if(s!=null){
            PageReference p = new PageReference(Url.getSalesforceBaseUrl().toExternalForm());
            p.setRedirect(true);
            return p;
        } else {
            return null;
        }       
    }
}