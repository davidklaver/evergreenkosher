$(document).ready(function(){
    $("button.navbar-toggle").click(function(){
    	$(".navbar").toggleClass("greenBackground", 200);
		});
});

$(window).bind('scroll', function() {
        var navHeight = $(window).height() - 700;
        if ($(window).scrollTop() > navHeight) {
            $('#menu').addClass('on');
            $('.page-scroll').addClass('whiteText');
        } else {
            $('#menu').removeClass('on');
            $('.page-scroll').removeClass('whiteText');
        }
    });