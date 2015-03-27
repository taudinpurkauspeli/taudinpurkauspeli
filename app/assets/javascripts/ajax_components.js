
//Warns if AJAX call returns error
$(document).ajaxError(function( event, jqxhr, settings, thrownError ) {
	alert("Ajax error: " + jqxhr.status + " " + jqxhr.statusText + " -- " + thrownError);
});


/**
* Overrides defaut submits with AJAX submits
*
* formsSelector: Selector string for forms to be overrided
* containerElementSelector: Selector string for element to be refreshed 
*/
function setAjaxSubmits(formsSelector, containerElementSelector, type, submitCallback){
	//alert("setajaxsubmits: " + formsSelector + "; " + containerElementSelector);
	var forms = $(formsSelector);
	var containerElement = $(containerElementSelector);

	forms.submit(function(){
		var clickedForm = $(this);
		var postUrl = fullUrlWithoutLayout(clickedForm.attr("action"));
		alert(postUrl);

		if(type == "post"){
			$.post(postUrl, clickedForm.serialize())
	    	.done(function(data) {
					containerElement.html(data);					
				})
				.fail(function(data) {
					alert("Vihe post-pyynnössä: \n" + data);
				})
				.always(function() {
					if(submitCallback != undefined){
				 		submitCallback();
				  }
	    	});	
			}else{
				loadView(postUrl, containerElementSelector, submitCallback)
			}
		
    return false;
	});

}

/**
*
*
*
*
*/
function setNewTabSubmits(formsSelector, containerElementSelector, callback){
	//alert("clickToOpenTaskTab: " + formsSelector + "; " + containerElementSelector);
	var containerElement = $(containerElementSelector);
	var forms = $(formsSelector)

	forms.submit(function(e){
		var actionUrl = $(this).attr("action");
		var taskName = $(this).find('input[type="submit"]').attr("value");
		//alert("urli: " + actionUrl);
		
		openNewTab(actionUrl, containerElementSelector, taskName, callback);		
		
		return false;
	});

}

function openNewTab(url, containerElementSelector, taskName, callback){
	var targetTabLink = $('#navigationTabs a[href="'+containerElementSelector+'"]')

	if(!targetTabLink.length){
		$("#navigationTabs").append("<li role='presentation'><a href='"+containerElementSelector+"' aria-controls='currentTask' role='tab' data-toggle='tab'>"+taskName+"</a></li>");
		targetTabLink = $('#navigationTabs a[href="'+containerElementSelector+'"]');
	}else{
		targetTabLink.html(taskName);
	}

	loadView(url, containerElementSelector, callback)
	targetTabLink.tab('show');
} 

/**
* Loads given url and inserts it inside given element with AJAX call
*
*
*
*
*/
function loadView(url, elementSelector, callback){
	//alert("loadView: " + url + "; " + elementSelector);
	var element = $(elementSelector);
	element.load(fullUrlWithoutLayout(url), function(responseTxt, statusTxt, xhr){
      if(statusTxt == "error"){
          element.html("<h1>Virhe sivua ladattaessa.</h1><div>"+responseTxt+"</div><p>"+statusTxt+"</p><p>"+xhr+"</p>");
      }else if(statusTxt == "success"){
      	if(callback != undefined){
			 		callback();
			  }

      }
  });
  
}

function fullUrlWithoutLayout(path){
	if(path.indexOf("http:") > -1 && path.indexOf("?layout=false") > -1){
		return path;
	}
	if(path.charAt(0) == "/"){
		path = path.substr(1);
	}
	return location.protocol + "//" + location.host + "/" + path + "?layout=false";
}

/*
function getView(url){
	$.get(url)
		.done(function(data) {
		alert( data );
		})
		.fail(function(data) {
		alert( "error: " + data );
		})
		.always(function(data) {
		alert( "finished: " + data );
		});
}
*/