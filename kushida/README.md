
## Natural_Activity RDF作成方法
### 1. Species- Activity - References
* step: [Species_Activity_References_fromNatural_Activity_main_02.py](../kushida/変換スクリプト20220108/Species_Activity_References_fromNatural_Activity_main_02.py)
* input: [Natural_Activity_main_rev.tsv](../kushida/変換前20210927/Natural_Activity_main_rev.tsv)
* output: [Species_Activity_References_fromNatural_Activity_main_02.ttl](../kushida/変換結果20220108/python変換結果20220108/Species_Activity_References_fromNatural_Activity_main_02.ttl)

### 2. References_title
* step: [References_title_fromNatural_Activity_main.py](../kushida/変換スクリプト20220108/References_title_fromNatural_Activity_main.py)
* input: [Natural_Activity_main_rev.tsv](../kushida/変換前20210927/Natural_Activity_main_rev.tsv)
* output: [References_title_fromNatural_Activity_main.ttl](../kushida/変換結果20220108/python変換結果20220108/References_title_fromNatural_Activity_main.ttl)

### 3. Activity_Species
* step: load RDF into virtuoso
   * graph <http://metadb.riken.jp/db/knapsackRDF>
     * Species_Activity_References_fromNatural_Activity_main_02.ttl
     * Activity_Species_fromNatural_Activity_act_list.ttl
     * References_title_fromNatural_Activity_main.ttl
   * graph <http://metadb.riken.jp/db/biologicalActivity>
     * BA_1_2_8plusMetaboliteA03.ttl
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

### 4. Activity-Species
* step: [Activity_Species_fromNatural_Activity_act_list.py](../kushida/変換スクリプト20220108/Activity_Species_fromNatural_Activity_act_list.py)
* input: [Natural_Activity_act_list.tsv](../kushida/変換前20210927/Natural_Activity_act_list.tsv)
* output: [Activity_Species_fromNatural_Activity_act_list.ttl](../kushida/変換結果20220108/python変換結果20220108/Activity_Species_fromNatural_Activity_act_list.ttl)

## Metabolite_Activity RDF作成方法
### 1. Metabolite_ActivityCateFunc_TargetSp_Ref
* step: [Metabolite_ActivityCateFunc_TargetSp_Ref.py](../kushida/変換スクリプト20220108/Metabolite_ActivityCateFunc_TargetSp_Ref.py)
* input: [Metabolite_Activity.tsv](../kushida/変換前20210927/Metabolite_Activity.tsv)
* output: [Metabolite_ActivityCateFunc_TargetSp_Ref.ttl](../kushida/変換結果20220108/python変換結果20220108/Metabolite_ActivityCateFunc_TargetSp_Ref.ttl)

### 2. Metabolite_Label_cid
* step: [Metabolite_ActivityCateFunc_TargetSp_Ref.py](../kushida/変換スクリプト20220108/Metabolite_ActivityCateFunc_TargetSp_Ref.py)
* input: [Metabolite_Activity.tsv](../kushida/変換前20210927/Metabolite_Activity.tsv)
* output: [Metabolite_Label_cid.ttl](../kushida/変換結果20220108/python変換結果20220108/Metabolite_Label_cid.ttl)

### 3. BA_1_2_8plusMetaboliteA03
* step: Protegeで編集
* input: [Natural_Activity_dictionary.tsv](../kushida/変換前20210927/Natural_Activity_dictionary.tsv)
* output: [BA_1_2_8plusMetaboliteA03.ttl](../kushida/変換結果20220108/Protegeで編集20220121/BA_1_2_8plusMetaboliteA03.ttl)





