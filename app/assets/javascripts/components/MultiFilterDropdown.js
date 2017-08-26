function MultiFilterDropdown(div, source, style = {}){
	var context = this;
	var obj = div;
	var selected = [];

	var input = $('<input/>').attr({ type: 'text', id: 'input' }).addClass("form-control dd-input")
	var list = $('<div/>').addClass("dd-list").css("display", "none");
	var display = $('<div/>').addClass("dd-display")
	
	input.appendTo(obj);
	list.appendTo(obj);
	display.appendTo(obj);
	
	$(input).on('keyup paste', function() {
		context.setList($(this).val());
		context.showList();
	});
	console.log("Secondary");
	$(document).ready(function () {

	    $('.dd-list').animate({
	        scrollTop : $("#test").position().top,
	    }, 200);

	});

	$(document).on("mouseup", function(e){
		if (!list.is(e.target) && list.has(e.target).length === 0) 
	    {
	        list.hide();
	    }
	    if (input.is(e.target) && input.has(e.target).length === 0) 
	    {
	        list.show();
	    }
	})
	
	this.setHiddenBreeds = function (){
	   str = ""
	   for(var i = 0; i < selected.length; i++){
	   		//console.log("ids");
      		var id = selected[i].id
      		//console.log(id);
      		str += id + "|"
      		//onsole.log(str);
	    }
	    div.find(".storage").val(str);
  	}


	this.setList = function(str){
		var html = "";
		var count = 0;
		for(var i = 0; i < this.data.length; i++){
			if(this.data[i].name.toLowerCase().indexOf(str.toLowerCase()) !== -1){
				count++;
				var added = ""
				if(this.containsItem(this.data[i].id)){
					added = "dd-item-selected";
				}

				html += "<div class='dd-item dd-row-"+ (count%2) +" "+added+"' id='"+this.data[i].id+"'>"+this.data[i].name+"</div>"
			}
		}

		list.html(html);
		list.find("div").on("click", function(){

			context.toggleItem($(this).attr("id"));
		})
		this.createDisplay();
		
	}
	this.showList = function(){
		list.show();
	}
	this.createDisplay = function(){
		var str = "";
		for(var i = 0; i < selected.length; i++){
			var id = selected[i].id;
			var text = selected[i].name;
			str +=
			"<div class = 'select-item' style = 'position: relative; display: inline-block;'>" 
	        + "<p style = 'margin:0px; padding-right:15px'>" + text + "</p>" + 
			"<span id = '"+id+"'class = 'glyphicon glyphicon-remove remove-behavior remove-item' style='margin:2px; float:right;'></span>" + 
			" </div>"

		}
		$(this).get(0).selectedIndex = 0;
		setHiddenBreeds();
		display.html(str);
		display.find(".glyphicon-remove").on("click", function(){
			
			context.removeItem($(this).attr("id"));
			$(this).closest(".dd-item").detach()
      		setHiddenBreeds();
		})
	}

	this.addItem = function(id){
		item = this.getItem(id);
		
		var id = item.id;
		var text = item.name;
		selected.push({name:text, id:id});
		console.log(input.val());
		this.setList(input.val());
	}
	
	this.removeItem = function(id){
		item = this.getItem(id);
		var id = item.id;
		var text = item.text;

		selected.splice(this.getItemIndex(id), 1);
		console.log(input.val());
		this.setList(input.val());
	}
	this.toggleItem = function(id){
		item = this.getItem(id);
		var json = {name:item.name, id:item.id}
		if(!this.containsItem(id)){
			this.addItem(id);
		}
		else{
			this.removeItem(id);
		}
	}
	this.getItem = function(id){

		for(var i = 0; i < this.data.length; i++){
			if(this.data[i].id + "" == id){
				return {id:id, name:this.data[i].name};
			}
		}
		return {};
	}
	this.getItemIndex = function(id){
		for(var i = 0; i < selected.length; i++){
			if(selected[i].id == id){
				return i;
			}
		}
		return -1;
	}
	this.containsItem = function(id){
		for(var i = 0; i < selected.length; i++){
			if(selected[i].id == id){
				return true;
			}
		}
		return false;
	}
	this.loadData = function(data){
		this.data = data;
	}
	this.loadString = function(str){
		$.ajax({
			url: source,
			context:context, 
			success: function(result){
	        	console.log("Done");
	        	this.data = result;
	    	},
	    	error: function(error){
	    		console.log("Failed");
	    	}
		});
	}
	if(typeof source === 'string'){this.loadString(source);}
	else{this.loadData(source);}
	this.setList("");

	
}