require 'sinatra/base'

module SlackRainman
  class Web < Sinatra::Base
    get '/' do
      'Math is good for you.'
    end
  end
end
