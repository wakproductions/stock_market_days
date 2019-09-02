# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stock_market_days/version'

Gem::Specification.new do |spec|
  spec.name          = "stock_market_days"
  spec.version       = StockMarketDays::VERSION
  spec.authors       = ["Winston Kotzan"]
  spec.email         = ["wak@wakproductions.com"]
  spec.summary       = %q{A gem for determining the days that the stock market is open}
  spec.description   = ""
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = [`git ls-files`.split($/)] + Dir["lib/**/*"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler", "~> 1.7"
  spec.add_dependency "rake"

  spec.add_development_dependency "clipboard"
  spec.add_development_dependency "rspec", ">= 3.2"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "webmock"
end
