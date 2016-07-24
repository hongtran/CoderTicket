class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  belongs_to :user
  has_many :ticket_types

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

  def venue_name
  	venue ? venue.name : nil
  end

  def self.search(search)
  	where("name ILIKE?", "%#{search}%")
  end

  def self.feature_events
  	 where("starts_at >= ?", DateTime.now)
  end

  def self.own_events(user)
    where("user_id = ?", user.id)
  end

  def make_publish
    if self.ticket_types.count >= 1
      self.publish = true
      self.save!
    end
  end
end
