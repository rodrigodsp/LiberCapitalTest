require 'bunny'
require 'prime'
require 'redis'

connection = Bunny.new
connection.start

channel = connection.create_channel

queue = channel.queue('eratosthenes_queue')

begin

    puts ' [*] Waiting for messages. To exit press CTRL+C'

    queue.subscribe(block: true) do |delivery_info, _properties, body|
        puts " [x] Received #{body}"

        value = body.to_i

        primes = Prime::EratosthenesGenerator.new.take_while {|i| i <= value}

        redis = Redis.new(host: "localhost")
        redis.set(value, primes.include?(value))
    end

rescue Interrupt => _
    connection.close

    exit(0)
end