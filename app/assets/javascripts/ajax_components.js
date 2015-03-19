
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
function setAjaxSubmits(formsSelector, containerElementSelector, post){
	alert("setajaxsubmits: " + formsSelector + "; " + containerElementSelector);
	var forms = $(formsSelector);
	var containerElement = $(containerElementSelector);

	forms.submit(function(){
		var clickedForm = $(this);
		//alert(location.protocol + "//" + location.host);
		var postUrl = fullUrlWithoutLayout(clickedForm.attr("action"));
		//alert("klikkasit submittia!");
		//alert("action: " + postUrl);
		//alert($(this).attr("id"));
		//alert(postUrl);

		if(post == true){
			$.post(postUrl, clickedForm.serialize())
	    	.done(function(data) {
					containerElement.html(data);
					//setAjaxSubmits(formsSelector, containerElementSelector);
				})
				.fail(function(data) {
					alert("Virhe tallentaessa: \n" + data);
				})
				.always(function() {
					//alert("Pyyntö valmis, onnistui tai ei");
	    	});	
			}else{
				loadView(postUrl, containerElementSelector)
			}
		
		
		
    return false;
	});

}

function clickToOpenTaskTab(formsSelector, containerElementSelector, callback){
	alert("clickToOpenTaskTab: " + formsSelector + "; " + containerElementSelector);
	var containerElement = $(containerElementSelector);
	var forms = $(formsSelector)
	//alert("nappeja" + forms.length);
	forms.submit(function(e){
		var actionUrl = $(this).attr("action");
		var taskName = $(this).find('input[type="submit"]').attr("value");
		//alert("urli: " + actionUrl);
		//e.preventDefault;
		//alert($('#navigationTabs a[href="#currentTask"]').length);
		var targetTabLink = $('#navigationTabs a[href="#currentTaskTab"]')

		if(!targetTabLink.length){
			$("#navigationTabs").append("<li role='presentation'><a href='#currentTaskTab' aria-controls='currentTask' role='tab' data-toggle='tab'>"+taskName+"</a></li>");
			targetTabLink = $('#navigationTabs a[href="#currentTaskTab"]');
		}else{
			targetTabLink.html(taskName);
		}

		loadView(actionUrl, containerElementSelector, callback)
		targetTabLink.tab('show');
		//$('#navigationTabs a[href="#currentTask"]')
		//alert("klikkasit nappia");
		return false;
	});

}

//Loads given url and inserts it inside given element with AJAX call
function loadView(url, elementSelector, callback){
	alert("loadView: " + url + "; " + elementSelector);
	var element = $(elementSelector);
	//alert(fullUrlWithoutLayout(url));
	element.load(fullUrlWithoutLayout(url), function(responseTxt, statusTxt, xhr){
      if(statusTxt == "error"){
          element.html("<h1>Virhe sivua ladattaessa.</h1><div>"+responseTxt+"</div><p>"+statusTxt+"</p><p>"+xhr+"</p>");
      }else if(statusTxt == "success"){
      	//setAjaxSubmits(element.find("form"));
      	if(callback != undefined){
			  	//clickToOpenTab($('.btn-available-task'), $('#navigationTabs a[href="#currentTask"]'), url, element);
			 		//alert("teki jotain");
			 		callback();
			  }

      }
  });
  
}

function fullUrlWithoutLayout(path){
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