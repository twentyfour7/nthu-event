# frozen_string_literal: true
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'nthuevent/version'

Gem::Specification.new do |s|
  s.name        =  'nthuevent'
  s.version     =  NthuEvent::VERSION

  s.summary     =  'Gets event content from NTHU bulletin'
  s.description =  'Extracts the title, content, and other informaiton of an event'
  s.authors     =  ['JJC', 'Rollee Chen', 'shannywu']
  s.email       =  ['jjc@nlplab.cc']

  s.files       =  `git ls-files`.split("\n")
  s.test_files  =  `git ls-files -- spec/*`.split("\n")
  s.executables << 'nthuevent'

  s.add_runtime_dependency 'nokogiri', '~> 1.6'

  s.add_development_dependency 'minitest', '~> 5.9'
  s.add_development_dependency 'minitest-rg', '~> 5.2'
  s.add_development_dependency 'rake', '~> 11.3'
  s.add_development_dependency 'vcr', '~> 3.0'
  s.add_development_dependency 'webmock', '~> 2.1'
  s.add_development_dependency 'simplecov', '~> 0.12'
  s.add_development_dependency 'flog', '~> 4.4'
  s.add_development_dependency 'flay', '~> 2.8'
  s.add_development_dependency 'rubocop', '~> 0.42'

  s.homepage    =  'https://github.com/twentyfour7/nthu-event'
  s.license     =  'MIT'
end
