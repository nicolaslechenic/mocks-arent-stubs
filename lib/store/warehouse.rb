module Store
  class Warehouse
    TYPES =
      {
        'input'  => '+',
        'output' => '-'
      }.freeze

    class << self
      def total(products)
        inputs, outputs =
          TYPES.map do |_, value|
            selected_types = products.select { |tx| tx[:type] == value }
            selected_types.map { |product| product[:amount] }.inject(:+) || 0
          end

        inputs - outputs
      end
    end

    def initialize
      @history = []
    end

    def add(product:, amount:)
      return unless amount > 0
      input(product_name: product, amount: amount)
    end

    def remove(product:, amount:)
      return if inventory(product) < amount
      output(product_name: product, amount: amount)
    end

    def inventory(product)
      products = @history.select { |tx| tx[:product_name] == product[:uniq_name] }

      self.class.total(products)
    end

    private

    def input(product_name:, amount:)
      @history << {
        product_name: product_name[:uniq_name],
        amount: amount,
        type: TYPES[__callee__.to_s]
      }
    end
    alias output input
  end
end
