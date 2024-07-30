class User
  def charge_for_subscription
    PaymentGateway.new.charge_for_subscription(self)
  end

  def create_as_customer
    PaymentGateway.new.create_customer(self)
  end
end

class Refund
  def process!
    PaymentGateway.new.refund(order.id, amount)
  end
end

class PaymentGateway
  SUBSCRIPTION_AMOUNT = 10.to_money

  def initialize(gateway = BraintreeGem)
    @gateway = gateway
  end

  def charge_for_subscription(user)
    braintree_id = @gateway.find_user(user.email).braintree_id
    @gateway.charge(braintree_id, SUBSCRIPTION_AMOUNT)
  end

  def create_as_customer(user)
    @gateway.create_customer(user.email)
  end

  def refund(order_id, amount)
    transaction_id = @gateway.find_transaction_id(order_id)
    @gateway.refund(transaction_id, amount)
  end
end
