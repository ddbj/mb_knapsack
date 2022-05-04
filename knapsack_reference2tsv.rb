#!/usr/bin/env ruby

require './lib/knapsack.rb'

kc = KNApSAcK::Reference.new(ARGV.shift)
kc.to_tsv
