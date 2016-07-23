class EventsController < ApplicationController
  def index
  	if params[:search]
  		@events = Event.search(params[:search])
  	else
    	@events = Event.feature_events    
    end
  end

  def new
  	@event = Event.new
  	@venues = Venue.all
  	@categories = Category.all
  end

  def create
  	event_params.merge(user_id: current_user.id)
  	@event = Event.new(event_params)
  	if @event.save
  		redirect_to event_path(@event), notice: "Account create"
  	else
  		render "new"
  	end
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def event_params
  	params.require(:event).permit(:name, :starts_at, :ends_at, :venue_id, :hero_image_url, :extended_html_description, :category_id)
  end
end
