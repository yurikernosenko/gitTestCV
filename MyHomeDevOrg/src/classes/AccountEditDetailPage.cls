public class AccountEditDetailPage{
public Account acc{get;set;}
public AccountEditDetailPage(ApexPages.StandardController controller) {
acc=(Account)controller.getRecord();
}
public static final Map<Id, RecordType> recordTypes = new Map<Id,RecordType>([SELECT Id, Name,DeveloperName FROM RecordType WHERE sObjectType ='Account']);
public PageReference getRedir() {
String url = '';
String ovveride = '';
if (recordTypes.containsKey(acc.recordtypeid)) {
String developerName = recordTypes.get(acc.recordtypeid).DeveloperName;
if (developerName.equalsIgnoreCase('Company') || developerName.equalsIgnoreCase('B2B')) {
url = '/' + acc.id + '/e?retURL=%2F' + acc.id;}else {
url = 'Our custom page for Address';
ovveride = '1';}}
if (String.isBlank(url)){url ='/' + acc.Id;
}
PageReference newPage = new PageReference(url);
if(String.isNotBlank(ovveride)){
newPage.getParameters().put('nooverride', ovveride);
}
newPage.setRedirect(true);
return newPage;
}
}