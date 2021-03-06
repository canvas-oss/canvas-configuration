# Copyright 2018-02-24
# Remy BOISSEZON boissezon.remy@gmail.com
# Valentin PRODHOMME valentin@prodhomme.me
# Dylan TROLES chill3d@protonmail.com
# Alexandre ZANNI alexandre.zanni@engineer.com
#
# This software is governed by the CeCILL license under French law and
# abiding by the rules of distribution of free software.  You can  use,
# modify and/ or redistribute the software under the terms of the CeCILL
# license as circulated by CEA, CNRS and INRIA at the following URL
# "http://www.cecill.info".
#
# The fact that you are presently reading this means that you have had
# knowledge of the CeCILL license and that you accept its terms.

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'canvas_oss/configuration/version'

Gem::Specification.new do |spec|
  spec.name          = 'canvas_oss-configuration'
  spec.version       = CanvasOss::Configuration::VERSION
  spec.version       = "#{spec.version}-alpha-#{ENV['TRAVIS_BUILD_NUMBER']}" if ENV['TRAVIS']
  spec.authors       = %w['Remy BOISSEZON' 'Valentin PRODHOMME' 'Dylan TROLES' 'Alexandre ZANNI']
  spec.email         = %w[boissezon.remy@gmail.com valentin@prodhomme.me chill3d@protonmail.com alexandre.zanni@engineer.com]
  spec.date          = '2018-02-24'
  spec.license       = 'CECILL-2.1'
  spec.required_ruby_version = '>= 2.4.0'

  spec.summary       = 'API for used by CANVAS subsystems'
  spec.description   = 'A little API to load and use CANVAS yaml configuration files'
  spec.homepage      = 'https://github.com/canvas-oss/canvas-configuration'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_development_dependency('bundler', '~> 1.16')
  spec.add_development_dependency('minitest', '~> 5.0')
  spec.add_development_dependency('rake', '~> 10.0')
end
