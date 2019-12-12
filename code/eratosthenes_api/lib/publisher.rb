require_relative 'rabbitmq_base'

require 'prime'
require 'redis'
require 'bunny'
require 'time'

class Publisher < RabbitMQBase
    
    attr_reader :value
    private     :value
    
    def initialize(value)
        super()
        @value = value.to_i
    end

    def is_prime_number!
        send_to_queue("is_prime " + value.to_s) if Rails.cache.read(value).nil?
        
        Rails.cache.read(value)
    end

    def send_to_queue message
        @queue.publish(message, persistent: true)
        Rails.logger.info("[#{Time.now}] Mensagem \'#{message}\' enviada para o RabbitMQ.")
    end
end

