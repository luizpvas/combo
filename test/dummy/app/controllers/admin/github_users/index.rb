# frozen_string_literal: true

class Admin::GithubUsers::Index < Combo::Component
  view <<~ERB
    <%= cb_link "New user", Admin::GithubUsers::New.route %>

    <%= cb_table github_users %>
  ERB

  def github_users
    GithubUser.all
  end
end
