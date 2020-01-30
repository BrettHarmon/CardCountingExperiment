NUMBER_OF_GAMES = 1000
require_relative 'deck.rb'
require_relative 'player.rb'
class Game
  @@players = Array.new
  attr_accessor :numPlayers, :dealer, :gameCount, :deck, :cheater
  def initialize(numberOfPlayers)
    @dealer = Player.new("DEALER")
    @cheater = Player.new("COUNTER")
    @gameCount = 0
    @numPlayers = numberOfPlayers
    @deck = Deck.new
    for i in 1..numberOfPlayers
      @@players << Player.new("Player#"<< i.to_s)
    end
    puts @@players.length.to_s << " players created"
    puts @deck.size.to_s << " cards in deck"
  end
  def players
    return @@players
  end
end

g = Game.new(3)

for rounds in 1..NUMBER_OF_GAMES
  if(g.deck.size < 52)
    break;
  end
  cards = g.deck.stack.pop(2)
  g.dealer.dealIn(cards)
  cards.each{|x| g.deck.countCards(x)}

  for pidx in 0..g.numPlayers-1
    player = g.players[pidx]
    cards = g.deck.stack.pop(2)
    player.dealIn(cards)
    cards.each{|x| g.deck.countCards(x)}
    while g.dealer.hit?
      g.dealer.hitMe(g.deck.countCards(g.deck.stack.pop))
    end
  end

  cards = g.deck.stack.pop(2)
  g.cheater.dealIn(cards)
  cards.each{|x| g.deck.countCards(x)}
  while g.cheater.hit?
    g.cheater.hitMe(g.deck.countCards(g.deck.stack.pop))
  end

  while g.dealer.hit?
    g.dealer.hitMe(g.deck.countCards(g.deck.stack.pop))
  end

  # Check win condition
  g.players.each{|x|
    if(x.total > 21)
    # loss
    elsif(g.dealer.total > 21)
    x.wins += 1;
    elsif(x.total == g.dealer.total)
      x.draws += 1
    elsif(x.total > g.dealer.total)
    x.wins += 1
    end

  }

  bet = g.cheater.bettingUnit
  bet *= g.deck.trueCount - 1
  if(g.deck.count < 0)
    bet = 5;
  end



  if(g.cheater.win?(g.dealer.total))
      g.cheater.money += bet*2;
  else
      g.cheater.money -= bet;
  end
  puts "Betting $"<< bet.to_s

  puts "Games count " << g.deck.trueCount.to_s << " basic count:"<<g.deck.count.to_s
  g.gameCount += 1;
end

g.players.each{|x| puts x.playerId << " has won " << x.wins.to_s << " games, with " << x.draws.to_s << " ties"}
puts g.gameCount.to_s << " games played"
puts g.cheater.money
