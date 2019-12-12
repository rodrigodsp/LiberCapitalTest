require File.join(Rails.root, "lib", "publisher")

require 'time'

class VerificationsController < ApplicationController
  def prime_numbers
    Rails.logger.info("[#{Time.now}] Recebida requisição POST /identify_prime_numbers.")
    render json: resp_body
  end

  protected

  def get_results
    profile_params.fetch(:values).split(',').map{|v| {value: v, prime: Publisher.new(v).is_prime_number!}}
  end

  def resp_body
    Rails.logger.info("[#{Time.now}] Retornando resultado da requisição POST /identify_prime_numbers.")
    {
      request: {
        values: profile_params.fetch(:values)
      },
      response: {
        numbers: get_results
      }
    }
  end

  def profile_params
    params.permit(:values)
  end
end
