
function loadentry(){
	$.ajax
	({
		url: 'http://127.0.0.1:5000/focalentries',
		type: "GET",
		dataType: "json",
		success: function(resp)
		{
			
			$("#func_focal").html("");
			if(resp.status =="ok")
			{
				for(i=0; i<resp.count; i++)
				{
					id = resp.entries[i].id;
					first_name=resp.entries[i].first_name;
					last_name = resp.entries[i].last_name;
					position = resp.entries[i].position;
					 $("#func_focal").append(rowtask(id, first_name, last_name, position));
					
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

function rowtask(id, lname, fname, pos)
{

	
 return '<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">'+
	  '<h4>' + id + "&nbsp;&nbsp;" + fname+ "&nbsp;&nbsp;" +lname+ '</h4>' +
	  '<p> Position: '+pos+'</p>'+
	  '</div>'; 
}
	
function rowfoc(fname, lname, position){
	
   var row ='<td>
}

function searchfoc(){
	var data =$('#focdetail').val();
	console.log(data);
	$.ajax({
		url: 'http://127.0.0.1:5000/focaldata/'+data,
		type: "GET",
		dataType: "json",
		success: function(resp)
		{
			if(resp.status == 'ok'){
				for(i=0; i<resp.count; i++)
				{
					fname = resp.entries[i].fname;
					lname =resp.entries[i].lname;
					position=resp.entries[i].position;
					$("#func_focal").append(rowfoc(fname, lname, position));
				}
			
			}
			else{
				$('#func_focal').html("");
				alert(resp.message);
			}
			
		},
		error: function(err)
		{
			
			alert("Error in the system occurred");
		}
		
		
	});
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
			$('#func_focal').html("");
			if(resp.status == 'ok'){
				for(i=0; i<resp.count; i++)
				{
					childid =resp.entries[i].id;
					childfname =resp.entries[i].first_name;
					childlname =resp.entries[i].last_name;
					childweight =resp.entries[i].weight;
					childheight=resp.entries[i].height;
					status=resp.entries[i].status;
					$("#func_child").append(childrow(childid, childfname, childlname, childweight, childheight, status));
				}
			
			}
			else{
				$('#func_focal').html("");
				alert(resp.message);
			}
		},
		error: function (e) {
        		alert("Error");
   		}
	
	});
}
function showchildstat(){
	$.ajax({
		url: 'http://127.0.0.1:5000/stat',
		dataType: "json",
		success: function(resp){
			
			alert(resp.message);
		}
		
	});
	
	
}
function displachildstat(){
	document.getElementById('showdata').innerHTML="Hello";
}
function childrow(childid, childfname, childlname, childweight, childheight, status){
	
	 return '<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">'+
          '<h4>' + childid + "&nbsp;&nbsp;" +  childfname+ "&nbsp;&nbsp;" +childlname+ '</h4>' +
          '<p> Status: '+status+'</p>'+
				'Weight: '+childweight+'<br>'+
				'Height: '+childheight+'<br>'+
		  '</div>'; 
}
