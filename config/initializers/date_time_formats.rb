Time::DATE_FORMATS.merge!(
  :full => '%B %d, %Y at %I:%M %p',
  :md => '%m/%d',
  :mdy => '%m/%d/%y',
  :time => '%I:%M %p',
  :pretty => lambda { |time| time.strftime("%a, %b %e at %l:%M") + time.strftime("%p").downcase }
)