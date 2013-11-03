class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable #, :validatable
  # You likely have this before callback set up for the token.
  before_save :ensure_authentication_token
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  serialize :setting, JSON
  serialize :sns, JSON

  validates_uniqueness_of    :name,     :case_sensitive => false, :allow_blank => false, :if => :name_changed?
  validates_length_of :name, :within => 2..10, :allow_blank => false
  validates_uniqueness_of    :email,    :case_sensitive => false, :allow_blank => true, :if => :email_changed?
  validates_format_of :email, :with  => Devise.email_regexp, :allow_blank => true, :if => :email_changed?
  validates_presence_of   :password, :on=>:update, :if => :email_changed?
  validates_presence_of   :password_confirmation, :on=>:update, :if => :email_changed?
  #validates_confirmation_of   :password, :on=>:update, :if => :email_changed?
  validates_length_of :password, :within => Devise.password_length, :allow_blank => true
 
  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private
  
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
