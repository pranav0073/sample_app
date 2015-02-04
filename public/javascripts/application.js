// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function remove_fields(link){
	
	$(link).previous("input[type=hidden]").value ="1";
	
	$(link).up(".fields").hide();
}

function add_fields(link, association, content){
	var new_id = new Date().getTime();
	var regexp =new RegExp("new_"+ association, "g")
	$(link).up().insert({
		before: content.replace(regexp,new_id)
	});
}


function fbremove(){

   		jQuery('#facebook-field').hide();
		jQuery('#contact_fb').val('');
}
function glremove(){

   		jQuery('#google-field').hide();
		jQuery('#contact_google_plus').val('');
}
function twremove(){

   		jQuery('#twitter-field').hide();
		jQuery('#contact_twitter').val('');
}
function gitremove(){

   		jQuery('#github-field').hide();
		jQuery('#contact_github').val('');
}
