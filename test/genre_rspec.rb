require_relative '../inc_helper'

RSpec.describe Genres do
  before(:each) do
    @genre = Genres.new('Action')
    @item = Items.new('Action', 'Bahati', 'Land of HomeLess', 'Netflix', '2010-10-11')
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
end
