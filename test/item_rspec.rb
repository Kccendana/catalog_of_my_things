require_relative '../inc_helper'

RSpec.describe Items do
  before(:each) do
    @items = Items.new('2010-10-11')
  end

  it 'Have initial state' do
    expect(@items.published_date).to be_a(Date)
    expect(@items.archived).to be_falsey
  end

  it 'Should be archived if the published date is greater than 10 year' do
    allow(Time).to receive(:now).and_return(Time.new(2022, 11, 1))
    expect(@items.can_be_archived?).to be_truthy
  end

  it 'Should not be archived if the published date is not greater than 10 year' do
    allow(Time).to receive(:now).and_return(Time.new(2018, 11, 1))
    expect(@items.can_be_archived?).to be_falsey
  end

  it 'Should move to archived state if can be archived ' do
    allow(Time).to receive(:now).and_return(Time.new(2022, 1, 1))
    @items.move_to_archived
    expect(@items.can_be_archived?).to be_truthy
  end

  it 'Should not move to archived state if can not be archived ' do
    allow(Time).to receive(:now).and_return(Time.new(2020, 1, 1))
    @items.move_to_archived
    expect(@items.can_be_archived?).to be_falsey
  end
end
