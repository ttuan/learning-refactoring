class OrderReport
  attr_reader :orders, :date_range

  def initialize(orders, date_range)
    @orders = orders
    @date_range = date_range
  end

  def total_sales_within_date_range
    orders_with_range.sum(&:amount)
  end

  private

  def orders_with_range
    orders.select { |order| date_range.include?(order.placed_at) }
  end
end

class DateRange < Struct.new(:start_date, :end_date)
  def include?(date)
    (start_date..end_date).cover?(date)
  end
end

class Order
  attr_reader :placed_at, :amount

  def initialize(placed_at: , amount:)
    @placed_at = placed_at
    @amount = amount
  end
end
