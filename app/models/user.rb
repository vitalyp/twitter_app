class User < ActiveRecord::Base

  has_one :profile, dependent: :destroy
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

      profile.name = auth['info']['name'] rescue nil
      profile.first_name = auth['info']['first_name'] rescue nil
      profile.last_name = auth['info']['last_name'] rescue nil
      profile.picture_url = auth['info']['image'] rescue nil
      profile.email = auth['info']['email'] rescue nil

      profile.avatar_from_url auth['info']['image']
      profile.avatar.save rescue nil
      profile.save
      user.save
      user
    end
  end

  def username
    "userName"
    #self.email.split(/@/).first
  end

  def to_param
    "#{id} #{username}".to_slug.normalize.to_s
  end

end
