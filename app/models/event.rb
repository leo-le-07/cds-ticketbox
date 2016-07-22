class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  belongs_to :owner, foreign_key: 'owner_id', class_name: 'User'
  has_many :ticket_types
  has_many :orders

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

  def draft?
    status == 1
  end
end
