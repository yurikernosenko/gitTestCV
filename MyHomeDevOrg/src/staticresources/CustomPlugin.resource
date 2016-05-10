(function($) {
	$.widget('x360.retrieveDataFromHeroku', {
		options: {
	  		'baseSelector'  : 'div.baseStyle',
			'dataAttribute' : 'data-entityId'
		},
	 
		_create: function () {

			console.log(this.options);

	    	var ids = [];
	    	var options = this.options;
	        $(this.options.baseSelector).each(function(){
				var currentElement = $(this);
	        	if(currentElement.attr(options.dataAttribute) != ''){
	        		ids.push(currentElement.attr(options.dataAttribute));
	            } else {
	                setDefaultImage(currentElement); 
	            }
	        });
	        ids = ids.join(',');
	        var urlBase = 'https://devsm360service.herokuapp.com/entity/aggregated?ids=';
	        var url = urlBase + ids;
	        //var url = "{!$Setup.Endpoint__c.EndpointUrl__c}" + "/entity/aggregated?ids=" + ids;
	        retrieveDataFromHeroku(url, callback, errorHandler, options);
		},

		

		_setOption: function (key, value) {
			switch( key ) {
		    case "baseSelector":
	      		this.baseSelector = value
	      	break;
	      	case "dataAttribute":
	      		this.dataAttribute = value
	      	break;
		  }
		},

		_destroy: function () {}
	 	

		
	});

		function retrieveDataFromHeroku (url, callback, error, options){
	    	var client = new XMLHttpRequest();
	    	client.open("GET", url, true);
	    	client.send();
	    	client.onreadystatechange = function() {
		        if (this.readyState == 4){
		            if (this.status == 200){
		                callback(JSON.parse(this.responseText), options); 
		            } else {
		                var result = JSON.parse(this.responseText);
		                result.status = this.status;
		                result.statusText = this.statusText;
		                errorHandler(result, options);
		            }
		        }
		    }
		}

		function callback (response, options){
	        for(i=0; i<response.length; i++){
	           var selector = options.baseSelector + '[' + options.dataAttribute + '="'+response[i].id+'"]';
	           var currentElement = $(selector);
	           if(response[i].imageURL != null){    
	               currentElement.css('background-image', 'url(' + response[i].imageURL+ ')');
	           } else {
	               currentElement.addClass('type_'+response[i].type);
	               setDefaultImage(currentElement);   
	           }
	        }
	        errorHandler('', options);
	    }

	    function errorHandler(response, options){
            $(options.baseSelector).each(function(){
                if($(this).css('background-image') == 'none'){
                    setDefaultImage(this);
                }
            });           
        }

		function setDefaultImage(el){
            $(el).addClass('default');
        }
}(jQuery));

/*

    return this.each(function() {        
    	var $this = $(this),
    	var ids = [];
        $($this.baseSelector).each(function(){
			var currentElement = $(this);
        	if(currentElement.attr($this.baseSelector) != ''){
        		ids.push(currentElement.attr($this.baseSelector));
            } else {
                setDefaultImage(currentElement); 
            }
        });
        ids = ids.join(',');
        var url = "{!$Setup.Endpoint__c.EndpointUrl__c}" + "/entity/aggregated?ids=" + ids;
        retrieveDataFromHeroku(url, callback, errorHandler);

        
    });

*/