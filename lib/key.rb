module Key
  def generate_key
    rand(9999).to_s.rjust(5, '0')
  end
end
