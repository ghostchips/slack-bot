module SlackRainman; module Commands

  class Calculate < SlackRubyBot::Commands::Base

    command 'calculate' do |client, data, _match|
      formula = clean_input(_match)
      result = formula.nil? ? 'Sorry I couldn\'t calculate that' : ordered_calc(formula)
      client.say(channel: data.channel, text: result)
    end

    class << self

      def clean_input(user_input)
        stripped_input = strip_input(user_input)
        numbers = strip_numbers(stripped_input)
        operators = strip_operators(stripped_input)

        formula = numbers.zip(operators).flatten.compact
        return formula_check(formula)
      end

      def strip_input(user_input)
        user_input.to_s.downcase.split('').reject { |char| remove_chars(char)}.join
      end

      def strip_numbers(stripped_input)
        stripped_input.split(/[^0-9a-z]/i).reject { |char| remove_chars(char)}
      end

      def strip_operators(stripped_input)
        stripped_input.gsub(/[0-9a-z]/,'').split('').select { |char| include_operators(char) }
      end

      def remove_chars(char)
        ('a'..'z').include?(char) || (' ').include?(char)
      end

      def include_operators(char)
        char == '*' || char == '/' || char == '+' || char == '-'
      end

      def formula_check(formula)
        length = formula.size
        length.odd? && length > 1 ? converted_formula(formula) : nil
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

      def ordered_calc(formula)
        formula.each.with_index do |char,i|
          formula[i-1..i+1] = do_math(formula, i) if operator_check(char)
        end
        include_special_operators(formula) ? ordered_calc(formula) : simple_calc(formula)
      end

      def operator_check(element)
        element == '/' || element == '*'
      end

      def include_special_operators(formula)
        formula.include?('*') || formula.include?('/')
      end

      def simple_calc(formula)
        return formula.first if formula.length == 1
        math = formula.each.with_index do |char,i|
          formula[0..2] = do_math(formula)
        end
        math.length == 1 ? math.first : simple_calc(formula)
      end

      def do_math(formula, index=1)
        formula[index-1].send(formula[index], formula[index+1])
      end

      # def first_operation(char)
      #   char = char.flatten
      # end

      # def order_of_operation(formula)
      #     if include_special_operators(formula)
      #       sub_operations = []
      #       operator_indexes = find_operator_indexes(formula)
      #       operator_indexes.each do |index|
      #         current_index = find_operator_indexes(formula).first
      #         sub_operation = formula.slice!(current_index-1..current_index+1)
      #         if current_index == 0
      #           sub_operations << formula.slice!(0)
      #         else
      #           sub_operations << sub_operation.compact
      #         end
      #       end
      #       sub_operations.zip(formula).flatten(1).compact
      #     else
      #       grouped(formula)
      #     end
      # end

      # def re_arrange_order(formula)
        # puts 'reearange'
        # sub_operations = []
        # operator_indexes = find_operator_indexes(formula)
        # operator_indexes.each do |index|
        #   operator_index = find_operator_indexes(formula).first
        #   sub_operation = formula.slice!(operator_index-1..operator_index+1)
        #   sub_operations << sub_operation.compact
        # end
        # sub_operations.zip(formula).flatten(1).compact
      # end

      # def find_operator_indexes(formula, all=false)
      #   operators = all ? %w(+ - / *) : %w(/ *)
      #   formula.map.with_index { |e, index| index if operators.include?(e) }.compact
      # end

      # def calculate_math(formula)
      #   next_formula = formula.map { |char| calculate_or_skip(char) }
      #   return next_formula.first if next_formula.flatten.length == 1
      #   calculate_math(grouped(next_formula))
      # end

      # def grouped(formula)
      #   operator_indexes = find_operator_indexes(formula, true)
      #   last_chars = operator_indexes.size.even? && formula.size > 3 ? formula.slice!(-2..-1) : nil
      #   grouping = operator_indexes.map.with_index(1) { |e, i|
      #     i.odd? ? formula[e-1..e+1] : formula[e] }.compact
      #   grouped_formula = last_chars.nil? ? grouping : grouping << last_chars.first << last_chars.last
      # end

      # def re_arrange_order(formula)
      #   sub_operations = []
      #   operator_indexes = find_operator_indexes(formula)
      #   operator_indexes.each do |index|
      #     operator_index = find_operator_indexes(formula).first
      #     sub_operation = formula.slice!(operator_index-1..operator_index+1)
      #     sub_operations << sub_operation.compact
      #   end
      #   sub_operations.zip(formula).flatten(1).compact
      # end

      # def calculate_or_skip(char)
      #   char.class != Array ? char : first_operation(char)
      # end

      # def first_operation(char)
      #   char = char.flatten
      #   char[0].send(char[1], char[2])
      # end

    end
  end

end; end
