require 'bunny'
require 'time'

class RabbitMQBase
  
  def initialize
    begin
      create_connection
      create_channel
      create_queue
    rescue StandardError
      Rails.logger.error("[#{Time.now}] Erro na conexão com RabbitMQ. Tentando novamente...")
      sleep 1
      retry
    end
  end

  protected

  def create_connection
    @connection = Bunny.new(hostname: rabbitmq_host)
    @connection.start
  end

  def create_channel
    @channel = @connection.create_channel
  end

  def create_queue
    @queue = @channel.queue(queue_name)
  end

  def queue_name
    ENV.fetch('QUEUE_NAME', 'worker_queue')
  end

  def rabbitmq_host
    ENV.fetch('RABBITMQ_HOST', 'localhost')
  end
end
