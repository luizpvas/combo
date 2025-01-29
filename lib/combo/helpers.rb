# frozen_string_literal: true

module Combo::Helpers
  extend ActiveSupport::Autoload

  autoload :Header
  autoload :Spacing
  autoload :Table

  include Header
  include Spacing
  include Table
end
