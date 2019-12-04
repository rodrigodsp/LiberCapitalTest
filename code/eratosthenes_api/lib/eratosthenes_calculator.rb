require 'prime'
require 'redis'

class EratosthenesCalculator
    attr_reader :value
    private     :value
    
    def initialize(value)
        @value = value.to_i
    end

    def is_prime_number!
        if Rails.cache.read(value).nil?
            primes = Prime::EratosthenesGenerator.new.take_while {|i| i <= value}
            Rails.cache.write(value, primes.include?(value))
        end

        Rails.cache.read(value)
    end
end