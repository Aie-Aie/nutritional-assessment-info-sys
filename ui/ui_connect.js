$(function(){
	$('#focal').click(function(){
		$('#stat').hide();
		$('#func_focal').show();
		$('#focwork').show();
		$('#childfunc').hide();
		$('#children').hide();
		$('#childwork').hide();
		
		
		
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