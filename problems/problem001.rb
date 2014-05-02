module Gauntlet
  module Problems
    class PostfixCalculator
      NUMBER = /[\d\.]+/.freeze

      # This one's not math, I swear!

      # Your job is to create a calculator which evaluates expressions
      # in postfix notation, sometimes called reverse Polish notation.

      # For example, the expression
      # 
      #     5 1 2 + 4 * + 3 -
      #
      # is equivalent to
      #
      #     5 + ((1 + 2) * 4) - 3
      #
      # and evaluates to 14.

      # Note for simplicity's sake you can assume there are always spaces
      # between numbers and operations.
      # e.g. `1 3 +` is valid but `1 3+` is not.

      # Source: Codewars

      def self.calc(expression)
        stack = []
        tokenize(expression).each do |token|
          token = token.perform(stack.pop, stack.pop) if token.is_a?(Operator)
          stack.push(token)
        end
        stack.last || 0
      end
      
      def self.tokenize(expression)
        expression.split(" ").map(&method(:to_token))
      end
      
      def self.to_token(token)
        return token.to_f if token =~ NUMBER
        case token
        when "+"; Add.new
        else; raise NotImplementedError.new("Unrecognized Operator: #{token.inspect}")
        end
      end
      
      
      
      class Operator < Struct.new(:symbol)
        def inspect
          "<#{symbol}>"
        end
        
        def perform(arg1, arg2)
          raise NotImplementedError.new("Unimplemented Operator: #{symbol.inspect}")
        end
      end
      
      class Add < Operator
        def initialize
          super "+"
        end
        
        def perform(arg1, arg2)
          arg1 + arg2
        end
      end
      
      
      
    end
  end
end
