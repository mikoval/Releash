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
  console.log(mobile);
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
        str +=  " </table> </div> <div class='text-right panel-footer'> <div class='row text-right'><a href= alerts class='btn btn-warning'>View all Alerts</a> </div></div>"
         $(".alert-list").each(function(){
            $(this).html( str)
         })

    }});
}
function widgetAnimalList(){
    $.ajax({url: "animals/querySimple", success: function(result){
        var str = initWidget("Animals");
        str += "<div class='panel-body no-padding'> <div class='table-responsive'> <table class='table table-hover table-striped'> <thead> <tr> <th>Name</th> <th>Primary Breed</th> <th>Age</th> </tr> </thead>" 
        for (x in result){
    
                str += "<tr> \
                <td> <a href='/animals/profile?method=get&param=" + result[x].id + " '  >" + result[x].name + "</a></td>\
                 <td>" + result[x].primary + "</td>\
                <td>" + result[x].age + "</td>\
                </tr>"
        }
        str +=  " </table> </div> <div class='text-right panel-footer'> <div class='row text-right'><a href= animals class='btn btn-primary'>View all Animals</a> </div></div>"
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
        str +=  " </table> </div> <div class='text-right panel-footer'> <div class='row text-right'><a href= animals class='btn btn-primary'>View all Animals</a> </div></div>"
         $(".coor-list").each(function(){
            $(this).html( str)
         })
         bindRemove();
    }});
}
function widgetStatusList(){
    $.ajax({url: "animals/querySimpleStatus", success: function(result){
        var str = initWidget("Status Count");
        str += "<div class='grid-stack-item-content panel-body'><div class='row'>" 
        for (x in result){
    
                str += "<div class='col-md-4'><div class='metric'><span class='icon'><i class='glyphicon glyphicon-tasks'></i><a href='/animals?n=+&?b=&?g=&?s=" + result[x].id + "&?a=0&?A=15&?qn=1 '></span><p><span class='number'>" + result[x].count + "</span><span class='title'>" + result[x].name + "</p></div></div>"
    
        }
        str +=  "</div></div><div class='text-right panel-footer'> <div class='row text-right'><a href= animals class='btn btn-primary'>View all Animals</a> </div></div>"
         $(".status-list").each(function(){
            $(this).html( str)
         })
         bindRemove();
    }});
}
function widgetUserList(){
    $.ajax({url: "people/query", success: function(result){
        var str = initWidget("User List");
        str += "<div class='panel-body no-padding'> <div class='table-responsive'> <table class='table table-hover table-striped'> <thead> <tr> <th>Name</th> <th>Email</th> </tr> </thead>" 
        for (x in result){
    
                str += "<tr> \
                <td> <a href='/people/profile?method=get&param=" + result[x].id + "' > " + result[x].name + "</a></td>\
                 <td>" + result[x].email + "</td>\
                </tr>"
        }
        str +=  " </table> </div> <div class='text-right panel-footer'> <div class='row text-right'><a href= people class='btn btn-primary'>View all Users</a> </div></div>"
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

  console.log("loading widgets")
  $.ajax({
        url: "dashboard",
        type: "GET",
       success: function(result){
        str = result.str;
        obj = JSON.parse(str);
        
        for (i = 0; i < obj.length; i++){
          console.log(obj[i])
          var el = $.parseHTML('<div class = "brick large ' + obj[i].type+' " widget-type="'+obj[i].type+'">' + obj[i].type + '</div>');
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
          console.log(obj[i])
          var el = $.parseHTML('<div class = "brick mobile ' + obj[i].type+' " >' + obj[i].type + '</div>');
          $(".gridly").append(el);
        }
        console.log($(window).width())
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
  console.log('saving');
  var arr = []
    $(".brick").each(function() {
        var type = $(this).attr("widget-type");
        arr.push({"type": type});
    })
    console.log(arr);
    var str = JSON.stringify(arr);
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
  saveLayout()
  $('.gridly').gridly(
        {base: 350, // px 
          gutter: 20, // px
          columns: (parseInt( $(".content-body").width()/350)), 
          callbacks: {
              reordered: function(){saveLayout()}
          }
        }
  );

}
$(window).resize(function(){
    clearTimeout(gridly_timeout);
    gridly_timeout = setTimeout(refreshGridly, 2000);
});

