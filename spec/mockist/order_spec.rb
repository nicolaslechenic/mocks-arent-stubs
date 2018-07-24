RSpec.describe Store::Order do
  context 'with 50 playstation added into warehouse' do
    let(:product)         { Store::Product.new(uniq_name: 'Playstation') }
    let(:warehouse_mock)  { instance_double(Store::Warehouse, inventory: 50) }

    it 'remove specified number of products when enough into Warehouse' do
      order = described_class.new(product: product, amount: 50)
      expect(warehouse_mock).to receive(:inventory).with(product).ordered
      expect(warehouse_mock).to receive(:remove).with(product: product, amount: 50).ordered

      order.pull(warehouse_mock)
      expect(order.pulled?).to eq(true)
    end

    it 'remove nothing for not enough product into Warehouse' do
      order = described_class.new(product: product, amount: 51)
      expect(warehouse_mock).to receive(:inventory).with(product).once
      expect(warehouse_mock).to_not receive(:remove)

      order.pull(warehouse_mock)
      expect(order.pulled?).to eq(false)
    end
  end
end
