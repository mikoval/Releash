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
//= require gridstack-js-rails
//= require_tree .

//= require moment 




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
 function validateForm(param){
    ret = true
    console.log("HEYYYYYY");
    console.log($(param).find(".required"))
    
    $(param).find(".required").each(function(){
      if($(this).val()==""){
          
          console.log(this);

          $(this).addClass("required-error")
          ret = false;
        }
        else{
            $(this).removeClass("required-error")
        }
    })
    console.log(ret);
    return ret;
}
