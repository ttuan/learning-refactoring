require 'ostruct'

class OrderReport
  def initialize(orders, date_range)
    @date_range = date_range
    @orders = orders
  end

  def total_sales_within_date_range
    orders_with_range.sum(&:amount)
  end

  private

  def orders_with_range
    @orders.select { |order| @date_range.include?(order.placed_at) }
  end
end

class DateRange < Struct.new(:start_date, :end_date)
  def include?(date)
    (start_date..end_date).cover?(date)
  end
end

class Order < OpenStruct
end
