class TicketType < ActiveRecord::Base
  belongs_to :event

  before_create :check_duplicates

  def check_duplicates
  	if TicketType.where(event: event, price: price).first
  		errors.add(:base, "Can not have duplicates")
  	end
  end

  def check_quantity(quantity)
  	if max_quantity < quantity
  		errors.add(:base, "Quanlity can not great than max_quantity")
  	end
  end

  def max_quantity_buy(quantity)
  	if quantity > 10
  		errors.add(:base, "Quanlity can not great than 10")
  	end
  end
end
