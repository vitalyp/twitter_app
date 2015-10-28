class User < ActiveRecord::Base

  has_one :profile, dependent: :destroy
  has_many :tweets
  has_many :comments

  acts_as_liker
  acts_as_follower
  acts_as_followable

  accepts_nested_attributes_for :profile

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save

      profile = user.build_profile
      profile.save #-> touch to get parent id

      p "AUTH:"
      p auth
      p "PROVIDER: #{auth.provider}"
      case auth.provider
        when 'google'
          profile.name = auth['info']['name']
          profile.first_name = auth['info']['first_name']
          profile.last_name = auth['info']['last_name']
          profile.picture_url = auth['info']['image']
          profile.email = auth['info']['email']
        when 'facebook'
          profile.name = auth['info']['name']
          profile.picture_url = auth['info']['image']
          p "auth['info']['name']:"
          p auth['info']['name']
          p "profile:"
          p profile
      end

      #profile.avatar_from_url auth['info']['image']
      #profile.avatar.save rescue nil
      profile.save
      user.save
      user
    end
  end

  def short_name
    name.split(' ').first
  end

  def picture_url
    self.profile.picture_url
  end
end
