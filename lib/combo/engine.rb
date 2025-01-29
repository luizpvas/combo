# frozen_string_literal: true

module Combo
  class Engine < ::Rails::Engine
    isolate_namespace Combo

    initializer "combo.helpers" do
      ActiveSupport.on_load(:action_view) do
        module ::ApplicationHelper
          include ::Combo::Helpers
        end

        class Combo::Component
          helper ::ApplicationHelper
        end
      end
    end
  end
end
