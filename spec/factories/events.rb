# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do


	factory :event do

		name "event"

		description "d" * 101

		start_at 1.days.from_now

		end_at 2.days.from_now

		address "Address"

		association :user

	end

end
