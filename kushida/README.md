
## Natural_Activity RDF作成方法
### 1. Species- Activity - References
* step: [md5Species_Activity_References_fromNatural_Activity_main_02_20220626.py](../kushida/変換スクリプト20220108/md5Species_Activity_References_fromNatural_Activity_main_02_20220626.py)
* input: [Natural_Activity_main_rev.tsv](../kushida/変換前20210927/Natural_Activity_main_rev.tsv)
* output: [md5Species_Activity_References_fromNatural_Activity_main_02.ttl](../kushida/変換結果20220108/python変換結果20220108/md5Species_Activity_References_fromNatural_Activity_main_02.ttl)

```
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .

<http://purl.jp/knapsack/annotation#e77d07072736ea0340064c854957905d>
	<http://purl.jp/knapsack/proterty/activity>	"Abortifacient"@en, "堕胎薬"@ja, "Antibacterial"@en, "抗菌"@ja, "Anticancer"@en, "抗ガン"@ja, "Antispasmodic"@en, "鎮痙薬"@ja, "Demulcent"@en, "皮膚の炎症または傷を沈静化する（油脂や軟膏等の形態の）薬物"@ja, "Diaphoretic"@en, "発汗剤"@ja, "Diuretic"@en, "利尿薬"@ja, "Emollient"@en, "緩和剤"@ja, "Immunostimulant"@en, "免疫賦活剤"@ja, "Stimulant"@en, "興奮薬"@ja.

<http://purl.jp/knapsack/annotation#d97e291f1149eff41f698e4d2f92ec20>
	<http://purl.jp/knapsack/proterty/activity>	"Antihysteric"@en, "抗ヒステリー"@ja, "Antipyretic"@en, "解熱薬"@ja, "Antiseptic"@en, "防腐剤"@ja, "Antispasmodic"@en, "鎮痙薬"@ja, "Aphrodisiac"@en, "媚薬"@ja, "Carminative"@en, "駆風薬"@ja, "Demulcent"@en, "皮膚の炎症または傷を沈静化する（油脂や軟膏等の形態の）薬物"@ja, "Diuretic"@en, "利尿薬"@ja, "Emollient"@en, "緩和剤"@ja, "Insecticide"@en, "殺虫剤"@ja, "Litholytic"@en, "結石溶解"@ja, "Stimulant"@en, "興奮薬"@ja, "Stomachic"@en, "健胃薬"@ja, "Tonic"@en, "強壮剤"@ja.

```

### 2. Activity-Species
* step: [md5Activity_Species_fromNatural_Activity_act_list20220626.py](../kushida/変換スクリプト20220108/md5Activity_Species_fromNatural_Activity_act_list20220626.py)
* input: [Natural_Activity_act_list.tsv](../kushida/変換前20210927/Natural_Activity_act_list.tsv)
* output: [md5Activity_Species_fromNatural_Activity_act_list.ttl](../kushida/変換結果20220108/python変換結果20220108/md5Activity_Species_fromNatural_Activity_act_list.ttl)

```
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .

<http://purl.jp/knapsack/activity#78b5662aa473d5a9f67c737ebf586cdf>
	<http://www.w3.org/2000/01/rdf-schema#label>	"12-Lipoxygenase inhibitor"@en ;
	<http://purl.jp/knapsack/property/sp2>	"Chelidonium majus"@en , "Theobroma cacao"@en .

<http://purl.jp/knapsack/activity#96d538ca336e0aaf5edd58850b5ebf26>
	<http://www.w3.org/2000/01/rdf-schema#label>	"15-Lipoxygenase inhibitor"@en ;
	<http://purl.jp/knapsack/property/sp2>	"Theobroma cacao"@en .
```

### 3. References_title
* step: [md5References_title_fromNatural_Activity_main20220626.py](../kushida/変換スクリプト20220108/md5References_title_fromNatural_Activity_main20220626.py)
* input: [Natural_Activity_main_rev.tsv](../kushida/変換前20210927/Natural_Activity_main_rev.tsv)
* output: [md5References_title_fromNatural_Activity_main.ttl](../kushida/変換結果20220108/python変換結果20220108/md5References_title_fromNatural_Activity_main.ttl)

```
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .

<http://purl.jp/knapsack/References/9dadd46089d9864f9457ca4eb941b002>
	<http://purl.org/dc/elements/1.1/title>	"James A. Duke,Duke's handbook of medicinal plants of Latin America,CRC Press(2008)" . 
    
<http://purl.jp/knapsack/References/f9bf95f6e8b4b522a83feefc371afcec>
	<http://purl.org/dc/elements/1.1/title>	"James A Duke with Mary Jo Bogenschutz-Godwin,Judi duCellier,Peggy-Ann K.Duke(Illustrator),CRC HANDBOOK OF Medicinal Spices,CRC PRESS(2002)" . 
    
<http://purl.jp/knapsack/References/9498058f7b9a417fa009c8dbc7ce48c3>
	<http://purl.org/dc/elements/1.1/title>	"James A. Duke,Handbook of Medicinal Herbs 2nd Ed.,CRC Press(2002)" . 
```

### 4. BA_1_2_8plusMetaboliteA03
* step: Protegeで編集
* input: [Natural_Activity_dictionary.tsv](../kushida/変換前20210927/Natural_Activity_dictionary.tsv)
* output: [BA_1_2_8plusMetaboliteA03.ttl](../kushida/変換結果20220108/Protegeで編集20220121/BA_1_2_8plusMetaboliteA03.ttl)

```
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix xml: <http://www.w3.org/XML/1998/namespace> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

<http://purl.jp/bio/4/id/kb0000000001>
    <http://purl.org/dc/terms/identifier> "kb0000000001" ;
    <http://semanticscience.org/resource/SIO_001278> <http://www.knapsackfamily.com/BiologicalActivity/NA_dictionary.pdf> ;
    a owl:Class ;
    rdfs:label "12-Lipoxygenase inhibitor"@en ;
    rdfs:subClassOf <http://purl.jp/bio/4/id/kb0000001321> ;
    <http://www.w3.org/2004/02/skos/core#altLabel> "12リポキシゲナーゼ阻害剤"@ja ;
    <http://www.w3.org/2004/02/skos/core#exactMatch> "http://purl.obolibrary.org/obo/CHEBI_64995" .

<http://purl.jp/bio/4/id/kb0000000002>
    <http://purl.org/dc/terms/identifier> "kb0000000002" ;
    <http://semanticscience.org/resource/SIO_001278> <http://www.knapsackfamily.com/BiologicalActivity/NA_dictionary.pdf> ;
    a owl:Class ;
    rdfs:label "15-Lipoxygenase inhibitor"@en ;
    rdfs:subClassOf <http://purl.jp/bio/4/id/kb0000001321> ;
    <http://www.w3.org/2004/02/skos/core#altLabel> "15リポキシゲナーゼ阻害剤"@ja ;
    <http://www.w3.org/2004/02/skos/core#exactMatch> "http://purl.obolibrary.org/obo/CHEBI_64996" .
```
```
<http://purl.jp/bio/4/subject/KnapsackBiologicalActivity>
    <http://semanticscience.org/resource/SIO_001278> <http://www.knapsackfamily.com/BiologicalActivity/NA_dictionary.pdf> ;
    a owl:Class ;
    rdfs:label "(Obsolete)KnapsackBiologicalActivity"@en ;
    rdfs:subClassOf <http://purl.jp/bio/4/id/kb0000002422> .

<http://purl.org/dc/terms/identifier>
    a owl:AnnotationProperty .

<http://semanticscience.org/resource/SIO_001278>
    a owl:AnnotationProperty .

<http://semanticscience.org/resource/SIO_001279>
    a owl:AnnotationProperty .
```


### 5. Activity_Species
* step: load RDF into virtuoso
   * graph <http://metadb.riken.jp/db/knapsackRDF>
     * 1. md5References_title_fromNatural_Activity_main.ttl
     * 2. md5Species_Activity_References_fromNatural_Activity_main_02.ttl
     * 3. md5Function_md5CategoryOfMebabolite.ttl
     * 4. md5Metabolite_Label_cid.ttl
     * 5. md5Metabolite_ActivityCateFunc_TargetSp_Ref.ttl
     * 6. md5Activity_Species_fromNatural_Activity_act_list.ttl
     * 7. BA_1_2_8plusMetaboliteA03.ttl
   * graph <http://metadb.riken.jp/db/biologicalActivity>
     * 4. BA_1_2_8plusMetaboliteA03.ttl
* step: sparql(*) 
* input: https://knowledge.brc.riken.jp/sparql
* output: [Activity_Species_fromNatural_Activity_act_list_BA_03.ttl](../kushida/変換結果20220108/SPARQLで取得20220121/Activity_Species_fromNatural_Activity_act_list_BA_03.ttl)

```
CONSTRUCT {
?ba <http://www.w3.org/2000/01/rdf-schema#label> ?label. 
?ba <http://purl.jp/knapsack/property/sp2> ?species. 
}
where {
  graph <http://metadb.riken.jp/db/knapsackRDF> {
    OPTIONAL{?knapsack <http://www.w3.org/2000/01/rdf-schema#label> ?label.}
    OPTIONAL{?knapsack <http://purl.jp/knapsack/property/sp2> ?species.  }
    }  
  graph <http://metadb.riken.jp/db/biologicalActivity> {
    ?ba <http://www.w3.org/2000/01/rdf-schema#label> ?label.  
    }
}

```
```
<http://purl.jp/bio/4/id/kb0000000001>
    <http://purl.jp/knapsack/property/sp2> "Chelidonium majus"@en, "Theobroma cacao"@en ;
    <http://www.w3.org/2000/01/rdf-schema#label> "12-Lipoxygenase inhibitor"@en .

<http://purl.jp/bio/4/id/kb0000000002>
    <http://purl.jp/knapsack/property/sp2> "Theobroma cacao"@en ;
    <http://www.w3.org/2000/01/rdf-schema#label> "15-Lipoxygenase inhibitor"@en .
```
```
<http://purl.jp/bio/4/subject/KnapsackBiologicalActivity>
    <http://www.w3.org/2000/01/rdf-schema#label> "(Obsolete)KnapsackBiologicalActivity"@en .
```



## Metabolite_Activity RDF作成方法
### 6. Metabolite_ActivityCateFunc_TargetSp_Ref
* step: [md5Metabolite_ActivityCateFunc_TargetSp_Ref20220626.py](../kushida/変換スクリプト20220108/md5Metabolite_ActivityCateFunc_TargetSp_Ref20220626.py)
* input: [Metabolite_Activity.tsv](../kushida/変換前20210927/Metabolite_Activity.tsv)
* output: [md5Metabolite_ActivityCateFunc_TargetSp_Ref.ttl](../kushida/変換結果20220108/python変換結果20220108/md5Metabolite_ActivityCateFunc_TargetSp_Ref.ttl)

```
<http://purl.jp/knapsack/activity#f6596aa6da5e0718dfd9799e38023a8e>
	<http://purl.jp/knapsack/property/category> "Antibacterial", "Antifungal" ;
	<http://purl.jp/knapsack/property/function> "Antibacterial", "Antifungal" ;
	<http://purl.jp/knapsack/property/references> "Evidente, et al., Phytochemistry, 65, (2004), 2113." ;
	<http://purl.jp/knapsack/property/targetsp> "Candida albicans", "Staphylococcus aureus" .

<http://purl.jp/knapsack/activity#09524c2d7c74cc3a58714e33bc81eda6>
	<http://purl.jp/knapsack/property/category> "Antituberculotic", "Cytotoxic" ;
	<http://purl.jp/knapsack/property/function> "Antibacterial", "Cytotoxic inactive, HT29 cells", "Cytotoxic inactive, MCF7 cells" ;
	<http://purl.jp/knapsack/property/references> "Li, et al., Chem Pharm Bull, 51, (2003), 262.;MACHIDA, et al., Chem Pharm Bull, 53, (2005), 934.;Lin, et al., Planta Med, 71, (2005), 171." ; 
	<http://purl.jp/knapsack/property/targetsp> "Mycobacterium tuberculosis" .
```

### 7. Metabolite_Label_cid
* step: [md5Metabolite_ActivityCateFunc_TargetSp_Ref20220626.py](../kushida/変換スクリプト20220108/md5Metabolite_ActivityCateFunc_TargetSp_Ref20220626.py)
* input: [Metabolite_Activity.tsv](../kushida/変換前20210927/Metabolite_Activity.tsv)
* output: [md5Metabolite_Label_cid.ttl](../kushida/変換結果20220108/python変換結果20220108/md5Metabolite_Label_cid.ttl)

```
<http://purl.jp/knapsack/activity#f6596aa6da5e0718dfd9799e38023a8e>
	<http://www.w3.org/2000/01/rdf-schema#label>	"(+)-11-Hydroxyvittatine"@en ;
	<http://purl.org/dc/terms/identifier>	"C00027615" .

<http://purl.jp/knapsack/activity#09524c2d7c74cc3a58714e33bc81eda6>
	<http://www.w3.org/2000/01/rdf-schema#label>
	"(+)-4-Hydroxy-1-tetralone;(4S)-4-Hydroxy-alpha-tetralone"@en ,"(+)-4-Hydroxy-1-tetralone"@en , "(4S)-4-Hydroxy-alpha-tetralone"@en ;
	<http://purl.org/dc/terms/identifier>	"C00050618" .
```


### 8. Activity_chebi
* step: load RDF into virtuoso
   * graph <http://metadb.riken.jp/db/knapsackRDF>
     * 1. md5References_title_fromNatural_Activity_main.ttl
     * 2. md5Species_Activity_References_fromNatural_Activity_main_02.ttl
     * 3. md5Function_md5CategoryOfMebabolite.ttl
     * 4. md5Metabolite_Label_cid.ttl
     * 5. md5Metabolite_ActivityCateFunc_TargetSp_Ref.ttl
     * 6. md5Activity_Species_fromNatural_Activity_act_list.ttl
     * 7. BA_1_2_8plusMetaboliteA03.ttl
   * graph <http://metadb.riken.jp/db/knapsack_cid-chebi_cid>
     * 4. knapsack_cid-chebi_cid.ttl
* step: sparql(*) 
* input: https://knowledge.brc.riken.jp/sparql
* output: [md5activity_chebi.ttl](../kushida/変換結果20220108/SPARQLで取得20220121/md5activity_chebi.ttl)

```
CONSTRUCT {?activity <http://www.w3.org/2000/01/rdf-schema#seeAlso> ?chebi.}
WHERE {
  graph <http://metadb.riken.jp/db/knapsackRDF>{
	?activity <http://www.w3.org/2000/01/rdf-schema#label> ?label.
    ?activity <http://purl.org/dc/terms/identifier>	?literal_c.
    	BIND(IRI(CONCAT("http://purl.jp/knapsack/", STR(?literal_c)))AS ?uri_c)
    }
  graph <http://metadb.riken.jp/db/knapsack_cid-chebi_cid> {
    ?uri_c <http://www.w3.org/2004/02/skos/core#closeMatch> ?chebi.
    }
} 

```
```
<http://purl.jp/knapsack/activity#6b8526f7c52cd7cf16c33e0e3dec2cf1>
	<http://www.w3.org/2000/01/rdf-schema#seeAlso>	<http://purl.obolibrary.org/obo/CHEBI_4289> .

<http://purl.jp/knapsack/activity#527390fa544d81dcc9cf22817c3bfc6f>
	<http://www.w3.org/2000/01/rdf-schema#seeAlso>	<http://purl.obolibrary.org/obo/CHEBI_10137> .
```
