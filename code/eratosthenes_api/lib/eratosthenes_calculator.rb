require 'prime'

class EratosthenesCalculator
    attr_reader :value
    private     :value
    
    def initialize(value)
        @value = value.to_i
    end

    def is_prime_number!
        primes = Prime::EratosthenesGenerator.new.take_while {|i| i <= value}
        primes.include?(value)
    end
end