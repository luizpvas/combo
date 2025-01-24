# frozen_string_literal: true

require "test_helper"

class Combo::Component::AttributeTest < ActiveSupport::TestCase
  test "attribute initialization" do
    component_class = Class.new(Combo::Component) do
      attribute :attr1
      attribute :attr2
    end

    component = component_class.new(attr1: "val1", attr2: "val2")

    assert_equal "val1", component.attr1
    assert_equal "val2", component.attr2
  end

  test "invalid attribute initialization" do
    component_class = Class.new(Combo::Component) do
      attribute :attr1
    end

    assert_raises Combo::UnknownAttributeError do
      component_class.new(attr1: "val1", attr2: "val2")
    end
  end
end
