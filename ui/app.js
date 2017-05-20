
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
	
	
function rowtask(id, first_name, last_name, position)
{
  
   var table = document.getElementById("Employeetable");
   var row = table.insertRow(0);
   var cell1 = row.insertRow(0);
   var cell2 = row.insertRow(1);
   var cell3 = row.insertRow(2);
   var cell4 = row.insertRow(3);
   
   cell1.innerHTML = id;
   cell2.innerHTML = first_name;
   cell3.innerHTML =last_name;
   cell4.innerHTML = position;
   
   
}

	
