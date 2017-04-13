class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    if @prev && @next
      @prev.next = @next
      @next.prev = @prev
    end
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each do |link|
      return link.val if link.key == key
    end
  end

  def include?(key)
    each do |link|
      return true if link.key == key
    end
    false
  end

  def append(key, val)
    new_link = Link.new(key, val)
    if include?(key)
      update(key, val)
    else
      @tail.prev.next = new_link
      new_link.prev = @tail.prev
      new_link.next = @tail
      @tail.prev = new_link
    end
  end

  def update(key, value)
    each do |link|
      link.val = value if link.key == key
    end
  end

  def remove(key)
    each do |link|
      if link && link.key == key
        link.remove
      end
    end
  end

  def each
    start = @head.next

    until start == @tail
      yield(start)
      start = start.next
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
