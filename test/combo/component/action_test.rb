# frozen_string_literal: true

require "test_helper"

class Combo::Component::ActionTest < ActiveSupport::TestCase
  class Dummy < Combo::Component
    def do_something
    end
  end

  test "decode success" do
    component = Dummy.new
    action = component.build_action(:do_something)

    decoded = Combo::Component::Action.decode(action.encode)

    assert_equal action, decoded
  end

  test "decode failure" do
    component = Dummy.new

    encoded = component.build_action(:do_something).encode + "tampered"

    assert_raises ActiveSupport::MessageVerifier::InvalidSignature do
      Combo::Component::Action.decode(encoded)
    end
  end

  test "action url" do
    component = Dummy.new

    assert_match /\/combo\/component\/action\?encoded=[A-Za-z0-9]+/, component.action(:do_something)
  end
end
