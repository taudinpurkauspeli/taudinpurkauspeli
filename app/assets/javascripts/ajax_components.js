
//Warns if AJAX call returns error
$(document).ajaxError(function( event, jqxhr, settings, thrownError ) {
	alert("Ajax error: " + jqxhr.status + " " + jqxhr.statusText);
});


//TODO
//Overrides defaut submits with AJAX submits
function setAjaxSubmits(forms){
	forms.submit(function(){
		var clickedForm = $(this);
		var postUrl = clickedForm.attr("action") + "?layout=false";
		alert("klikkasit submittia!");
		alert("action: " + clickedForm.attr("action"));
		//alert($(this).attr("id"));
		
		$.post(postUrl, clickedForm.serialize())
    	.done(function(data) {
				alert("palaute: /n" + data);
			})
			.fail(function(data) {
				alert("Virhe tallentaessa. Yritä uudelleen./n" + data);
			})
			.always(function() {
				alert("Pyyntö valmis, onnistui tai ei");
    	});
		
    return false;
	});

}

//Loads given url and inserts it inside given element with AJAX call
function loadView(url, element){

	element.load(url + "?layout=false", function(responseTxt, statusTxt, xhr){
      if(statusTxt == "error"){
          element.html("<h1>Virhe sivua ladattaessa.</h1><p>"+responseTxt+"</p><p>"+statusTxt+"</p><p>"+xhr+"</p>");
      }else if(statusTxt == "success"){
      	//setAjaxSubmits(element.find("form"));

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