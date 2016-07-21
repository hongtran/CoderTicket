class TicketType < ActiveRecord::Base
  belongs_to :event

  before_create :check_duplicates

  def check_duplicates
  	if TicketType.where(event: event, price: price).first
  		errors.add(:base, "Can not have duplicates")
  	end
  end

end
