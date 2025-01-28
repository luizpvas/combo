# frozen_string_literal: true

Combo::Engine.routes.draw do
  post "/components/actions/executions" => "components/actions/executions#create",
    name: :create_component_action_execution
end
