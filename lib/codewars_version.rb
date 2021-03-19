class SnakesLadders

  attr_reader :player_1_pos, :player_2_pos

  JUMPS = {
    2 => 38, 7 => 14, 8 => 31, 15 => 26, 21 => 42, 
    36 => 44, 51 => 67, 71 => 91, 78 => 98, 87 => 94, 
    16 => 6, 46 => 25, 49 => 11, 62 => 19, 64 => 60, 
    74 => 53, 89 => 68, 92 => 88, 95 => 75, 99 => 80
  }

  def initialize
    @player_1_pos = 0
    @player_2_pos = 0
    @last_turn = 0
    @who = 0
  end

  def play(die1, die2)
    return "Game over!" if @player_1_pos == 100 || @player_2_pos == 100

    move_up_board(total_roll(die1, die2))

    return win_game if check_winner?
    bounce if over_100?
    
    update_position(jump_pos) if jump?

    last_turn
    who unless extra_turn?(die1, die2)
    outcome
  end
  
  def outcome
    return "Player 1 is on square #{@player_1_pos}" if @last_turn == 0
    "Player 2 is on square #{@player_2_pos}"
  end

  def move_up_board(amount)
    return @player_1_pos += amount if @who == 0
    @player_2_pos += amount
  end

  def bounce
    if @who == 0
      return @player_1_pos -= 2 * (@player_1_pos % 100) if @player_1_pos > 100
    end
    @player_2_pos -= 2 * (@player_2_pos % 100) if @player_2_pos > 100
  end

  def jump?
    return JUMPS.keys.include?(@player_1_pos) if @who == 0
    JUMPS.keys.include?(@player_2_pos)
  end



  def win_game
    return "Player 1 Wins!" if @who == 0
    return "Player 2 Wins!"
  end


  private

  def extra_turn?(die1, die2)
    die1 == die2
  end

  def total_roll(die1, die2)
    die1 + die2
  end

  def check_winner?
    player_1_pos == 100 || player_2_pos == 100
  end
  
  def over_100?
    player_1_pos > 100 || player_2_pos > 100
  end
  
  def jump_pos
    return JUMPS[@player_1_pos] if @who == 0
    JUMPS[@player_2_pos]
  end
  
  def update_position(position)
    return @player_1_pos = position if @who == 0
    @player_2_pos = position
  end
  
  def who
    @who = 1 - @who
  end
  
  def last_turn
    @last_turn = @who
  end

end