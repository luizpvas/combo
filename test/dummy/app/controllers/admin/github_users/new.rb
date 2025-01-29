# frozen_string_literal: true

class Admin::GithubUsers::New < Combo::Component
  view <<~ERB
    <%= cb_form action(:submit) do |f| %>
      <%= f.field_text :login, label: "Login", required: true %>
      <%= f.submit "Add Github user" %>
    <% end %>
  ERB

  def submit
    raise "not implemented"
  end
end
