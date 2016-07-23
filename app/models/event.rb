class Event < ActiveRecord::Base
  before_save {self.status ||= 1}

  belongs_to :venue
  belongs_to :category
  belongs_to :owner, foreign_key: 'owner_id', class_name: 'User'
  has_many :ticket_types
  has_many :orders

  validates_presence_of :extended_html_description, :venue, :category, :starts_at, :ends_at, :owner, :name
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}
  validate :ends_at_is_after_starts_at
  validate :starts_at_is_not_in_past

  def draft?
    status == 1
  end

  def ends_at_is_after_starts_at
    return if ends_at.blank? || starts_at.blank?
    if ends_at < starts_at
      errors.add(:ends_at, "ends_at can't be before starts_at")
    end
  end

  def starts_at_is_not_in_past
    return if starts_at.blank?
    if starts_at < DateTime.now
      errors.add(:starts_at, "starts_at can't be in past")
    end
  end
end
