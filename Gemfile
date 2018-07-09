ruby '2.5.1'

# FFI with geos C++ library
gem 'ffi-geos'
# Map geo stuff easily
gem "rgeo", "~> 1.0"
# Import/export using geojson files
gem "rgeo-geojson", "~> 2.0"
# Rails is awesome :)
gem 'rails', '~> 5.2.0'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use postgis adapter instead of postgres one
gem 'activerecord-postgis-adapter', '~> 5.2.1'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'byebug', platforms: :mri
  gem 'rspec-rails', '~> 3.7.2'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
end
