require 'spec_helper'
require '././application'

describe API do
  include Rack::Test::Methods

  def app
    API
  end

  let(:url) {create(:url)}
  let(:visit_data) {create_list(:url_visit, 2, {url: url})}
  let(:url_params) { attributes_for(:url) }

  context 'GET /:key' do
    it 'redirects to original url' do
      expect(url.present?).to eq(true)
      expect(UrlVisit.count).to eq(0)
      get "/#{url.key}"
      expect(last_response.status).to eq(302)
      expect(UrlVisit.count).to eq(1)
    end

    it 'redirects to error on invalid params' do
      expect(UrlVisit.count).to eq(0)
      expect(url.present?).to eq(true)
      get "/invalid_request"
      expect(last_response.status).to eq(302)
      expect(UrlVisit.count).to eq(0)
    end
  end

  context 'POST /api/urls' do
    it 'creates url record' do
      expect(Url.count).to eq(0)
      post "/api/urls", {model: url_params}
      expect(last_response.status).to eq(201)
      expect(Url.count).to eq(1)
      expect(Url.last.original_url).to eq(url_params[:original_url])
    end

    it 'creates url record with specific strategy' do
      expect(Url.count).to eq(0)
      strategy = Url::STRATEGIES.sample
      post "/api/urls", {model: url_params.merge(strategy: strategy)}
      expect(last_response.status).to eq(201)
      expect(Url.count).to eq(1)
      expect(Url.last.strategy).to eq(strategy)
    end

    it 'returns an error with invalid params' do
      expect(Url.count).to eq(0)
      post "/api/urls", {model: {original_url: nil}}
      expect(last_response.status).to eq(400)
      expect(Url.count).to eq(0)
    end
  end

  context 'GET /api/urls/:key' do
    it 'returns visit data for url' do
      expect(visit_data.count).to eq(2)
      get "/api/urls/#{url.key}"
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body).count).to eq(2)
    end
  end
end