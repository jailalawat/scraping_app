RSpec.shared_examples 'Page views' do |method_name|
  it "return the #{method_name.titleize} views" do
    expect(log_analyzer.send(method_name)).to eq(expected_datas)
  end
end