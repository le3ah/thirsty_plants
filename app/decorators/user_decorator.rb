class UserDecorator < Draper::Decorator
  delegate_all

  def show_gardens
    if object.gardens.count > 0
      get_gardens
    else
      h.content_tag(:h3, 'No Gardens Created Yet!')
    end.html_safe
  end
  
  def get_gardens
    object.gardens.map do |garden|
      h.content_tag(:div, show_single_garden(garden),
       garden_formatting(garden))
    end.join("\n")
  end
  
  def show_single_garden(garden)
    h.content_tag(:div, (h.content_tag(:h3, h.link_to(garden.name, h.garden_path(garden))) + h.content_tag(:h3, garden.zip_code)))
  end
  
  def garden_formatting(garden)
    {class: "garden", id: "garden-#{garden.id}"}
  end

  
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
