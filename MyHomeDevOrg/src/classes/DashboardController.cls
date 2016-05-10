public class DashboardController{
    public list<Report> reports {
        get{
            return [SELECT Id FROm Report WHERE Id IN('00O20000006W7ct','00O20000006VTSq')LIMIT 5];
        }
    }
}