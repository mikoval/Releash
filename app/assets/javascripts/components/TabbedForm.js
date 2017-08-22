function TabbedForm(div){
	this.obj = div;
	this.titles = [];
	this.index = 0;
	this.submit = div.find(".submit-btn").addClass("mobile-form-submit");
	//closure
	var context = this;

	var divs = div.find(".form-page");
	for(var i = 0; i < divs.length; i++){
		var title = $(divs[i]).attr("title");
		var tab = $(divs[i]);
		if(i > 0){
			tab.hide();
		}
		this.titles.push(title);
	}
	var tabStr = ""
	for(var i = 0; i < this.titles.length; i++){
		tabStr += '<span id = "'+this.titles[i]+'-title" class="mobile-tab-title">'+this.titles[i]+'</span>'
	}
	var tabs = '<div class="mobile-tabs">\
      <div class="mobile-tabs-wrapper">\
        <span id = "tab-left" class = "glyphicon glyphicon-chevron-left"> </span>\
        <div id = "mobile-tab-content" id = >'
        +tabStr + 
          
        '</div>\
        <span id = "tab-right" class = "glyphicon glyphicon-chevron-right"> </span>\
      </div>\
    </div>'
    this.obj.html(tabs + this.obj.html());

    var height  =$( window ).height() - ($($(".form-page")[0]).offset().top - $(window).scrollTop())  - 40;
    var divs = div.find(".form-page");

	for(var i = 0; i < divs.length; i++){
		$(divs[i]).css("height", height);
	}
	$("#tab-left").on("click", function(){
  		context.tabLeft();
	})
	$("#tab-right").on("click", function(){
	  	context.tabRight();
	})
	var el = div[0]
	swipedetect(el, function(dir){
		if(dir == "left"){
			this.tabLeft();
		}
		if(dir == "right"){
			this.tabRight();
		}
	});


	this.tabRight = function(){
	  var next = this.getRight();
	  this.index = next;
	  this.showTab(this.index);
	} 
	this.tabLeft = function(){
	  var next = this.getLeft();
	  this.index = next;
	  this.showTab(this.index);
	} 
	this.getLeft = function(){
	  var tmp = this.index - 1;
	  if(tmp < 0){
	    tmp = this.titles.length-1;
	  }
	  
	  return tmp;
	}
	this.getRight = function(){
	  var tmp = this.index + 1;
	  if(tmp >= this.titles.length){
	    tmp = 0;
	  }
	  
	  return tmp;
	}
	this.showTab = function(){
		$(".mobile-tab-title").hide();
		$("#"+this.titles[this.index] + "-title").show();
		for(var i = 0 ; i < divs.length; i++){
			$(divs[i]).hide();
		}
		$(divs[this.index]).show();
	}
	this.showTab();

}

// credit: http://www.javascriptkit.com/javatutors/touchevents2.shtml
function swipedetect(el, callback){
  
    var touchsurface = el,
    swipedir,
    startX,
    startY,
    distX,
    distY,
    threshold = 100, //required min distance traveled to be considered swipe
    restraint = 100, // maximum distance allowed at the same time in perpendicular direction
    allowedTime = 500, // maximum time allowed to travel that distance
    elapsedTime,
    startTime,
    handleswipe = callback || function(swipedir){}
  
    touchsurface.addEventListener('touchstart', function(e){
        var touchobj = e.changedTouches[0]
        swipedir = 'none'
        dist = 0
        startX = touchobj.pageX
        startY = touchobj.pageY
        startTime = new Date().getTime() // record time when finger first makes contact with surface
        
    }, false)
  
    touchsurface.addEventListener('touchmove', function(e){
    }, false)
  
    touchsurface.addEventListener('touchend', function(e){
        var touchobj = e.changedTouches[0]
        distX = touchobj.pageX - startX // get horizontal dist traveled by finger while in contact with surface
        distY = touchobj.pageY - startY // get vertical dist traveled by finger while in contact with surface
        elapsedTime = new Date().getTime() - startTime // get time elapsed
        if (elapsedTime <= allowedTime){ // first condition for awipe met
            if (Math.abs(distX) >= threshold && Math.abs(distY) <= restraint){ // 2nd condition for horizontal swipe met
                swipedir = (distX < 0)? 'left' : 'right' // if dist traveled is negative, it indicates left swipe
            }
            else if (Math.abs(distY) >= threshold && Math.abs(distX) <= restraint){ // 2nd condition for vertical swipe met
                swipedir = (distY < 0)? 'up' : 'down' // if dist traveled is negative, it indicates up swipe
            }
        }
        handleswipe(swipedir)
 
    }, false)
}
  



