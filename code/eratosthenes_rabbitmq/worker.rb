require_relative 'rabbitmq_base'

require 'redis'
require 'prime'
require 'logger'
require 'time'

class Worker < RabbitMQBase
  
  def start
    logger = Logger.new(STDOUT)
    logger.info("[#{Time.now}] RabbitMQ aguardando por mensagens.")

    @queue.subscribe(block: true) do |_delivery_info, _properties, body|
      
      logger.info("[#{Time.now}] Mensagem \'#{body}\' recebida pelo RabbitMQ.")
      
      params = body.split(' ')
      
      if WorkerMethods.public_methods.include?(params[0].to_sym)
        WorkerMethods.send(params[0], params[1].to_i)
      else
        raise 'Método do worker não encontrado!'
      end
    end
  end

  module WorkerMethods
    module_function

    def is_prime number
      primes = Prime::EratosthenesGenerator.new.take_while {|i| i <= number}

      redis = Redis.new(host: redis_host)
      redis.set(number, primes.include?(number) ? 'Sim' : 'Não')
    end

    def redis_host
      ENV.fetch('REDIS_HOST', 'localhost')
    end

  end
end

Worker.new.start
