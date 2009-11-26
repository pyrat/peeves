module Peeves
  class Money
    def initialize(amount, currency)
      @amount = amount.to_f
      @currency = currency
    end
    
    attr_accessor :amount, :currency
  end
end