require 'dice'

describe Dice do
  describe 'roll' do
    it 'returns a random number from 1 to 6' do
      allow(subject).to receive(:rand).and_return(6)
      expect(subject.roll_dice).to eq(6)
    end
  end
end