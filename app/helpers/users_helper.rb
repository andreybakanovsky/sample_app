module UsersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    size = options[:size]
    default = "identicon"
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?d=#{default}&s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: 'gravatar')
  end
end
