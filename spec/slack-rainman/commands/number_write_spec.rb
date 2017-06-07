require 'spec_helper'

describe SlackRainman::Commands::Calculate do

  def app
    SlackRainman::Bot.instance
  end

  subject { app }

  it 'returns 1 1' do
    expect(message: "#{SlackRubyBot.config.user} write out 1", channel: 'channel').to respond_with_slack_message('one')
  end

  it 'returns 1 1' do
    expect(message: "#{SlackRubyBot.config.user} write out 0", channel: 'channel').to respond_with_slack_message('zero')
  end

  it 'returns number written out in words' do
    expect(message: "#{SlackRubyBot.config.user} write out 324", channel: 'channel').to respond_with_slack_message('three-hundred-and-twenty-four')
  end

  it 'returns number written out in words' do
    expect(message: "#{SlackRubyBot.config.user} write out 3,024", channel: 'channel').to respond_with_slack_message('three-thousand and-twenty-four')
  end

  it 'returns number written out in words' do
    expect(message: "#{SlackRubyBot.config.user} write out 30,024", channel: 'channel').to respond_with_slack_message('thirty-thousand and-twenty-four')
  end

  it 'returns number written out in words' do
    expect(message: "#{SlackRubyBot.config.user} write out 310,624", channel: 'channel').to respond_with_slack_message('three-hundred-and-ten-thousand six-hundred-and-twenty-four')
  end

  it 'returns number written out in words' do
    expect(message: "#{SlackRubyBot.config.user} write out 2,517,604", channel: 'channel').to respond_with_slack_message('two-million five-hundred-and-seventeen-thousand six-hundred-and-four')
  end

  it 'returns number written out in words' do
    expect(message: "#{SlackRubyBot.config.user} write out 1,000,000,000", channel: 'channel').to respond_with_slack_message('one-billion')
  end

end
