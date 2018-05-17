$(window).bind('scroll', function() {
        var navHeight = $(window).height() - 700;
        if ($(window).scrollTop() > navHeight) {
            $('.cartLinkDiv').addClass('display');
        } else {
            $('.cartLinkDiv').removeClass('display');
        }
    });