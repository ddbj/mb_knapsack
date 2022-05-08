require 'pp'
require 'cgi'
require 'uri'
require 'json'
require 'digest/md5'
require 'zlib'
require "open3"

module KNApSAcK
end


require_relative 'knapsack/core.rb'
require_relative 'knapsack/metabolite_activity.rb'
require_relative 'knapsack/natural_activity.rb'
require_relative 'knapsack/reference.rb'
