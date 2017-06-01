require 'spec_helper'

describe SlackRainman::Commands::Calculate do
  def app
    SlackRainman::Bot.instance
  end

  subject { app }

  it 'returns 4' do
    expect(message: "#{SlackRubyBot.config.user} calculate 2+2", channel: 'channel').to respond_with_slack_message('4')
  end

  it 'returns 6' do
    expect(message: "#{SlackRubyBot.config.user} calculate 2+2+2", channel: 'channel').to respond_with_slack_message('6')
  end

  it 'returns 8' do
    expect(message: "#{SlackRubyBot.config.user} calculate 2+2+2+2", channel: 'channel').to respond_with_slack_message('8')
  end
end
