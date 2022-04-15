require 'pp'
#require 'cgi'
require 'uri'
require 'json'

module KNApSAcK
class Core

def initialize (selected = "all")
 @ids_data = {}
 @ranks = family_kingdom
 @refs  = references_pmid
 @ids = id_all
 to_ttl_prefix
 #@ids.sort.first(100).each_with_index do |id, i|
 @ids.sort.each_with_index do |id, i|
     @id = id
     next if (selected != "all" and selected != id.to_s)
     #pp [id, selected]
     #parse_by_id 'C00000091'
     parse_by_id
     warn "#{i}\t#{@id}"
     to_ttl @ids_data[id]

 end
 #puts JSON.pretty_generate(@ids_data)
end

def to_ttl_prefix
puts "
@prefix : <http://mb-wiki.nig.ac.jp/resource/> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix dc: <http://purl.org/dc/elements/1.1/> .
@prefix dcterms: <http://purl.org/dc/terms/> .
@prefix mb: <http://ddbj.nig.ac.jp/ontolofies/metabobank/> .
@prefix mb-wiki: <http://mb-wiki.nig.ac.jp/> .
@prefix sio: <http://semanticscience.org/resource/> .
@prefix cheminf: <http://semanticscience.org/resource/> .
@prefix foaf: <http://xmlns.com/foaf/0.1/> .
"
end

def to_ttl h
    #subject = "<http://mb-wiki.nig.ac.jp/resource/#{h[:id]}>"
    subject =":#{h[:id]}"
puts "
#{subject}
  rdf:type mb:KNApSAcKCoreRecord ;
  dc:identifier \"#{h[:id]}\" ;
  rdfs:label \"#{h[:name]}\" ;
  mb:fid \"#{h[:fid]}\" ;
  foaf:homepage mb-wiki:#{h[:id]} ;
  rdfs:seeAlso <http://www.knapsackfamily.com/knapsack_core/info.php?sname=C_ID&word=#{h[:id]}> ;
  sio:SIO_000008 #{subject}\\/molecular_formula ; #sio:has-attribute
  sio:SIO_000008 #{subject}\\/names ;             #sio:has-attribute
  cheminf:CHEMINF_000200 #{subject}\\/smiles ;            #cheminf:has-attribute
  cheminf:CHEMINF_000200 #{subject}\\/standard_inchikey ; #cheminf:has-attribute
  cheminf:CHEMINF_000200 #{subject}\\/standard_inchi ;    #cheminf:has-attribute
  cheminf:CHEMINF_000200 #{subject}\\/cas ;               #cheminf:has-attribute
  cheminf:CHEMINF_000200 #{subject}\\/start_substance ;   #cheminf:has-attribute
  dcterms:hasPart #{subject}\\/x-mdl-molfile ;  
  dcterms:hasPart #{subject}\\/x-chemdraw ;  
  dcterms:hasPart #{subject}\\/gif .  
"

puts "
#{subject}\\/x-mdl-molfile 
  rdf:type cheminf:CHEMINF_000058 ;
  dcterms:format <nrn:mimetype:chemical/x-mdl-molfile> ; 
  rdfs:seeAlso mb-wiki:Mol:C00000091 .

#{subject}\\/x-chemdraw
  rdf:type mb:CDXfile ;
  dcterms:format <nrn:mimetype:chemical/x-chemdraw> ; 
  rdfs:seeAlso mb-wiki:File:C00000091.cdx .

#{subject}\\/gif
  rdf:type mb:SDfile ;
  dcterms:format <nrn:mimetype:image/gif> ; 
  rdfs:seeAlso mb-wiki:File:C00000091.gif .

"

puts "
#{subject}\\/molecular_formula
  rdf:type cheminf:CHEMINF_000042 ;
  sio:SIO_000300 \"#{h[:comp]}\" .

#{subject}\\/names
  rdf:type cheminf:CHEMINF_000043 ;
  sio:SIO_000300 \"#{h[:name]}\" .

#{subject}\\/smiles
  rdf:type cheminf:CHEMINF_000018 ;
  sio:SIO_000300 \"#{h[:smiles]}\" .

#{subject}\\/standard_inchikey
  rdf:type cheminf:CHEMINF_000059 ;
  sio:SIO_000300 \"#{h[:ikey]}\";
  rdfs:seeAlso <http://identifiers.org/inchikey/#{h[:ikey]}>.
  
#{subject}\\/standard_inchi
  rdf:type cheminf:CHEMINF_000113 ;
  sio:SIO_000300 \"#{h[:inchi]}\";
  rdfs:seeAlso <http://identifiers.org/inchi/#{h[:inchi]}>.
  
#{subject}\\/start_substance
  rdf:type mb:Start_substance ;
  sio:SIO_000300 \"#{h[:substance]}\" .
"

cas =
"
#{subject}\\/cas
  rdf:type cheminf:CHEMINF_000446 ;
  sio:SIO_000300 \"#{h[:cas_id]}\";
  rdfs:seeAlso <http://identifiers.org/cas/#{h[:cas_id]}>.
"

#h[:annotations].first(1).each do |ann|
h[:annotations].each do |ann|
  #s = "#{subject}\\/#{ann[:organism].gsub(' ','-')}"
  s = "#{subject}\\/#{URI.encode(ann[:organism].gsub(".","_").gsub("(","_").gsub(")","_"))}"
  s = "<http://mb-wiki.nig.ac.jp/resource/#{h[:id]}/organism##{URI.encode(ann[:organism])}>"
  puts "
#{subject} sio:SIO_000255 #{s} ." #sio:has-annotation
  puts "
#{s} rdf:type mb:KNApSAcKCoreAnnotations ;
  mb:organism \"#{ann[:organism]}\" ;
  mb:references \"#{ann[:reference]}\" ;
  mb:sp1 \"#{ann[:sp1]}\" ;
  mb:family \"#{ann[:family]}\" ;
  mb:kingdom \"#{ann[:kingdom]}\" ;"
  ann[:pmids].each do |pmid|
    puts "  mb:pmid \"#{pmid}\" ;"
    puts "  dcterms:references  <http://identifiers.org/pubmed/#{pmid}> ;" 
  end
  puts "  rdfs:seeAlso <http://identifiers.org/taxonomy/#{ann[:taxonomy]}> ;" if ann[:taxonomy].to_i > 0
  puts "  rdf:type mb:KNApSAcKCoreAnnotations ."

  puts 
  #pp ann
end

end

def parse_by_id
 id_data
 in_chi_key
 id_cas
 start_substance
 smiles_inchi
 #puts JSON.pretty_generate(@ids_data)
end

def id_all
  @id_hash = {}
  file_path = '有田先生用_20210806/id_data.dat'
  File.foreach(file_path) do |line|
      id = line.chomp.split("\t").first
      @id_hash[id] = 1
  end
  @ids = @id_hash.keys
end

def references_pmid
    @refs ={}
    file_path = 'knapsack-references-uniq-20210823.pmid'
    File.foreach(file_path) do |line|
        pmid, references = line.chomp.split("\t")
        @refs[references] = pmid
    end
    @refs
end

def id_data
  begin
    #file_path = '有田先生用_20210806/id_data.dat'
    file_path = 'knapsack_20210806_id_data.tsv' # OpenRefine tax_id mapping
    annotations = []
    id = fid = comp = name = nil
    File.foreach(file_path).grep(/#{@id}/) do |line|
      # C00000091 C10H13N5O_C00000091 C10H13N5O trans-Zeatin  Abies balsamea  Little,Phytochem.,18,(1979),1219
      id, fid, comp, name, organism, reference, taxonomy_id =  line.chomp.split("\t")
      sp1 = organism.split(" ").first
      rank = @ranks[sp1] || {:sp1 => '', :family => '-', :kingdom => '-'}
      reference = reference.to_s
      ref_key = reference.gsub(":[Pathway]", ";[Pathway]").split(";").map{|x| x.gsub(",", ", ").gsub(".",". ")}.delete_if{|x| x == "[Pathway]"}
      pmids = []
      ref_key.each do |r|
          pmids.push @refs[r] if @refs[r] != ""
      end
      annotations.push({
          :organism => organism ,
          #:sp1 => rank[:sp1],
          :family => rank[:family],
          :kingdom => rank[:kingdom],
          :taxonomy => taxonomy_id, 
          :reference => reference,
          :references => ref_key,
          #:references => reference.gsub(":[Pathway]", ";[Pathway]").split(";").map{|x| x.gsub(",", ", ").gsub(".",". ")}.delete_if{|x| x == "[Pathway]" }
          :pmids => pmids
      })
    end
    @ids_data[@id] = { :id => id, :fid => fid, :comp => comp, :name => name, :annotations => annotations}
  rescue SystemCallError => e
    puts %Q(class=[#{e.class}] message=[#{e.message}])
  end
end

#in_chi_key.dat
def in_chi_key
  begin
    file_path = '有田先生用_20210806/in_chi_key.dat'
    id = ikey = nil
    File.foreach(file_path).grep(/#{@id}/) do |line|
      #C00000091 UZKQTCBAMSWPJD-FARCUNLSSA-N
      id, ikey =  line.chomp.split("\t")
    end
    #d = { :id => id, :ikey => ikey}
    @ids_data[@id][:ikey] = ikey
  rescue SystemCallError => e
    puts %Q(class=[#{e.class}] message=[#{e.message}])
  end
end

def id_cas
  begin
    file_path = '有田先生用_20210806/cas_id.dat'
    id = cas_id = nil
    File.foreach(file_path).grep(/#{@id}/) do |line|
      #C00000091       1637-39-4
      id, cas_id=  line.chomp.split("\t")
    end
    @ids_data[@id][:cas_id] = cas_id
  rescue SystemCallError => e
    puts %Q(class=[#{e.class}] message=[#{e.message}])
  end
end

def start_substance
  begin
    file_path = '有田先生用_20210806/start_substance.dat'
    id = substance = nil
    File.foreach(file_path).grep(/#{@id}/) do |line|
      #C00000091       1637-39-4
      id, substance =  line.chomp.split("\t")
    end
    @ids_data[@id][:substance] = substance
  rescue SystemCallError => e
    puts %Q(class=[#{e.class}] message=[#{e.message}])
  end
end

def smiles_inchi
  begin
    file_path = '有田先生用_20210806/smiles_inchi.dat'
    id = smiles = inchi= nil
    File.foreach(file_path).grep(/#{@id}/) do |line|
      #C00000091       1637-39-4
      id, smiles, inchi =  line.chomp.split("\t")
    end
    @ids_data[@id][:smiles] = smiles
    @ids_data[@id][:inchi] = inchi
  rescue SystemCallError => e
    puts %Q(class=[#{e.class}] message=[#{e.message}])
  end
end

# family_kingdom.dat
def family_kingdom 
  @ranks ={}
  begin
    file_path = '有田先生用_20210806/family_kingdom.dat'
    sp1 = family =  kindom = nil
    File.foreach(file_path) do |line|
      sp1, family, kingdom =  line.chomp.split("\t")
      @ranks[sp1] = {:sp1 => sp1, :family => family, :kingdom => kingdom } 
    end
    @ranks
  rescue SystemCallError => e
    puts %Q(class=[#{e.class}] message=[#{e.message}])
  end
end

end
end

kc = KNApSAcK::Core.new(ARGV.shift)
