# Copyright 2018-02-22
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

require 'test_helper'

module CanvasOss
  class ConfigurationTest < Minitest::Test
    SUBSYSTEM_NAME = 'subsystem_name'.freeze
    SAMPLE_FILE_PATH = 'files/canvas-configuration-sample.yml'.freeze

    def test_that_it_has_a_version_number
      refute_nil ::CanvasOss::Configuration::VERSION
    end

    def test_that_it_has_a_default_path_name
      refute_nil ::CanvasOss::Configuration::DEFAULT_PATH
    end

    def test_that_sample_file_can_be_loaded
      assert CanvasOss::Configuration.new(SAMPLE_FILE_PATH)
      assert_raises(StandardError) { CanvasOss::Configuration.new('dummy_filepath.yml') }
      assert_raises(StandardError) { CanvasOss::Configuration.new() }
    end

    def test_that_parameters_are_retrieved_from_sample_file
      assert configuration = CanvasOss::Configuration.new(SAMPLE_FILE_PATH)
      assert configuration.global.key?(:database)
      assert configuration.global[:database].key?(:canvas_configuration)
      assert configuration.global[:database].key?(:canvas_data)
      assert configuration.subsys.key?(:domain)
    end
  end
end
