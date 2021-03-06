class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || I18n.t("isnotanemail"))
    end
  end
end

class Player < ActiveRecord::Base
  has_and_belongs_to_many :tourneys
  has_many :matches, :foreign_key => :player1_id, :dependent => :destroy
  has_many :rankings, :through => :tourneys
  
  validates :firstName, presence: true
  validates :lastName, presence: true
  # validates :email, presence: true, email: true
  
  before_validation :ensure_ranking_has_value
  
  def completeName
    lastName = self.lastName || ""
    self.firstName + " " + lastName
  end
private
  def ensure_ranking_has_value
    self.ranking = 1400 if self.ranking.nil?
  end
end