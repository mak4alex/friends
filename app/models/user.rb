class User < ApplicationRecord
  SEX = {
    0 => 'UNKNOWN',
    1 => 'FEMALE',
    2 => 'MALE',
    3 => 'TRANNI'
  }
  DATA_FIELDS = [
    :id, :first_name, :last_name, :screen_name, :photo_50, :photo_100,
    :photo_400_orig, :hidden, :sex, :status, :domain
  ]
  ONLINE  = 1
  OFFLINE = 0
  ONLINE_FIELDS = [ :last_seen, :online ]

  has_many :online_statuses, :primary_key => :vk_user_id, :foreign_key => :vk_user_id
end
