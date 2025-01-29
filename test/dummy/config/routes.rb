# frozen_string_literal: true

Rails.application.routes.draw do
  scope "admin" do
    get "/github_users", to: Admin::GithubUsers::Index
    get "/github_users/new", to: Admin::GithubUsers::New
  end

  mount Combo::Engine => "/combo"
end
