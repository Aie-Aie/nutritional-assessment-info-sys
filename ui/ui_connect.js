$(function(){
	$('#focal').click(function(){
		$('#stat').hide();
		$('#func_focal').show();
		$('#table').show();
		$('#func_child').hide();
		$('#func_municipality').hide();
		$('#focaltable').show();
		$('#Employeetable').show();
		
	});
	
	$('#municipality').click(function(){
		$('#stat').hide();
		$('#table').show();
		$('#func_child').hide();
		$('#func_municipality').show();
		$('#focaltable').hide();
		$('#Employeetable').hide();
		$('#func_focal').hide();
	
	});
	
	$('#child_entry').click(function(){
		$('#stat').hide();
		$('#func_focal').hide();
		$('#table').show();
		$('#func_child').show();
		$('#func_municipality').hide();
		$('#focaltable').hide();
	
	});
	
	$('#overview').click(function(){
		$('#stat').show();
		$('#table').hide();
		$('#func_focal').hide();
		$('#func_child').hide();
		$('#func_municipality').hide();
		$('#focaltable').hide();
	
	});
	
	
	
	
	
});