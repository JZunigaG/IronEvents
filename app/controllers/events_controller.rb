class EventsController < ApplicationController

    #Autorizacion para los usuarios
    before_filter :authenticate_user!,only: [:new,:create,:edit,:update,:destroy]


    def index

        #@events = Event.all

        @events = Event.start_at_today

        # En la url se pasa el formato con .formato(/events.xml),segun la peticion
        # devolveremos un formato u otro
        respond_to do |format|

            format.html

            format.xml {render xml: @events}

            #format.json {render json: @events}

            # Busca fichero para renderizar ,.erb,.builder ,...,
            format.json

        end

    end


    def new

        @event = Event.new

        authorize @event
   
    end


    def edit

        @event = Event.find_by(id: params[:id])

        authorize @event
               
    end


    def create
   
        @event = Event.new(entry_params)

        @event.user = current_user

        #Rails.logger.debug "CURRENT_USERRRR::::: #{current_user.email}"

        authorize @event

        if @event.save

            #flash[:notice] = "Event #{@event.name} created sucessfully."
            redirect_to event_path(@event)

        else

            render :new

        end

    end
 

    def show

        @event = Event.find_by(id: params[:id])

        if @event == nil

            redirect_to events_path

        end


=begin
        @event = Event.find(params[:id])

        rescue ActiveRecord::RecordNotFound

            render 'errors/record_not_found'
=end            
    end


    def update

        @event = Event.find(params[:id])

        @event.update_attributes(entry_params)

        if @event.save

            # Utilizamos el nombre que nos proporciona rake routes con _path o _url(con nombre de dominio)
            redirect_to event_path(@event)

        else
            render :show
        end
        
    end


    def destroy
        

        if @event = Event.find_by(id: params[:id])

            @event.destroy

            if @event.destroyed?

                redirect_to events_path
            
            else

                render text: "Delete failed."

            end
        else

            flash[:alert] = "Event to delete does not exits"

        end
    
    
    end


    private

    def entry_params

        params.require(:event).permit(:name,:description,:start_at,:end_at,:address)

    end

end
