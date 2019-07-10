require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  before do
    items = [
      Item.new(name='+5 Dexterity Vest', sell_in=10, quality=20),
      Item.new(name='Aged Brie', sell_in=2, quality=0),
      Item.new(name='Elixir of the Mongoose', sell_in=5, quality=7),
      Item.new(name='Sulfuras, Hand of Ragnaros', sell_in=0, quality=80),
      Item.new(name='Sulfuras, Hand of Ragnaros', sell_in=-1, quality=80),
      Item.new(name='Backstage passes to a TAFKAL80ETC concert', sell_in=15, quality=20),
      Item.new(name='Backstage passes to a TAFKAL80ETC concert', sell_in=10, quality=20),
      Item.new(name='Backstage passes to a TAFKAL80ETC concert', sell_in=5, quality=20),
      # This Conjured item does not work properly yet
      Item.new(name='Conjured Mana Cake', sell_in=3, quality=6), # <-- :O
    ]
    @gilded_rose = GildedRose.new items
    @gilded_rose.update_quality
  end
  
  describe '#update_quality' do
    context 'When item is "Aged Brie" and sell_in is less than 5' do
      it 'quality should be increased by 3' do
        expect(@gilded_rose.items[1].quality).to eq(3)
      end
    end

    context 'When item is "Sulfuras"' do
      it 'quantity should be 80' do
        expect(@gilded_rose.items[3].quality).to eq(80)
      end
    end

    context 'When item is "Backstage passes"' do
      context 'and sell_in is great than 10' do
        it 'quantity should be increased by 1' do
          expect(@gilded_rose.items[5].quality).to eq(21)
        end
      end

      context 'and sell_in is 10 or less than 10' do
        it 'quantity should be increased by 2' do
          expect(@gilded_rose.items[6].quality).to eq(22)

        end
      end

      context 'and sell_in is 5 or less than 5' do
        it 'quantity should be increased by 3' do
          expect(@gilded_rose.items[7].quality).to eq(23)
        end
      end
    end

    context 'When item is "Conjured"' do
      it 'quantity should be degraded by 2' do
        expect(@gilded_rose.items[8].quality).to eq(4)
      end
    end
  end
end
