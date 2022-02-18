# tsvからttl作成（20220121 櫛田）
## 変換前（tsv）
a. Natural_Activity_main_rev.tsv
b. Natural_Activity_act_list.tsv
c. Metabolite_Activity.tsv
d. Natural_Activity_dictionary.tsv

## 変換結果（ttl）
1. Species_Activity_References_fromNatural_Activity_main_02.ttl
2. References_title_fromNatural_Activity_main.ttl 
3. Activity_Species_fromNatural_Activity_act_list_BA_02.ttl
4. Activity_Species_fromNatural_Activity_act_list.ttl
5. Metabolite_ActivityCateFunc_TargetSp_Ref.ttl
6. Metabolite_Label_cid.ttl
7. BA_1_2_8plusMetaboliteA03.ttl


## 変換スクリプト（python）and 作成方法
1. <- a. Species_Activity_References_fromNatural_Activity_main_02.py
2. <- a. References_title_fromNatural_Activity_main.py
3. <- 下記のSPARQLで取得（＊）
4. <- b. Activity_Species_fromNatural_Activity_act_list.py
5. <- c. Metabolite_ActivityCateFunc_TargetSp_Ref.py
6. <- c. Metabolite_ActivityCateFunc_TargetSp_Ref.py
7. <- d. Protegeで編集

---
* SPARQLで取得（＊）
* 以下のSPARQL Endpointで取得
* https://knowledge.brc.riken.jp/sparql

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

# graph <http://metadb.riken.jp/db/knapsackRDF>
## Species_Activity_References_fromNatural_Activity_main_02.ttl
## Activity_Species_fromNatural_Activity_act_list.ttl
## References_title_fromNatural_Activity_main.ttl

# graph <http://metadb.riken.jp/db/biologicalActivity>
## BA_1_2_8plusMetaboliteA03.ttl
```



