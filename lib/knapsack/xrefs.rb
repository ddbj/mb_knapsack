require 'pp'
#require 'cgi'
require 'uri'
require 'json'
require 'digest/md5'
require 'zlib'

module KNApSAcK
class Xrefs
    include Helper

def initialize (selected = nil)
  if selected != nil
    @selected = selected
  end
  #warn @selected
  @ids_data = {}
  #cid_inchi_key
  cid_smiles_inchi
  #inchi_key_pubchem
  #to_ttl_prefix
  #output_ttl
  output
end

def output
  begin
    tsvfile = File.open("id_mapping/knapsack_cid-pubchem_cid.csv", "w")
    tsvfile.write("source,target\n")

    ttlfile = File.open("rdf/knapsack-xrefs.ttl", "w")
    ttlfile.write("@base <http://purl.jp/knapsack/> .\n")
    ttlfile.write("@prefix skos: <http://www.w3.org/2004/02/skos/core#> .\n\n")
    #puts "@base <http://purl.jp/knapsack/> ."
    #puts "@prefix skos: <http://www.w3.org/2004/02/skos/core#> ."
    #puts
    #@inchi_key2pubchem = {}
    #file_path = 'id_mapping/pubchem-inchikey-20220514.tsv'
    file_path = 'id_mapping/pubchem-inchi-20220514.tsv'
    id = ikey = nil
    File.foreach(file_path).each do |line|
      #1 UZKQTCBAMSWPJD-FARCUNLSSA-N
      pubchem_id, ikey =  line.chomp.split("\t")
      #@inchi_key2pubchem[ikey] = id
      next unless @cid2inchi.has_value?(ikey)
      inchi = @cid2inchi[id]
      h = @cid2inchi.reject{|key, value| value != ikey}
      h.each do |cid, value|
        tsvfile.write("#{cid},#{pubchem_id}\n")
        ttlfile.write("<#{cid}> skos:closeMatch <http://rdf.ncbi.nlm.nih.gov/pubchem/compound/CID#{pubchem_id}> .\n")
        #puts [cid, pubchem_id, value, h.keys.size].join("\t")
      end
    end

    ttlfile = File.close
    tsvfile.close
  rescue SystemCallError => e
    puts %Q(class=[#{e.class}] message=[#{e.message}])
  end
end

def output_ttl
  begin
    puts "@base <http://purl.jp/knapsack/> ."
    puts "@prefix skos: <http://www.w3.org/2004/02/skos/core#> ."

    cids = {}
    file_path = '有田先生用_20210806/id_data.dat'
    #id	fid	comp	name	organism	reference

    id = fid = comp = name = nil
    File.foreach(file_path).each do |line|
      id, fid, comp, name, organism, reference =  line.chomp.split("\t")
      next if (@selected and !@selected[id])
      ikey = @cid2inchi_key[id]
      inchi = @cid2inchi[id]
      unless cids.key?(id)
        if @inchi_key2pubchem.key?(ikey)
        puts "<#{id}> skos:exactMatch \"#{ikey}\" <http://rdf.ncbi.nlm.nih.gov/pubchem/compound/CID#{@inchi_key2pubchem[ikey]}> ."
        #puts "<#{id}> cheminf:CHEMINF_000200 <#{id}#standard_inchikey> ."
        #puts "<#{id}> cheminf:CHEMINF_000200 <#{id}#standard_inchi> ."
        #puts "<#{id}#standard_inchikey> sio:SIO_000300 \"#{ikey}\"."
        #puts "<#{id}#standard_inchi> sio:SIO_000300 \"#{inchi}\"."
        end
        cids[id] = 1
      end
    end
  rescue SystemCallError => e
    puts %Q(class=[#{e.class}] message=[#{e.message}])
  end
end

def inchi_key_pubchem
  begin
    @inchi_key2pubchem = {}
    file_path = 'id_mapping/pubchem-inchikey-20220514.tsv'
    id = ikey = nil
    File.foreach(file_path).first(100000).each do |line|
      #1 UZKQTCBAMSWPJD-FARCUNLSSA-N
      id, ikey =  line.chomp.split("\t")
      @inchi_key2pubchem[ikey] = id
    end
    @inchi_key2pubchem
    #@ids_data[@id][:ikey] = ikey
  rescue SystemCallError => e
    puts %Q(class=[#{e.class}] message=[#{e.message}])
  end
end


#in_chi_key.dat
def cid_inchi_key
  begin
    @cid2inchi_key = {}
    @inchi_key2cid = {}
    file_path = '有田先生用_20210806/in_chi_key.dat'
    id = ikey = nil
    File.foreach(file_path).each do |line|
      #C00000091 UZKQTCBAMSWPJD-FARCUNLSSA-N
      id, ikey =  line.chomp.split("\t")
      @cid2inchi_key[id] = ikey
      #unless @inchi_key2cid.key?(ikey)
      #  @inchi_key2cid[ikey] =[]
      #end
      #@inchi_key2cid[ikey] = id
      #@inchi_key2cid[ikey].push(id)
    end


    @cid2inchi_key
    #@ids_data[@id][:ikey] = ikey
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

end
end