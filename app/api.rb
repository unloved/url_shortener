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
        url = Url.new(original_url: params[:url])
        if url.save
          {url: url.key}
        else
          error!({error: url.errors[:original_url].join(', ')})
        end
      end

      get '/:key' do
        url = Url.find_by_key(params[:key])
        url.visits.map{|v| v.data}
      end
    end
  end
end