require 'api_constraints'

AppstoreInfoApi::Application.routes.draw do
  # Api definition
  scope '/api' do
    scope '/v1' do
      scope '/top_rank' do
        get '/' => 'api/v1/top_ranks#index'
        scope '/publishers' do
          get '/' => 'api/v1/top_ranks#top_publishers'
        end
      end
    end
  end
end
