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
//= require_tree .

$(".nav a").on("click", function(){
   $(".nav").find(".active").removeClass("active");
   $(this).parent().addClass("active");
});

$('.audio-widget').on('click', function(e) {           
  audioElement.play(); // load the html response into a DOM element
  e.preventDefault(); // stop the browser from following the link
  console.log('Trying to play');
});

$(document).on('ready', function () {




	$('.js-followers').on('click', function() {
		console.log('Requested User Followers.');
		var user_id = $('.js-followers').data('user-id');
		getFollowers(user_id);
	}); // on click

	$('.js-following').on('click', function() {
		console.log('Requested Users Following.');
		var user_id = $('.js-following').data('user-id');
		getFollowing(user_id);
	});

	$('.js-unlike-track').on('click', function() {
		console.log('Unliking this song.');
		var user_id = $('.js-unlike-track').data('user-id');
		var track_id = $('.js-unlike-track').data('fid');
		console.log(user_id);
		console.log(track_id);
		unlikeTrack(user_id, track_id);
	});

	$('.js-show-likes').on('click', function() {
		console.log('Gettin da likes');
		$('.overeverything').css({                      // scroll to that element or below it
            display: 'none'
        });
		var user_id = $('.js-show-likes').data('id');
		getLikes(user_id);
	});



var fixmeTop = $('.overeverything').offset().top;       // get initial position of the element

$(window).scroll(function() {                  // assign scroll event listener
	
    var currentScroll = $(window).scrollTop(); // get current position

    if (currentScroll >= fixmeTop - 50) {           // apply position: fixed if you
        $('.overeverything').css({                      // scroll to that element or below it
            position: 'fixed',
            top: '6%',
            width: '25.3%'
        });
    } else {                                   // apply position: static
        $('.overeverything').css({                      // if you scroll above it
            position: 'static',
            width: '100%'
        });
    }

});

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



function getFollowing(user_id) {
	$.ajax({
		url: `/users/${user_id}/following`,

		data: {},

		success: function(response) {
			console.log(response);
			showFollowing(response);
		},

		error: function() {
			console.log('Something went wrong while grabbing the followers');
		}
	}); // ajax
} // getFollowing

function showFollowing(response) {
	var following = response
	following.forEach(function (following) {
		var html = `
			<div class="follower-item row">
		<div class="col-sm-3">
			<img src="${following.avatar.url}" width="100" height="100">
		</div>
		<div class="col-sm-4">
			<a href="/users/${following.id}"><span class="follower-name">${following.first_name}</span>
			<span class="follower-name">${following.last_name}</span></a>

			<p>${following.email}</p>	
			</div>
		</div>
		`

		$('.js-following-modal').html(html);
	}); // forEach
	console.log(response);
} // getFollowing

function getLikes(user_id) {
	$.ajax({
		url: `/users/${user_id}/likes`,

		success: function(response) {
			console.log(response);
			showLikes(response);
		},

		error: function() {

		}
	}); // ajax
} // getLikes

function showLikes(response) {
	console.log(response);
	var likes = response
	likes.forEach(function (likes) {

		var html = `<script>
			$("audio").on("play", function(){
	    		var _this = $(this);
	    		$("audio").each(function(i,el){
	        		if(!$(el).is(_this))
	            		$(el).get(0).pause();
	    			});
				});

			$("audio").load();
		</script>
			<div class="audio-around box-shadow--2dp">
					<audio controls class="audio-widget">
					  <source src="${likes.track.url}" type="audio/mpeg">
					Your browser does not support the audio element.
					</audio>

					<div class="song-content">
						<div class="row">
							<div class="col-sm-10">
					<h4 style="color: #F7F7F7; font-family: helvetica;">${likes.title}</h4>
					<h6 style="color: #F7F7F7; font-family: helvetica;"><em>${likes.description}</em></h6>
							</div> <!-- col-sm-8 -->

							<div class="col-sm-2">
								<div class="song-btns">
									
									<a class="fa fa-heart js-unlike-track" href="#" style="color: #880000"></a>
									
							

								<i class="fa fa-share song-btn-space"></i>

								<i class="fa fa-tags song-btn-space"></i>

								</div> <!-- song-btns -->
							</div> <!-- col-sm-4 -->
						</div> <!-- row -->

					</div><!-- song content -->
					</div><!-- audio-around -->
					<br><br>

				`

				$('.gonna-put-it-on-top-append').append(html);
				$('.gonna-put-it-on-top').css({
					display: 'none'
				});

				
	}); // for each
} // show likes


function unlikeTrack(user_id, track_id) {
	$.ajax({
		url: `/tracks/${track_id}/unlike`,

		type: 'POST',

		success: function(response) {
			console.log(response);
		},

		error: function() {
			console.log('Something went wrong while unliking this track.');
		}
	});
}




$("audio").on("play", function(){
    var _this = $(this);
    $("audio").each(function(i,el){
        if(!$(el).is(_this))
            $(el).get(0).pause();
    });
});


$(document).on('ready', function() {
$("audio").on("play", function(){
    var _this = $(this);
    $("audio").each(function(i,el){
        if(!$(el).is(_this))
            $(el).get(0).pause();
    });
});

var fixmeTop = $('.overeverything').offset().top;       // get initial position of the element

$(window).scroll(function() {                  // assign scroll event listener
	
    var currentScroll = $(window).scrollTop(); // get current position

    if (currentScroll >= fixmeTop - 50) {           // apply position: fixed if you
        $('.overeverything').css({                      // scroll to that element or below it
            position: 'fixed',
            top: '6%',
            width: '25.3%'
        });
    } else {                                   // apply position: static
        $('.overeverything').css({                      // if you scroll above it
            position: 'static',
            width: '100%'
        });
    }

});

});












