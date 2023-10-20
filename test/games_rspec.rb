require_relative '../inc_helper'

RSpec.describe Games do
  before(:each) do
    @author = Authors.new('John', 'Doe')
    @published_date = '2015-10-01'
    @multiplayer = true
    @last_played_at = '2022-09-15'
    @game = Games.new(@author, @published_date, @multiplayer, @last_played_at)
  end

  it 'Should have initial state' do
    expect(@game.author).to eq(@author)
    expect(@game.published_date).to be_a(Date)
    expect(@game.multiplayer).to be_truthy
    expect(@game.last_played_at).to be_a(Date)
    expect(@game.id).to be_a(Integer)
  end

  it 'Should be archived if last played date is more than 2 years ago' do
    allow(Time).to receive(:now).and_return(Time.new(2026, 3, 1))
    expect(@game.can_be_archived?).to be_truthy
  end

  it 'Should not be archived if last played date is within 2 years' do
    allow(Time).to receive(:now).and_return(Time.new(2023, 1, 1))
    expect(@game.can_be_archived?).to be_falsey
  end

  it 'Should not be archived if not multiplayer' do
    @game.multiplayer = false
    allow(Time).to receive(:now).and_return(Time.new(2024, 3, 1))
    expect(@game.can_be_archived?).to be_falsey
  end

  it 'Should serialize to JSON' do
    json_str = @game.to_json
    expect(json_str).to be_a(String)

    json_data = JSON.parse(json_str)
    expect(json_data['id']).to be_a(Integer)
    expect(json_data['author_fname']).to eq('John')
    expect(json_data['author_lname']).to eq('Doe')
    expect(json_data['published_date']).to eq('2015-10-01')
    expect(json_data['multiplayer']).to be_truthy
    expect(json_data['last_played_at']).to eq('2022-09-15')
  end

  it 'Should deserialize from JSON' do
    json_str = @game.to_json
    deserialized_game = Games.from_json(json_str)
    expect(deserialized_game).to be_a(Games)
    expect(deserialized_game.author.fname).to eq('John')
    expect(deserialized_game.author.lname).to eq('Doe')
    expect(deserialized_game.published_date.to_s).to eq('2015-10-01')
    expect(deserialized_game.multiplayer).to be_truthy
    expect(deserialized_game.last_played_at.to_s).to eq('2022-09-15')
  end
end
