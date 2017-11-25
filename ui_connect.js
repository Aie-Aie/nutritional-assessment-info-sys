
$(function(){
	$('#focal').click(function(){
		$('#stat').hide();
		
		$('#focwork').show();
		$('#childfunc').hide();
		$('#children').hide();
		$('#childwork').hide();
		$('#func_focal').hide();
		$('#viewsearchfocal').hide();
		
		//$('#viewsearchfocal').show();
		//$('#func_focal').show();  //load focals
		
		
	});
	
	$('#municipality').click(function(){
		$('#stat').hide();
		$('#func_focal').hide();
		$('#focwork').hide();
		$('#childfunc').hide();
		$('#children').hide();
		$('#childwork').hide();
		
	});
	
	
	$('#child_entry').click(function(){
		$('#stat').hide();
		$('#func_municipality').hide();
		$('#focwork').hide();
		$('#childfunc').hide();
		$('#childwork').show();
		$('#childentrydata').hide();
	
	
	});
	
	$('#overview').click(function(){
		$('#stat').show();
		$('#func_focal').hide();
		$('#focwork').hide();
		$('#childtask').empty();
		$('#children').hide();
		$('#childwork').hide();
		
	
	});
	
	
	
	
	
});

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
					$('#viewsearchfocal').hide();
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
			'<td>'+pos+'</td>'+
			'</tr>';
	
}

function rowchild(fname,lname, status)
{
	return '<tr class="table-success">'+
			'<td>'+fname+'</td>'+
			'<td>'+lname+'</td>'+
			'<td>'+status+'</td>'+
			'<td style="width:200px;"><button class="btn success" onclick="updatechild();" style="background-color: #4CAF50;"><b>Update</b></button>'+
			'<button class="btn success" onclick= "deletechild();" style="background-color: #f44336;"><b>Delete</b></button></td>'+
			'</tr>';
}


function searchchild(){
	var data =$('#childdetail').val();
	$.ajax({
		url: 'http://127.0.0.1:5000/childdata/'+data,
		type: "GET",
		dataType: "json",
		success:function(resp)
		{
			$("#childtbody").html("");
			if(resp.status == 'ok')
			{
				for(i=0; i<resp.count; i++)
				{
					fname =resp.entries[i].fname;
					lname =resp.entries[i].lname;
					status =resp.entries[i].status;
				
					
					$("#childtbody").append(rowchild(fname,lname, status));
					$("#viewsearchchild").show();
					$("#childentrydata").hide();
					
				}
			}
			else{
				$("#childtbody").html("");
				alert(resp.message);
			
			}
		},
		error:function(err)
		{
			alert("Error napod");
		}
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
					$('#viewsearchchild').hide();
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
function showstat(normal, uw, obese, female, male)
{
	 var data =	'<div>' +
				'<tr class="table-success">'+
					'<h4>Normal:'+normal+'</h4>'+
				'</tr>'+
				'<tr class="table-success">'+
					'<h4>Obesity:'+obese+'</h4>'+
				'</tr>'+
				'<tr class="table-success">'+
					'<h4>Underweight:'+uw+'</h4>'+
				'</tr>'+
				
				
				'</div>';
				
				
	  $('#display').show();
	  document.getElementById('childresult').innerHTML = data;
}

function showfocstat()
{
	$.ajax({
		url: 'http://127.0.0.1:5000/focstat',
		type: "GET",
		dataType: "json",
		success: function(resp)
		{
			if(resp.status == 'ok')
			{
				count = resp.data;
				showfoc(count);
			}
			else{
				alert("There is something wrong the programmer -_-");
			}
		}
		
	});
}

function showfoc(count)
{
	var data =	'<div>' +
				
				'<tr class="table-success">'+
					'<h4>Number of Focals:'+count+'</h4>'+
				'</tr>'+
				
				
				'</div>';
				
				
	  $('#display').show();
	  $('#childresult').hide();
	  document.getElementById('focresult').innerHTML = data;
}
function signin()
{
	var dataid =$('#id').val();
	
	var name=$('#name').val();
	
	$.ajax({
		url: 'http://127.0.0.1:5000/access'+dataid+'/'+name,
		type: 'POST',
		dataType: "json",
		success: function(resp)
		{
			if(resp.status ='Access granted')
			{
				alert("HI");
			}
			else{
				alert("There is something wrong the programmer -_-");
			}
		
		}
		
		
	});
}

function showchildstat()
{
	$.ajax({
		url: 'http://127.0.0.1:5000/childstat',
		type: "GET",
		dataType: "json",
		success: function(resp)
		{
			if(resp.status == 'ok')
			{
				normal =resp.Normal;
				uw =resp.UW;
				obese=resp.Obese;
				
				showstat(normal, uw, obese);
				
			}
		}
	});
	
	//return  document.getElementById('result').innerHTML = "Hello";
	
}

function signin1(){
	alert("In");
	
	uname= $('#admin').val();
	pwd =$('#password').val();

	alert(uname);
	alert(pwd);
	$.ajax({
		data:{
			uname: $('#admin').val(),
			pwd:$('#password').val()
		}
		url: 'http://127.0.0.1:5000/access',
		type:'POST',
		dataType:'json',
		success: function(resp)
		{
			alert("success");
		}
		error: function(err)
		{
			alert("pastilan");
		}

	});
}