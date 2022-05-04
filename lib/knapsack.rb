require 'pp'
require 'cgi'
require 'uri'
require 'json'
require 'digest/md5'
require 'zlib'
require "open3"

module KNApSAcK
class Reference

def initialize (selected = nil)
  if selected != nil
    @selected = selected
  end
  references_pmid
  #to_ttl
  #to_tsv
end

def retrieve_pmid (file_path)
    #file = ARGV.shift
    #file_path = './id_mapping/reference-pmid-20210823.tsv'
    File.foreach(file_path).each do |line|
        ref_uri, pmid, title =  line.chomp.split("\t")
        note = ""
        if pmid == ""
           query_title = title.strip.gsub(",", ", ").gsub(".",". ")
           q = CGI.escape(title)
           o, e, s = Open3.capture3("curl -L http://pubmed.ncbi.nlm.nih.gov/?term=#{q} |grep articlePageUrl", :stdin_data=>"foo\nbar\nbaz\n")
           if pmid = /\/(\d+)\//.match(o.to_s){|e| $1 }
             $note = "[NEW]"
           end
           puts "#{ref_uri}\t#{pmid}\t#{title}\t#{note}"
           sleep 0.2
        else
          puts "#{ref_uri}\t#{pmid}\t#{title}\t"
        end
        #sleep 0.2
    end
end

def to_tsv
    begin
      uniq_ref = {}
      pmid_count = 0
      file_path = '有田先生用_20210806/id_data.dat'
      #id	fid	comp	name	organism	reference
      File.foreach(file_path).each do |line|
        id, fid, comp, name, organism, reference =  line.chomp.split("\t")
        next if (@selected and !@selected[id])
        cid_uri = "<#{id}>"
        ann_uri = "<annotation##{Digest::MD5.hexdigest(organism)}>"
        reference.to_s.gsub(":[Pathway]", ";[Pathway]").split(";").each do |title|
          #query = r.gsub(",", ", ").gsub(".",". ")}
          r = title.gsub(",", ", ").gsub(".",". ")
          next if r == "[Pathway]"
          ref_uri = "<reference##{Digest::MD5.hexdigest(title)}>"
          #pmid = @refs[r] || ""
          pmid = @refs[ref_uri] || ""
          #puts "#{ann_uri} dcterms:isReferencedBy #{ref[:uri]} ."

          #puts [ref_uri, pmid, title].join("\t")
          uniq_ref[ref_uri] = {:ref_uri => ref_uri, :pmid => pmid, :title => title}
        end
      end
      uniq_ref.each do |v,k|
        puts [k[:ref_uri], k[:pmid], k[:title]].join("\t")
        pmid_count += 1 if k[:pmid] != ""
      end
      warn "#{pmid_count} / #{uniq_ref.count}"
    rescue SystemCallError => e
      puts %Q(class=[#{e.class}] message=[#{e.message}])
    end
  end


def to_ttl
  begin
    to_ttl_prefix
    file_path = '有田先生用_20210806/id_data.dat'
    #id	fid	comp	name	organism	reference
    File.foreach(file_path).each do |line|
      id, fid, comp, name, organism, reference =  line.chomp.split("\t")
      next if (@selected and !@selected[id])
      cid_uri = "<#{id}>"
      ann_uri = "<annotation##{Digest::MD5.hexdigest(organism)}>"

      #puts "#{cid_uri} sio:SIO_000255 #{ann_uri} ." #sio:has-annotation      
      
      #reference.to_s.gsub(":[Pathway]", ";[Pathway]").split(";").map{|x| x.gsub(",", ", ").gsub(".",". ")}.delete_if{|x| x == "[Pathway]"}.each do |r|
      reference.to_s.gsub(":[Pathway]", ";[Pathway]").split(";").each do |title|
        r = title.gsub(",", ", ").gsub(".",". ")
        next if r == "[Pathway]"
        ref_uri = "<reference##{Digest::MD5.hexdigest(title)}>"
        pmid = @refs[ref_uri] || ""
        #puts "#{ann_uri} dcterms:isReferencedBy #{ref[:uri]} ."
        puts "#{ref_uri} rdf:type mb:KNApSAcKReference ;"
          if pmid !=""
            puts "  dc:identifier \"#{pmid}\" ;"
            puts "  dcterms:references  <http://identifiers.org/pubmed/#{pmid}> ;"
          end
          puts "  dc:title \"#{title}\" ;"
          puts

          puts "#{cid_uri} dcterms:isReferencedBy #{ref_uri} ."
          puts
          puts
      end
      
    end
  rescue SystemCallError => e
    puts %Q(class=[#{e.class}] message=[#{e.message}])
  end
end

# id_mapping/reference-pmid-20210823.tsv
def references_pmid
  @refs ={}
  #file_path = 'knapsack-references-uniq-20210823.pmid'
  file_path = './id_mapping/reference-pmid-20210823.tsv'
  File.foreach(file_path) do |line|
    ref_uri, pmid, title =  line.chomp.split("\t")
    @refs[ref_uri] = pmid
    #  pmid, references = line.chomp.split("\t")
    #  @refs[references] = pmid
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
@prefix cheminf: <http://semanticscience.org/resource/> .
@prefix foaf: <http://xmlns.com/foaf/0.1/> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix obo: <http://purl.obolibrary.org/obo/> .

  "
end


end
end