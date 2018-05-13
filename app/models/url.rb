require 'active_record'

class Url < ActiveRecord::Base
  before_create :generate_unique_key
  validates :original_url, presence: true
  has_many :visits, class_name: 'UrlVisit', dependent: :destroy

  def generate_unique_key
    self.key = SecureRandom.hex(3)
    generate_unique_key if self.class.exists?(key: key)
  end
end