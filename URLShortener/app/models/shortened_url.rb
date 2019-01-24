# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  short_url  :string           not null
#  long_url   :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord
  validates :long_url, presence: true
  validates :short_url, presence: true, uniqueness: true
  validates :user_id, presence: true


  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visitors,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Visit

  def self.random_code
    random_url = SecureRandom.urlsafe_base64

    until !ShortenedUrl.exists?(:short_url => SecureRandom.urlsafe_base64) do
      random_url = SecureRandom.urlsafe_base64
    end

    random_url
  end

  def self.create!(user, long_url)
    short_url = self.random_code
    s = ShortenedUrl.new(:short_url => short_url, :long_url => long_url, :user_id => user.id)
    s.save
  end


end
