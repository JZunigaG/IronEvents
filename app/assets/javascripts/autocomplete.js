// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function()
{
	$('#search').autocomplete({source: '/events/search'})

/*
	$("#search").autocomplete(
	{
			source: '/events/search',
			select: function (event, ui) 
			{
				$("#search").val(ui.item.label);
				console.log("Hola")
				window.location = ui.item.value;
				return false;
			}
	}
	);
*/
})