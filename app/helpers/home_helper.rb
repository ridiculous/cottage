module HomeHelper
  def section_header(title)
    content_tag(:div, class: 'section') do
      content_tag(:div, class: 'wrapper') do
        concat link_to('', '#', {name: title.underscore.downcase})
        concat content_tag(:h3, title)
      end
    end
  end
end