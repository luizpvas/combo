# frozen_string_literal: true

require "test_helper"

class Combo::Component::ActionTest < ActiveSupport::TestCase
  class Dummy < Combo::Component
    def do_something
    end
  end

  test "decode success" do
    component = Dummy.new
    action = component.action(:do_something)

    decoded = Combo::Component::Action.decode(action.encode)

    assert_equal action, decoded
  end

  test "decode failure" do
    component = Dummy.new

    encoded = component.action(:do_something).encode + "tampered"

    assert_raises ActiveSupport::MessageVerifier::InvalidSignature do
      Combo::Component::Action.decode(encoded)
    end
  end
end
