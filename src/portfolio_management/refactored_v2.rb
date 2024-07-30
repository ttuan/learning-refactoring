# Portfolio Class
class Portfolio
  attr_reader :owner, :investments, :value

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

# Investment Class
class Investment
  attr_reader :type, :amount, :value

  def initialize(type, amount)
    @type = type
    @amount = amount
    @value = calculate_value
  end

  private

  def calculate_value
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

# ReportGenerator Class
class ReportGenerator
  def self.generate(portfolio)
    "Report for #{portfolio.owner}: Total Value: $#{portfolio.value}. Investments: #{portfolio.investments.map { |inv| "#{inv.type} - $#{inv.amount}" }.join(', ')}"
  end
end

# Example usage
portfolio1 = Portfolio.new("Alice")
portfolio1.add_investment(Investment.new("stocks", 10000))
portfolio1.add_investment(Investment.new("bonds", 5000))
puts ReportGenerator.generate(portfolio1)

portfolio2 = Portfolio.new("Bob")
portfolio2.add_investment(Investment.new("real_estate", 20000))
puts ReportGenerator.generate(portfolio2)

portfolio3 = Portfolio.new("Charlie")
portfolio3.add_investment(Investment.new("stocks", 15000))
portfolio3.add_investment(Investment.new("bonds", 8000))
portfolio3.add_investment(Investment.new("real_estate", 30000))
puts ReportGenerator.generate(portfolio3)

portfolio4 = Portfolio.new("Dana")
portfolio4.add_investment(Investment.new("stocks", 7000))
puts ReportGenerator.generate(portfolio4)

portfolio5 = Portfolio.new("Eve")
portfolio5.add_investment(Investment.new("bonds", 6000))
portfolio5.add_investment(Investment.new("real_estate", 10000))
puts ReportGenerator.generate(portfolio5)
