module SlackRainman; module Commands

  class NumberWrite < SlackRubyBot::Commands::Base

    command 'write out' do |client, data, _match|
      number = grab_number(_match)
      result = translate(number)
      client.say(channel: data.channel, text: result)
    end

    LOOKUP_1 = [
      %w(. one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen),
      %w(. . twenty thirty fourty fifty sixty seventy eighty ninety),
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
        return 'zero' if number.first == 0
        grouped(number).map.with_index { |numbers,i| translate_group(numbers, i) }.reverse.join(' ').strip
      end

      def translate_group(numbers, group_i)
        translation = []
        round = 0

        numbers.each.with_index do |num, index|
          index += round
          num = numbers[index]
          two_digits = two_digit(numbers, index)

          if index.zero? && ('1'..'19').include?(two_digits)
            conjuction = two_digits.length == 2 ? "and-" : first_conjuction(numbers, index)
            translation << written_num(two_digits.to_i, index, conjuction)
            round += 1
          elsif index.zero? || index == 1
            conjuction = index == 1 ? second_conjuction(numbers, index) : first_conjuction(numbers, index)
            translation << written_num(num, index, conjuction)
          elsif index == 2
            next if num.nil?
            translation << written_num(num)
          end
        end

        if group_i == 0
          translation.reverse.compact.join('-')
        else
          extra = numbers.last.zero? ? nil : LOOKUP_2[group_i]
          translation.unshift(extra).reverse.compact.join('-')
        end
      end

      def written_num(num, index=nil, conjuction=nil)
        return nil if num.zero?
        if index
          "#{conjuction}#{LOOKUP_1[index][num]}"
        else
          "#{LOOKUP_1[0][num]}-#{LOOKUP_2[0]}"
        end
      end

      def first_conjuction(numbers, index)
        index += 1
        numbers[index].nil? || !numbers[index].zero? ? nil : "and-"
      end

      def second_conjuction(numbers, index)
        numbers[index+1].nil? || !(0..9).include?(numbers[index-1]) ? nil : "and-"
      end

      def grouped(number)
        number.reverse.each_slice(3).to_a
      end

      def two_digit(numbers, round)
        two_digits = numbers[round+1].to_s + numbers[round].to_s
        strip_zero(two_digits).join('')
      end

      def remove_leading_zeros(number)
        strip_zero(number).map(&:to_i)
      end

      def strip_zero(number)
        number = number.split('')
        loop { number.first == '0' ? number.shift : break }
        number.empty? ? ['0'] : number
      end

    end
  end

end; end
