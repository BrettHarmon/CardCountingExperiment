NUM_OF_DECKS = 150
class Deck
  @@deck = Array.new
  attr_accessor :count

  def initialize()
    @count = 0
    for l in 1..NUM_OF_DECKS
      for i in 0..51 do
        value = (i/4+1).to_i

        @@deck << cardFactory(value)

      end
    end
    @@deck.shuffle!.shuffle!.shuffle!.shuffle!
    #@@deck.each { |x| puts x.printInfo}

  end

  def countCards(card)
    case card.value
      when 1..6
        @count += 1
      when 10..11
        @count -= 1
    end
    return card
  end

  def cardFactory(num)
    case num
      when 2..10
        return Card.new(num.to_s,num)
      when 11
        return Card.new("J", 10)
      when 12
        return Card.new("Q", 10)
      when 13
        return Card.new("K", 10)
      when 1
        return Card.new("A", 11)
    end

  end
  # True count
  def trueCount
    if(size == 0)
      return 0
    end
    return (@count*2 / ((size/52.0).ceil)).ceil.to_f / 2

  end
  # Get deck size
  def size
    return @@deck.length
  end
  # Get deck
  def stack
    return @@deck
  end

end

class Card
  attr_accessor :display, :value

  def initialize(display,value)
    @display = display
    @value = value
  end


  def display
    return @display
  end
  def value
    return @value
  end

  def printInfo
    return "Value: " << @value.to_s << "  -Display: " << @display
  end
  def to_s
    return printInfo
  end
end
