require 'test_helper'

class VerificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get prime_numbers" do
    get verifications_prime_numbers_url
    assert_response :success
  end

end
