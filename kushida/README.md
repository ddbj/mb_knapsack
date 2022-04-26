
## Natural_Activity RDF作成方法
### 1. Species- Activity - References
* step: [Species_Activity_References_fromNatural_Activity_main_02.py](../kushida/変換スクリプト20220108/Species_Activity_References_fromNatural_Activity_main_02.py)
* input: [Natural_Activity_main_rev.tsv](../kushida/変換前20210927/Natural_Activity_main_rev.tsv)
* output: [Species_Activity_References_fromNatural_Activity_main_02.ttl](../kushida/変換結果20220108/python変換結果20220108/Species_Activity_References_fromNatural_Activity_main_02.ttl)

```
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .

<http://knapsack/Species/Abelmoschus%20esculentus%20%28L.%29%20Moench.>
    <http://knapsack/proterty/activity> "Abortifacient"@en, "Antibacterial"@en, "Anticancer"@en, "Antispasmodic"@en, "Demulcent"@en, "Diaphoretic"@en, "Diuretic"@en, "Emollient"@en, "Immunostimulant"@en, "Stimulant"@en, "免疫賦活剤"@ja, "利尿薬"@ja, "堕胎薬"@ja, "抗ガン"@ja, "抗菌"@ja, "発汗剤"@ja, "皮膚の炎症または傷を沈静化する（油脂や軟膏等の形態の）薬物"@ja, "緩和剤"@ja, "興奮薬"@ja, "鎮痙薬"@ja .

<http://knapsack/Species/Abelmoschus%20moschatus%20Medik.>
    <http://knapsack/proterty/activity> "Antihysteric"@en, "Antipyretic"@en, "Antiseptic"@en, "Antispasmodic"@en, "Aphrodisiac"@en, "Carminative"@en, "Demulcent"@en, "Diuretic"@en, "Emollient"@en, "Insecticide"@en, "Litholytic"@en, "Stimulant"@en, "Stomachic"@en, "Tonic"@en, "健胃薬"@ja, "利尿薬"@ja, "媚薬"@ja, "強壮剤"@ja, "抗ヒステリー"@ja, "殺虫剤"@ja, "皮膚
の炎症または傷を沈静化する（油脂や軟膏等の形態の）薬物"@ja, "結石溶解"@ja, "緩和剤"@ja, "興奮薬"@ja, "解熱薬"@ja, "鎮痙薬"@ja, "防腐剤"@ja, "駆風薬"@ja .

```

### 2. Activity-Species
* step: [Activity_Species_fromNatural_Activity_act_list.py](../kushida/変換スクリプト20220108/Activity_Species_fromNatural_Activity_act_list.py)
* input: [Natural_Activity_act_list.tsv](../kushida/変換前20210927/Natural_Activity_act_list.tsv)
* output: [Activity_Species_fromNatural_Activity_act_list.ttl](../kushida/変換結果20220108/python変換結果20220108/Activity_Species_fromNatural_Activity_act_list.ttl)

```
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .

<http://kanpsack/Activities/0001>
    <http://kanpsack/property/sp2> "Chelidonium majus"@en, "Theobroma cacao"@en ;
    <http://www.w3.org/2000/01/rdf-schema#label> "12-Lipoxygenase inhibitor"@en .

<http://kanpsack/Activities/0002>
    <http://kanpsack/property/sp2> "Theobroma cacao"@en ;
    <http://www.w3.org/2000/01/rdf-schema#label> "15-Lipoxygenase inhibitor"@en .
```

### 3. References_title
* step: [References_title_fromNatural_Activity_main.py](../kushida/変換スクリプト20220108/References_title_fromNatural_Activity_main.py)
* input: [Natural_Activity_main_rev.tsv](../kushida/変換前20210927/Natural_Activity_main_rev.tsv)
* output: [References_title_fromNatural_Activity_main.ttl](../kushida/変換結果20220108/python変換結果20220108/References_title_fromNatural_Activity_main.ttl)

```
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .

<http://kanpsack/References/James%20A%20Duke%20with%20Mary%20Jo%20Bogenschutz-Godwin%2CJudi%20duCellier%2CPeggy-Ann%20K.Duke%28Illustrator%29%2CCRC%20HANDBOOK%20OF%20Medicinal%20Spices%2CCRC%20PRESS%282002%29>
    <http://purl.org/dc/elements/1.1/title> "James A Duke with Mary Jo Bogenschutz-Godwin,Judi duCellier,Peggy-Ann K.Duke(Illustrator),CRC HANDBOOK OF Medicinal Spices,CRC PRESS(2002)" .

<http://kanpsack/References/James%20A.%20Duke%2CDuke%27s%20handbook%20of%20medicinal%20plants%20of%20Latin%20America%2CCRC%20Press%282008%29>
    <http://purl.org/dc/elements/1.1/title> "James A. Duke,Duke's handbook of medicinal plants of Latin America,CRC Press(2008)" .

<http://kanpsack/References/James%20A.%20Duke%2CHandbook%20of%20Medicinal%20Herbs%202nd%20Ed.%2CCRC%20Press%282002%29>
    <http://purl.org/dc/elements/1.1/title> "James A. Duke,Handbook of Medicinal Herbs 2nd Ed.,CRC Press(2002)" .
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
     * 1. Species_Activity_References_fromNatural_Activity_main_02.ttl
     * 2. Activity_Species_fromNatural_Activity_act_list.ttl
     * 3. References_title_fromNatural_Activity_main.ttl
   * graph <http://metadb.riken.jp/db/biologicalActivity>
     * 4. BA_1_2_8plusMetaboliteA03.ttl
* step: sparql(*) 
* input: https://knowledge.brc.riken.jp/sparql
* output: [Activity_Species_fromNatural_Activity_act_list_BA_02.ttl](../kushida/変換結果20220108/SPARQLで取得20220121/Activity_Species_fromNatural_Activity_act_list_BA_02.ttl)

```
CONSTRUCT {
?ba <http://www.w3.org/2000/01/rdf-schema#label> ?label. 
?ba <http://knapsack/property/sp2> ?species. 
}
where {
  graph <http://metadb.riken.jp/db/knapsackRDF> {
    OPTIONAL{?knapsack <http://www.w3.org/2000/01/rdf-schema#label> ?label.}
    OPTIONAL{?knapsack <http://kanpsack/property/sp2> ?species.  }
    }  
  graph <http://metadb.riken.jp/db/biologicalActivity> {
    ?ba <http://www.w3.org/2000/01/rdf-schema#label> ?label.  
    }
}

```
```
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .

<http://purl.jp/bio/4/id/kb0000000001>
    <http://knapsack/property/sp2> "Chelidonium majus"@en, "Theobroma cacao"@en ;
    <http://www.w3.org/2000/01/rdf-schema#label> "12-Lipoxygenase inhibitor"@en .

<http://purl.jp/bio/4/id/kb0000000002>
    <http://knapsack/property/sp2> "Theobroma cacao"@en ;
    <http://www.w3.org/2000/01/rdf-schema#label> "15-Lipoxygenase inhibitor"@en .
```
```
<http://purl.jp/bio/4/subject/KnapsackBiologicalActivity>
    <http://www.w3.org/2000/01/rdf-schema#label> "(Obsolete)KnapsackBiologicalActivity"@en .
```



## Metabolite_Activity RDF作成方法
### 6. Metabolite_ActivityCateFunc_TargetSp_Ref
* step: [Metabolite_ActivityCateFunc_TargetSp_Ref.py](../kushida/変換スクリプト20220108/Metabolite_ActivityCateFunc_TargetSp_Ref.py)
* input: [Metabolite_Activity.tsv](../kushida/変換前20210927/Metabolite_Activity.tsv)
* output: [Metabolite_ActivityCateFunc_TargetSp_Ref.ttl](../kushida/変換結果20220108/python変換結果20220108/Metabolite_ActivityCateFunc_TargetSp_Ref.ttl)

```
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .

<http://knapsack/Metabolite/%28%2B%29-11-Hydroxyvittatine>
    <http://knapsack/property/category> "Antibacterial", "Antifungal" ;
    <http://knapsack/property/function> "Antibacterial", "Antifungal" ;
    <http://knapsack/property/references> "Evidente, et al., Phytochemistry, 65, (2004), 2113." ;
    <http://knapsack/property/targetsp> "Candida albicans", "Staphylococcus aureus" .

<http://knapsack/Metabolite/%28%2B%29-4-Hydroxy-1-tetralone%3B%284S%29-4-Hydroxy-alpha-tetralone>
    <http://knapsack/property/category> "Antituberculotic", "Cytotoxic" ;
    <http://knapsack/property/function> "Antibacterial", "Cytotoxic inactive, HT29 cells", "Cytotoxic inactive, MCF7 cells" ;
    <http://knapsack/property/references> "Li, et al., Chem Pharm Bull, 51, (2003), 262.;MACHIDA, et al., Chem Pharm Bull, 53, (2005), 934.;Lin, et al., Planta Med, 71, (2005), 171."
    <http://knapsack/property/targetsp> "Mycobacterium tuberculosis" .
```

### 7. Metabolite_Label_cid
* step: [Metabolite_ActivityCateFunc_TargetSp_Ref.py](../kushida/変換スクリプト20220108/Metabolite_ActivityCateFunc_TargetSp_Ref.py)
* input: [Metabolite_Activity.tsv](../kushida/変換前20210927/Metabolite_Activity.tsv)
* output: [Metabolite_Label_cid.ttl](../kushida/変換結果20220108/python変換結果20220108/Metabolite_Label_cid.ttl)

```
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .

<http://knapsack/Metabolite/%28%2B%29-11-Hydroxyvittatine>
    <http://purl.org/dc/terms/identifier> "C00027615" ;
    <http://www.w3.org/2000/01/rdf-schema#label> "(+)-11-Hydroxyvittatine"@en .

<http://knapsack/Metabolite/%28%2B%29-4-Hydroxy-1-tetralone%3B%284S%29-4-Hydroxy-alpha-tetralone>
    <http://purl.org/dc/terms/identifier> "C00050618" ;
    <http://www.w3.org/2000/01/rdf-schema#label> "(+)-4-Hydroxy-1-tetralone;(4S)-4-Hydroxy-alpha-tetralone"@en .
```




