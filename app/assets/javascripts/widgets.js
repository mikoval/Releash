var gridly_timeout;
var mobile = false;
function activateWidgets(){
  widgetAlertList();
  widgetUserList();
  widgetAnimalList();
  widgetStatusList();
  widgetCoorList();
}

function generateAnimals(arr){
  str = ""
  for (i in arr){
    var id = arr[i].id;
    var name = arr[i].name;
    str = str + "<span><a target='_blank' href='/animals/profile?method=get&param=" + id + "'>" + name + "</a></span>";
    if(i != arr.length -1){
      str = str + ", ";
    }
    else{
      str = str + " ";
    }
  }
  return str;
}
function generateUsers(arr){
  str = ""
  for (i in arr){
    var id = arr[i].id;
    var name = arr[i].name;
    str = str + "<span><a target='_blank' href='/people/profile?method=get&param=" + id + "'>" + name + "</a></span>";
    if(i != arr.length -1){
      str = str + ", ";
    }
    else{
      str = str + " ";
    }
  }
  return str;
}
function initWidget(str){
  if(mobile){
    return "<div class='panel-heading'> <h3 class= 'panel-title -leftpull'> "+str + "</h3></div>"
  }
  else{
    return "<div class='panel-heading'> <h3 class= 'panel-title -leftpull'>"+str+"</h3><div class='right'><button type='button' class='remove-item-btn' onclick='return false;'><i class='lnr lnr-cross'></i></button></div></div>"
  }
}
function widgetAlertList(){
    $.ajax({url: "/alerts/query", success: function(result){
        
        var str = initWidget("Alerts");
        str += "<div class='panel-body no-padding'> <div class='table-responsive'> <table class='table table-hover table-striped'> <thead> <tr> <th>Title</th> <th>Date</th> </tr> </thead>" 
        for (x in result){
    
          str += "<tr> \
          <td> <a href = '#' class = 'alert-event' id = 'alert-" + result[x].id + "'> " + result[x].title + "</a></td>\
          <td>" + result[x].date + "</td>\
          </tr>"
        }
        str +=  " </table> </div> <div class='Float panel-footer'> <div class='row '><a href= alerts class='btn btn-warning'>View all Alerts</a> </div></div>"
         $(".alert-list").each(function(){
            $(this).html( str)
         })

    }});
}
function widgetAnimalList(){
    $.ajax({url: "animals/querySimple", success: function(result){
        var str = initWidget("New Animals");
        str += "<div class='panel-body no-padding'> <div class='table-responsive'> <table class='table table-hover table-striped'> <thead> <tr> <th>Name</th> <th>Primary Breed</th> <th>Age</th> </tr> </thead>" 
        for (x in result){
    
                str += "<tr> \
                <td> <a href='/animals/profile?method=get&param=" + result[x].id + " '  >" + result[x].name + "</a></td>\
                 <td>" + result[x].primary + "</td>\
                <td>" + result[x].age + "</td>\
                </tr>"
        }
        str +=  " </table> </div> <div class='Float panel-footer'> <div class='row Float'><a href= animals class='btn btn-primary'>View all Animals</a> </div></div>"
         $(".animal-list").each(function(){
            $(this).html( str)
         })
         bindRemove();
    }});
}
function widgetCoorList(){
    $.ajax({url: "animals/querySimpleCoor", success: function(result){
        var str = initWidget("My Assigned Animals");
        str += "<div class='panel-body no-padding'> <div class='table-responsive'> <table class='table table-hover table-striped'> <thead> <tr> <th>Name</th> <th>Primary Breed</th> <th>Age</th> </tr> </thead>" 
        for (x in result){
    
                str += "<tr> \
                <td> <a href='/animals/profile?method=get&param=" + result[x].id + " '  >" + result[x].name + "</a></td>\
                 <td>" + result[x].primary + "</td>\
                <td>" + result[x].age + "</td>\
                </tr>"
        }
        str +=  " </table> </div> <div class='Float panel-footer'> <div class='row Float'><a href= animals class='btn btn-primary'>View all Animals</a> </div></div>"
         $(".coor-list").each(function(){
            $(this).html( str)
         })
         bindRemove();
    }});
}
function widgetStatusList(){
    $.ajax({url: "animals/querySimpleStatus", success: function(result){
        var str = initWidget("Tracking");
        str += "<div class='no-padding panel-body'><div class='table-responsive'>" 
        for (x in result){
    
                str += "<div class='col-md-4'><div class='metric'><span class='icon'><i class='glyphicon glyphicon-tasks'></i><a href='/animals?n=+&?b=&?g=&?s=" + result[x].id + "&?a=0&?A=15&?qn=1 '></span><p><span class='number'>" + result[x].count + "</span> <span class='title'>" + result[x].name + "</p></div></div>"
    
        }
        str +=  "</div><div class='Float panel-footer'> <div class='row '><a href= animals class='btn btn-primary'>View all Animals</a> </div></div>"
         $(".status-list").each(function(){
            $(this).html( str)
         })
         bindRemove();
    }});
}
function widgetUserList(){
    $.ajax({url: "people/query", success: function(result){
        var str = initWidget("People");
        str += "<div class='panel-body no-padding'> <div class='table-responsive'> <table class='table table-hover table-striped'> <thead> <tr> <th>Name</th> <th>Email</th> </tr> </thead>" 
        for (x in result){
    
                str += "<tr> \
                <td> <a href='/people/profile?method=get&param=" + result[x].id + "' > " + result[x].name + "</a></td>\
                 <td>" + result[x].email + "</td>\
                </tr>"
        }
        str +=  " </table> </div> <div class='Float panel-footer'> <div class='row Float'><a href= people class='btn btn-primary'>View all Users</a> </div></div>"
         $(".user-list").each(function(){
            $(this).html( str)
         })
         bindRemove();
    }});
}
function bindRemove(){
  $(".panel-heading").unbind('touchstart');
  $(".panel-heading").bind("touchstart", function(e){
    if(!$(this).closest(".brick").hasClass("collapsed")){
        $(this).closest(".brick").find(".panel-body").hide();
        $(this).closest(".brick").find(".panel-footer").hide();
        $(this).closest(".brick").addClass("collapsed");
        setTimeout(function(){$('.gridly').gridly();}, 500);
    }
    else{
        
        $(this).closest(".brick").removeClass("collapsed");
        setTimeout(function(param){
          $('.gridly').gridly();
          $(param).closest(".brick").find(".panel-body").show();
        }, 500, this);
    }
   
  });
  $(".remove-item-btn").unbind('click');
  $('.remove-item-btn').on('click', function(event) {
    $(this).closest('.brick').remove()
    saveLayout();
  })
}


function addAnimalWidget() {
  $('#widgetsList').modal('hide')   
    var el = $.parseHTML('<div class = "brick large animal-list" widget-type="animal-list" ></div>');

    $(".gridly").append(el);
    widgetAnimalList()
    gridlyInit();
}
function addCoorWidget() {
  $('#widgetsList').modal('hide')   
    var el = $.parseHTML('<div class = "brick large coor-list " widget-type="coor-list" ></div>');

    $(".gridly").append(el);
    widgetCoorList()
    gridlyInit();
}
function addStatusWidget() {
  $('#widgetsList').modal('hide')   
    var el = $.parseHTML('<div class = "brick large status-list " widget-type="status-list"></div>');
    $(".gridly").append(el);
    widgetStatusList()
    gridlyInit();
}
function addAlertsWidget() {
  $('#widgetsList').modal('hide')   
    
    var el = $.parseHTML('<div class = "brick large alert-list " widget-type="alert-list"></div>');
    $(".gridly").append(el);

    widgetAlertList()
    gridlyInit();
}
function addUserWidget() {
  $('#widgetsList').modal('hide')   
    var el = $.parseHTML('<div class = "brick large user-list" widget-type="user-list"></div>');

    $(".gridly").append(el);

    widgetUserList()
    gridlyInit();
}

function loadWidgets(){

  $.ajax({
        url: "dashboard",
        type: "GET",
       success: function(result){
        str = result.str;
        obj = JSON.parse(str);
        sortWidgets(obj)
        
        for (i = 0; i < obj.length; i++){
          var el = $.parseHTML('<div class = "brick large ' + obj[i].type+' " widget-type="'+obj[i].type+'"style="left:'+obj[i].x+'; top:'+obj[i].y+'">' + obj[i].type + '</div>');
          console.log('<div class = "brick large ' + obj[i].type+' " widget-type="'+obj[i].type+'" style="left:'+obj[i].x+'; top:'+obj[i].y+'">' + obj[i].type + '</div>')
          $(".gridly").append(el);
        }
        gridlyInit();
        mobile=false;
        activateWidgets();
       },
       error: function(){
        console.log("failed")
       }
     })
}

function loadWidgetsMobile(){

  $.ajax({
        url: "dashboard",
        type: "GET",
       success: function(result){
        str = result.str;
        obj = JSON.parse(str);
        
        for (i = 0; i < obj.length; i++){
      
          var el = $.parseHTML('<div class = "brick mobile ' + obj[i].type+' " >' + obj[i].type + '</div>');
          $(".gridly").append(el);
        }
       
         $('.gridly').gridly(
           {base: $(window).width(), // px 
            gutter: 0, // px
            columns:1,
            draggable: false}
          );
         mobile=true;
         activateWidgets();
       },
       error: function(){
        console.log("failed")
       }
     })
}



function saveLayout() {

  var arr = []
    if($('.gridly').length == 0){return;}
    $(".brick").each(function() {
        var type = $(this).attr("widget-type");
        var x =  $(this).css("left");
        var y =  $(this).css("top");
    
        arr.push({"type": type, x:x, y:y});
    })
    var str = JSON.stringify(arr);
    console.log(str);
    $.ajax({
        url: "dashboard",
        type: "PATCH",
        data: {"str": str},
       success: function(result){
       },
       error: function(){
        console.log("failed")
       }
     })
}
function refreshGridly() {


    gridlyInit();
    
}
function gridlyInit(){
  console.log("here")
  setTimeout(saveLayout, 2000);
  $('.gridly').gridly(
        {base: 320, // px 
          gutter: 20, // px
          columns: (parseInt( $(".content-body").width()/320)), 
          callbacks: {
              reordered: function(){setTimeout(saveLayout, 1000)}
          }
        }
  );
  var w = (parseInt( $(".content-body").width()/320)) * (320 + 20)
  $(".gridly").css("width", w);

}
$(window).resize(function(){
    clearTimeout(gridly_timeout);
    gridly_timeout = setTimeout(refreshGridly, 50);
});
function sortWidgets(arr){
  var minIdx, temp, len = arr.length;

  for(var i = 0; i < len; i++){
    minIdx = i;
    for(var  j = i+1; j<len; j++){
       if(arr[j].y<arr[minIdx].y || (arr[j].y == arr[minIdx].y && arr[j].x < arr[minIdx].x ) ){
          minIdx = j;
       }
    }
    temp = arr[i];
    arr[i] = arr[minIdx];
    arr[minIdx] = temp;
  }
  return arr;

}

