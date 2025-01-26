# frozen_string_literal: true

require "test_helper"

class Combo::Component::BrowserTest < ActiveSupport::TestCase
  StreamAction = Combo::Component::Browser::StreamAction

  test "clear_form" do
    browser.clear_form

    browser.stream_actions.first.tap do |stream_action|
      assert_instance_of StreamAction::ClearForms, stream_action
      assert stream_action.render
    end
  end

  test "clear_forms" do
    browser.clear_forms

    browser.stream_actions.first.tap do |stream_action|
      assert_instance_of StreamAction::ClearForms, stream_action
      assert stream_action.render
    end
  end

  test "flash_success" do
    browser.flash_success "Hello, world!"

    browser.stream_actions.first.tap do |stream_action|
      assert_instance_of StreamAction::Flash, stream_action
      assert_equal :success, stream_action.variant
      assert_equal "Hello, world!", stream_action.message
      assert stream_action.render
    end
  end

  test "flash_error" do
    browser.flash_error "Hello, world!"

    browser.stream_actions.first.tap do |stream_action|
      assert_instance_of StreamAction::Flash, stream_action
      assert_equal :error, stream_action.variant
      assert_equal "Hello, world!", stream_action.message
      assert stream_action.render
    end
  end

  test "redirect" do
    browser.redirect "/some_page"

    browser.stream_actions.first.tap do |stream_action|
      assert_instance_of StreamAction::Redirect, stream_action
      assert_equal "/some_page", stream_action.location
      assert stream_action.render
    end
  end

  test "reload_page" do
    browser.reload_page

    browser.stream_actions.first.tap do |stream_action|
      assert_instance_of StreamAction::ReloadPage, stream_action
      assert stream_action.render
    end
  end

  test "reload_component" do
    browser.reload_component

    browser.stream_actions.first.tap do |stream_action|
      assert_instance_of StreamAction::ReloadComponent, stream_action
      assert stream_action.render
    end
  end

  private
    def browser
      @browser ||= Combo::Component.new.browser
    end
end