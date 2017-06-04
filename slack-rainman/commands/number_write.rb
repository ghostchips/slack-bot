module SlackRainman; module Commands

  class NumberWrite < SlackRubyBot::Commands::Base

    command 'write' do |client, data, _match|
      number = grab_number(_match)
      written_numbers = translate(number)
      result = written_numbers
      client.say(channel: data.channel, text: result)
    end

    LOOKUP_1 = [
      %w(. one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen),
      %w(. . twenty thrity fourty fifty sixty seventy eighty ninety),
    ]

    LOOKUP_2 =
      %w(hundred thousand million billion trillion quadrillion quintillion sextillion septillion octillion nonillion decillion undecillion duodecillion tredecillion quattuordecillion quindecillion sexdecillion septendecillion octodecillion novemdecillion vigintillion centillion)


    class << self

      def grab_number(input)
        input.to_s.split('').select { |char| number?(char) }.join.strip.split(' ').first
      end

      def number?(char)
        range = '0'..'9'
        range.include?(char) || char == ' '
      end

      def translate(number)
        number = remove_leading_zeros(number)
        translate = grouped(number).map.with_index { |numbers,i| translate_group(numbers, i) }.reverse.join(', ')
        binding.pry
      end

      def translate_group(numbers, group_i)
        translation = []
        index = 0
        numbers.each.with_index do |num, round|
          if round.zero? && ('0'..'19').include?(two_digit = numbers[round+1].to_s + numbers[round].to_s)
            conjuction = numbers.length > 2 ? "and-" : nil
            translation << "#{conjuction}#{LOOKUP_1[index][two_digit.to_i]}"
            index += 2
          else
            if index == 2
              translation << "#{LOOKUP_1[0][num]}-#{LOOKUP_2[group_i]}"
            else
              conjuction = index == 0 ? nil : "and-"
              translation << "#{conjuction}#{LOOKUP_1[index][num]}" if num != 0
            end
            index += 1
          end
        end
        if group_i == 0
          return translation.reverse.join('-')
        else
          return translation.unshift(LOOKUP_2[group_i]).reverse.join('-')
        end
      end

      def grouped(number)
        number.reverse.each_slice(3).to_a
      end

      def remove_leading_zeros(number)
        number = number.split('')
        loop { number.first == '0' ? number.shift : break }
        number.map(&:to_i)
      end

    end
  end

end; end
