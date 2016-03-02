
$(".nav a").on("click", function(){
   $(".nav").find(".active").removeClass("active");
   $(this).parent().addClass("active");
});

$(document).on('ready', function () {

	$('.song-btns').delegate('.js-unlike-track', 'click', function() {
		console.log('Liking this song.');
		var user_id = $('.js-like-track').data('user-id');
		var track_id = $(this).data('id');
		console.log(user_id);
		console.log(track_id);
		unlikeTrack(user_id, track_id);
	});

	$('.song-btns').delegate('.js-like-track', 'click', function() {
		console.log('Liking this song.');
		var user_id = $('.js-like-track').data('user-id');
		var track_id = $(this).data('id');
		console.log(user_id);
		console.log(track_id);
		likeTrack(user_id, track_id);
	});

	$('.top-btns-2nd').delegate('.profile-link', 'click', function() {
		var user_id = $('.avatar-border').data("user-id");
		getProfile(user_id);
	});


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
		var track_id = $(this).data('id');
		console.log(user_id);
		console.log(track_id);
		unlikeTrack(user_id, track_id);
	});

	$('.js-like-track').on('click', function() {
		console.log('Liking this song.');
		var user_id = $('.js-like-track').data('user-id');
		var track_id = $(this).data('id');
		console.log(user_id);
		console.log(track_id);
		likeTrack(user_id, track_id);
	});

	$('.js-show-likes').on('click', function() {
		console.log('Gettin da likes');
		$('.overeverything').css({                      // scroll to that element or below it
            zIndex: '200'
        });
		var user_id = $('.js-show-likes').data('user-id');
		getLikes(user_id);
	});

	$('.js-tag-tracks').on('click', function() {
		
	});

	$(window).on('scroll', function() {
    var y_scroll_pos = window.pageYOffset;
    var scroll_pos_test = 150;             // set to whatever you want it to be

    if(y_scroll_pos > scroll_pos_test) {


  	var html = `
  			<svg width="70" height="20">
	  <circle cx="10" cy="10" r="0">
	    <animate attributeName="r" from="0" to="10" values="0;10;10;10;0" dur="1000ms" repeatCount="indefinite"/>
	  </circle>
	  <circle cx="35" cy="10" r="0">
	    <animate attributeName="r" from="0" to="10" values="0;10;10;10;0" begin="200ms" dur="1000ms" repeatCount="indefinite"/>
	  </circle>
	  <circle cx="60" cy="10" r="0">
	    <animate attributeName="r" from="0" to="10" values="0;10;10;10;0" begin="400ms" dur="1000ms" repeatCount="indefinite"/>
	  </circle>
			</svg>
  		`

  	$('#loading').html(html);
 } else {
 	$('#loading').empty();
 }
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

	$('.tag-btns').on('click', function() {
		$(this).fadeOut("2000");
		var potato = $(this).text();
		console.log(potato + " added to tags.");
	});



}); // doc ready

function getFollowers(user_id) {
	console.log('Getting Followers!');

	$.ajax({
		url: `/users/${user_id}/followers`,

		data: {},

		success: function(response) {
			$('.js-followers-modal').empty();
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
		<hr>
		`

		$('.js-followers-modal').append(html);


	});
		console.log(response);
}



function getFollowing(user_id) {
	$.ajax({
		url: `/users/${user_id}/following`,

		data: {},

		success: function(response) {
			$('.js-following-modal').empty();
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
		<hr>
		`
		$('.js-following-modal').append(html);

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
	var user_id_link = response[0].user_id
	likes.forEach(function (likes) {
		
		var link = `
			
			
			`
		
		var html = `
		<script>
			$("audio").on("play", function(){
	    		var _this = $(this);
	    		$("audio").each(function(i,el){
	        		if(!$(el).is(_this))
	            		$(el).get(0).pause();
	    			});
				});

			$('.song-btns').delegate('.js-unlike-track', 'click', function() {
				console.log('Liking this song.');
				var user_id = $('.js-like-track').data('user-id');
				var track_id = $(this).data('id');
				console.log(user_id);
				console.log(track_id);
				unlikeTrack(user_id, track_id);
			});

			$("audio").load();

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
									
									<span data-id="${likes.id}">
									<i class="fa fa-heart js-unlike-track" style="color: #880000" data-id="${likes.id}" data-user-id="${likes.user_id}"></i>
									</span>
							

								<i class="fa fa-share song-btn-space"></i>

								<i class="fa fa-tags song-btn-space"></i>

								</div> <!-- song-btns -->
							</div> <!-- col-sm-4 -->
						</div> <!-- row -->

					</div><!-- song content -->
					</div><!-- audio-around -->
					<br><br>

				`
				$('.js-likes-title').html("<h1 style='margin-left: 12px;'>Likes</h1><hr style='width: 64%; margin-left: 15px; border-color: gray;'>");
				$('.gonna-put-it-on-top-append').append(html);
				$('.top-btns-2nd').html(link);

				$('.top-btns-2nd').css({
					marginLeft: '380px'
				});

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
			showUnlike(response);
		},

		error: function() {
			console.log('Something went wrong while unliking this track.');
		}
	});
}

function showUnlike(response) {
	console.log(response);
	var html = `
		<i class="fa fa-heart-o js-like-track" style="text-decoration: none" data-id="${response.id}" data-user-id="${response.user_id}"></i>
		`

	$(`[data-id='${response.id}']`).html(html);
}

function likeTrack(user_id, track_id) {
	$.ajax({
		url: `/tracks/${track_id}/like`,

		type: 'POST',

		success: function(response) {
			console.log(response);
			showLike(response);
		},

		error: function() {
			console.log('Something went wrong while liking this track.');
		}
	});
}

function showLike(response) {
	console.log(response);
	var html = `
		<i class="fa fa-heart js-unlike-track" style="color: #880000; text-decoration: none" data-id="${response.id}" data-user-id="${response.user_id}"></i>
		`

		$(`[data-id='${response.id}']`).html(html);
}





$(document).on('ready', function() {
$("audio").on("play", function(){
    var _this = $(this);
    $("audio").each(function(i,el){
        if(!$(el).is(_this))
            $(el).get(0).pause();
    }); // audio on play
}); // doc ready




// =================== fixed side bar to top ==========================


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

// =================== fixed side bar to top ==========================

function getProfile(user_id) {
	$.ajax({
		url: `/users/${user_id}/`,

		success: function(response) {
			showProfile(response);
		},

		error: function() {
			console.log("Something went wrong while grabbing the profile.");
		}
	});
}


function showProfile(response) {

	var html = `

		<head>
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
  <link href='https://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">

		</head>

		${response}


		`

		$('.main-container').html(html);
}




