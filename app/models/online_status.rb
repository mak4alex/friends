class OnlineStatus < ApplicationRecord
  PLATFORM = {
    1 => 'MOBILE',
    2 => 'IPHONE',
    3 => 'IPAD',
    4 => 'ANDROID',
    5 => 'WINDOWS_PHONE',
    6 => 'WINDOWS_10',
    7 => 'WEB'
  }
end
