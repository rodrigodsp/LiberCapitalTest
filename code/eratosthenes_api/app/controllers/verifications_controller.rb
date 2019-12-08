require File.join(Rails.root, "lib", "eratosthenes_publisher")

class VerificationsController < ApplicationController
  def prime_numbers
    render json: resp_body
  end

  protected

  def get_results
    profile_params.fetch(:values).split(',').map{|v| {value: v, prime: EratosthenesPublisher.new(v).is_prime_number!}}
  end

  def resp_body
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
