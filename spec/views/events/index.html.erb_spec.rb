require 'rails_helper'

RSpec.describe "events/index", type: :view do
	it "the view include title" do
		event1, event2 = Event.new(starts_at: DateTime.now + 5.days), Event.new(starts_at: DateTime.now + 5.days)
        event1.save! validate: false
        event2.save! validate: false 
		assign(:events, Event.all)
		render
		expect(view).to render_template(:partial => "_card", :count => Event.all.count)
	end
end
