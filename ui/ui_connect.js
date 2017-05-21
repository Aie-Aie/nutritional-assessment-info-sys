$(function(){
	$('#focal').click(function(){
		$('#stat').hide();
		$('#func_focal').show();
		$('#work').show();
		$('#func_child').hide();
		$('#func_municipality').hide();
		//$('#focal').hide();
		
		
		
	});
	
	$('#municipality').click(function(){
		$('#stat').hide();
		$('#func_child').hide();
		$('#func_municipality').show();
		$('#func_focal').hide();
	
	});
	
	$('#child_entry').click(function(){
		$('#stat').hide();
		$('#func_child').show();
		$('#func_municipality').hide();
	
	
	});
	
	$('#overview').click(function(){
		$('#stat').show();
		$('#func_focal').hide();
		$('#func_child').hide();
		$('#func_municipality').hide();
		$('#work').hide();
	
	
	});
	
	
	
	
	
});