# frozen_string_literal: true

class Admin::GithubUsers::Index < Combo::Component
  view <<~ERB
    <%= cb_table github_users %>
  ERB

  def github_users
    GithubUser.all
  end
end
