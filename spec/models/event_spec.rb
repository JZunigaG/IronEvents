require 'spec_helper'

describe Event do

	describe 'name' do 

		it 'should no be blank' do

			event = Event.new(name: nil)

			expect(event).to have(1).error_on(:name)

		end

		it 'should no have error when present' do

			event = Event.new(name: "Pepe")

			expect(event).not_to have(1).error_on(:name)

		end

	end


	describe 'name length' do 

		it 'should no be longer than 60 characters' do

			event = Event.new(name: "a" * 61)

			expect(event).to have(1).error_on(:name)

		end

		it 'should be shorter than 61 characters' do

			event = Event.new(name: "PEPE")

			expect(event).not_to have(1).error_on(:name)

		end

	end


	describe 'description' do 

		it 'is valid when blank' do

			event = Event.new(description: "")

			expect(event).to have(0).error_on(:description)

		end


		it 'should not be shorter than 100 characters' do

			event = Event.new(description: "a" * 99)

			expect(event).to have(1).error_on(:description)

		end


		it 'should be longer than 99 characters' do

			event = Event.new(description: "a" * 100)

			expect(event).to have(0).error_on(:description)

		end


	end


	describe 'start_at' do 

		it 'is invalid when blank' do

			event = Event.new(start_at: nil)

			expect(event).to have(1).error_on(:start_at)

		end

	end


	describe 'start_at,end_at' do 

		it 'start_at can not before end_at' do

			event = Event.new(start_at: Date.today,end_at: Date.today - 1.days)

			expect(event).to have(1).error_on(:start_at)

		end

		it 'start_at less or equal end_at' do

			event = Event.new(start_at: Date.today,end_at: Date.today + 1.days)

			expect(event).to have(0).error_on(:start_at)

		end

	end


	describe 'for today' do 

		it 'returns events that start today' do

			# create,almacena en base de datos el objeto
			event = FactoryGirl.create(:event,start_at: Date.today)

			expect(Event.start_at_today).to include(event)

		end

		it 'returns events that no starts tomorrow' do

			event = FactoryGirl.create(:event,start_at: Date.today + 1.days)

			expect(Event.start_at_today).not_to include(event)

		end	

		it 'returns events that already started' do

			event = FactoryGirl.create(:event,start_at: Date.today - 1.days)

			expect(Event.start_at_today).not_to include(event)

		end	

	end


	describe 'user' do 

		#it 'is mandatory',:focus => true do
		it 'is mandatory' do

			event = Event.new(user: nil)

			expect(event).to have(1).error_on(:user)

		end

	end


end
