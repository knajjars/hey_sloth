class TrueClass
  def yesno
    'Yes'
  end
end

class FalseClass
  def yesno
    'No'
  end
end

class String
  def titlecap
    gsub(/\b('?[a-z])/) { Regexp.last_match(1).capitalize }
  end
end
