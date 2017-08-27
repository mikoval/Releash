function SingleFilterDropdown(div, source, style = {}){
	var context = this;
	var obj = div;
	var selected = [];

	var input = $('<input/>').attr({ type: 'text', id: 'input2' }).addClass("form-control ss-input")
	var list = $('<div/>').attr({id: 'list2'}).addClass("ss-list").css("display", "none");
	var display = $('<div/>').addClass("ss-display")

	
	input.appendTo(obj);
	list.appendTo(obj);
	display.appendTo(obj);
	
	$(input).on('keyup paste', function() {
		context.setList1($(this).val());
		context.showList1();
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
	    }
	    if (input.is(e.target) && input.has(e.target).length === 0) 
	    {
	        list.show();
	    }
	})
	
	this.setHiddenVals = function (){
	    //div.find("animal_primary_breed_id").val(selected[0].id);
	    div.find(".storage").val(selected[0].id);
	    input.val(selected[0].name);
	    //console.log(selected)
  	}


	this.setList1 = function(str){
		var html = "";
		var count = 0;
		
		for (var i = 0; i < this.data.length; i++) {
			if(this.data[i].name.toLowerCase().indexOf(str.toLowerCase()) !== -1){
				count++;
				var added = ""
				if(this.containsItem(this.data[i].id)){
					added = "ss-item-selected";
				}

				html += "<div class='ss-item ss-row-"+ (count%2) +" "+added+"' id='"+this.data[i].id + "'>"+this.data[i].name+"</div>"
			}
		}

		list.html(html);
		list.find("div").on("click", function(){
			context.toggleItem1($(this).attr("id"));
			console.log($(this).attr("id"));
		})
		if(selected.length != 0) {
			setHiddenVals();
		}
	}
	this.showList1 = function(){
		list.show();
	}
	this.addItem1 = function(id){
		item = this.getItem(id);
		console.log(item);
		var id = item.id;
		var text = item.name;
		selected.push({name:text, id:id});
		
		this.setList1(input.val());
	}
	
	this.removeItem1 = function(id){
		item = this.getItem(id);
		var id = item.id;
		var text = item.text;

		selected.splice(this.getItemIndex(id), 1);
		//console.log(input.val());
		this.setList1(input.val());
	}
	this.toggleItem1 = function(id){
		item = this.getItem1(id);
		//console.log(id);
		var json = {name:item.name, id:item.id}
		
		if(!this.containsItem(id)){
			this.addItem1(id);
		}
		else{
			this.removeItem1(id);
		}
	}
	this.getItem1 = function(id){

		for(var i = 0; i < this.data.length; i++){
			if(this.data[i].id + "" == id){
				return {id:id, name:this.data[i].name};
			}
		}
		return {};
	}
	this.getItemIndex1 = function(id){
		for(var i = 0; i < selected.length; i++){
			if(selected[i].id == id){
				return i;
			}
		}
		return -1;
	}
	this.containsItem1 = function(id){
		for(var i = 0; i < selected.length; i++){
			if(selected[i].id == id){
				return true;
			}
		}
		return false;
	}
	this.loadData1 = function(data){
		this.data = data;
	}
	this.loadString1 = function(str){
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
	if(typeof source === 'string'){this.loadString1(source);}
	else{this.loadData1(source);}
	this.setList1("");

	
}