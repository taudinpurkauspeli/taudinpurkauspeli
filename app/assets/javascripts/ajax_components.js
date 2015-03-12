
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
function setAjaxSubmits(formsSelector, containerElementSelector){
	var forms = $(formsSelector);
	var containerElement = $(containerElementSelector);
	forms.submit(function(){
		var clickedForm = $(this);
		var postUrl = clickedForm.attr("action") + "?layout=false";
		//alert("klikkasit submittia!");
		//alert("action: " + postUrl);
		//alert($(this).attr("id"));
		
		$.post(postUrl, clickedForm.serialize())
    	.done(function(data) {
				containerElement.html(data);
				setAjaxSubmits(formsSelector, containerElementSelector);
			})
			.fail(function(data) {
				//alert("Virhe tallentaessa. Yritä uudelleen./n" + data);
			})
			.always(function() {
				//alert("Pyyntö valmis, onnistui tai ei");
    	});
		
    return false;
	});

}

function clickToOpenTaskTab(formsSelector, containerElementSelector){
	var containerElement = $(containerElementSelector);
	var forms = $(formsSelector)
	alert("nappeja" + forms.length);
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

		loadView(actionUrl, containerElementSelector, function(){
			//setAjaxSubmits($("#currentTaskTab form"));
		});
		targetTabLink.tab('show');
		//$('#navigationTabs a[href="#currentTask"]')
		//alert("klikkasit nappia");
		return false;
	});

}

//Loads given url and inserts it inside given element with AJAX call
function loadView(url, elementSelector, callback){
	var element = $(elementSelector);

	element.load(url + "?layout=false", function(responseTxt, statusTxt, xhr){
      if(statusTxt == "error"){
          element.html("<h1>Virhe sivua ladattaessa.</h1><p>"+responseTxt+"</p><p>"+statusTxt+"</p><p>"+xhr+"</p>");
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