# rubocop:disable Metrics/LineLength

module MailerHelper
  def primary_background
    'background: #FF6600'
  end

  def font_family
    'font-family: verdana'
  end

  def font_size
    'font-size: 15px'
  end

  def font_size_caption
    'font-size: 20px'
  end

  def padding(value)
    "padding: #{value}px"
  end

  def color(value)
    "color: #{value}"
  end

  def table_attrs
    style 'background: #FFF7F2; width: 100%'
  end

  def td_attrs
    style "#{font_size};#{color('#555555')};#{padding(10)}"
  end

  def caption_attrs
    style "#{font_size_caption};#{color('#FFF')};#{primary_background};#{padding(10)}"
  end

  def style(value)
    { style: "#{font_family};#{value};" }
  end
end
