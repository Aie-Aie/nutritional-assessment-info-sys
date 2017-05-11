function signin()
{
	$.ajax
	
	({
		data:
			{
				name: $('#name').val(),
				id:	$('#id').val()
			},
		url: 'http://127.0.0.1:5000/access',
		type:'POST',
		dataType: 'json',
		success: function(resp)
			{
				if(resp.status == 'Error'){
					
				}
				
				else{
					
					alert("Access Granted");
				}
					
			},
		error: function(e)
			alert("GG");
			
		
		
	});
		
		
		
};