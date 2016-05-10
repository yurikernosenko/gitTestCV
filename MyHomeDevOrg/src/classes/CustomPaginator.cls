public class CustomPaginator { 
    
    public Integer index {get;set;} 
    public Integer pageNum {get;set;} 
    public Integer totalPage {get;set;} 
    public Integer totalResults {get;set;} 
    public List<Pages> pageList {get;set;} 
    public Boolean showPrevious {get;set;} 
    public Boolean showNext {get;set;} 
    public Boolean isAll {get;set;} 
    
    public CustomPaginator(Integer listSize, Integer pageSize){ 
        this.totalResults = listSize; 
        pageSize = (pageSize > 0)?pageSize:10; 
        this.totalPage = (Integer)Math.ceil((Double)listSize / (Double)pageSize); 
        this.pageNum = 1; 
        this.index = 0; 
        this.isAll = (listSize == pageSize)?true:false; 
        updateNumbers(); 
    } 
    
    public void updateNumbers(){ 
        this.pageList = new List<Pages>(); 
        for(Integer i = 1; i < (this.totalPage + 1); i++){ 
            Boolean isPageSelected = (i == pageNum)?true:false; 
            this.pageList.add(new Pages(i, isPageSelected)); 
        } 
        this.showPrevious = (this.pageNum == 1)?false:true; 
        this.showNext = (this.pageNum == this.totalPage)?false:true; 
        this.index = this.pageNum - 1; 
    } 
    
    public void decrement(){ 
        this.pageNum = this.pageNum - 1; 
        updateNumbers(); 
    } 
    
    public void increment(){ 
        this.pageNum++; updateNumbers(); 
    } 
    
    public class Pages{ 
        public Integer pageNum {get;set;} 
        public Boolean isActive {get;set;}
         
        public Pages(Integer num, Boolean active){ 
            this.pageNum = num; 
            this.isActive = active; 
        } 
    } 
}