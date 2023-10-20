require_relative '../inc_helper'

RSpec.describe Authors do
  before(:each) do
    @fname = 'John'
    @lname = 'Doe'
    @author = Authors.new(@fname, @lname)
  end

  it 'Should have an initial state' do
    expect(@author.fname).to eq(@fname)
    expect(@author.lname).to eq(@lname)
    expect(@author.id).to be_a(Integer)
    expect(@author.items).to be_an(Array)
    expect(@author.items).to be_empty
  end

  it 'Should add an item and associate it with the author' do
    game = Games.new(@author, '2022-01-15', true, '2022-09-15')
    @author.add_item(game)

    expect(game.author).to eq(@author)
    expect(@author.items).to include(game)
  end

  it 'Should serialize to JSON' do
    json_str = @author.to_json
    expect(json_str).to be_a(String)
    json_data = JSON.parse(json_str)
    expect(json_data['id']).to be_a(Integer)
    expect(json_data['fname']).to eq(@fname)
    expect(json_data['lname']).to eq(@lname)
    expect(json_data['items']).to be_an(Array)
    expect(json_data['items']).to be_empty
  end

  it 'Should deserialize from JSON' do
    json_str = @author.to_json
    deserialized_author = Authors.from_json(json_str)
    expect(deserialized_author).to be_a(Authors)
    expect(deserialized_author.fname).to eq(@fname)
    expect(deserialized_author.lname).to eq(@lname)
    expect(deserialized_author.id).to be_a(Integer)
    expect(deserialized_author.items).to be_an(Array)
    expect(deserialized_author.items).to be_empty
  end
end
