from shexer.shaper import Shaper
from shexer.consts import NT, SHEXC, SHACL_TURTLE, TURTLE

target_classes = [
        "http://ddbj.nig.ac.jp/ontolofies/metabobank/KNApSAcKCoreRecord", 
        "http://semanticscience.org/resource/CHEMINF_000058", 
        "http://ddbj.nig.ac.jp/ontolofies/metabobank/CDXfile", 
        "http://ddbj.nig.ac.jp/ontolofies/metabobank/SDfile",
        "http://semanticscience.org/resource/CHEMINF_000042", 
        "http://semanticscience.org/resource/CHEMINF_000043", 
        "http://semanticscience.org/resource/CHEMINF_000018", 
        "http://semanticscience.org/resource/CHEMINF_000059", 
        "http://semanticscience.org/resource/CHEMINF_000113", 
        "http://ddbj.nig.ac.jp/ontolofies/metabobank/Start_substance",
        "http://ddbj.nig.ac.jp/ontolofies/metabobank/KNApSAcKCoreAnnotations" 
    ]

namespaces_dict = {"http://www.w3.org/1999/02/22-rdf-syntax-ns#": "rdf",
                   "http://example.org/": "ex",
                   "http://weso.es/shapes/": "",
                   "http://www.w3.org/2001/XMLSchema#": "xml"
                   }

input_nt_file = "glycovid.nt"
input_ttl_file = "knapsack_core.ttl"

shaper = Shaper(target_classes=target_classes,
                graph_file_input=input_ttl_file,
#                raw_graph=raw_graph,
                input_format=TURTLE,
                namespaces_dict=namespaces_dict,  # Default: no prefixes
                instantiation_property="http://www.w3.org/1999/02/22-rdf-syntax-ns#type")  # Default rdf:type

output_file = "knapsack_core.shex"

shaper.shex_graph(output_file=output_file,
                                    acceptance_threshold=0.1)

print("Done!")
