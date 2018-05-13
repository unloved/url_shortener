require 'active_record'

class UrlVisit < ActiveRecord::Base
  belongs_to :url
  validates :url, presence: true
end