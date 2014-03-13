require 'spec_helper'

feature 'Event_creation' do

	scenario 'creating an event' do

		visit new_event_path

		fill_in "event_name",with: "Evento de prueba"

		fill_in "event_description",with: "D" * 101

		fill_in "event_start_at",with: "01/01/2014"

		fill_in "event_end_at",with: "02/01/2014"

		click_button "Save"

		page.should have_content "Evento de prueba"

	end
	
end