require 'bundler/setup'
require 'rake/testtask'
load 'tasks/otr-activerecord.rake'

OTR::ActiveRecord.db_dir = 'database'
OTR::ActiveRecord.migrations_paths = ['database/migrations']
OTR::ActiveRecord.fixtures_path = 'test/fixtures'

namespace :db do
  task :environment do
    require_relative 'application'
  end
end

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/*_test.rb']
end