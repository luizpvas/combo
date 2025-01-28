# frozen_string_literal: true

Rails.application.routes.draw do
  scope "admin" do
    get "/github_users", to: Admin::GithubUsers::Index
  end

  mount Combo::Engine => "/combo"
end
