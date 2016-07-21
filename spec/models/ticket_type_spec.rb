require 'rails_helper'

RSpec.describe TicketType, type: :model do
  context "multiple tickets with different price" do
  	it "handle one ticket type case" do
  	end

  	it "handle duplicates" do
  		event = Event.new(name: "blala")
  		event.save validate: false
  		type1 = event.ticket_types.create! price: 1.00
  		type2 = event.ticket_types.create! price: 1.00
  		expect(type2.errors[:base]).to eq ["Can not have duplicates"]
  	end
  end
end
