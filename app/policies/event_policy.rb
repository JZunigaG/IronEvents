class EventPolicy < ApplicationPolicy


=begin
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
=end

	#Redefinimos el metodo new para que tengamos permiso
	def new?

		true

	end


	def create?

		true

	end


	def edit?

		@user == @record.user

	end

end
