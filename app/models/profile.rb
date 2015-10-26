class Profile < ActiveRecord::Base
  belongs_to :user

  has_attached_file :avatar, styles: { original: '83x83' },
    path: ':rails_root/log/users_data/:attachment/:id/:style/:filename',
    url: '/assets/:attachment/:id/:style/:filename',
    default_url: "/assets/null.png"

  validates_attachment :avatar,
                       content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
                       size: { in: 0..1.megabytes }

  def avatar_from_url(url)
    self.avatar = URI.parse(url) rescue nil
  end

end
