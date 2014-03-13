class ApplicationController < ActionController::Base

    include Pundit

	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	
	rescue_from Pundit::NotAuthorizedError,with: :user_not_authorized

	rescue_from ActiveRecord::RecordNotFound,with: :record_not_found



	private

	def user_not_authorized

		flash[:error] = "You are not authorized to perform this action."

		# lo redireccion a la pagina de donde viene o si no a la pagina raiz
		redirect_to(request.referrer || root_path)
		
	end


	def record_not_found

		render 'errors/record_not_found'
		
	end

end
