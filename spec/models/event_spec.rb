require 'rails_helper'

RSpec.describe Event, type: :model do
	let(:event) {event = Event.new}
  describe "#venue_name" do
  	it "return nil if there is no venue" do
  		expect(event.venue_name).to be_nil
  	end

  	it "returns venue name if there is a event" do
  		event.venue = Venue.new(name: "RMIT")
  		expect(event.venue_name).to eq "RMIT"
  	end
  end

  describe "#feature_events" do
    it "Past events should not be shown"  do
       event1, event2 = Event.new(starts_at: 1.day.ago), Event.new(starts_at: DateTime.now + 5.days)
       event1.save! validate: false
       event2.save! validate: false 
       expect(Event.feature_events).to eq [event2]
     end
  end
end
