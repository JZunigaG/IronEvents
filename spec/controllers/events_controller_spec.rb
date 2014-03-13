require 'spec_helper'



describe EventsController do


	describe '#index' do

		it 'returns events with DOUBLE that start today' do

			event = double("event")

			#Espera que se llame al metodo start_at_today en el metodo index de events controller
			#Con el double ,no llamamos al metodo sino retornamos un event
			expect(Event).to receive(:start_at_today).and_return([event])

			# Accion	
			get :index

			#:events es el nombre de la variable de instancia
			expect(assigns(:events)).to eq([event])

			expect(request).to render_template(:index)

		end

		#Sin usar doubles,es mas un test de integracion,solo testeamos el 
		#resultado
		it 'returns events with FACTORYGIRL that start today' do

			event = FactoryGirl.create(:event,start_at: Date.today)

			# Accion	
			get :index

			expect(assigns(:events)).to eq([event])

			expect(request).to render_template(:index)

		end

		#Sin usar doubles,es mas un test de integracion,solo testeamos el 
		#resultado
		it 'returns events with STUB that start today' do

			event = double("event")

			# DA igual que no llame a :start_at_today lo que importa es 
			# el return
			Event.stub(:start_at_today).and_return([event])
	
			# Accion	
			get :index

			expect(assigns(:events)).to eq([event])

			expect(request).to render_template(:index)

		end


		# Se llama al metodo :start_at_today realmente,accede a BD
		it 'returns events with CALL ORIGINAL that start today' do

			event = FactoryGirl.create(:event,start_at: Date.today)

			expect(Event).to receive(:start_at_today).and_call_original

			# Accion	
			get :index

			expect(assigns(:events)).to eq([event])

			expect(request).to render_template(:index)

		end

	end


	describe '#create' do

		before do

			@user = FactoryGirl.create(:user)

			sign_in @user

		end


		# Si se crea un registro en la BD
		it 'creates an event',:focus => true do

			my_event = {
							name: "EventX",

							description: "a" * 101,

							start_at: Date.today,

							end_at: Date.today + 1.days,

							address: "Madrid",
					   }

			expect {post :create,event: my_event}.to change(Event,:count).by(1)	

			# Chequea que si va bien el create nos redirija al evento creado
			expect(response).to redirect_to(assigns(:event))

=begin
			expect {post :create,event: FactoryGirl.attributes_for(:event)}.to change(Event,:count).by(1)	


			expect {post :create, 
					event: {name: "EventX",
							description: "a" * 101,
							start_at: Date.today,
							end_at: Date.today + 1.days,
							address: "Madrid"}
					}.to change(Event,:count).by(1)
=end

		end


		it 'render the form when invalid' do

			post :create,event: {address: "Hervas"}

			expect(request).to render_template(:new)

		end

	end


end
