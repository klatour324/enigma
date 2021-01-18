module Offset

  def create_offset(date)
    offset = ((date.to_i) ** 2).to_s.split('').last(4)
  end
end
