module ApplicationHelper

	def flash_message

		display_message(:notice) || display_message(:alert)

	end

	private


	def display_message(message_type)

		if flash[message_type]

			content_tag :div,class: message_type do 
				
				content_tag :p do

					flash[message_type]

				end
				
			end

		end

	end	
end
