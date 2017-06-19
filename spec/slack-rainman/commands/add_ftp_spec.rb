require 'spec_helper'

describe SlackRainman::Commands::AddFtp do

  def app
    SlackRainman::Bot.instance
  end

  subject { app }

  context 'doing math' do
    # it 'returns 4' do
    #   expect(message: "#{SlackRubyBot.config.user} list ftp", channel: 'channel').to respond_with_slack_message('4')
    # end

  end
end
