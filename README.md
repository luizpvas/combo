# Combo

Combo is a full stack component library for Rails inspired by Liveview and Livewire. The goal is to provide better
abstractions than MVC for building admin and backoffice applications.

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
4. Component library
   - Date picker

# Definins components

Components encapsulate a view and actions. The view works similar to templates, and actions work similar to
controllers.

```ruby
class MyApp::AccountDetails < Combo::Component
  attribute :account, Account

  def view
    inline <<~HTML
      <%= form_with url: action(:submit) do |f| %>
        <%= f.combo_date_picker(:date) %>
        <%= f.combo_money(:amount) %>
        <%= f.submit "Schedule payment" %>
      <% end %>
    HTML
  end

  def submit
    payment_id = account.payments.schedule(date: params[:date], amount: params[:amount])

    flash.success "Payment #{payment_id} scheduled"
  end
end
```

# State management

There are four pieces of state in a component:

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

When doing so, your component must implement the `resolve` method. For example:

```ruby
class MyApp::PaymentDetails < Combo::Component
  attribute :payment, Payment

  def resolve
    payment = Payment.find(params[:payment_id])

    render(payment:)
  end

  def view
    partial "my_app/payment_details"
  end
end
```
