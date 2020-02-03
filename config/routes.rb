Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root to: 'landing#index'

  with_options controller: 'landing' do |landing|
    landing.get '/', action: :index, format: false
    landing.get '/*path', action: :index, format: false
  end
end
