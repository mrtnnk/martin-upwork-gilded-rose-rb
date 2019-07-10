class GildedRose

  attr_accessor :items

  SULFURAS  = 'Sulfuras'
  AGED_BRIE = 'Aged Brie'
  BACKSTAGE = 'Backstage passes'
  CONJURED  = 'Conjured'

  ZERO = 0
  TEN  = 10
  FIVE = 5

  QUANTITY_LIMIT = 50

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      next if item.name.start_with?(GildedRose::SULFURAS)
      item.sell_in -= 1

      if item.name.start_with?(GildedRose::AGED_BRIE, GildedRose::BACKSTAGE)
        next unless item.quality < GildedRose::QUANTITY_LIMIT
        item.quality += 1
        item.quality += 1 if item.sell_in <= GildedRose::TEN
        item.quality += 1 if item.sell_in <= GildedRose::FIVE
        next
      end

      next if item.quality <= 0
      item.quality -= 1
      item.quality -= 1 if item.name.start_with? GildedRose::CONJURED || item.sell_in <= GildedRose::ZERO
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
