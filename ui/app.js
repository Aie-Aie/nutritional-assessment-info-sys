
function loadentry()
{
	$.ajax
	({
		url: 'http://127.0.0.1:5000/entries',
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
	
	
function rowtask(description, done, id, title)
{
   var table = document.getElementById("Employeetable");
   
   return  '<div class="box-body table-responsive no-padding">'+
	
					'<tr>					'+
					'	<td>' +id+		'	</td>		'+
					'	<td>' +first_name+'	</td>		'+
					'	<td>' +last_name +' </td>		'+
					'	<td>' +position+ '  </td>		'+
					
					'</tr>					'+
            '</div>							';
   
   
}

	
