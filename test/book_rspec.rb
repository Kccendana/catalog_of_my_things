require_relative '../inc_helper'
RSpec.describe Book do
  before(:each) do
    @book = Book.new('New Label', 'Publisher Name', '2022-01-01', 'bad')
  end

  describe '#to_hash' do
    it 'returns the book data as a hash' do
      hash_data = @book.to_hash

      expect(hash_data['label']).to eq('New Label')
      expect(hash_data['published_date']).to eq('2022-01-01')
      expect(hash_data['cover_state']).to eq('bad')
      expect(hash_data['can_be_archived']).to eq(true)
    end
  end

  describe '.from_json' do
    it 'creates a Book object from JSON data' do
      json_data = {
        'label' => 'New Label',
        'publisher' => 'Publisher Name',
        'published_date' => '2022-01-01',
        'cover_state' => 'bad'
      }.to_json

      new_book = described_class.from_json(json_data)

      expect(new_book.label).to eq('New Label')
      expect(new_book.publisher).to eq('Publisher Name')
      expect(new_book.published_date.to_s).to eq('2022-01-01')
      expect(new_book.cover_state).to eq('bad')
      expect(new_book.archived).to eq(true)
    end
  end

  describe '#can_be_archived?' do
    it 'checks if the book can be archived' do
      @book.cover_state = 'bad'
      expect(@book.can_be_archived?).to eq(true)
      @book.cover_state = 'good'
      expect(@book.can_be_archived?).to eq(false)
    end
  end
end
