// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
$(document).ready(function() {
	// $( document ).ajaxSend(function( event, jqxhr, settings ) {
	//   console.log(event);
	//   console.log(jqxhr);
	//   console.log(settings);
	// });

	$('#new_user').on('ajax:send', function(xhr) {
		console.log('test');
	});

	$('#new_user').on('ajax:success', function(xhr, status, err) {
	  // console.log(xhr);
	  console.log(status);
	  // console.log(err);
	});
});
