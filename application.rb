require './app/api'
require 'rack'
require 'rack/contrib'
require 'otr-activerecord'

OTR::ActiveRecord.configure_from_file! "config/database.yml"