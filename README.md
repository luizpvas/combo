# Combo

Combo is a full stack component library for Rails inspired by Liveview and Livewire. The goal of this library is to
provide a better abstraction over traditional MVC for building admin and backoffice applications along with a rich
collection of components and view helpers.

1. [Defining components](#defining-components)
2. [State management](#state-management)
   - [Request params](#request-params)
   - [Attributes](#attributes)
   - [Action payload](#action-payload)
3. Action responses
   - Clear forms
   - Flash
   - Redirect
   - Reload
4. Helpers and components library
   - Tables
   - Date picker

# Defining components

Components encapsulate views and backend actions into a single unit. Views work similar to Rails' ERB templates, and
actions work similar to controllers actions, except you don't have to add a route entry.

```ruby
class MyApp::Admin::UserDetails < Combo::Component
  attribute :user, User

  def view
    inline <<~ERB
      <%= cb_panel do %>
        <%= cb_table do %>
          <%= cb_row "Email", user.email %>
          <%= cb_row "Registration date", user.registration_date %>
        <% end %>

        <%= cb_dropdown do %>
          <%= cb_button "Actions" %>

          <%= cb_menu do %>
            <%= cb_menu_item "Unlock login", to: action(:unlock_login) %>
            <%= cb_menu_item "Send password reset email", to: action(:send_password_reset_email) %>
          <% end %>
        <% end %>
      <% end %>
    ERB
  end

  def unlock_login
    user.unlock_login!

    client.flash_success "Login unlocked"
  end

  def send_password_reset_email
    token = user.generate_password_reset_token

    UserMailer.password_reset(user, token).deliver_now

    client.flash_success "Password reset email sent"
  end
end
```

# State management

There are three pieces of state in a component:

1. Request params
2. Attributes
3. Action payload

### Request params

Components can respond to requests like controllers. For example, in your `routes.rb`:

```ruby
Rails.application.routes.draw do
  get '/payments/:payment_id', to: MyApp::PaymentDetails
end
```
