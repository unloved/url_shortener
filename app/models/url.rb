require 'active_record'

class Url < ActiveRecord::Base
  STRATEGIES = %w(SecureRandom MD5)

  before_validation :check_strategy
  before_create :generate_unique_key

  validates :original_url, :strategy, presence: true
  validates :strategy, inclusion: { in: STRATEGIES }

  has_many :visits, class_name: 'UrlVisit', dependent: :destroy

  private

  def generate_unique_key
    self.key = self.send("generate_#{strategy.downcase}_key")
  end

  def generate_securerandom_key
    key = SecureRandom.hex(3)
    if self.class.exists?(key: key)
      generate_secure_random_key
    else
      key
    end
  end

  def generate_md5_key
    key = Digest::MD5.new.update(original_url + Time.now.to_s).to_s
    if self.class.exists?(key: key)
      generate_md5_key
    else
      key
    end
  end

  def check_strategy
    unless strategy.present?
      self.strategy = STRATEGIES.sample
    end
  end

end