# frozen_string_literal: true

module Combo::Helpers
  extend ActiveSupport::Autoload

  autoload :Header
  autoload :Page
  autoload :Spacing
  autoload :Table

  include Header
  include Page
  include Spacing
  include Table
end
