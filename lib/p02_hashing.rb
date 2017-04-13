class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    copy = self.dup
    result = 0
    until copy.empty?
      result += copy.pop.hash
      result -= copy.pop.hash unless copy.empty?
      result %= copy.pop.hash unless copy.empty?
    end

    result
  end
end

class String
  def hash
    copy = self.dup
    result = 0
    until copy.length == 0
      result += copy[-1].ord if copy[-1]
      copy = copy[0...-1]
      result *= copy[-1].ord if copy[-1]
      copy = copy[0...-1]
      result /= copy[-1].ord if copy[-1]
      copy = copy[0...-1]
    end

    result
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    result = []
    self.each do |key, val|
      key.to_s.each_char do |char|
        result << char.ord
      end
      val.to_s.each_char do |char|
        result << char.ord
      end
    end

    result.sort!
    result.hash
  end
end
