# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord
  validates :long_url, presence: true, uniqueness: true 
  validates :short_url, presence: true, uniqueness: true 
  validates :user_id, presence: true, uniqueness: true 
  
  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'User'
  
  def self.random_code 
    short_url_code = SecureRandom::urlsafe_base64
    
    until !ShortenedUrl.exists?(short_url: short_url_code)
      short_url_code = SecureRandom::urlsafe_base64
    end 
    
    short_url_code
    
  end
  
  def self.create_new_url(user, long_url)
    
    ShortenedUrl.create!(long_url: long_url, short_url: self.random_code, user_id: user.id)
  end
end
