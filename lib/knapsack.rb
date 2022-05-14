require 'pp'
require 'cgi'
require 'uri'
require 'json'
require 'digest/md5'
require 'zlib'
require "open3"

module KNApSAcK
module Helper
 # input: id_mapping/reference-pmid-20210823.tsv
 def references_pmid
    @refs ={}
    file_path = './id_mapping/reference-pmid-20210823.tsv'
    File.foreach(file_path) do |line|
      ref_uri, pmid, title =  line.chomp.split("\t")
      @refs[ref_uri] = pmid if pmid == ""
    end
    @refs
  end
  
  def to_ttl_prefix
  puts "
  @base <http://purl.jp/knapsack/> .
  @prefix : <http://purl.jp/knapsack/> .
  @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
  @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
  @prefix dc: <http://purl.org/dc/elements/1.1/> .
  @prefix dcterms: <http://purl.org/dc/terms/> .
  @prefix mb: <http://ddbj.nig.ac.jp/ontolofies/metabobank/> .
  @prefix sio: <http://semanticscience.org/resource/> .
  #core  
  @prefix cheminf: <http://semanticscience.org/resource/> .
  @prefix foaf: <http://xmlns.com/foaf/0.1/> .
  @prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
  @prefix obo: <http://purl.obolibrary.org/obo/> .
  #biological_activity
  @prefix skos: <http://www.w3.org/2004/02/skos/core#> .
  @prefix owl: <http://www.w3.org/2002/07/owl#> .

  
  "
  end    
end

end


require_relative 'knapsack/core.rb'
require_relative 'knapsack/metabolite_activity.rb'
require_relative 'knapsack/natural_activity.rb'
require_relative 'knapsack/reference.rb'
require_relative 'knapsack/biological_activity.rb'
require_relative 'knapsack/resource.rb'