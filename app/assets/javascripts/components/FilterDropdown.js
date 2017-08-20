function FilterDropdown(div, source, style = {}){
	var context = this;
	var obj = div;
	var selected = [];
	//obj.append("<input type='text' class='form-control'></input>")
	var input = $('<input/>').attr({ type: 'text', id: 'input' }).addClass("form-control dd-input")
	var display = $('<div/>').addClass("dd-list").css("display", "none");
	input.appendTo(obj);
	display.appendTo(obj);
	$(input).on('keyup paste', function() {
		context.setDisplay($(this).val());
		context.showDisplay();
	});
	$(document).on("mouseup", function(e){
		if (!display.is(e.target) && display.has(e.target).length === 0) 
	    {
	        display.hide();
	    }
	    if (input.is(e.target) && input.has(e.target).length === 0) 
	    {
	        display.show();
	    }
	})
	
	this.setDisplay = function(str){
		var html = "";
		var count = 0;
		for(var i = 0; i < this.data.length; i++){
			if(this.data[i].name.toLowerCase().indexOf(str.toLowerCase()) !== -1){
				count++;
				var added = ""
				if(this.containsItem(this.data[i])){
					added = "dd-item-selected";
				}

				html += "<div class='dd-item dd-row-"+ (count%2) +" "+added+"' id='"+this.data[i].id+"'>"+this.data[i].name+"</div>"
			}
		}
		display.html(html);
		display.find("div").on("click", function(){

			context.toggleItem(this);
		})
		
	}
	this.showDisplay = function(){
		display.show();
	}
	this.addItem = function(item){
		item = $(item);
		item.addClass("dd-item-selected");
		selected.push({name:item.html(), id:item.attr("id")});
	}
	this.toggleItem = function(item){
		item = $(item);
		var json = {name:item.html(), id:item.attr("id")}
		if(!this.containsItem(json)){
			item.addClass("dd-item-selected");
			selected.push(json);
		}
		else{
			item.removeClass("dd-item-selected");

			selected.splice(this.getItemIndex(json), 1);
		}
		
		//this.updateSelected();
	}
	this.getItemIndex = function(item){
		for(var i = 0; i < selected.length; i++){
			if(selected[i].id == item.id){
				return i;
			}
		}
		return -1;
	}
	this.containsItem = function(item){
		for(var i = 0; i < selected.length; i++){
			if(selected[i].id == item.id){
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
	this.setDisplay("");

	
}