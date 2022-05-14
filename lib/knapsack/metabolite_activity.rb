require 'digest/md5'
require 'pp'

module KNApSAcK
class MetaboliteActivity
    include Helper

def initialize (selected = nil)
  if selected != nil
    @selected = selected
  end
  to_ttl_prefix
  @refs = references_pmid # @refs
  parse_na_dict # @activity_ja
  parse_ma_main

end

#	input: Metabolite_Activity.tsv
def parse_ma_main

 file_path = 'kushida/変換前20210927/Metabolite_Activity.tsv'
 File.foreach(file_path) do |line|
   #cid	metabolite	category	function	targetsp	reference
   #referenceが複数 or ない場合がある
   #cid, targetspがない場合がある
   #Activity categories 
   #Individual descriptions of biological activities 
   cid, metabolite, category, function, targetsp, references = line.chomp.split("\t")
   next if cid == "cid"
   next if (@selected and cid != @selected)
   #next if sp == "(1432 rows)"
   
   references.to_s.split(";").each do |reference|
    #pp [cid, metabolite, category, function, targetsp, reference]
    annotation_uri = "<annotation##{Digest::MD5.hexdigest(targetsp)}>"
    compound_uri = "<#{cid}>"
    activity_uri = "<activity##{Digest::MD5.hexdigest(function)}>"
    reference_uri = "<reference##{Digest::MD5.hexdigest(reference)}>"

    #cidがない場合はblank node
    unless cid == "" and targetsp == ""
      puts "
#{compound_uri}
  rdf:type mb:KNApSAcKMetaboliteRecord ;
  dc:identifier \"#{cid}\" ;
  mb:category \"#{category}\" ;
  mb:function \"#{function}\" ;
  mb:targetsp \"#{targetsp}\" ;
  dcterms:isReferencedBy #{reference_uri} ;
  sio:SIO_000255 #{annotation_uri} ; # sio:has-annotation
  mb:has-activity #{activity_uri} ;
  rdfs:label \"#{metabolite}\" .
"   
    else 
      puts "
[
  rdf:type mb:KNApSAcKMetaboliteRecord ;
  mb:category \"#{category}\" ;
  mb:function \"#{function}\" ;
  mb:targetsp \"#{targetsp}\" ;
  dcterms:isReferencedBy #{reference_uri} ;
  mb:has-activity #{activity_uri} ;
  rdfs:label \"#{metabolite}\" 
    ].
"  
    end

    unless targetsp == ""
    puts "
#{annotation_uri} rdf:type mb:KNApSAcKMetaboliteActivityAnnotation ;  
    mb:sp \"#{targetsp}\" ;
    dcterms:isReferencedBy #{reference_uri} .
    
#{activity_uri} sio:SIO_000255 #{annotation_uri} .  # sio:has-annotation

    "

    end
    puts "
#{reference_uri} rdf:type mb:KNApSAcKReference ;
    dc:title \"#{reference}\" .
"
    puts "
#{activity_uri} rdf:type mb:KnapsackMetaboliteActivity ;
    rdfs:label \"#{function}\"@en ;
    sio:SIO_001278 <http://www.knapsackfamily.com/MetaboliteActivity/MA_dictionary.pdf> . #sio:is-data-item-in
"

if @refs.has_key?(reference_uri) and @refs[reference_uri] !=""
  puts "#{reference_uri} dcterms:references #{@refs[reference_uri]} ."
end

#    rdfs:subClassOf <http://purl.jp/bio/4/id/kb0000001321> ;
#    skos:exactMatch "http://purl.obolibrary.org/obo/CHEBI_64995" .

   end
 end
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
