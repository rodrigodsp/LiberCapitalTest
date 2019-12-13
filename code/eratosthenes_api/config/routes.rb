Rails.application.routes.draw do
  post '/identify_prime_numbers', to: 'numbers_identification#prime_numbers'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
