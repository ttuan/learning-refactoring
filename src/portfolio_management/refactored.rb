require 'pry'

class Portfolio
  attr_accessor :investments, :value
  attr_reader :owner

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

class Report
  def self.generate_report(portfolio)
    "Report for #{portfolio.owner}: Total Value: $#{portfolio.value}. Investments: #{portfolio.investments.map { |inv| "#{inv.name} - $#{inv.amount}" }.join(', ')}"
  end
end

class Investment
  attr_reader :amount

  def initialize(amount)
    @amount = amount
  end

  def name
    ""
  end

  def value
    amount
  end
end

class Stocks < Investment
  BASE_PERFORMANCE = 1.2

  def name
    "stocks"
  end

  def value
    amount * BASE_PERFORMANCE
  end
end

class Bond < Investment
  BASE_PERFORMANCE = 1.1

  def name
    "bonds"
  end
  def value
    amount * BASE_PERFORMANCE
  end
end

class RealEstate < Investment
  BASE_PERFORMANCE = 1.5

  def name
    "real_estate"
  end

  def value
    amount * BASE_PERFORMANCE
  end
end
