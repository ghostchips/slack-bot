require 'spec_helper'

describe SlackRainman::Bot do
  def app
    SlackRainman::Bot.instance
  end

  subject { app }

  it_behaves_like 'a slack ruby bot'
end
