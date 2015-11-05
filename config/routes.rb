Rails.application.routes.draw do

namespace :api do
  namespace :v1 do

    namespace :customers, defaults: { format: :json} do
        get "/:id/favorite_merchant", to: "customer_logic#favorite_merchant"
      end
    resources :customers, only: [:index, :show], defaults: { format: :json} do
      collection do
        get 'random'
        get 'find'
        get 'find_all'
      end
      resources :invoices, only: [:index], module: :customers
      resources :transactions, only: [:index], module: :customers
    end

    resources :invoice_items, only: [:index, :show], defaults: { format: :json} do
      collection do
        get 'random'
        get 'find'
        get 'find_all'
      end
      resource :invoice, only: [:show], module: :invoice_items
      resource :item, only: [:show], module: :invoice_items
    end

    resources :invoices, only: [:index, :show], defaults: { format: :json} do
      collection do
        get 'random'
        get 'find'
        get 'find_all'
      end
      resources :transactions, only: [:index], module: :invoices
      resources :invoice_items, only: [:index], module: :invoices
      resources :items, only: [:index], module: :invoices
      resource :customer, only: [:show], module: :invoices
      resource :merchant, only: [:show], module: :invoices
    end

    namespace :items, defaults: { format: :json} do
        get "/:id/best_day", to: "item_logic#best_day"
        get "most_revenue", to: "item_logic#most_revenue"
        get "most_items", to: "item_logic#most_items"
      end
    resources :items, only: [:index, :show], defaults: { format: :json} do
      collection do
        get 'random'
        get 'find'
        get 'find_all'
      end
      resources :invoice_items, only: [:index], module: :items
      resource :merchant, only: [:show], module: :items
    end

    namespace :merchants, defaults: { format: :json} do
        get "/revenue", to: "merchant_logic#revenue_by_date"
        get "/most_revenue", to: "merchant_logic#most_revenue"
        get "/most_items", to: "merchant_logic#most_items"
        get "/:id/favorite_customer", to: "merchant_logic#favorite_customer"
        get "/:id/revenue", to: "merchant_logic#revenue"
        get "/:id/customers_with_pending_invoices", to: "merchant_logic#pending_invoices"
      end
    resources :merchants, only: [:index, :show], defaults: { format: :json} do
      collection do
        get 'random'
        get 'find'
        get 'find_all'
      end
      resources :items, only: [:index], module: :merchants
      resources :invoices, only: [:index], module: :merchants
    end

    resources :transactions, only: [:index, :show], defaults: { format: :json} do
      collection do
        get 'random'
        get 'find'
        get 'find_all'
      end
      resource :invoice, only: [:show], module: :transactions
    end
  end
end

end
