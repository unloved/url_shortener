require 'grape'
require './app/models/url'
require './app/models/url_visit'

class API < Grape::API
  format :json

  get "/:key" do
    url = Url.where(key: params[:key]).first
    if url.present?
      data = {
        ip: request.ip,
        referer: request.referer
      }
      UrlVisit.create(url: url, data: data)
      redirect url.original_url
    else
      redirect '/error.html'
    end
  end

  namespace :api do
    resource :urls do
      post '/' do
        model_attributes = params[:model]
        url = Url.new(model_attributes)
        if url.save
          {url: url.key, strategy: url.strategy}
        else
          error!({error: url.errors.to_hash}, 400)
        end
      end

      get '/:key' do
        url = Url.find_by_key(params[:key])
        url.visits.map{|v| v.data}
      end
    end
  end
end