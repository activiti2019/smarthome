(function(h) {
    var l = [];
    h.preload = function(a, c, d) {
        if ("undefined" !== typeof a) {
            "string" === typeof a && (a = [a]);
            2 === arguments.length && "function" === typeof c && (d = c, c = 0);
            var e = a.length,
            j;
            0 < c && c < e && (j = a.slice(c, e), a = a.slice(0, c), e = a.length);
            if (e) for (var f = arguments.callee,
            g = 0,
            k = function() {
                g++;
                g === e && ("function" === typeof d && d.call(a, !j), f(j, c, d))
            },
            b, n = 0; n < a.length; n++) {
                b = new Image;
                b.src = a[n];
                a: {
                    for (var m = 0; m < l.length; m++) if (l[m].src === b.src) {
                        b = l[m];
                        break a
                    }
                    l.push(b)
                }
                if (b.complete) k();
                else h(b).on("load error", k)
            } else "function" === typeof d && d.call(a, !0)
        }
    };
    h.fn.preload = function(a) {
        var c = this,
        d = c,
        e = [],
        j = /url\(['"]?([^"')]*)['"]?\)/i,
        f,
        g,
        k,
        b,
        d = d.find("*").add(d);
        d.each(function() {
            f = h(this).css("backgroundImage");
            f = f.split(", ");
            for (b = 0; b < f.length; b++) g = f[b],
            -1 !== g.indexOf("about:blank") || -1 !== g.indexOf("data:image") || (k = j.exec(g)) && e.push(k[1]);
            "IMG" === this.nodeName && e.push(this.src)
        });
        h.preload(e,
        function() {
            "function" === typeof a && a.call(c.get())
        });
        return this
    }
})(jQuery);


$(function() {
    var is_in_transition = false;
var qjbg=null;

// 点击空白处取消气泡
$("#body").click(function(){
	if($("#body a").hasClass("active")){
		$("#body  .active").trigger("click");
		stop();
	};
	stop();
})
   function stop() {
            // 判定浏览器引擎是IE还是其他浏览器
            event = event || window.event;
            if (event.stopPropagation) {
                // 非IE浏览器
                event.stopPropagation();
            } else {
                // IE浏览器
                event.cancelBubble = true;
            }
        }
    $('.show-box .more-info,.show-box .more-info.have').click(function() {
    	// 取消事件冒泡
    	stop();
        if (!is_in_transition) {
            var $this = $(this);
            var $vsc = $('.show-box');
            if (qjbg == null) {
                qjbg= $('.show-box .background-image img').first().attr('src');
            }
           $('.more-info.active').not($this).removeClass('active');
          
            if ($this.hasClass('active')) {
                $this.removeClass('active');
				$this.siblings('a').addClass('more-info');

                if (!benefits) {
                    $this.find('.bubble').mkHideThis();
                } else {
                    $('#mobile-content-area').empty();
                }
                if (qjbg!= null) {
                    transition_to_image($vsc,qjbg);
                }
            } else {
            	$this.removeClass('have');
                $this.addClass('active');
                $this.siblings('a').removeClass('more-info');
                if (!benefits) {
                    $('.bubble').not($this.find('.bubble')).mkHideThis();
                    $this.find('.bubble').mkShowThis();
                } else {
                    $('#mobile-content-area').html($(document.createElement('div')).html($this.find('.bubble').html()));
                }
                if (qjbg != null) {
                	if($this.hasClass("dp")){
                    transition_to_image($vsc, qjbg);}else{
                    	transition_to_image($vsc, $this.attr('data-next-image'));
                    }
                }
            }
        }
    }
    );
  
// 客厅背景切换
    $('#kt').change(function() {
    	if($("#kt").val()==3){
    		qjbg="images/ktbgml.png";
    		if($("#button3").html()=="关闭"){
    			qjbg="images/ktbgml-video.png";
    		}
		}
    	if($("#kt").val()==2){
    		qjbg='images/ktbgrg.png';
    		if($("#button3").html()=="关闭"){
    			qjbg="images/ktbgrg-video.png";
    		}
    	}
    	if($("#kt").val()==1){
    		qjbg='images/ktbg.jpg';
    		if($("#button3").html()=="关闭"){
    			qjbg="images/ktbg-video.png";
    		}
    	}
    	if($("#kt").val()==0){
    		qjbg='images/ktbgwg.png';
    		if($("#button3").html()=="关闭"){
    			qjbg="images/ktbgwg-video.png";
    		}
    	}transition_to_image($('.show-box'), qjbg);
	});

    $("#button1").click(function () {
    	var switchstate=$("#button1").html();
   		if("开启"==switchstate){	
   			qjbg='images/ktbg.jpg';
    		if($("#button3").html()=="关闭"){
    			qjbg="images/ktbg-video.png";
    		}
   		}else{
   			qjbg='images/ktbgwg.png';
    		if($("#button3").html()=="关闭"){
    			qjbg="images/ktbgwg-video.png";
    		}
   			}transition_to_image($('.show-box'), qjbg);
    	});
    $("#button3").click(function () {
    	var switchstate=$("#button3").html();
   		if("开启"==switchstate){

   			if($("#kt").val()==3){
   	    			qjbg="images/ktbgml-video.png";
   	    		
   			}
   	    	if($("#kt").val()==2){
   	    			qjbg="images/ktbgrg-video.png";
   	    		
   	    	}
   	    	if($("#kt").val()==1){
   	    			qjbg="images/ktbg-video.png";
   	    		
   	    	}
   	    	if($("#kt").val()==0){
   	    			qjbg="images/ktbgwg-video.png";
   	    		
   	    	}
   		}else{
   			if($("#kt").val()==3){
   	    		qjbg="images/ktbgml.png";
   	    		
   			}
   	    	if($("#kt").val()==2){
   	    		qjbg='images/ktbgrg.png';
   	    	}
   	    	if($("#kt").val()==1){
   	    		qjbg='images/ktbg.jpg';
   	    		
   	    	}
   	    	if($("#kt").val()==0){
   	    		qjbg='images/ktbgwg.png';
   	    		
   	    	}
   			
   			}transition_to_image($('.show-box'),qjbg);
    	});
    
    
    
    
    
    // 厨房背景切换
    $('#cf').change(function() {
    	if($("#cf").val()==3){
    		qjbg="images/cfbgml.png";}
    	if($("#cf").val()==2){
    		qjbg='images/cfbgrg.png';
    	}
    	if($("#cf").val()==1){
    		qjbg='images/cfbg.png';
    	}
    	if($("#cf").val()==0){
    		qjbg='images/cfbgwg.png';
    	}transition_to_image($('.show-box'), qjbg);
	});

    $("#button18").click(function () {
    	var switchstate=$("#button18").html();
   		if("开启"==switchstate){	
   			qjbg='images/cfbg.png';
   			
   		}else{
   			qjbg='images/cfbgwg.png';
   			}transition_to_image($('.show-box'), qjbg);
    	});
    // 餐厅背景切换
    $('#ct').change(function() {
    	if($("#ct").val()==3){
    		qjbg="images/ctbgml.png";}
    	if($("#ct").val()==2){
    		qjbg='images/ctbgrg.png';
    	}
    	if($("#ct").val()==1){
    		qjbg='images/ctbg.png';
    	}
    	if($("#ct").val()==0){
    		qjbg='images/ctbgwg.png';
    	}transition_to_image($('.show-box'), qjbg);
	});

    $("#button19").click(function () {
    	var switchstate=$("#button19").html();
   		if("开启"==switchstate){	
   			qjbg='images/ctbg.png';
   		}else{
   			qjbg='images/ctbgwg.png';
   			}transition_to_image($('.show-box'), qjbg);
    	});
    // 露台背景切换
    $('#lt').change(function() {
    	if($("#lt").val()==3){
    		qjbg="images/ltbgml.png";
		}
    	if($("#lt").val()==2){
    		qjbg='images/ltbgrg.png';
    	}
    	if($("#lt").val()==1){
    		qjbg='images/ltbg.png';
    	}
    	if($("#lt").val()==0){
    		qjbg='images/ltbgwg.png';
    	}transition_to_image($('.show-box'), qjbg);
	});

    $("#button23").click(function () {
    	var switchstate=$("#button23").html();
   		if("开启"==switchstate){	
   			qjbg='images/ltbg.png';
   		}else{
   			qjbg='images/ltbgwg.png';
   			}transition_to_image($('.show-box'), qjbg);
    	});
    
    // 浴室背景切换
    $('#ys').change(function() {
    	if($("#ys").val()==3){
    		qjbg="images/ysbgml.png";
		}
    	if($("#ys").val()==2){
    		qjbg='images/ysbgrg.png';
    	}
    	if($("#ys").val()==1){
    		qjbg='images/ysbg.png';
    	}
    	if($("#ys").val()==0){
    		qjbg='images/ysbgwg.png';
    	}transition_to_image($('.show-box'), qjbg);
	});

    $("#button28").click(function () {
    	var switchstate=$("#button28").html();
   		if("开启"==switchstate){	
   			qjbg='images/ysbg.png';
    	}else{
    		qjbg='images/ysbgwg.png';
   			}transition_to_image($('.show-box'), qjbg);
    	});
    // 卧室背景切换
    $('#ws').change(function() {
    	if($("#ws").val()==3){
    		if($("#button11").html() == "关闭"){
    			if($("#button9").html() == "关闭"){
    				qjbg="images/wsbgml-tv.png";// 明亮 电视开启 窗帘开启
    			}else{
    				qjbg="images/ws-kcq-ml-tv.png";// 明亮 电视开启 窗帘关闭
    			}
    		}else{
    			if($("#button9").html() == "关闭"){
    				qjbg="images/wsbgml.png";// 明亮 电视关闭 窗帘开启
    			}else{
    				qjbg="images/ws-kcq-ml.png";// 明亮 电视关闭 窗帘关闭
    			}
    		}
    		}
    	if($("#ws").val()==2){
    		if($("#button11").html() == "关闭"){
    			if($("#button9").html() == "关闭"){
    				qjbg="images/wsbgrg-tv.png";// 柔光 电视开启 窗帘开启
    			}else{
    				qjbg="images/ws-kcq-rg-tv.png";// 柔光 电视开启 窗帘关闭
    			}
    		}else{
    			if($("#button9").html() == "关闭"){
    				qjbg='images/wsbgrg.png';// 柔光 电视关闭 窗帘开启
    			}else{
    				qjbg="images/ws-kcq-rg.png";// 柔光 电视关闭 窗帘关闭
    			}
    		}
    		
    	}
    	if($("#ws").val()==1){
    		if($("#button11").html() == "关闭"){
    			if($("#button9").html() == "关闭"){
    				qjbg="images/wsbg-tv.png";// 暗淡 电视开启 窗帘开启
    			}else{
    				qjbg="images/ws-kcq-ad-tv.png";// 暗淡 电视开启 窗帘关闭
    			}
    		}else{
    			if($("#button9").html() == "关闭"){
    				qjbg='images/wsbg.png';// 暗淡 电视关闭 窗帘开启 1
    			}else{
    				qjbg="images/ws-kcq-ad.png";// 暗淡 电视关闭 窗帘关闭
    			}
    		}
    		
    	}
    	if($("#ws").val()==0){
    		if($("#button11").html() == "关闭"){
    			if($("#button9").html() == "关闭"){
    				qjbg="images/wsbgwg-tv.png";// 无光 电视开启 窗帘开启 1
    			}else{
    				qjbg="images/ws-kcq-wg-tv.png";// 无光 电视开启 窗帘关闭
    			}
    		}else{
    			if($("#button9").html() == "关闭"){
    				qjbg='images/wsbgwg.png';// 无光 电视关闭 窗帘开启 1
    			}else{
    				qjbg="images/ws-kcq-wg.png";// 无光 电视关闭 窗帘关闭
    			}
    		}
    	}transition_to_image($('.show-box'), qjbg);
	});

    $("#button14").click(function () {
    	var switchstate=$("#button14").html();
   		if("开启"==switchstate){	
   			if($("#button11").html() == "关闭"){
    			if($("#button9").html() == "关闭"){
    				qjbg="images/wsbg-tv.png";// 暗淡 电视开启 窗帘开启
    			}else{
    				qjbg="images/ws-kcq-ad-tv.png";// 暗淡 电视开启 窗帘关闭
    			}
    		}else{
    			if($("#button9").html() == "关闭"){
    				qjbg='images/wsbg.png';// 暗淡 电视关闭 窗帘开启 1
    			}else{
    				qjbg="images/ws-kcq-ad.png";// 暗淡 电视关闭 窗帘关闭
    			}
    		}
   		}else{
   	  		if($("#button11").html() == "关闭"){
    			if($("#button9").html() == "关闭"){
    				qjbg="images/wsbgwg-tv.png";// 无光 电视开启 窗帘开启 1
    			}else{
    				qjbg="images/ws-kcq-wg-tv.png";// 无光 电视开启 窗帘关闭
    			}
    		}else{
    			if($("#button9").html() == "关闭"){
    				qjbg='images/wsbgwg.png';// 无光 电视关闭 窗帘开启 1
    			}else{
    				qjbg="images/ws-kcq-wg.png";// 无光 电视关闭 窗帘关闭
    			}
    		}
   			}
   		
   		

   		
   		
   		
   		transition_to_image($('.show-box'), qjbg);
    	});
    
    
    
    // 点击电视开关背景的切换
    $("#button11").click(function () {
    	if($("#ws").val()==3){
		if($("#button11").html() == "开启"){
			if($("#button9").html() == "关闭"){
				qjbg="images/wsbgml-tv.png";// 明亮 电视开启 窗帘开启
			}else{
				qjbg="images/ws-kcq-ml-tv.png";// 明亮 电视开启 窗帘关闭
			}
		}else{
			if($("#button9").html() == "关闭"){
				qjbg="images/wsbgml.png";// 明亮 电视关闭 窗帘开启
			}else{
				qjbg="images/ws-kcq-ml.png";// 明亮 电视关闭 窗帘关闭
			}
		}
		}
	if($("#ws").val()==2){
		if($("#button11").html() == "开启"){
			if($("#button9").html() == "关闭"){
				qjbg="images/wsbgrg-tv.png";// 柔光 电视开启 窗帘开启
			}else{
				qjbg="images/ws-kcq-rg-tv.png";// 柔光 电视开启 窗帘关闭
			}
		}else{
			if($("#button9").html() == "关闭"){
				qjbg='images/wsbgrg.png';// 柔光 电视关闭 窗帘开启
			}else{
				qjbg="images/ws-kcq-rg.png";// 柔光 电视关闭 窗帘关闭
			}
		}
		
	}
	if($("#ws").val()==1){
		if($("#button11").html() == "开启"){
			if($("#button9").html() == "关闭"){
				qjbg="images/wsbg-tv.png";// 暗淡 电视开启 窗帘开启
			}else{
				qjbg="images/ws-kcq-ad-tv.png";// 暗淡 电视开启 窗帘关闭
			}
		}else{
			if($("#button9").html() == "关闭"){
				qjbg='images/wsbg.png';// 暗淡 电视关闭 窗帘开启 1
			}else{
				qjbg="images/ws-kcq-ad.png";// 暗淡 电视关闭 窗帘关闭
			}
		}
		
	}
	if($("#ws").val()==0){
		if($("#button11").html() == "开启"){
			if($("#button9").html() == "关闭"){
				qjbg="images/wsbgwg-tv.png";// 无光 电视开启 窗帘开启 1
			}else{
				qjbg="images/ws-kcq-wg-tv.png";// 无光 电视开启 窗帘关闭
			}
		}else{
			if($("#button9").html() == "关闭"){
				qjbg='images/wsbgwg.png';// 无光 电视关闭 窗帘开启 1
			}else{
				qjbg="images/ws-kcq-wg.png";// 无光 电视关闭 窗帘关闭
			}
		}
	}transition_to_image($('.show-box'),qjbg);
    	});
    
    // 点击窗帘开关的背景切换
    $("#button9").click(function () {
    if($("#ws").val()==3){
		if($("#button11").html() == "关闭"){
			if($("#button9").html() == "开启"){
				qjbg="images/wsbgml-tv.png";// 明亮 电视开启 窗帘开启
			}else{
				qjbg="images/ws-kcq-ml-tv.png";// 明亮 电视开启 窗帘关闭
			}
		}else{
			if($("#button9").html() == "开启"){
				qjbg="images/wsbgml.png";// 明亮 电视关闭 窗帘开启
			}else{
				qjbg="images/ws-kcq-ml.png";// 明亮 电视关闭 窗帘关闭
			}
		}
		}
	if($("#ws").val()==2){
		if($("#button11").html() == "关闭"){
			if($("#button9").html() == "开启"){
				qjbg="images/wsbgrg-tv.png";// 柔光 电视开启 窗帘开启
			}else{
				qjbg="images/ws-kcq-rg-tv.png";// 柔光 电视开启 窗帘关闭
			}
		}else{
			if($("#button9").html() == "开启"){
				qjbg='images/wsbgrg.png';// 柔光 电视关闭 窗帘开启
			}else{
				qjbg="images/ws-kcq-rg.png";// 柔光 电视关闭 窗帘关闭
			}
		}
		
	}
	if($("#ws").val()==1){
		if($("#button11").html() == "关闭"){
			if($("#button9").html() == "开启"){
				qjbg="images/wsbg-tv.png";// 暗淡 电视开启 窗帘开启
			}else{
				qjbg="images/ws-kcq-ad-tv.png";// 暗淡 电视开启 窗帘关闭
			}
		}else{
			if($("#button9").html() == "开启"){
				qjbg='images/wsbg.png';// 暗淡 电视关闭 窗帘开启 1
			}else{
				qjbg="images/ws-kcq-ad.png";// 暗淡 电视关闭 窗帘关闭
			}
		}
		
	}
	if($("#ws").val()==0){
		if($("#button11").html() == "关闭"){
			if($("#button9").html() == "开启"){
				qjbg="images/wsbgwg-tv.png";// 无光 电视开启 窗帘开启 1
			}else{
				qjbg="images/ws-kcq-wg-tv.png";// 无光 电视开启 窗帘关闭
			}
		}else{
			if($("#button9").html() == "开启"){
				qjbg='images/wsbgwg.png';// 无光 电视关闭 窗帘开启 1
			}else{
				qjbg="images/ws-kcq-wg.png";// 无光 电视关闭 窗帘关闭
			}
		}
	}transition_to_image($('.show-box'),qjbg);
    	});
    
    
    
    
    
    
    
    // 设置关闭时不能选择亮度
    $(".zdybutton").click(function(){
    	var onoffstate = $(".zdybutton").html();
    	if("关闭"==onoffstate){
    		$("select").attr("disabled", "disabled");
    	}else{
    		$("select").removeAttr("disabled"); 		
    	}		
    });
    

    
    
    
    
    
    
    
    
    
    function transition_to_image(show_in_con, image_src) {
        is_in_transition = true;
        var $new_image = $('<img>').attr({
            'src': image_src,
        }).css({
            'width': '100%',
            'position': 'absolute',
            'top': 0,
            'left': 0,
            'z-index': 0,
        });
        show_in_con.find('.background-image').append($new_image);
        var $orig_image = $('.show-box .background-image img').first();
        $orig_image.stop().fadeOut(500,
        function() {
            $new_image.attr('style', 'width: 100%;');
            is_in_transition = false;
            $orig_image.remove();
        });
    }
});

$.fn.mkShowThis = function(callback) {
    var clean_callback = function() {};
    if (typeof callback == 'function') {
        clean_callback = callback;
    }
    $(this).css('opacity', 0).slideDown(200, clean_callback).animate({
        'opacity': 1
    },
    200, 'linear');
    return $(this);
};
$.fn.mkHideThis = function(callback) {
    var clean_callback = function() {};
    if (typeof callback == 'function') {
        clean_callback = callback;
    }
    $(this).css('opacity', 1).fadeOut(200, clean_callback).animate({
        'opacity': 0
    },
    200, 'linear');
    return $(this);
};


