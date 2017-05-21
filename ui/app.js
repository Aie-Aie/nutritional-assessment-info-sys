
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

function rowtask(id, fname, lname, pos)
{
   return '<div>'+
			'<p><td>'+id+ '&nbsp;&nbsp;</td>'+	
				'<td>'+fname+'&nbsp;&nbsp;</td>'+
				'<td>'+lname+'&nbsp;&nbsp;</td>'+
				'<td>'+pos+'</td></p>'+
		  '</div>';
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
			if(resp.status == 'ok'){
				alert("Congrats error found");
			}
			else{
				alert(resp.message);
			}
		},
		error: function(err)
		{
			alert("Error");
		}
		
	});
}

function searchfoc(){
	$.ajax({
		data:{
			detail:$('#focalsearch').val()
		}
		url: 
		
	});
}
	
