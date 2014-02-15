class DateRange
  attr_reader :start_at, :end_at, :errors

  class << self
    def convert(the_date)
      the_date.gsub(%r{(\d{2})/(\d{2})/(\d+)}, '\3-\1-\2')
    end
  end

  def initialize(start_at=nil, end_at=nil)
    @start_at = start_at
    @end_at = end_at
    @errors = []
  end

  def to_date!
    convert!
    @start_at = Date.parse(start_at) rescue nil
    @end_at = Date.parse(end_at) rescue nil
  end

  def convert!
    @start_at = convert(start_at)
    @end_at = convert(end_at)
  end

  def convert(the_date)
    self.class.convert(the_date)
  end

  def validate
    @errors = []
    if !start_at
      errors << 'Please enter an arrival date'
    elsif !end_at
      errors << 'Please enter a departure date'
    elsif start_at > end_at
      errors << 'Departure date should be later than arrival date'
    elsif start_at < Date.today
      errors << 'You should really plan for a trip in the future instead of the past'
    end
  end

  def valid?
    validate
    errors.blank?
  end

  def open?
    Calendar.check_availability(start_at, end_at)
  end

  def diff_days
    (end_at - start_at).to_i
  end

end
