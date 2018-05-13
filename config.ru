require './application'

use OTR::ActiveRecord::ConnectionManagement
use Rack::TryStatic, :urls => [""], :root => 'public', :index => 'index.html'
run API