# Combo

Combo is a full stack component library for Rails inspired by Liveview and Livewire. The goal of this library is to
provide a rich collection of components and view helpers and better abstractions over traditional MVC for building
admin/backoffice apps.

1. [Defining components](#defining-components)
2. [Using components](#using-components)
3. [State management](#state-management)
   - [Request params](#request-params)
   - [Attributes](#attributes)
   - [Action payload](#action-payload)
4. Action responses
   - Clear forms
   - Flash
   - Redirect
   - Reload
5. Helpers and components library
   - [`cb_header`](#cb_header)
   - [`cb_brand`](#cb_brand)
   - [`cb_navbar`](#cb_navbar)
   - [`cb_navbar_item`](#cb_navbar_item)
   - [`cb_spacer`](#cb_spacer)
   - [`cb_table`](#cb_table)

# Defining components

Components encapsulate views and backend actions into a single unit. Views work similar to Rails' ERB templates, and
actions work similar to controllers actions, except you don't have to add a route entry.

```ruby
class Admin::UserDetails < Combo::Component
  attribute :user, User

  view <<~ERB
    <%= cb_panel do %>
      <%= cb_table do %>
        <%= cb_row "Email", user.email %>
        <%= cb_row "Registration date", user.registration_date %>
      <% end %>

      <%= cb_dropdown do %>
        <%= cb_button "Actions" %>

        <%= cb_menu do %>
          <%= cb_menu_item "Unlock login", action(:unlock_login) %>
          <%= cb_menu_item "Send password reset email", action(:send_password_reset_email) %>
        <% end %>
      <% end %>
    <% end %>
  ERB

  def unlock_login
    user.unlock!

    browser.flash_success "Login unlocked"
  end

  def send_password_reset_email
    token = user.generate_password_reset_token

    UserMailer.password_reset(user, token).deliver_now

    browser.flash_success "Password reset email sent"
  end
end
```

# Using components

You can use components by either rendering them in a regular rails view or mounting them in a route. To render a
component in a view call the `render` method passing the component and attributes. For example, in
`myapp/admin/users/index.html.erb`:

```erb
<h1>User <%= user.id %></h1>

<div>
  <%= render MyApp::Admin::UserDetails, user: user %>
</div>
```

To render a component as a full page from a route, add the following entry to your `routes.rb`:

```ruby
Rails.application.routes.draw do
  get '/users/:user_id', to: MyApp::Admin::UserDetails
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

# Helpers and components library

### `cb_header`
