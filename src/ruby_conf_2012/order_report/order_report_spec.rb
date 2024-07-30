require 'rspec'
require 'date'
require_relative 'original'

RSpec.describe OrderReport do

  describe '#total_sales_within_date_range' do
    let(:orders) do
      [
        Order.new(placed_at: Date.new(2024, 07, 01), amount: 10),
        Order.new(placed_at: Date.new(2024, 07, 11), amount: 3),
        Order.new(placed_at: Date.new(2024, 05, 22), amount: 2),
        Order.new(placed_at: Date.new(2024, 06, 3), amount: 9),
      ]
    end

    it 'returns the total sales within a date range' do
      start_date = Date.new(2024, 07, 01)
      end_date = Date.new(2024, 07, 11)

      date_range = DateRange.new(start_date, end_date)
      order_report = OrderReport.new(orders, date_range)

      expect(order_report.total_sales_within_date_range).to eq(13)
    end
  end

end
