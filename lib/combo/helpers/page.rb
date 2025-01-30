# frozen_string_literal: true

module Combo::Helpers::Page
  def cb_page(&block)
    content_tag(:div, class: "cb_page", &block)
  end
end
