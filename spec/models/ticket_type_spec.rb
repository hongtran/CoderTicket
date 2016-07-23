require 'rails_helper'

RSpec.describe TicketType, type: :model do
  describe "multiple tickets with different price" do
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

  describe "cannot buy more tickets than the quantity available" do
    it "the quantity more than max_quantity" do
      event = Event.new(name: "test")
      event.save validate: false
      type = event.ticket_types.create! price: 1.00, max_quantity: 10
      type.check_quantity(11)
      expect(type.errors[:base]).to eq ["Quanlity can not great than max_quantity"]
    end
  end
end
