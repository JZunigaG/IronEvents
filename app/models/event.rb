class Event < ActiveRecord::Base

	belongs_to :user


	validates :name,presence: true,length: {maximum: 60}

	validates :description,length: {minimum: 100},allow_blank: true

	validates :user,presence: true

	# Creamos nuestra propia validacion
	validate :start_at_is_present

	validate :start_at_less_or_equal_than_end_up


=begin ,otra forma de hacer con scope
	scope :start_at_today,lambda 
	{
		where(["start_at = ?",Date.today])
	}
=end


	def self.start_at_today

		where(["start_at = ?",Date.today])

	end


	private

	def start_at_is_present

		if start_at.blank?

			errors.add(:start_at,"can not be blank")

		end

	end


	def start_at_less_or_equal_than_end_up

		if start_at.present? && end_at.present?

			if start_at > end_at

				errors.add(:start_at,"can not be higher than end_at")

			end
		end

	end

end
