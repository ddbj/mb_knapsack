#!/usr/bin/env ruby

require './lib/knapsack.rb'

r = KNApSAcK::Reference.new
r.retrieve_pmid (ARGV.shift)
