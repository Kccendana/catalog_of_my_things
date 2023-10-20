require_relative '../inc_helper'

RSpec.describe Genres do
  before(:each) do
    @genre = Genres.new('Action')
    @item = Items.new('2010-10-11')
    @genre.add_item(@item)
  end

  it 'Have initial state' do
    expect(@genre.id).to be_a(Integer)
    expect(@genre.name).to eq('Action')
    expect(@genre.items).to include(@item)
  end

  it 'Should be associated with an item' do
    expect(@item.genre).to eq(@genre)
  end

  it 'Can add an item to the genre' do
    new_item = Items.new('2022-01-01')
    @genre.add_item(new_item)
    expect(@genre.items).to include(new_item)
    expect(new_item.genre).to eq(@genre)
  end
end
