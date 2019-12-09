require 'prime'
require 'redis'
require 'bunny'

class EratosthenesPublisher
    attr_reader :value
    private     :value
    
    def initialize(value)
        @value = value.to_i
    end

    def is_prime_number!
        send_to_queue("is_prime " + value.to_s) if Rails.cache.read(value).nil?
        
        Rails.cache.read(value)
    end

    def send_to_queue message
        connection = Bunny.new(hostname: "localhost")
        connection.start

        channel = connection.create_channel

        queue = channel.queue('worker_queue')

        queue.publish(message, persistent: true)
        puts " [x] Sent #{message}"
    end
end

