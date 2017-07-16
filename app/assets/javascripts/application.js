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


