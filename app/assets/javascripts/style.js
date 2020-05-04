// $(function(){
//         $("#open").show();
//         $("#close").hide();
//     // アイコンをクリック
// 	$("#open").click(function(){
// 		// ulメニューを開閉する
// 		$("#navi").slideToggle();
//         $("#open").hide();
//         $("#close").show();
// 	});
 
//     // アイコンをクリック
// 	$("#close").click(function(){
// 		// ulメニューを開閉する
// 		$("#navi").slideToggle();
//         $("#open").show();
//         $("#close").hide();
// 	});
// });


$(function () {
    var topBtn = $('#pagetop');
    topBtn.hide();
    //スクロールが300に達したらボタン表示
    $(window).scroll(function () {
        if ($(this).scrollTop() > 300) {
            topBtn.fadeIn();
        } else {
            topBtn.fadeOut();
        }
    });
    //スクロールでトップへもどる
    topBtn.click(function () {
        $('body,html').animate({
            scrollTop: 0
        }, 500);
        return false;
    });
});

$(function () {
    $('.mainimg').slick({
        prevArrow: false,
        nextArrow: false,
        // dots: true,
        fade: true,
        autoplay: true,
        autoplaySpeed: 500,
    });
});

$(function () {
    $('span').hover(
        function(){
        $('span').next().show();
        // $('span').css('background-color', '#999');
        },
        function(){
        $('span').css('background-color', '');
        $('ol').hide();
        $('.tabboo').hide();
        }
    );
});


// $(function () {
//     // 親メニュー処理
//     $('span').hover(function() {
//       // メニュー表示/非表示
//       $(this).next('b').show('fast');
//     });
  
//     // 子メニュー処理
//     $('c').hover(function(e) {
//       // メニュー表示/非表示
//       $(this).children('b').show('fast');
//       e.stopPropagation();
//     });
//   });