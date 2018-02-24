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

require 'canvas_oss/configuration/version'
require 'canvas_oss/configuration/default_path'
require 'yaml'

module CanvasOss
  # A class that open a CANVAS configuration file and parse it
  # @example Load configuration from a CANVAS subsystem_name subsystem configuration file. A default file URI is assumed.
  # => configuration = new Configuration(uri)
  class Configuration
    # :global contains CANVAS global configuration as a hash
    attr_reader :global
    # :subsys contains CANVAS subsystem configuration as a hash
    attr_reader :subsys

    SUBSYSTEM_NAME = 'subsystem_name'.freeze

    # Load CANVAS configuration file from `uri` file or from default file
    def initialize(uri = nil)
      filename = File.realpath(File.join(DEFAULT_PATH, configuration_filename)) unless uri
      filename = File.realpath(uri) if uri.is_a?(String) && uri.length.positive?
      # Load YAML configuration file
      documents = []
      YAML.load_stream(File.read(filename)) do |document|
        documents << document
      end
      # CANVAS Configuration file contain CANVAS global configuration
      @global = validate_global(documents[0])
      # CANVAS Configuration file contains CANVAS product-inventory subprocess configuration
      @subsys = validate_subsys(documents[1])
    end

    # Ensure that CANVAS configuration contains at least some parameters
    def validate_global(hash)
      # CANVAS global configuration contains `canvas`
      hash.key?(:canvas)
      # CANVAS global configuration contains database parameters
      hash[:canvas].key?(:database)
      # CANVAS global configuration contains `canvas_configuration` database parameters
      hash[:canvas][:database].key?(:canvas_configuration)
      hash[:canvas][:database][:canvas_configuration].key?(:host)
      hash[:canvas][:database][:canvas_configuration].key?(:port)
      hash[:canvas][:database][:canvas_configuration].key?(:database)
      hash[:canvas][:database][:canvas_configuration].key?(:username)
      hash[:canvas][:database][:canvas_configuration].key?(:password)
      # CANVAS global configuration contains `canvas_data` database parameters
      hash[:canvas][:database].key?(:canvas_data)
      hash[:canvas][:database][:canvas_data].key?(:host)
      hash[:canvas][:database][:canvas_data].key?(:port)
      hash[:canvas][:database][:canvas_data].key?(:database)
      hash[:canvas][:database][:canvas_data].key?(:username)
      hash[:canvas][:database][:canvas_data].key?(:password)
      return hash[:canvas]
    end

    # Ensure that CANVAS subsystem configuration contains at least some parameters
    # This method should be overloaded
    def validate_subsys(hash)
      # CANVAS global configuration contains `subsystem_name`
      hash.key?(:subsystem_name)
      return hash[:subsystem_name]
    end

    # Return configuration filename
    def configuration_filename
      return SUBSYSTEM_NAME + '.yml'
    end
  end
end
