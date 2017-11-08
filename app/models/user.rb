class User < ApplicationRecord
  SEX = {
    0 => 'UNKNOWN',
    1 => 'FEMALE',
    2 => 'MALE',
    3 => 'TRANNI'
  }
  DATA_FIELDS = [
    :id, :first_name, :last_name, :screen_name, :photo_50, :photo_100,
    :photo_400_orig, :hidden, :sex, :status, :domain, :bdate, :about,
    :can_see_all_posts, :wall_comments, :deactivated
  ]
  ONLINE  = 1
  OFFLINE = 0
  API_TRUE = 1
  ONLINE_FIELDS = [ :last_seen, :online ]
  COUNTRIES = {
    'BELARUS' => 3
  }
  CITIES = {
    'MINSK' => 282
  }

  has_many :online_statuses, :primary_key => :vk_user_id, :foreign_key => :vk_user_id
end
