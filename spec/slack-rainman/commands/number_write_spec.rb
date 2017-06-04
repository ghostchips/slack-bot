require 'spec_helper'

describe SlackRainman::Commands::Calculate do

  def app
    SlackRainman::Bot.instance
  end

  subject { app }

  it 'returns 1 1' do
    expect(message: "#{SlackRubyBot.config.user} write 1 1", channel: 'channel').to respond_with_slack_message('1')
  end

  it 'returns 1 1' do
    expect(message: "#{SlackRubyBot.config.user} write 101", channel: 'channel').to respond_with_slack_message('100')
  end

  it 'returns 1000' do
    expect(message: "#{SlackRubyBot.config.user} write 4,320", channel: 'channel').to respond_with_slack_message('1211')
  end

  LOOKUP_1 = [
    %w(. one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen),
    %w(. . twenty thrity fourty fifty sixty seventy eighty ninety),
  ]

  LOOKUP_2 =
    %w(hundred thousand million billion trillion quadrillion quintillion sextillion septillion octillion nonillion decillion undecillion duodecillion tredecillion quattuordecillion quindecillion sexdecillion septendecillion octodecillion novemdecillion vigintillion centillion)

end
