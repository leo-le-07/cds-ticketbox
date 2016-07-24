class Event < ActiveRecord::Base
  before_create {status ||= 1}
  before_create :unaccent_fields

  # include PgSearch
  # pg_search_scope :name_search,
  #                 :against => :name,
  #                 :ignoring => :accents

  belongs_to :venue
  belongs_to :category
  belongs_to :owner, foreign_key: 'owner_id', class_name: 'User'
  has_many :ticket_types
  has_many :orders

  validates_presence_of :extended_html_description, :venue, :category, :owner, :name
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}
  validate :ends_at_is_after_starts_at
  validate :starts_at_is_not_in_past

  accepts_nested_attributes_for :venue
  accepts_nested_attributes_for :category

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

  def self.search_by_name(event_name)
    if event_name && !event_name.empty?
      Event.where("unaccent_name ILIKE ? and starts_at >= ? and status = 2", "%#{self.unaccent(event_name)}%", DateTime.now).order("starts_at ASC, unaccent_name ASC")
    else
      Event.where("starts_at >= ? and status = 2", DateTime.now).order("starts_at ASC, unaccent_name ASC")
    end
  end

  def self.unaccent(str)
    str.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s if str
  end

  def event_image_url
    hero_image_url && !hero_image_url.empty? ? hero_image_url : "https://unsplash.it/600/300?random"
  end

  private
    def unaccent_fields
      self.unaccent_name = unaccent(self.name)
      self.unaccent_description = unaccent(self.extended_html_description)
    end

    def unaccent(str)
      str.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s
    end
end
