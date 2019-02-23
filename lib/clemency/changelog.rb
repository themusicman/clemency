class Changelog

  attr_reader :items

  def initialize
    @items = Hash.new { |h, k| h[k] = [] }
  end

  def fixed(item)
    @items[:fixed] << item
  end

  def added(item)
    @items[:added] << item
  end

  def changed(item)
    @items[:changed] << item
  end

  def to_markdown
    @items.map do |type, items|
      "####{type.upcase}\n" + items.map { |item| "- #{item}"}.join("\n")
    end.join("\n\n")
  end

end
