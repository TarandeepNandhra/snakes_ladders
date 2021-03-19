require 'dice'

class SnakesLadders

  attr_reader :player_1_pos, :player_2_pos

  JUMPS = {
    2 => 38, 7 => 14, 8 => 31, 15 => 26, 21 => 42, 
    36 => 44, 51 => 67, 71 => 91, 78 => 98, 87 => 94, 
    16 => 6, 46 => 25, 49 => 11, 62 => 19, 64 => 60, 
    74 => 53, 89 => 68, 92 => 88, 95 => 75, 99 => 80
  }

  def initialize(dice = Dice.new)
    @dice = dice
    @player_1_pos = 0
    @player_2_pos = 0
    @who = 0
  end

  def who
    @who = 1 - @who
  end

  def roll
    roll_1 = @dice.roll_dice
    roll_2 = @dice.roll_dice
    return roll_1 + roll_2, roll_1 == roll_2
  end

  def jump?
    JUMPS.keys.include?(@player_1_pos) if @who == 0
    JUMPS.keys.include?(@player_2_pos)  
  end

  def bounce
    if @who == 0
      @player_1_pos -= 2 * (@player_1_pos % 100) if @player_1_pos > 100
    end
    @player_2_pos -= 2 * (@player_2_pos % 100) if @player_2_pos > 100
  end

  def play_game
    total_roll, extra_turn? = roll
    # check if position + roll is 100?
    # if not then update position
    # check if over100 -> bounce

    # if at a jump location
    update_position(JUMPS[jump_pos]) if jump?

    who unless extra_turn?

  end

  private

  def jump_pos
    JUMPS[@player_1_pos] if who == 0
    JUMPS[@player_2_pos]
  end

  def update_position(position)
    @player_1_pos = position if who == 0
    @player_2_pos = position
  end

end
