require 'date'

class Offset
  attr_reader :date

  def initialize(date)
    @date = date ||= generate_date
  end

  def create_offsets
    ((date.to_i) ** 2).to_s.split('').last(4)
  end

  def generate_date
    Date.today.strftime('%d%m%y')
  end
end
