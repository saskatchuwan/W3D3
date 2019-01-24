# == Schema Information
#
# Table name: visits
#
#  id               :bigint(8)        not null, primary key
#  shortened_url_id :integer          not null
#  user_id          :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Visit < ApplicationRecord
  validates :shortened_url_id, presence:true
  validates :user_id, presence:true

  def self.record_visit!(user, shortened_url)
    Visit.new(:user => user, :shortened_url => shortened_url)
  end

  
end
