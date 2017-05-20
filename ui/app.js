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
			if(resp
			
			
			
		},
		error: function(err)
		{
			alert("Error");
		}
		
	)};
	

}