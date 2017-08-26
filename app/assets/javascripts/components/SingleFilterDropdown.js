function SingleFilterDropdown(div, source, style = {}){
	var context = this;
	var obj = div;
	var selected = [];

	var input = $('<input/>').attr({ type: 'text', id: 'input2' }).addClass("form-control ss-input")
	var list = $('<div/>').addClass("ss-list").css("display", "none");
	var display = $('<div/>').addClass("ss-display")

	
	input.appendTo(obj);
	list.appendTo(obj);
	display.appendTo(obj);
	
	$(input).on('keyup paste', function() {
		context.setList($(this).val());
		context.showList();
	});

	$(document).ready(function () {

	    $('.ss-list').animate({
	        scrollTop : $("#test1").position().top,
	    }, 200);

	});

	$(document).on("mouseup", function(e){
		if (!list.is(e.target) && list.has(e.target).length === 0) 
	    {
	        list.hide();
	        //input.val("");
	    }
	    if (input.is(e.target) && input.has(e.target).length === 0) 
	    {
	        list.show();
	    }
	})
	
	this.setHiddenBreeds = function (){
	    div.find("prim_breed").val(selected[0].id);
	    console.log(selected);
	    input.val(selected[0].name);
	    console.log(input)
  	}


	this.setList = function(str){
		var html = "";
		var count = 0;
		for(var i = 0; i < this.data.length; i++){
			if(this.data[i].name.toLowerCase().indexOf(str.toLowerCase()) !== -1){
				count++;
				var added = ""
				if(this.containsItem(this.data[i].id)){
					added = "ss-item-selected";
				}

				html += "<div class='ss-item ss-row-"+ (count%2) +" "+added+"' id='"+this.data[i].id+"'>"+this.data[i].name+"</div>"
			}
		}

		list.html(html);
		list.find("div").on("click", function(){

			context.toggleItem($(this).attr("id"));
		})
		setHiddenBreeds();
		//this.createDisplay();
		
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
			$(this).closest(".ss-item").detach()
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