function signin()
{
	$.ajax
			var name =$('#name').val(),
			var id =$('#id').val()
	({
		data: $('form').serialize(),
		url: 'http://127.0.0.1:5000/access',
		type:'POST',
		dataType: 'json',
		success: function(resp)
		{
			
		}
			
	});
		
		
		
};

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
				   $("#tasks").html("");
				   alert(resp.message);
			}
			
			
			
			
		},
		error: function(err)
		{
			alert("Error");
		}
		
	)};
	
	
function rowtask(description, done, id, title)
{
   return '<div class="col-lg-12">' +
		  '<h4>' + id + "&nbsp;&nbsp;" + first_name + '</h4>' +
		  '<p>'+last_name+' </br> Status: '+position+'</p> </div>'; 
}

	
	
	

}