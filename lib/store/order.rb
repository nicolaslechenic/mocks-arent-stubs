module Store
  class Order
    attr_reader :product, :amount

    def initialize(product:, amount:)
      @product = product
      @amount = amount
    end

    def pull(warehouse)
      return if warehouse.inventory(product) < amount
      @pulled = true
      warehouse.remove(product: product, amount: amount)
    end

    def pulled?
      @pulled || false
    end
  end
end
