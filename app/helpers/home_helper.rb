module HomeHelper

  def base_rate(date = Date.today)
    if (Date.parse("December 16, 2022")..Date.parse("March 31, 2023")).include?(date)
      '375.00'
    else
      '325.00'
    end
  end

  def cleaning_fee
    '125.00'
  end

  def tax_rate
    0.175
  end

  def tax
    tax_rate * base_rate.to_f
  end

  def section_header(title)
    section_name = title.underscore.downcase
    content_tag(:div, class: 'section-wrap') do
      content_tag(:div, class: 'section') do
        content_tag(:div, class: 'wrapper') do
          concat link_to('', '#', {name: section_name})
          concat content_tag(:h3, title, id: section_name)
        end
      end
    end
  end
end