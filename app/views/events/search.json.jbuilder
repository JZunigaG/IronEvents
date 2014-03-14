#begin
#json.array! @events_filtered_by_name
#end
json.array! @events_filtered_by_name do |event| 

	json.label event.name

	#json.value event.name

	json.value event_path(event)

end


	