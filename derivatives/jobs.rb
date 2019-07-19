# frozen_string_literal: true

# This little feller just tells sidekiq to load all the other stuff we need for
# processing the various jobs so all our dependencies can live here instead of
# scattered throughout the code

require 'aws-sdk'
require 'fileutils'
require 'open3'
require 'shellwords'
require 'sidekiq'
require 'tempfile'

require_relative('./shell.rb')
require_relative('./create_images.rb')
require_relative('./create_image_derivatives_job.rb')
require '/usr/local/oddeps/lib/oregon_digital/derivative_path.rb'
