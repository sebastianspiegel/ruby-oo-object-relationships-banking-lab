require 'pry'

class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status 
  
  def initialize(sender, receiver, amount)
    @sender = sender 
    @receiver = receiver
    @amount = amount 
    @status = "pending" 
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    # use ||= to make only happen once? 
    if self.valid? && sender.balance > amount && @status == "pending"
      sender.balance -= amount
      receiver.balance += amount 
      @status = "complete"
    else 
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
    # binding.pry

  end

  def reverse_transfer
    # can only happen for exectued transfers 
    if @status == "complete"
      sender.balance += @amount
      receiver.balance -= @amount 
      @status = "reversed"
    end
  end
end

