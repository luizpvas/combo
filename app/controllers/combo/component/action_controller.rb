# frozen_string_literal: true

module Combo
  class Component::ActionController < ApplicationController
    def create
      action = Combo::Component::Action.decode(params[:action])

      raise "not implemented"
    end
  end
end