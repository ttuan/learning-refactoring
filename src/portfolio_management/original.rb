class Portfolio
  attr_accessor :owner, :investments, :value

  def initialize(owner)
    @owner = owner
    @investments = []
    @value = 0
  end

  def add_investment(investment)
    @investments << investment
    @value += investment.value
  end
end

class Investment
  attr_reader :type, :amount

  def initialize(type, amount)
    @type = type
    @amount = amount
  end

  def value
    case @type
    when "stocks"
      @amount * 1.2
    when "bonds"
      @amount * 1.1
    when "real_estate"
      @amount * 1.5
    else
      @amount
    end
  end
end

class Report
  def self.generate_report(portfolio)
    "Report for #{portfolio.owner}: Total Value: $#{portfolio.value}. Investments: #{portfolio.investments.map { |inv| "#{inv.type} - $#{inv.amount}" }.join(', ')}"
  end
end

# Example usage
system = PortfolioManagementSystem.new
portfolio3 = Portfolio.new("Charlie")

stock_investment = Investment.new("stocks", 15000)
portfolio3.add_investment(stock_investment)

bond_investment = Investment.new("bonds", 8000)
portfolio3.add_investment(bond_investment)

real_estate_investment = Investment.new("real_estate", 30000)
portfolio3.add_investment(real_estate_investment)

puts system.generate_report(portfolio3)
