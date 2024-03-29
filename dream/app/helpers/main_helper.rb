module MainHelper
  def prepare_post_body( content )
    content = h(content)
    # Stip out html tags.
    content = strip_tags(content)
    # Look for line returns.  When it finds one it will put a <br />.  If it finds 2 line returns it will put <p> tags.
    content = simple_format(content)
    #content = auto_link(content)
    return content
  end
  
  def strip_zeros_from_date(marked_date_string)
    marked_date_string.gsub('*0', '').gsub('*', '')
  end
  
  def use_relative_time(time)
    return "Unknown" if time.nil?
    interval = Time.now - time
    secs = interval.to_i
    mins = (interval/60).to_i
    hours = (interval/(60*60)).to_i
    days = (interval/(60*60*24)).to_i
    
    case
    when days == 0 && hours == 0 && mins == 0
      return "#{pluralize(secs, 'second')} ago"
    when days == 0 && hours == 0
      return "#{pluralize(mins, 'minute')} ago"
    when days == 0
      return "#{pluralize(hours, 'hour')} ago"
    else
      return "#{pluralize(days, 'day')} ago"
    end
  end
end
