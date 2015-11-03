Rails.application.routes.draw do

namespace :api do
  namespace :v1 do
    resources :customers, except: [:new, :edit], defaults: { format: :json}
    resources :invoice_items, except: [:new, :edit]
    resources :invoices, except: [:new, :edit]
    resources :items, except: [:new, :edit]
    resources :merchants, except: [:new, :edit]
    resources :transactions, except: [:new, :edit]
  end
end

end