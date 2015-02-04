jQuery(document).ready(function(){
	jQuery('#facebook').on('click',function(){
		console.log("facebook selected");
		jQuery('#facebook-field').show();

	})

	jQuery('#twitter').on('click',function(){
		console.log("twitter selected");
		jQuery('#twitter-field').show();
	})

	jQuery('#google').on('click',function(){
		console.log("google+ selected");
		jQuery('#google-field').show();
	})

	jQuery('#github').on('click',function(){
		console.log("github selected");
		jQuery('#github-field').show();
	})

	jQuery('#other').on('click',function(){
		console.log("other selected");
	})
	
	jQuery('#fb-remove').on('click',function(){
		 jQuery('#facebook-field').hide();
		 jQuery('#contact_fb').val('');
	})

	jQuery('#twitter-remove').on('click',function(){
		 jQuery('#twitter-field').hide();
		 jQuery('#contact_twitter').val('');  // take value of text 
                                                     // field using .val()		
	})

	jQuery('#google-remove').on('click',function(){
		 jQuery('#google-field').hide();
		 jQuery('#contact_google_plus').val('');  // take value of text 
                                                     // field using .val()		
	})

	jQuery('#github-remove').on('click',function(){
		 jQuery('#github-field').hide();
		 jQuery('#contact_github').val('');  // take value of text 
                                                     // field using .val()		
	})

	var value= jQuery("#contact_google_plus").val();
   if(value != ""){
    jQuery('#google-field').show();
   }

   var value= jQuery("#contact_fb").val();
   console.log(value);
   if(value != "" ||value == undefined){
    jQuery('#facebook-field').show();
   }

   var value= jQuery("#contact_twitter").val();
   console.log(value);
   if(value != "" || value == undefined){
    jQuery('#twitter-field').show();
   }
   var value= jQuery("#contact_github").val();
   console.log(value);
   if(value != ""){
    jQuery('#github-field').show();
   }



	
});
