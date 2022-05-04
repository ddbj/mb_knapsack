require 'pp'
#require 'cgi'
require 'uri'
require 'json'
require 'digest/md5'
require 'zlib'

module KNApSAcK
class Core


def initialize (selected = nil)
  if selected != nil
    @selected = selected
  end
  #warn @selected
  @ids_data = {}
  @ranks = family_kingdom
  @mws = mw_data
  @sp2taxid = sp_taxid
  @refs  = references_pmid
  cid_inchi_key
  cid_cas
  cid_start_substance
  cid_smiles_inchi
  to_ttl_prefix
  output_by_id

end


def output_by_id
  begin
    cids = {}
    file_path = '有田先生用_20210806/id_data.dat'
    #id	fid	comp	name	organism	reference

    id = fid = comp = name = nil
    File.foreach(file_path).each do |line|
      id, fid, comp, name, organism, reference =  line.chomp.split("\t")
      next if (@selected and !@selected[id])
      cid_attrs = { 
        :id => id, 
        :fid => fid, 
        :comp => comp, 
        :name => name, 
        :ikey => @cid2inchi_key[id],  #cid2inchi_key
        :cas_id => @cid2cas[id],      #cid_cas
        :substance => @cid2start_substance[id], #cid_start_substance
        :smiles => @cid2smiles[id], #cid_smiles_inchi
        :inchi => @cid2inchi[id],   #cid_smiles_inchi
        :mw => @mws[id] || "NaN"
      }
      unless cids.key?(id)
        to_ttl cid_attrs
        cids[id] = 1 
      end

      #sp
      sp1 = organism.split(" ").first
      rank = @ranks[sp1] || {:sp1 => '', :family => '-', :kingdom => '-'}
      references_new =[]
      reference.to_s.gsub(":[Pathway]", ";[Pathway]").split(";").each do |title|
        r = title.gsub(",", ", ").gsub(".",". ")
        next if r == "[Pathway]"
        ref_uri = "<reference##{Digest::MD5.hexdigest(title)}>"
        pmid = @refs[ref_uri] || ""
        references_new.push({
          :title => title ,
          :uri => ref_uri ,
          :pmid => pmid
        })        
      end


      ann = {
          :cid => id,
          :uri => "<annotation##{Digest::MD5.hexdigest(organism)}>",
          :organism => organism ,
          #:sp1 => rank[:sp1],
          :family => rank[:family],
          :kingdom => rank[:kingdom],
          :taxonomy => @sp2taxid[organism], 
          :reference => reference.to_s,
          :references_new => references_new
      }
      to_ttl_annotation ann
    end
  rescue SystemCallError => e
    puts %Q(class=[#{e.class}] message=[#{e.message}])
  end
end

#in_chi_key.dat
def cid_inchi_key
  begin
    @cid2inchi_key = {}
    file_path = '有田先生用_20210806/in_chi_key.dat'
    id = ikey = nil
    File.foreach(file_path).each do |line|
      #C00000091 UZKQTCBAMSWPJD-FARCUNLSSA-N
      id, ikey =  line.chomp.split("\t")
      @cid2inchi_key[id] = ikey
    end


    @cid2inchi_key
    #@ids_data[@id][:ikey] = ikey
  rescue SystemCallError => e
    puts %Q(class=[#{e.class}] message=[#{e.message}])
  end
end

def cid_cas
  begin
    @cid2cas ={}
    file_path = '有田先生用_20210806/cas_id.dat'
    id = cas_id = nil
    File.foreach(file_path) do |line|
      #C00000091       1637-39-4
      id, cas_id=  line.chomp.split("\t")
      @cid2cas[id] = cas_id
    end
    
    #@ids_data[@id][:cas_id] = cas_id
  rescue SystemCallError => e
    puts %Q(class=[#{e.class}] message=[#{e.message}])
  end
end

def cid_start_substance
  begin
    @cid2start_substance ={}
    file_path = '有田先生用_20210806/start_substance.dat'
    id = substance = nil
    File.foreach(file_path) do |line|
      id, substance =  line.chomp.split("\t")
      @cid2start_substance[id] = substance
    end
    #@ids_data[@id][:substance] = substance
  rescue SystemCallError => e
    puts %Q(class=[#{e.class}] message=[#{e.message}])
  end
end

def cid_smiles_inchi
  begin
    @cid2smiles = {}
    @cid2inchi = {}
    file_path = '有田先生用_20210806/smiles_inchi.dat'
    id = smiles = inchi= nil
    File.foreach(file_path) do |line|
      id, smiles, inchi =  line.chomp.split("\t")
      @cid2smiles[id] = smiles
      @cid2inchi[id] = inchi
    end
    #@ids_data[@id][:smiles] = smiles
    #@ids_data[@id][:inchi] = inchi
  rescue SystemCallError => e
    puts %Q(class=[#{e.class}] message=[#{e.message}])
  end
end

# id_mapping/sp-taxid-20210806.tsv
def sp_taxid
  @sp2taxid ={}
  file_path = 'id_mapping/sp-taxid-20210806.tsv'
  File.foreach(file_path) do |line|
      sp, taxid = line.chomp.split("\t")
      @sp2taxid[sp] = taxid
  end
  @sp2taxid
end

def references_pmid
  @refs ={}
  file_path = './id_mapping/reference-pmid-20210823.tsv'
  File.foreach(file_path) do |line|
    ref_uri, pmid, title =  line.chomp.split("\t")
    @refs[ref_uri] = pmid
  end
  @refs
end

# knapsack_mw-tmp.txt.gz
def mw_data
  file_path = 'knapsack_mw-tmp.txt.gz'
  mws ={}
  gz = Zlib::GzipReader.open(file_path)
  gz.each_line do |line|
    #puts line
    cid, mw = line.chomp.split("\t")
    mws[cid] = mw
  end
  mws
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
@prefix cheminf: <http://semanticscience.org/resource/> .
@prefix foaf: <http://xmlns.com/foaf/0.1/> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix obo: <http://purl.obolibrary.org/obo/> .


  "
end
  
def to_ttl h
  subject ="<#{h[:id]}>"
  puts "
#{subject}
  rdf:type mb:KNApSAcKCoreRecord ;
  dc:identifier \"#{h[:id]}\" ;
  rdfs:label \"#{h[:name]}\" ;
  mb:fid \"#{h[:fid]}\" ;
  foaf:homepage <https://mb.metabolomics.jp/wiki/Compound:#{h[:id]}> ;
  rdfs:seeAlso <http://www.knapsackfamily.com/knapsack_core/info.php?sname=C_ID&word=#{h[:id]}> ;
  sio:SIO_000008 <#{h[:id]}#molecular_formula> ;         #sio:has-attribute
  sio:SIO_000008 <#{h[:id]}#molecular_entity_name> ;
  sio:SIO_000008 <#{h[:id]}#molecular_weight> ;
  cheminf:CHEMINF_000200 <#{h[:id]}#smiles> ;            #cheminf:has-attribute
  cheminf:CHEMINF_000200 <#{h[:id]}#standard_inchikey> ;
  cheminf:CHEMINF_000200 <#{h[:id]}#standard_inchi> ;
  cheminf:CHEMINF_000200 <#{h[:id]}#cas> ;
  cheminf:CHEMINF_000200 <#{h[:id]}#start_substance> ;
  dcterms:hasPart <#{h[:id]}#x-mdl-molfile> ;  
  dcterms:hasPart <#{h[:id]}#x-chemdraw> ;  
  dcterms:hasPart <#{h[:id]}#gif> . 


<#{h[:id]}#x-mdl-molfile> 
  rdf:type cheminf:CHEMINF_000058 ;
  dcterms:format <nrn:mimetype:chemical/x-mdl-molfile> ; 
  rdfs:seeAlso <https://mb.metabolomics.jp/wiki/Mol:#{h[:id]}> .

<#{h[:id]}#x-chemdraw> 
  rdf:type mb:CDXfile ;
  dcterms:format <nrn:mimetype:chemical/x-chemdraw> ; 
  rdfs:seeAlso <https://mb.metabolomics.jp/wiki/File:#{h[:id]}.cdx> .

<#{h[:id]}#gif> 
  rdf:type mb:SDfile ;
  dcterms:format <nrn:mimetype:image/gif> ; 
  rdfs:seeAlso <https://mb.metabolomics.jp/wiki/File:#{h[:id]}.gif> .

<#{h[:id]}#molecular_formula>
  rdf:type cheminf:CHEMINF_000042 ;
  sio:SIO_000300 \"#{h[:comp]}\" .

<#{h[:id]}#molecular_entity_name>
  rdf:type cheminf:CHEMINF_000043 ;
  sio:SIO_000300 \"#{h[:name]}\" .

<#{h[:id]}#molecular_weight>
  rdf:type cheminf:CHEMINF_000334 ;
  sio:SIO_000300 \"#{h[:mw]}\"^^xsd:double ;
  sio:SIO_000221 obo:UO_0000055 . # has unit

<#{h[:id]}#smiles>
  rdf:type cheminf:CHEMINF_000018 ;
  sio:SIO_000300 \"#{h[:smiles]}\" .

<#{h[:id]}#standard_inchikey>
  rdf:type cheminf:CHEMINF_000059 ;
  sio:SIO_000300 \"#{h[:ikey]}\";
  rdfs:seeAlso <http://identifiers.org/inchikey/#{h[:ikey]}>.
  
<#{h[:id]}#standard_inchi>
  rdf:type cheminf:CHEMINF_000113 ;
  sio:SIO_000300 \"#{h[:inchi]}\";
  rdfs:seeAlso <http://identifiers.org/inchi/#{h[:inchi]}>.
  
<#{h[:id]}#start_substance>
  rdf:type mb:Start_substance ;
  sio:SIO_000300 \"#{h[:substance]}\" .
  "
  
  cas =
  "
<#{h[:id]}#cas>
  rdf:type cheminf:CHEMINF_000446 ;
  sio:SIO_000300 \"#{h[:cas_id]}\";
  rdfs:seeAlso <http://identifiers.org/cas/#{h[:cas_id]}>.
  "

end

def wiki_title str
  #Marc|ias,__F._A.__et_al._,__Phytochemistry,__1998,__48,__631-636_(isol,__pmr,__cmr)>
  #Lycopersicon_esculentum_var._`Tangella'
  str.sub("Marc|ias","Marclias").sub("`Tangella'","'Tangella'").sub("`Yalaha`","'Yalaha'").gsub(" ","_").gsub("<","").gsub(">","")
  #str.gsub(/[<>|`]/){|s| "_" }
end

def to_ttl_annotation ann
  puts "
<#{ann[:cid]}> sio:SIO_000255 #{ann[:uri]} ." #sio:has-annotation

  ann[:references_new].each do |ref|
    puts "
<#{ann[:cid]}> dcterms:isReferencedBy #{ref[:uri]} ."
  end

  puts "
#{ann[:uri]} rdf:type mb:KNApSAcKCoreAnnotation ;
  mb:sp \"#{ann[:organism]}\" ;
  mb:references \"#{ann[:reference]}\" ;
  mb:sp1 \"#{ann[:sp1]}\" ;
  mb:family \"#{ann[:family]}\" ;
  mb:kingdom \"#{ann[:kingdom]}\" ;"
  ann[:references_new].each do |ref|
    puts "  dcterms:isReferencedBy #{ref[:uri]} ;"
  end

  puts "  rdfs:seeAlso <http://identifiers.org/taxonomy/#{ann[:taxonomy]}> ;" if ann[:taxonomy].to_i > 0
  puts "  foaf:homepage <https://mb.metabolomics.jp/wiki/Species:#{wiki_title(ann[:organism])}> ; "
  puts "  sio:SIO_000254 <#{ann[:cid]}> . #sio:is annotation of" 
  puts 

  ### references_new
  ann[:references_new].each do |ref|
    puts "
#{ref[:uri]} rdf:type mb:KNApSAcKReference ;
"
    if ref[:pmid] !=""
      puts "  dc:identifier \"#{ref[:pmid]}\" ;"
      puts "  dcterms:references  <http://identifiers.org/pubmed/#{ref[:pmid]}> ;"
    end
    puts "  dc:title \"#{ref[:title]}\" ;"
    puts "  foaf:homepage <https://mb.metabolomics.jp/wiki/Reference:#{wiki_title(ref[:title])}> . "
    puts
  end
end

end
end

kc = KNApSAcK::Core.new(ARGV.shift)
