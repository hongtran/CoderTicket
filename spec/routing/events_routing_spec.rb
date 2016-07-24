require "rails_helper"

RSpec.describe "routes for Event", :type => :routing do
  it "routes /events to the event controller" do
    expect(get("/")).to route_to("events#index")
  end
end