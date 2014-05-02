module Gauntlet
  module Problems
    class PostfixCalculator

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
        case token
        when /[\d\.]+/; token.to_f
        when "+"; Add.new
        when "-"; Subtraction.new
        when "*"; Multiplication.new
        when "/"; Division.new
        else; raise NotImplementedError.new("Unrecognized Operator: #{token.inspect}")
        end
      end
      
      
      
      class Operator < Struct.new(:symbol)
        def inspect
          "<#{symbol}>"
        end
        
        def perform(arg1, arg2)
          raise NotImplementedError.new("Unimplemented Operator: #{inspect}")
        end
      end
      
      class Add < Operator
        def initialize
          super "+"
        end
        
        def perform(arg1, arg2)
          arg2 + arg1
        end
      end
      
      class Subtraction < Operator
        def initialize
          super "-"
        end
        
        def perform(arg1, arg2)
          arg2 - arg1
        end
      end
      
      class Multiplication < Operator
        def initialize
          super "*"
        end
        
        def perform(arg1, arg2)
          arg2 * arg1
        end
      end
      
      class Division < Operator
        def initialize
          super "/"
        end
        
        def perform(arg1, arg2)
          arg2 / arg1
        end
      end
      
      
      
    end
  end
end
