class ExpenseType
  attr_reader :name, :limit, :meal

  def initialize(name, limit, meal)
    @name = name
    @limit = limit
    @meal = meal
  end

  BREAKFAST = new("Breakfast", 1000, true)
  LUNCH = new("Lunch", 0, true)
  DINNER = new("Dinner", 5000, true)
  CAR_RENTAL = new("Car Rental", 0, false)
end

class Expense
  attr_reader :type, :amount

  def initialize(type, amount)
    @type = type
    @amount = amount
  end

  def name
    type.name
  end

  def meal?
    type.meal
  end

  def over_limit?
    type.limit > 0 && amount > type.limit
  end
end

class Report
  attr_accessor :expense_items, :total_expenses, :meal_expenses

  def initialize(expenses)
    @expense_items = []
    @total_expenses = 0
    @meal_expenses = 0

    post_initialize(expenses)
  end

  def post_initialize(expenses)
    expenses.each do |expense|
      @expense_items << expense

      @total_expenses += expense.amount
      @meal_expenses += expense.amount if expense.meal?
    end
  end
end

class ReportPrinter
  attr_reader :report

  MARK = "X"
  NO_MARK = ""

  def initialize(report)
    @report = report
  end

  def print
    # Header
    puts "Expenses: #{Time.now}"

    # Body/Detail
    report.expense_items.each do |expense|
      puts "#{expense.name}\t#{expense.amount}\t#{expense.over_limit? ? MARK : NO_MARK}"
    end

    # Footer
    puts "Meal Expenses: #{report.meal_expenses}"
    puts "Total Expenses: #{report.total_expenses}"
  end
end
