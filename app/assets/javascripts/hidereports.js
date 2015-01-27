$(document).ready(function(){
	$(".reportHideButton").click(function(){
		var elem = $(this).parent();
		var currentHeight = elem.height();
		var autoHeight = elem.css('height', 'auto').height();
		elem.height(currentHeight);

		if(currentHeight >= autoHeight){
			elem.animate({height: "10px"});	
		}else{
			var auto = elem.css('height', 'auto').height();
			elem.height(10).animate({height: auto}, 500);
		}
		
	});
});
