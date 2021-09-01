
require 'cgi'
require 'pp'
require "open3"
file = ARGV.shift
File.open(file) do |f|
    #f.first(10).each do |ref|
    f.each do |ref|
        next if ref == "\n"
        next if ref.strip =~/^-/
        #pp ref
        q = CGI.escape(ref.strip)
        #puts q
        o, e, s = Open3.capture3("curl -L http://pubmed.ncbi.nlm.nih.gov/?term=#{q} |grep articlePageUrl", :stdin_data=>"foo\nbar\nbaz\n")
        pmid = ""
        if pmid = /\/(\d+)\//.match(o.to_s){|e| $1 }
        end
        puts "#{pmid}\t#{ref.strip}"
        #if str = `curl -L http://pubmed.ncbi.nlm.nih.gov/?term=#{q} |grep articlePageUrl"`
        #    #puts str.to_s.match('/articlePageUrl: "\/(\d+)\/"/'){ |e|" match #{$1}"}
        #    puts str
        #    #puts /\/(.+*)\//.match(str.to_s)
        #end
        sleep 0.2
    end
end
