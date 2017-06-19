# require "set"
#
# module SlackRainman; module Commands
#
#   class AddFtp < SlackRubyBot::Commands::Base
#
#     command 'list ftp' do |client, data, _match|
#       carriers, details = read_lines
#       hash_lines(details, carriers)
#       client.say(channel: data.channel, text: '')
#     end
#
#     class << self
# 
#       def read_lines
#         ftp_file = '/Users/micahboyd/bot/carrier_config.yaml'
#
#         lines = IO.readlines(ftp_file)
#         carriers, details = lines.partition { |line| line[0] != ' ' }
#
#         [carriers, details].each.with_index do |array, index|
#           cut = index.zero? ? -3 : -2
#           array.map! { |e| e[0..cut].strip }.reject! { |e| e[0] == '#'}
#         end
#         [carriers, details]
#       end
#
#       def hash_lines(details, carriers)
#         grouped_details = []
#         carrier_details = {}
#         split = 0
#         c_index = -1
#
#         details.each do |detail|
#           binding.pry
#           split += 1; c_index += 1 if detail[0..9] == 'transport:'
#           if split < 2
#             detail = map_detail(detail)
#             carrier_details[detail[0].to_sym] = detail[1]
#           else
#             binding.pry
#             grouped_details << Hash[carriers[c_index].to_sym , carrier_details.dup]
#             carrier_details.clear
#             split = 1
#             detail = map_detail(detail)
#             carrier_details[detail[0].to_sym] = detail[1]
#           end
#         end
#         # hash_details(grouped_details, carriers)
#       end
#
#       def hash_details(grouped_details, carriers)
#         carriers_hash = {}
#         carriers.each.with_index do |carrier, index|
#           carriers_hash[carrier.to_sym] = grouped_details[index]
#         end
#         binding.pry
#         carriers_hash
#         # carrier_and_details = carriers.zip(grouped_details)
#         # Hash[*carrier_and_details]
#       end
#
#       def map_detail(detail)
#         detail.split(':', 2).map(&:strip)
#       end
#
#
#     end
#   end
#
# end; end
