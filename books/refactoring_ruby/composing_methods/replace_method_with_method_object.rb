class Account
  def gamma(input_val, quantity, year_to_date)
    inportant_value1 = (input_val * quantity) + delta
    important_value2 = (input_val * year_to_date) + 100

    important_thing()

    important_value3 = important_value2 * 7
    # and so on.
    important_value3 - 2 * important_value1
  end
end

#===============================================================================

class Gramma
  attr_reader :account, :input_val, :quantity, :year_to_date

  def initialize(account, input_val, quantity, year_to_date)
    @input_val = input_val
    @quantity = quantity
    @year_to_date = year_to_date
  end

  def compute
    inportant_value1 = (input_val * quantity) + delta

    important_value2 = (input_val * year_to_date) + 100

    important_thing()

    important_value3 = important_value2 * 7
    # and so on.
    important_value3 - 2 * important_value1
  end
end

class Account
  def gramma(input_val, quantity, year_to_date)
    Gramma.new(self, input_val, quantity, year_to_date).compute
  end
end

#===============================================================================


class Account
  def gramma(input_val, quantity, year_to_date)
    Gramma.new(self, input_val, quantity, year_to_date).compute
  end
end

class Gramma
  attr_reader :account, :input_val, :quantity, :year_to_date,
              :important_value1, :important_value2, :important_value3

  def initialize(account, input_val, quantity, year_to_date)
    @input_val = input_val
    @quantity = quantity
    @year_to_date = year_to_date
  end

  def compute
    @inportant_value1 = (input_val * quantity) + delta

    @important_value2 = (input_val * year_to_date) + 100

    important_thing()

    @important_value3 = important_value2 * 7
    # and so on.
    @important_value3 - 2 * important_value1
  end

  private
  def important_thing()
    if (year_to_date - important_value1) > 100
      @important_value2 -= 20
    end
  end
end
