require 'rspec'
require_relative 'refactored'

RSpec.describe 'printReport' do
  describe '#printReport' do
    it 'prints a report with expenses' do
      breakfast = Expense.new(ExpenseType::BREAKFAST, 1000)
      dinner = Expense.new(ExpenseType::DINNER, 6000)
      car_rental = Expense.new(ExpenseType::CAR_RENTAL, 3000)
      expenses = [breakfast, dinner, car_rental]
      report = Report.new(expenses)

      expected_output = /Expenses: .*?\nBreakfast\t1000\t\nDinner\t6000\tX\nCar Rental\t3000\t\nMeal Expenses: 7000\nTotal Expenses: 10000\n/m

      expect { ReportPrinter.new(report).print }.to output(expected_output).to_stdout
    end

    it 'prints a report with no expenses' do
      expected_output = /Expenses: .*?\nMeal Expenses: 0\nTotal Expenses: 0\n/m
      report = Report.new([])

      expect { ReportPrinter.new(report).print }.to output(expected_output).to_stdout
    end

    it 'prints a report with only meal expenses' do
      breakfast = Expense.new(ExpenseType::BREAKFAST, 1200)
      dinner = Expense.new(ExpenseType::DINNER, 4000)
      expenses = [breakfast, dinner]
      report = Report.new(expenses)

      expected_output = /Expenses: .*?\nBreakfast\t1200\tX\nDinner\t4000\t\nMeal Expenses: 5200\nTotal Expenses: 5200\n/m

      expect { ReportPrinter.new(report).print }.to output(expected_output).to_stdout
    end

    it 'prints a report with only non-meal expenses' do
      car_rental = Expense.new(ExpenseType::CAR_RENTAL, 3000)
      expenses = [car_rental]
      report = Report.new(expenses)

      expected_output = /Expenses: .*?\nCar Rental\t3000\t\nMeal Expenses: 0\nTotal Expenses: 3000\n/m

      expect { ReportPrinter.new(report).print }.to output(expected_output).to_stdout
    end
  end
end
