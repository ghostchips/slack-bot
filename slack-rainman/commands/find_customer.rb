module SlackRainman; module Commands

  class FindCustomer < SlackRubyBot::Commands::Base

    command 'find customers for' do |client, data, _match|
      service_code = carrier_service(_match)
      customers = find_cutomers(service_code)
      client.say(channel: data.channel, text: customers )
    end

    class << self

      def carrier_service(input)
        input.split(' ').pop
      end

      def find_cutomers(service_code)
        sites = SiteService.all
        carrier_sites = sites.select { |site| site.carrier_service.code == service_code}
        return customers = carrier_sites.map { |site| site.rate_code }.uniq.join(' ')
      end
    end

  end

end; end
