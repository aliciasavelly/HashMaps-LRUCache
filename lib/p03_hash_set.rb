require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count >= num_buckets
    self[key.hash] << key.hash
    @count += 1
  end

  def include?(key)
    return false if key == [[]]
    self[key.hash].include?(key.hash)
  end

  def remove(key)
    self[key.hash].delete(key.hash)
    @count -= 1
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) { Array.new }
    old_store.each do |bucket|
      bucket.each do |el|
        self[el] << el
      end
    end
  end
end
