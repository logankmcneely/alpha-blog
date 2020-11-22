# These are helper functions connected to the views. Will not work in other
# places like controllers, or models

module ApplicationHelper

  def get_header
    case request.path
    when articles_path
      "Articles"
    else
      "Alpha Blog"
    end
  end
  
end
