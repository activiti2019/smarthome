/* 
Theme Name:yuncms theme
Theme URI:http://www.haothemes.com/name
Author:author
Author URI:http://www.haothemes.com
Description:yuncms
Version:1.0.0
License:MIT
Tags:wordpress,themes,haothemes,Bootstrap,full-width,one-column,font-awesome
*/
(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
'use strict';
require('./global');

//头部导航搜索按钮事件
$('.search-botton').on('click', function () {
    $('.search-box').css('display', 'block');
    $(document).keypress(function (e) {

        // 回车键事件
        if (e.keyCode == 13) {
            $('#search-keyword').submit();
        }
    });

});
//头部搜索框退出按钮事件
$('.search-box span').click(function () {
    $('.search-box').css('display', 'none');
});
$('.search-box-li i').click(function () {
    $('.hd-nav').css('display', 'none');
    $('.motai').css('display', 'none');
    $('.carousel-indicators').css('z-index', '15');
});
//头部响应式手机导航按钮
$('.nav-bottom').click(function () {
    $('.hd-nav').css('display', 'block');
    $('.motai').css('display', 'block');
    $('.search-box-li').css('display', 'block');
    $('.carousel-indicators').css('z-index', '0');
    $('.motai').css('top', $('.hd-nav').css('height'));
    $('.motai').css('height', document.body.scrollHeight - parseInt($('.hd-nav').css('height')) + 'px');
});
//头部响应式手机搜索按钮事件
$('.search-submit').click(function () {
    $('#search-keyword').submit();
});
//main-head的高度自适应
$(function () {
    var aa =$(document).width();
    var b = aa * 0.06 + 'px';
    var c = aa * 0.06 - 10 + 'px';
    $('.main-head').css('padding-top', b);
    $('.main-we-provide').css('padding-top', c);
    $('.main-body p').css('height', $('.main-body-img li').css('height'));

});
//商品鼠标mousemove详情事件
$('.main-submenu-info a').hover(
    function (e) {
        e.stopPropagation();
        var a = $(this).find('img').css('width');
        var b = $(this).find('img').css('height');
        $('.img-bg').css('width', a);
        $('.img-bg').css('height', b);

        $(this).find('.food-name').slideDown('slow');
        $(this).find('.food-price').slideDown('slow');
        $(this).find('.img-bg').slideDown('slow');
        return false;


    },
    function (e) {
        e.stopPropagation();
        $(this).find('.food-name').slideUp('slow');
        $(this).find('.food-price').slideUp('slow');
        $(this).find('.img-bg').slideUp('slow');
        return false;
    }
);
$(function () {
    var aa = $('.activity-duration').next('img').css('width');
    var bb = $('.activity-duration').next('img').css('height');
    var aaa = parseInt(aa);
    var bbb = parseInt(bb);
    $('.activity-duration').css('width', aaa * 0.36);
    $('.activity-duration').css('height', bbb * 0.45);

});
//预定功能提交按钮
$('.reserve').click(function () {

    $('#food-reserve').submit();
    return false;
});
//轮播时间控制
$('.carousel').carousel({
    interval: 2000
})
//关于我们图片高度一致
$(function(){
    var a=$('.main-about-body').find('img').css('width');
    var b=parseInt(a)*0.6988;
    $('.main-about-body > div').css('height',b+'px');

});
//关于我们团队成员高度控制
$(function(){
  var teamHeight=$('.main-team li').css('height') ;
  $('.main-team').css('height',teamHeight);
});
//关于我们团队成员翻页按钮
$(function(){
    var l=$('.main-team li').length;
    var indexa=$('.main-team li').index($('.main-team-display'));
    var indexb=l-1;
    $('.prevbtn').click(function(){
        if(indexa===0){
            return false;
        }else if(indexa > 0){
            indexa -= 1;
            $('.main-team li').removeClass('main-team-display');
            $('.main-team li').eq(indexa).addClass('main-team-display');

        }

    });
    $('.nextbtn').click(function(){
        if(indexa===indexb){
            return false;
        }else if(indexa<l){
            indexa += 1;
            $('.main-team li').removeClass('main-team-display');
            $('.main-team li').eq(indexa).addClass('main-team-display');
        }

    });
});
//顶部导航栏跟随页面显示hover效果
$(function(){
    var pathname=window.location.pathname;
    if(pathname.length>=3){
        $('.hd-nav li').removeClass('on');
        $('.hd-nav a').each(function(){
            if($(this).attr('href').indexOf(pathname) !== -1){

                $(this).parent().addClass('on');
            }
        });
    }

});
},{"./global":2}],2:[function(require,module,exports){
(function (global){
'use strict';
var $ = (typeof window !== "undefined" ? window['jQuery'] : typeof global !== "undefined" ? global['jQuery'] : null);
$(function () {

});
}).call(this,typeof self !== "undefined" ? self : typeof window !== "undefined" ? window : {})
},{}]},{},[1])