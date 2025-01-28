# frozen_string_literal: true

Combo::Engine.routes.draw do
  post "/components/actions/executions" => "components/actions/executions#create",
    as: :component_action_executions
end
