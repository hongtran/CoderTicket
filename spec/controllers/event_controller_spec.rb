require 'rails_helper'

RSpec.describe EventsController, type: :controller do
	describe "Get #index" do
	   it "responds successfully with an HTTP 200 status code" do
	   	 get :index
	   	 expect(response).to be_success
	   	 expect(response).to have_http_status(200)
	   end

	   it "renders the index template" do
	   	 get :index
	   	 expect(response).to render_template("index")
	   end
	end
	let(:event) {event = Event.new}
	describe "Get #edit/:id" do
		
		#event.save! validate: false
		 
		

	end
end