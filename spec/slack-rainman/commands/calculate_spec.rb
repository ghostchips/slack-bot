require 'spec_helper'

describe SlackRainman::Commands::Calculate do

  def app
    SlackRainman::Bot.instance
  end

  subject { app }

  context 'doing math' do
    it 'returns 4' do
      expect(message: "#{SlackRubyBot.config.user} calculate 2+2", channel: 'channel').to respond_with_slack_message('4')
    end

    it 'returns 6' do
      expect(message: "#{SlackRubyBot.config.user} calculate 2+2+2", channel: 'channel').to respond_with_slack_message('6')
    end

    it 'returns 8' do
      expect(message: "#{SlackRubyBot.config.user} calculate 2+2+2+2", channel: 'channel').to respond_with_slack_message('8')
    end

    it 'returns 4' do
      expect(message: "#{SlackRubyBot.config.user} calculate 2*2", channel: 'channel').to respond_with_slack_message('4')
    end

    it 'returns 8' do
      expect(message: "#{SlackRubyBot.config.user} calculate 2*2+2*2", channel: 'channel').to respond_with_slack_message('8')
    end

    it 'returns 16' do
      expect(message: "#{SlackRubyBot.config.user} calculate 2*2*2*2", channel: 'channel').to respond_with_slack_message('16')
    end

    it 'returns 18' do
      expect(message: "#{SlackRubyBot.config.user} calculate 2*2*2*2+2", channel: 'channel').to respond_with_slack_message('18')
    end

    it 'returns 2' do
      expect(message: "#{SlackRubyBot.config.user} calculate 2/2*2-2+2", channel: 'channel').to respond_with_slack_message('2')
    end

    it 'returns 1' do
      expect(message: "#{SlackRubyBot.config.user} calculate 2-2*2-2/2", channel: 'channel').to respond_with_slack_message('-3')
    end

    it 'returns 20' do
      expect(message: "#{SlackRubyBot.config.user} calculate 10+10", channel: 'channel').to respond_with_slack_message('20')
    end
  end

  context 'input check' do
    it 'can calculate' do
      expect(message: "#{SlackRubyBot.config.user} calculate 2     +2", channel: 'channel').to respond_with_slack_message('4')
    end

    it 'cant calculate' do
      expect(message: "#{SlackRubyBot.config.user} calculate 2 #+ 2", channel: 'channel').to respond_with_slack_message('4')
    end

    it 'can\'t calculate' do
      expect(message: "#{SlackRubyBot.config.user} calculate", channel: 'channel').to respond_with_slack_message('Sorry I couldn\'t calculate that')
    end

    it 'can\'t calculate' do
      expect(message: "#{SlackRubyBot.config.user} calculate 2", channel: 'channel').to respond_with_slack_message('Sorry I couldn\'t calculate that')
    end

    it 'can\'t calculate' do
      expect(message: "#{SlackRubyBot.config.user} calculate 2 2", channel: 'channel').to respond_with_slack_message('Sorry I couldn\'t calculate that')
    end

    it 'can\'t calculate' do
      expect(message: "#{SlackRubyBot.config.user} calculate 2 2 2", channel: 'channel').to respond_with_slack_message('Sorry I couldn\'t calculate that')
    end

    it 'can\'t calculate' do
      expect(message: "#{SlackRubyBot.config.user} calculate +", channel: 'channel').to respond_with_slack_message('Sorry I couldn\'t calculate that')
    end

    it 'can\'t calculate' do
      expect(message: "#{SlackRubyBot.config.user} calculate + +", channel: 'channel').to respond_with_slack_message('Sorry I couldn\'t calculate that')
    end

    it 'can\'t calculate' do
      expect(message: "#{SlackRubyBot.config.user} calculate + + +", channel: 'channel').to respond_with_slack_message('Sorry I couldn\'t calculate that')
    end
  end
end
