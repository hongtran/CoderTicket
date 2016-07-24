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

	describe "Get edit/id" do
		it "user who created the event can edit the event" do
			user1 = User.new(name: "test", email: "test@gmail.com", password: "123456")
			user2 = User.new(name: "test2", email: "test2@gmail.com", password: "123456")
			user1.save
			user2.save
			event = Event.new(user_id: user1.id)
			event.save! validate: false
			allow(controller).to receive(:current_user) { user1 }
			get :edit, id: event.id
			expect(response).to render_template("edit")
		end
	end
end
