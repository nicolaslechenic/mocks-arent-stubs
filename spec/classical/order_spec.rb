RSpec.describe Store::Order do
  context 'with 50 playstation added into warehouse' do
    let(:product)   { Store::Product.new(uniq_name: 'Playstation') }
    let(:warehouse) { Store::Warehouse.new }

    before { warehouse.add(product: product, amount: 50) }

    it 'remove specified number of products when enough into Warehouse' do
      current_order = described_class.new(product: product, amount: 50)
      current_order.pull(warehouse)

      expect(current_order.pulled?).to eq(true)
      expect(warehouse.inventory(product)).to eq(0)
    end

    it 'remove nothing for not enough product into Warehouse' do
      current_order = described_class.new(product: product, amount: 51)
      current_order.pull(warehouse)

      expect(current_order.pulled?).to eq(false)
      expect(warehouse.inventory(product)).to eq(50)
    end
  end
end
