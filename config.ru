require './api'
require 'rack'
require 'rack/contrib'

use Rack::TryStatic, :urls => [""], :root => 'public', :index => 'index.html'
run API