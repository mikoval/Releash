module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "iShelter"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def display_avatar(user, size)  
    unless user.picture.nil? 
      image_tag( user.picture.url,  :size => size, :class => "small_img")
    else
      image_tag("/images/default.png",  :size => size, :class => "small_img")
     end    
  end

end