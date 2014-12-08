require 'spec_helper'

describe Chewy::Search do
  before do
    stub_index(:products) do
      define_type :product
      define_type :product2
    end
  end

  let(:product) { ProductsIndex::Product }

  describe '.search_string' do
    specify do
      expect(ProductsIndex.client).to receive(:search).with(hash_including(q: 'hello')).twice
      ProductsIndex.search_string('hello')
      product.search_string('hello')
    end

    specify do
      expect(ProductsIndex.client).to receive(:search).with(hash_including(explain: true)).twice
      ProductsIndex.search_string('hello', explain: true)
      product.search_string('hello', explain: true)
    end

    specify do
      expect(ProductsIndex.client).to receive(:search).with(hash_including(index: ['products'], type: []))
      ProductsIndex.search_string('hello')
    end

    specify do
      expect(ProductsIndex.client).to receive(:search).with(hash_including(index: ['products'], type: ['product']))
      product.search_string('hello')
    end
  end
end
