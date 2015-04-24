/**
*   Listerners for rompvable blocks
*
*
*/
function setRemovables(){
	$(".removable").click(function(){
		$(this).fadeOut(50);
	});	
}

/**
 * Function for testing ckeditor text editors.
 *
 * Allows tests to wait until ckeditor has been loaded.
 *
 */

function isCkeditorLoaded(instance_selector) {
    // instance_selector is e.g. 'template_html'
    var status;
    if (window.CKEDITOR && CKEDITOR.instances && CKEDITOR.instances[instance_selector]) {
        status = CKEDITOR.instances[instance_selector].status;
    }
    return status === 'ready';
};

/**
 * Updates CKeditor instance in view.
 *
 *
 *
 */

function CKupdate(){
    for ( instance in CKEDITOR.instances ){
        CKEDITOR.instances[instance].updateElement();
    }
}

/**
*   Popovers for help buttons
*
*
*/
$(document).ready(function(){
    $('[data-toggle="popover"]').popover();
});