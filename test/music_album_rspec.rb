require_relative '../inc_helper'
RSpec.describe MusicAlbum do
  before(:each) do
    @album = MusicAlbum.new('Pop', '2010-01-01', true)
  end

  it 'Have initial state' do
    expect(@album.genre).to eq('Pop')
    expect(@album.published_date).to be_a(Date)
    expect(@album.on_spotify).to be_truthy
    expect(@album.archived).to be_falsey
  end

  it 'Should be archived if the published date is greater than 10 years and on Spotify' do
    allow(Time).to receive(:now).and_return(Time.new(2022, 11, 1))
    expect(@album.can_be_archived?).to be_truthy
  end

  it 'Should not be archived if the published date is not greater than 10 years' do
    allow(Time).to receive(:now).and_return(Time.new(2018, 11, 1))
    expect(@album.can_be_archived?).to be_falsey
  end

  it 'Should not be archived if not on Spotify' do
    @album.on_spotify = false
    allow(Time).to receive(:now).and_return(Time.new(2022, 11, 1))
    expect(@album.can_be_archived?).to be_falsey
  end

  it 'Should move to archived state if can be archived' do
    @album.on_spotify = true
    allow(Time).to receive(:now).and_return(Time.new(2022, 1, 1))
    @album.move_to_archived
    expect(@album.can_be_archived?).to be_truthy
  end

  it 'Should not move to archived state if cannot be archived' do
    @album.on_spotify = false
    allow(Time).to receive(:now).and_return(Time.new(2022, 1, 1))
    @album.move_to_archived
    expect(@album.can_be_archived?).to be_falsey
  end
end
