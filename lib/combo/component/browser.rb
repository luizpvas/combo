# frozen_string_literal: true

class Combo::Component::Browser
  attr_reader :stream_actions

  module StreamAction
    ClearForms = Data.define do
      def render
        <<~HTML
          <turbo-stream action="clear-forms"></turbo-stream>
        HTML
      end
    end

    Flash = Data.define(:variant, :message) do
      def render
        <<~HTML
          TODO
        HTML
      end
    end

    Redirect = Data.define(:location) do
      def render
        <<~HTML
          TODO
        HTML
      end
    end

    ReloadPage = Data.define do
      def render
        <<~HTML
          TODO
        HTML
      end
    end

    ReloadComponent = Data.define(:dom_id) do
      def render
        <<~HTML
          TODO
        HTML
      end
    end
  end

  def initialize(component)
    @component = component
    @stream_actions = []
  end

  def clear_form
    @stream_actions << StreamAction::ClearForms.new
  end

  def clear_forms
    @stream_actions << StreamAction::ClearForms.new
  end

  def flash_success(message)
    @stream_actions << StreamAction::Flash.new(variant: :success, message:)
  end

  def flash_error(message)
    @stream_actions << StreamAction::Flash.new(variant: :error, message:)
  end

  def redirect(location)
    @stream_actions << StreamAction::Redirect.new(location:)
  end

  def reload_page
    @stream_actions << StreamAction::ReloadPage.new
  end

  def reload_component
    @stream_actions << StreamAction::ReloadComponent.new(dom_id: @component.dom_id)
  end
end
