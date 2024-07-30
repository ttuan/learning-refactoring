require 'rspec'
require_relative 'original'

RSpec.describe "Sample" do
  describe '#generate_report' do

    it 'should render report' do
      portfolio1 = Portfolio.new("Alice")
      portfolio1.add_investment(Stocks.new(10000))
      portfolio1.add_investment(Bond.new(5000))

      expected_output = "Report for Alice: Total Value: $17500.0. Investments: stocks - $10000, bonds - $5000"

      expect(Report.generate_report(portfolio1)).to eq(expected_output)
    end

    it 'should render report for p2' do
      portfolio2 = Portfolio.new("Bob")
      portfolio2.add_investment(RealEstate.new(20000))

      expected_output = "Report for Bob: Total Value: $30000.0. Investments: real_estate - $20000"

      expect(Report.generate_report(portfolio2)).to eq(expected_output)
    end

    it 'should render report for p3' do
      portfolio3 = Portfolio.new("Charlie")
      portfolio3.add_investment(Stocks.new(15000))
      portfolio3.add_investment(Bond.new(8000))
      portfolio3.add_investment(RealEstate.new(30000))

      expected_output = "Report for Charlie: Total Value: $71800.0. Investments: stocks - $15000, bonds - $8000, real_estate - $30000"

      expect(Report.generate_report(portfolio3)).to eq(expected_output)
    end

    it 'should render report for p4' do
      portfolio4 = Portfolio.new("Dana")
      portfolio4.add_investment(Stocks.new(7000))

      expected_output = "Report for Dana: Total Value: $8400.0. Investments: stocks - $7000"

      expect(Report.generate_report(portfolio4)).to eq(expected_output)
    end

    it 'should render report for p5' do
      portfolio5 = Portfolio.new("Eve")
      portfolio5.add_investment(Bond.new(6000))
      portfolio5.add_investment(RealEstate.new(10000))

      expected_output = "Report for Eve: Total Value: $21600.0. Investments: bonds - $6000, real_estate - $10000"

      expect(Report.generate_report(portfolio5)).to eq(expected_output)
    end
  end
end
