require_relative '../inc_helper'

RSpec.describe Label do
  before(:each) do
    @label = Label.new('Sample Label', 'Blue')
  end

  it 'has an initial state' do
    expect(@label.id).to be_a(Integer)
    expect(@label.title).to eq('Sample Label')
    expect(@label.color).to eq('Blue')
    expect(@label.items).to be_empty
  end

  it 'can be created from JSON' do
    label_json = '{"title": "JSON Label", "color": "Green"}'
    new_label = Label.from_json(label_json)

    expect(new_label).to be_a(Label)
    expect(new_label.title).to eq('JSON Label')
    expect(new_label.color).to eq('Green')
  end
end
