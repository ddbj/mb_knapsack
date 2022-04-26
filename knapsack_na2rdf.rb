require 'digest/md5'
#require 'pp'

module KNApSAcK
class NaturalActivity

def initialize
  to_ttl_prefix
  references_pmid # @refs
  parse_na_dict # @activity_ja
  parse_na_act  # @activity_sp2
  parse_na_main

end

#	input: Natural_Activity_main_rev.tsv
def parse_na_main
 puts "
<KnapsackBiologicalActivity> rdf:type owl:Class ;
  rdfs:label \"(Obsolete)KnapsackBiologicalActivity\"@en ;
  #rdfs:subClassOf <http://purl.jp/bio/4/id/kb0000002422> ;
  sio:SIO_001278 <http://www.knapsackfamily.com/BiologicalActivity/NA_dictionary.pdf> .
"
 file_path = 'kushida/変換前20210927/Natural_Activity_main_rev.tsv'
 File.foreach(file_path) do |line|
   #sp	activity	reference
   sp, activities, reference  = line.chomp.split("\t")
   next if sp == "sp"
   next if sp == "(1432 rows)"
   #pp [sp,activities, reference]
   activities.split(";").each do |act|
    activity = act.split("(").first #FIXME
    annotation_uri = "<annotation##{Digest::MD5.hexdigest(sp)}>"
    activity_uri = "<activity##{Digest::MD5.hexdigest(activity)}>"
    reference_uri = "<reference##{Digest::MD5.hexdigest(reference)}>"
    #pp [annotation_uri, sp, activity, reference_uri, reference]
    puts "
#{annotation_uri} rdf:type <KNApSAcKNaturalActivityAnnotation> ;  
    mb:sp \"#{sp}\" ;
    mb:activity #{activity_uri} ;
    mb:reference #{reference_uri} .

#{reference_uri} rdf:type mb:KNApSAcKReference ;
    dc:title \"#{reference}\" .

#{activity_uri} rdf:type owl:Class ;
    rdfs:subClassOf mb:KNApSAcKActivity ;
    rdfs:label \"#{activity}\"@en ;
    skos:altLabel \"#{@activity_ja[activity]}\"@ja ;
    sio:SIO_001278 <http://www.knapsackfamily.com/BiologicalActivity/NA_dictionary.pdf> . #sio:is-data-item-in
"
if @refs[reference]
  puts "#{reference_uri} dcterms:references @refs[references] ."
end

#    rdfs:subClassOf <http://purl.jp/bio/4/id/kb0000001321> ;
#    skos:exactMatch "http://purl.obolibrary.org/obo/CHEBI_64995" .

   end
 end
end

#	input: Natural_Activity_act_list.tsv
def parse_na_act
  @activity_sp2 ={}
  file_path = 'kushida/変換前20210927/Natural_Activity_act_list.tsv'
  File.foreach(file_path) do |line|
    #activity	sp2
    activity, sp2s  = line.chomp.split("\t")
    #pp [activity, sp2s]
    @activity_sp2[activity] = sp2s.to_s.split("/")
    sp2s.to_s.split("/").each do |sp2|
      #pp [activity, sp2]
      annotation_uri = "<annotation##{Digest::MD5.hexdigest(sp2)}>"
      activity_uri = "<activity##{Digest::MD5.hexdigest(activity)}>"

      puts "
#{activity_uri} rdfs:label \"#{activity}\" ;
  sio:SIO_00025 #{annotation_uri} . #sio:has-annotation   

#{annotation_uri} mb:sp2 \"#{sp2}\" .
"
    end
  end
  @activity_sp2
 end

#	input: Natural_Activity_dictionary.tsv
 def parse_na_dict
  @activity_ja ={}
  file_path = 'kushida/変換前20210927/Natural_Activity_dictionary.tsv'
  File.foreach(file_path) do |line|
    #activity	activity_j
    activity, activity_j  = line.chomp.split("\t")
    #pp [activity, activity_j]
    @activity_ja[activity] = activity_j
  end
  @activity_ja
 end

# input: knapsack-references-uniq-20210823.pmid
def references_pmid
  @refs ={}
  file_path = 'knapsack-references-uniq-20210823.pmid'
  File.foreach(file_path) do |line|
      pmid, references = line.chomp.split("\t")
      @refs[references] = pmid
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
@prefix skos: <http://www.w3.org/2004/02/skos/core#> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .


"
end

end
end

kn = KNApSAcK::NaturalActivity.new
