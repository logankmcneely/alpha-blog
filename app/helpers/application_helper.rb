# These are helper functions connected to the views. Will not work in other
# places like controllers, or models

module ApplicationHelper

  def gravatar_for(user, options = { size: 80 })
    hash = Digest::MD5.hexdigest(user.email)
    gravatar_url = "https://www.gravatar.com/avatar/hash/#{hash}?s=#{options[:size]}"
    image_tag(gravatar_url, alt: user.username, class: "rounded mx-auto d-block shadow")
  end
  
end
