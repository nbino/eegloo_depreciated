require File.dirname(__FILE__) + '/../test_helper'
require 'migration_controller'

# Re-raise errors caught by the controller.
class MigrationController; def rescue_action(e) raise e end; end

class MigrationControllerTest < Test::Unit::TestCase
  def setup
    @controller = MigrationController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
