require 'stamp'
require 'chinese_pinyin'
require 'letter_avatar'

module ApplicationHelper

  include LetterAvatar::AvatarHelper

  def full_title(page_title = '')
    base_title = ENV['Base_title']
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def format_date(date)
    date.stamp("March 1 at 01:00 AM")
  end

  def username_for_avatar(name)
    Pinyin.t name
  end

  def avatar_for_user(user)
    if user.avatar.url
      user.avatar.url
    else
      letter_avatar_url_for(letter_avatar_for(username_for_avatar(user.name), 200))
    end
  end

end
