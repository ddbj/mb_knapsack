require 'digest/md5'
#require 'pp'

module KNApSAcK
class NaturalActivity
    include Helper

def initialize
  to_ttl_prefix
  @refs = references_pmid # @refs
  parse_na_dict # @activity_ja
  parse_na_act  # @activity_sp2
  parse_na_main

end

#	input: Natural_Activity_main_rev.tsv
def parse_na_main

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

# Annotation/Reference/Activity  
    puts "
#{annotation_uri} rdf:type knapsack:KNApSAcKNaturalActivityAnnotation ;  
    knapsack:sp \"#{sp}\" ;
    knapsack:activity #{activity_uri} ;
    dcterms:references #{reference_uri} .

#{activity_uri} rdf:type knapsack:KnapsackNaturalActivity ;
    rdfs:label \"#{activity}\"@en ;
    skos:altLabel \"#{@activity_ja[activity]}\"@ja ;
    dcterms:references #{reference_uri} ;
    sio:SIO_001278 <http://www.knapsackfamily.com/BiologicalActivity/NA_dictionary.pdf> . #sio:is-data-item-in

#{reference_uri} rdf:type knapsack:KNApSAcKReference ;
    dc:title \"#{reference}\" ;
    dcterms:isReferencedBy #{annotation_uri} ;
    dcterms:isReferencedBy #{activity_uri} ;
    rdf:type bibo:Article .

"

if @refs.has_key?(reference_uri)
  puts "#{reference_uri} foaf:primaryTopic <http://rdf.ncbi.nlm.nih.gov/pubmed/#{@refs[reference_uri]}> ."
  puts "#{reference_uri} rdfs:seeAlso <http://identifiers.org/pubmed/#{@refs[reference_uri]}> ."
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
  sio:SIO_000255 #{annotation_uri} . #sio:has-annotation   

#{annotation_uri} knapsack:sp2 \"#{sp2}\" .
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


end
end
