class Player
  @@hand = Array.new
  attr_accessor :playerId, :hiddenCard, :wins, :draws, :total, :bettingUnit, :money
  def initialize(id)
    @playerId = id
    @wins = 0
    @draws = 0
    @money = 500
    @bettingUnit = 25
  end

  def dealIn(cards)
    @total = 0
    @@hand = Array.new
    @hiddenCard = cards[0]
    cards.each{|x| @total += x.value; @@hand << x}
    puts "Player " << @playerId << " dealt hand with " << cards[1].display << " showing"
  end

  def hit?
    if(total > 16)
      return false;
    end

    return true;
  end

  def hitMe(card)
    @total += card.value
    @@hand << card
    puts "Card with a showing value of " << card.display << " to " << @playerId
  end

  def win?(dealerTotal)
    if(@total > 21)
      return false
    elsif(dealerTotal > 21)
      return true;
    elsif(@total == dealerTotal)
      return false
    elsif(@total > dealerTotal)
      return true
    end
  end


end