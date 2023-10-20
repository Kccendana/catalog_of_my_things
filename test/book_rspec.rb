require_relative '../inc_helper'
RSpec.describe Book do
  before(:each) do
    @book = Book.new('New Label', '2022-01-01', 'bad')
  end

  describe '.from_json' do
    it 'creates a Book object from JSON data' do
      json_data = {
        'label' => 'New Label',
        'published_date' => '2022-01-01',
        'cover_state' => 'bad',
        'archived' => true
      }.to_json

      new_book = described_class.from_json(json_data)

      expect(new_book.label).to eq('New Label')
      expect(new_book.published_date).to eq(Date.parse('2022-01-01'))
      expect(new_book.cover_state).to eq('bad')
      expect(new_book.archived).to eq(true)
    end
  end
end
