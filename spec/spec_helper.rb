# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'vcr'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|

  # config.treat_symbols_as_metadata_keys_with_true_values = true
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.include Rails.application.routes.url_helpers
  config.include Capybara::DSL

  config.around(:each, :vcr) do |example|
    name = example.metadata[:full_description].split(/\s+/, 2).join("/").underscore.gsub(/[^\w\/]+/, "_")
    options = {}
    options[:record] = example.metadata[:record] if example.metadata[:record]
    VCR.use_cassette(name, options) { example.call }
  end
end


VCR.configure do |c|
  c.cassette_library_dir        = 'spec/vcr'
  c.hook_into                   :webmock

  c.default_cassette_options    = {
    :record                     => :once,
    :decode_compressed_response => true,
    # Because psych is binary encoding response headers marked with ASCII-8BIT
    # https://groups.google.com/forum/?fromgroups#!topic/vcr-ruby/2sKrJa86ktU
    # And syck's output is much easier to read
    :serialize_with             => :psych,
  }

  # Pretty print your json so it's not all on one line
  # From discussion here: https://github.com/myronmarston/vcr/pull/147
  # https://gist.github.com/26edfe7669cc7b85e164
  c.before_record do |i|
    type = Array(i.response.headers['Content-Type']).join(',').split(';').first
    code = i.response.status.code

    if type =~ /[\/+]json$/ or 'text/javascript' == type
      begin
        data = JSON.parse i.response.body
      rescue
        if code != 404
          puts
          warn "VCR: JSON parse error for Content-type #{type}"
          warn "Your unparseable json is: " + i.response.body.inspect
          puts
        end
      else
        i.response.body = JSON.pretty_generate data
        i.response.update_content_length_header
      end
    end
  end
end
