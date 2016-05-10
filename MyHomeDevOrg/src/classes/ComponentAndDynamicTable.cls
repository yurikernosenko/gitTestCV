public class ComponentAndDynamicTable{

	public list<Account> acc {
		get {
			return [SELECT ID FROM Account];
		}
		set;}

	public ComponentAndDynamicTable(){
	}
}