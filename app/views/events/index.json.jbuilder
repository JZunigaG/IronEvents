json.array! @events do |event|

	#json.(event,:name,:description)

	#json.start_at event.start_at.to_i

	#json.end_at event.end_at.to_i

	json.user do

		if event.user != nil

			json.email event.user.email

		end

	end

end





