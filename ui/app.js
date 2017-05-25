
function loadentry(){
	
	
	
	$.ajax
	({
		url: 'http://127.0.0.1:5000/focalentries',
		type: "GET",
		dataType: "json",
		success: function(resp)
		{
			$('#loadentry').html("");
			if(resp.status =="ok")
			{
				for(i=0; i<resp.count; i++)
				{
					id = resp.entries[i].id;
					first_name=resp.entries[i].first_name;
					last_name = resp.entries[i].last_name;
					position = resp.entries[i].position;	
					$("#loadentry").append(rowentry(id, first_name, last_name, position));
					$('#func_focal').show();
				}
			}
			else
			{
				   $("#func_focal").html("");
				   alert(resp.message);
			}
		},
		error: function(err)
		{
			alert("Error");
		}
		
	});
}

function rowentry(id, fname, lname, pos)
{
	
	return '<tr class="table-success">'+
			'<td>'+id+'</td>'+
			'<td>'+fname+'</td>'+
			'<td>'+lname+'</td>'+
			'<td>'+position+'</td>'+
			'</tr>';
	
}

function searchchild(){
	var data =$('#childdetail').val();
	$.ajax({
		
	});
}


function searchfoc(){
	
	
	var data =$('#focdetail').val();
	$.ajax({
		url: 'http://127.0.0.1:5000/focaldata/'+data,
		type: "GET",
		dataType: "json",
		success: function(resp)
		{
			$("#tbody").html("");
			
			if(resp.status == 'ok'){
				for(i=0; i<resp.count; i++)
				{
					fname = resp.entries[i].fname;
					lname =resp.entries[i].lname;
					position=resp.entries[i].position;
					$("#tbody").append(rowfoc(fname, lname, position));
					$('#viewsearchfocal').show();
					$('#func_focal').hide();
					
				}
			
			}
			else{
				$("#tbody").html("");
				alert(resp.message);
			}
			
		},
		error: function(err)
		{
			
			alert("Error in the system occurred");
		}
		
		
	});
}

function updatefoc(){
	alert("Hi");
}

	
function rowfoc(fname, lname, position){

	 return '<tr class="table-success">'+
			'<td>'+fname+'</td>'+
			'<td>'+lname+'</td>'+
			'<td>'+position+'</td>'+
			'<td style="width:200px;"><button class="btn success" onclick="updatefoc();" style="background-color: #4CAF50;"><b>Update</b></button>'+
			'<button class="btn success" onclick= "deletefocal();" style="background-color: #f44336;"><b>Delete</b></button></td>'+
			'</tr>';
}
function addfocal(){
	$.ajax({
		data:{
			id: $('#id').val(),
			lname:$('#lname').val(),
			fname:$('#fname').val(),
			pos :$('#pos').val(),
		},
		url:'http://127.0.0.1:5000/focal',
		type: "POST",
		dataType:"json",
		success:function(resp)
		{
			$("#func_focal").html("");
			alert(resp.message);
		},
		error: function(err)
		{
			alert("Error in the system occurred");
		}
		
	});
}


function addchild(){
	$.ajax({
		data:{
			childid: $('#childid').val(),
			childlname:$('#childlname').val(),
			childfname:$('#childfname').val(),
			weight:$('#weight').val(),
			height: $('#height').val()
		},
		url:'http://127.0.0.1:5000/child',
		type: "POST",
		dataType:"json",
		success:function(resp)
		{
			alert(resp.message);
		},
		error: function(err)
		{
			alert("Error in the system occurred");
		}
		
	});
}



function loadchild(){
	$.ajax({
		url: 'http://127.0.0.1:5000/childentries',
		type: 'GET',
		dataType: 'json',
		success: function(resp)
		{
			$('#childentry').html("");
			if(resp.status == 'ok'){
				for(i=0; i<resp.count; i++)
				{
					childid =resp.entries[i].id;
					childfname =resp.entries[i].first_name;
					childlname =resp.entries[i].last_name;
					childweight =resp.entries[i].weight;
					childheight=resp.entries[i].height;
					status=resp.entries[i].status;
					$("#childentry").append(childrow(childid, childfname, childlname, childweight, childheight, status));
					$('#childentrydata').show();
				}
			
			}
			else{
				$('#childentry').html("");
				alert(resp.message);
			}
		},
		error: function (e) {
        		alert("Error");
   		}
	
	});
}

function childrow(childid, childfname, childlname, childweight, childheight, status){
	
	 
	return '<tr class="table-success">'+
			'<td>'+childid+'</td>'+
			'<td>'+childfname+'</td>'+
			'<td>'+childlname+'</td>'+
			'<td>'+childweight+'</td>'+
			'<td>'+childheight+'</td>'+
			'<td>'+status+'</td>'+
			'</tr>';
	
}

function showchildstat(a){
	$.ajax({
		url: 'http://127.0.0.1:5000/stat',
		dataType: "json",
		success: function(resp){
			
			alert(resp.message);
		}
		
	});
	
	
}
