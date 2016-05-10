public class ActionFunctionWithRedirect{
    
    public PageReference redirectToYouTube(){
        PageReference redirectPage = new PageReference('https://www.youtube.com/watch?v=RQLnvde45xI');
        redirectPage.setRedirect (false);
        return redirectPage;
    }
}