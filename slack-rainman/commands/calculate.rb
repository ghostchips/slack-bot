module SlackRainman; module Commands

  class Calculate < SlackRubyBot::Commands::Base
    command 'calculate' do |client, data, _match|
      formula = strip_input(_match)
      ordered_formula = order_of_operation(formula)
      result = calculate_math(ordered_formula)
      client.say(channel: data.channel, text: result)
    end

    command 'hello' do |client, data, _match|
      client.say(channel: data.channel, text: "You just said #{_match}")
    end

    class << self

      def strip_input(user_input)
        stripped_input = user_input.to_s.downcase.split('').reject { |char| remove_chars(char)}.join
        numbers = stripped_input.split(/[^0-9a-z]/i)
        operators = stripped_input.gsub(/[0-9a-z]/,'').split('').select { |char| include_operators(char) }
        formula = numbers.zip(operators).flatten.compact
        converted_formula(formula) if formula.size.odd?
      end

      def remove_chars(char)
        ('a'..'z').include?(char) || (' ').include?(char)
      end

      def order_of_operation(formula)
        return grouped(formula) unless include_special_operators(formula)
        re_arrange_order(formula)
      end

      def include_operators(char)
        char == '*' || char == '/' || char == '+' || char == '-'
      end

      def include_special_operators(formula)
        formula.include?('*') || formula.include?('/')
      end

      def re_arrange_order(formula)
        sub_operations = []
        operator_indexes = find_operator_indexes(formula)
        operator_indexes.each do |index|
          operator_index = find_operator_indexes(formula).first
          sub_operation = formula.slice!(operator_index-1..operator_index+1)
          sub_operations << sub_operation.compact
        end
        sub_operations.zip(formula).flatten(1).compact
      end

      def find_operator_indexes(formula, all=false)
        operators = all ? %w(+ - / *) : %w(/ *)
        formula.map.with_index { |e, index| index if operators.include?(e) }.compact
      end

      def operator_check(element)
        element == '/' || element == '*'
      end

      def calculate_math(formula)
        if formula.flatten.length == 1
          return formula.flatten.first
        else
          next_formula = formula.map { |char| calculate_or_skip(char) }
        end
        calculate_math(grouped(next_formula))
      end

      def grouped(formula)
        operator_indexes = find_operator_indexes(formula, true)
        binding.pry
        last_chars = operator_indexes.size.even? && formula.size > 3 ? formula.slice!(-2..-1) : nil
        grouping = operator_indexes.map.with_index(1) { |e, i|
          i.odd? ? formula[e-1..e+1] : formula[e] }.compact
        binding.pry
        grouped_formula = last_chars.nil? ? grouping : grouping << last_chars.first << last_chars.last
      end

      def re_arrange_order(formula)
        sub_operations = []
        operator_indexes = find_operator_indexes(formula)
        operator_indexes.each do |index|
          operator_index = find_operator_indexes(formula).first
          sub_operation = formula.slice!(operator_index-1..operator_index+1)
          sub_operations << sub_operation.compact
        end
        sub_operations.zip(formula).flatten(1).compact
      end

      def calculate_or_skip(char)
        char.class != Array ? char : first_operation(char)
      end

      def first_operation(char)
        char = char.flatten
        char[0].send(char[1], char[2])
      end

      def converted_formula(formula)
        formula.map { |e| convert_char(e) }
      end

      def convert_char(char)
        if char == '0'
          0
        elsif char.to_i == 0
          char
        else
          char.to_i
        end
      end

    end
  end

end; end
