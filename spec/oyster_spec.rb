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
  describe "#touch_in" do
    it "changes value of in_journey to true" do
      oystercard.top_up(5)
      oystercard.touch_in("Oxford Road")
      expect(oystercard.in_journey?).to eq(true)
    end
    it "raises an error if balance is below #{OysterCard::MINIMUM}" do
      expect { oystercard.touch_in("Oxford Road") }.to raise_error("Balance below #{OysterCard::MINIMUM}!")
    end
  end

  describe "#touch_out" do
    it "changes value of in_journey to false" do
      oystercard = OysterCard.new(balance: 5)
      oystercard.touch_out("piccadilly")
      expect(oystercard.in_journey?).to eq(false)
    end
    it "deducts the minimum fare from balace" do
      oystercard.top_up(1)
      expect { oystercard.touch_out("Afganistan") }.to change{ oystercard.balance }.by(-OysterCard::MINIMUM)
      
    end
    
  end
  describe "#in_journey?" do
    it "states whether it's in a journey" do
      oystercard = OysterCard.new(balance: 5)
      oystercard.touch_in("Oxford Road", 4)
      expect(oystercard.in_journey?).to eq(true)
    end
  end
  describe "#journeys" do
    it "returns an empty list when it is initially called" do
      expect(oystercard.journeys).to(eq([]))
    end
    it "records 1 set of entry and exit stations and returns them on demand" do
      oystercard.top_up(50)
      oystercard.touch_in("Oxford Road", 1)
      oystercard.touch_out("Piccadilly", 2)
      expect(oystercard.journeys).to eq([{entry: Station.new("Oxford Road", 1), exit: Station.new("Piccadilly", 2}])
    end
    it "records several sets of entry and exit stations and returns them on demand" do
      oystercard.top_up(50)
      3.times {
      oystercard.touch_in("Oxford Road", 1)
      oystercard.touch_out("Piccadilly", 2)
              }
      oystercard.touch_in("Piccadilly", 2)
      oystercard.touch_out("Oxford Road", 1)
      expect(oystercard.journeys).to eq([
        {entry: Station.new("Oxford Road", 1), exit: Station.new("Piccadilly", 2}, 
        {entry: Station.new("Oxford Road", 1), exit: Station.new("Piccadilly", 2}, 
        {entry: Station.new("Oxford Road", 1), exit: Station.new("Piccadilly", 2}, 
        {entry: Station.new("Piccadilly", 2}, exit: Station.new("Oxford Road", 1)}
        ])
    end
  end
end