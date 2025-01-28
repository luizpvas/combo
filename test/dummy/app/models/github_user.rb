# frozen_string_literal: true

class GithubUser < ApplicationRecord
  validates :login, presence: true
end
