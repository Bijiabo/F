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
    delta_setting = (Time.new.to_i - date.to_i).floor / 60
    distance = distance_of_time_in_words(delta_setting)
    distance
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

  private

    def distance_of_time_in_words(minutes)
      case
        when minutes < 0.4
          # "a few seconds"
          "几秒前"
        when minutes < 0.6
          # "half a minute"
          "半分钟前"
        when minutes < 1
          # "less than a minute"
          "一分钟前"
        when minutes < 2
          # "one minute"
          "一分钟前"
        when minutes < 45
          # "#{minutes} minutes"
          "#{minutes}分钟前"
        when minutes < 59
          # "less than one hour"
          "一小时前"
        when minutes < 120
          # "one hour"
          "一小时前"
        when minutes < 1080
          # "#{(minutes / 60).round} hours"
          "#{(minutes / 60).round}小时前"
        when minutes < 2880
          # "yesterday"
          "昨天"
        when minutes < 8640
          # "#{(minutes / 1440).round} days"
          "#{(minutes / 1440).round}天前"
        when minutes < 10080
          # "one week"
          "一周前"
        when minutes < 40320
          # "#{(minutes / 8640).round} weeks"
          "#{(minutes / 8640).round}周前"
        when minutes < 43200
          # "one month"
          "一个月前"
        when minutes < 525580
          # "#{(minutes / 43200).round} months"
          "#{(minutes / 43200).round}个月前"
        when minutes < 525600
          # "one year"
          "一年前"
        when minutes < 2628000
          # "#{(minutes / 525600).round} years"
          "#{(minutes / 525600).round}年前"
        else
          # "#{minutes} minutes"
          "#{minutes}分钟前"
      end
    end

end
