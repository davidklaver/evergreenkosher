$(document).ready(function(){
    $("button.navbar-toggle").click(function(){
    	$(".navbar").toggleClass("greenBackground", 200);
		});
});

$(window).bind('scroll', function() {
        var navHeight = $(window).height() - 700;
        if ($(window).scrollTop() > navHeight) {
            $('#menu').addClass('on');
            $('#menu').addClass('shorter');
            $('.page-scroll').addClass('whiteText');
            $('.navLogo').addClass('visible');
        } else {
            $('#menu').removeClass('on');
            $('#menu').removeClass('shorter');
            $('.page-scroll').removeClass('whiteText');
            $('.navLogo').removeClass('visible');
        }
    });