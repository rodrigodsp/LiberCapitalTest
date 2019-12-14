require 'bunny'

class RabbitMQBase
  
  def initialize
    begin
      create_connection
      create_channel
      create_queue
    rescue StandardError
      sleep 1
      retry
    end
  end

  protected

  def create_connection
    @connection = Bunny.new(hostname: rabbitmq_host, user: rabbitmq_user, password: rabbitmq_passwd, vhost: rabbitmq_vhost)
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

  def rabbitmq_user
    ENV.fetch('RABBITMQ_USER', 'guest')
  end

  def rabbitmq_passwd
    ENV.fetch('RABBITMQ_PASSWD', 'guest')
  end

  def rabbitmq_vhost
    ENV.fetch('RABBITMQ_VHOST', '/')
  end
end
