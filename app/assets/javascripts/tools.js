/**
*   Listerners for removable blocks
*
*
*/
function setRemovables(){
	$(".removable").click(function(){
		$(this).fadeOut(50);
	});	
}

/**
*   Shows the explanation of given exhyp element
*
*
*/
function showExHypExplanation(elemid){
    $(elemid).fadeIn(50);
}

/**
*   Popovers for help buttons
*
*
*/
//$(document).ready(function(){
//    $('[data-toggle="popover"]').popover();
//    $().dndPageScroll();
//});