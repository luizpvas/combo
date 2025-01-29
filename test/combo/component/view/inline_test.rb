# frozen_string_literal: true

require "test_helper"

class Combo::Component::View::InlineTest < ActiveSupport::TestCase
  test "inline rendering without component methods and helpers" do
    component_class = Class.new(Combo::Component) do
      view <<~HTML
        <div>Hello, world!</div>
      HTML
    end

    component = component_class.new

    assert_equal "<div>Hello, world!</div>", component.render_view_to_string.squish
  end

  test "inline rendering with rails helpers" do
    component_class = Class.new(Combo::Component) do
      view <<~HTML
        Value <%= number_to_currency(10, precision: 2) %>
      HTML
    end

    component = component_class.new

    assert_equal "Value $10.00", component.render_view_to_string.squish
  end

  test "inline rendering with component methods" do
    component_class = Class.new(Combo::Component) do
      view <<~HTML
        Hello, <%= name %>!
      HTML

      def name
        "world"
      end
    end

    component = component_class.new

    assert_equal "Hello, world!", component.render_view_to_string.squish
  end
end
