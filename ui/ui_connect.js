$(function(){
	$('#focal').click(function(){
		$('#stat').hide();
		$('#func_focal').show();
		$('#func_child').hide();
		$('#func_municipality').hide();
	});
	
	$('#municipality').click(function(){
		$('#stat').hide();
		$('#func_focal').hide();
		$('#func_child').hide();
		$('#func_municipality').show();
	
	});
	
	$('#child_entry').click(function(){
		$('#stat').hide();
		$('#func_focal').hide();
		$('#func_child').hide();
		$('#func_municipality').show();
	
	});
	
	
});