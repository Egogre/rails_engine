Rails.application.routes.draw do

namespace :api do
  namespace :v1 do
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

    resources :items, only: [:index, :show], defaults: { format: :json} do
      collection do
        get 'random'
        get 'find'
        get 'find_all'
      end
      resources :invoice_items, only: [:index], module: :items
      resource :merchant, only: [:show], module: :items
    end

    get 'merchants/find', to: 'merchants#find', defaults: {format: :json}
    resources :merchants, only: [:index, :show], defaults: { format: :json}

    get 'transactions/find', to: 'transactions#find', defaults: {format: :json}
    resources :transactions, only: [:index, :show], defaults: { format: :json}
  end
end

end
