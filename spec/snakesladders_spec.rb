require 'snakesladders'

describe SnakesLadders do
  describe 'who' do
    it 'alternates between 0 and 1, player 1 and 2' do
      expect(subject.who).to eq(1)
      expect(subject.who).to eq(0)
      expect(subject.who).to eq(1)
      expect(subject.who).to eq(0)
    end
  end

  describe 'roll' do
    it 'returns the total of two rolled dice and t/f if dice equal' do
      dice = double(roll_dice: 5)
      snakes = SnakesLadders.new(dice)
      expect(snakes.roll).to eq([10, true])
    end
  end

  describe 'jump?' do
    it 'checks if player at the base of a ladder, or the mouth of a snake' do
      expect(subject.jump?).to eq(false)
      subject.who
      subject.instance_variable_set(:@player_2_pos, 2)
      expect(subject.jump?).to eq(true)
    end
  end

  describe 'bounce' do
    it 'bounces the player if they overshoot 100 by how much they overshoot' do
      dice = double(roll_dice: 5)
      snakes = SnakesLadders.new(dice)
      # player1 was at 95, they then rolled a 10
      snakes.instance_variable_set(:@player_1_pos, 105)
      expect { snakes.bounce }.to change { snakes.player_1_pos }.by -10
      expect { subject.bounce }.to change { subject.player_1_pos }.by 0
    end
  end

  # describe 'win_game' do
  #   it 'checks if either player has won the game' do
  #     subject.instance_variable_set(:@player_2_pos, 100)
  #     expect(subject.win_game).to eq("Player 2 Wins!")
  #   end
  # end

end