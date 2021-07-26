require "OysterCard"

describe OysterCard do
  let(:oystercard) { OysterCard.new }
  describe "#balance" do
    it "should return balance" do
      expect(oystercard.balance).to eq(0)
    end
  end
  describe "#top_up" do
    it "adds money to balance" do
      oystercard.top_up(10)
      expect(oystercard.balance).to(eq(10))
    end
    it "fails when user tops up more than 90" do
      expect { oystercard.top_up(91) }.to raise_error("Balance cannot exceed #{OysterCard::LIMIT}!")
    end
  end
  describe "#deduct" do 
    it "deducts the cost of the ticket" do
      oystercard.top_up(10)
      expect(oystercard.deduct(5)).to(eq(5))
    end
  end
  describe "#touch_in" do
    it "changes value of in_journey to true" do
      oystercard.top_up(5)
      oystercard.touch_in
      expect(oystercard.in_journey).to eq(true)
    end
    it "raises an error if balance is below 1" do
      expect { oystercard.touch_in }.to raise_error("Balance below #{OysterCard::MINIMUM}!")
    end
  end
  describe "#touch_out" do
    it "changes value of in_journey to false" do
      oystercard.touch_out
      expect(oystercard.in_journey).to eq(false)
    end
  end
  describe "#in_journey?" do
    it "states whether it's in a journey" do
      oystercard.top_up(5)
      oystercard.touch_in
      expect(oystercard.in_journey?).to eq(true)
    end
  end

end