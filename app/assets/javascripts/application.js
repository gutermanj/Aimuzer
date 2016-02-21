// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(".nav a").on("click", function(){
   $(".nav").find(".active").removeClass("active");
   $(this).parent().addClass("active");
});

$(document).on('ready', function () {

	$('.js-followers').on('click', function() {
		console.log('Requested User Followers.');
		var user_id = $('.js-followers').data('user-id');
		getFollowers(user_id);
	}); // on click

}); // doc ready

function getFollowers(user_id) {
	console.log('Getting Followers!');

	$.ajax({
		url: `/users/${user_id}/followers`,

		data: {},

		success: function(response) {
			console.log(response[0]);
			showFollowers(response);
		},

		error: function() {
			console.log('Soemthing went wrong while grabbing the followers');
		}

			
	}); // ajax request
} // getFollowers();

function showFollowers(response) {
	var followers = response
	followers.forEach(function (follower) {
		var html = `
		<div class="follower-item row">
		<div class="col-sm-3">
			<img src="${follower.avatar.url}" width="100" height="100">
		</div>
		<div class="col-sm-4">
			<a href="/users/${follower.id}"><span class="follower-name">${follower.first_name}</span>
			<span class="follower-name">${follower.last_name}</span></a>

			<p>${follower.email}</p>	
			</div>
		</div>
		`

		$('.js-followers-modal').html(html);

	});
		console.log(response);
}





