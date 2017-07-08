// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require bootstrap
//= require moment
//= require bootstrap-datetimepicker
//= require bootstrap-slider
//= require gridly

//= require_tree .




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
function checkEditable(userID, createdID, alertID){ 
  if(userID == createdID){
    str = "<a href='/alerts/edit?method=get&param=" + alertID + "'><span class = 'glyphicon glyphicon-pencil'></span></a>"
    $(".modal-edit").html(str)
  }
  else{
    $(".modal-edit").html("")
  }
}
 function validateform(){
    ret = true
    $(".required").each(function(){
        console.log($(this).val())
        if($(this).val()==""){
          $(this).addClass("required-error")
          ret = false;
        }
        else{
            $(this).removeClass("required-error")
        }
    

    })
    return ret;
  }
function activateWidgets(){
  widgetAlertList();
  widgetUserList();
  widgetAnimalList();
  widgetStatusList();
  widgetCoorList();
}
function widgetAlertList(){
    $.ajax({url: "/alerts/query", success: function(result){
        var str = "<div class='panel-heading'> <h3 class= 'panel-title -leftpull'> Alerts</h3><div class='right'><button type='button' class='remove-item-btn' onclick='return false;'><i class='lnr lnr-cross'></i></button></div></div>"
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
        var str = "<div class='panel-heading'> <h3 class= 'panel-title  '> Animals</h3><div class='right'><button type='button' class='remove-item-btn' onclick='return false;'><i class='lnr lnr-cross'></i></button></div></div>"
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
        var str = "<div class='panel-heading'> <h3 class= 'panel-title  '> My Assigned Animals</h3><div class='right'><button type='button' class='remove-item-btn' onclick='return false;'><i class='lnr lnr-cross'></i></button></div></div>"
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
        var str = "<div class='panel panel-scrolling'><div class='panel-heading'> <h3 class= 'panel-title  '> Status Count</h3><div class='right'><button type='button' class='remove-item-btn' onclick='return false;'><i class='lnr lnr-cross'></i></button></div></div>"
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
        var str = "<div class='panel-heading'> <h3 class= 'panel-title'> Users</h3><div class='right'><button type='button' class='remove-item-btn' onclick='return false;'><i class='lnr lnr-cross'></i></button></div></div>"
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
  $('.remove-item-btn').on('click', function(event) {
    console.log("removing")
    $(this).closest('.brick').remove()
    saveLayout();
  })
}

function saveLayout() {
  
}

