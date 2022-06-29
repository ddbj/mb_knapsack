# tsvからttl作成（20220629修正 by櫛田，20220121作成 by櫛田）
## 変換前（tsv）
a. Natural_Activity_main_rev.tsv  
b. Natural_Activity_act_list.tsv  
c. Metabolite_Activity.tsv  
d. Natural_Activity_dictionary.tsv  

## 変換結果（ttl）
1. md5Species_Activity_References_fromNatural_Activity_main_02.ttl
2. md5References_title_fromNatural_Activity_main.ttl 
3. Activity_Species_fromNatural_Activity_act_list_BA_03.ttl
4. md5Activity_Species_fromNatural_Activity_act_list.ttl
5. md5Metabolite_ActivityCateFunc_TargetSp_Ref.ttl
6. md5Metabolite_Label_cid.ttl
7. BA_1_2_8plusMetaboliteA03.ttl
8. md5activity_chebi.ttl

## 変換スクリプト（python）and 作成方法
1. <- a. md5Species_Activity_References_fromNatural_Activity_main_02_20220626.py
2. <- a. md5References_title_fromNatural_Activity_main20220626.py
3. <- 下記のSPARQLで取得（*1）
4. <- b. md5Activity_Species_fromNatural_Activity_act_list20220626.py
5. <- c. md5Metabolite_ActivityCateFunc_TargetSp_Ref20220626.py
6. <- c. md5Metabolite_ActivityCateFunc_TargetSp_Ref20220626.py
7. <- d. Protegeで編集
8. <- 下記のSPARQLで取得（*2）

---
* SPARQLで取得（*1, *2）
* 以下のSPARQL Endpointで取得
* https://knowledge.brc.riken.jp/sparql

```
# *1
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

# graph <http://metadb.riken.jp/db/knapsackRDF>
## md5References_title_fromNatural_Activity_main.ttl
## md5Species_Activity_References_fromNatural_Activity_main_02.ttl
## md5Function_md5CategoryOfMebabolite.ttl
## md5Metabolite_Label_cid.ttl
## md5Metabolite_ActivityCateFunc_TargetSp_Ref.ttl
## md5Activity_Species_fromNatural_Activity_act_list.ttl
## BA_1_2_8plusMetaboliteA03.ttl

# graph <http://metadb.riken.jp/db/biologicalActivity>
## BA_1_2_8plusMetaboliteA03.ttl
```

```
# ＊2
# knapsackのactivityとchebiのマッピングデータを取得するクエリ

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

# graph <http://metadb.riken.jp/db/knapsack_cid-chebi_cid>
## knapsack_cid-chebi_cid.ttl
```
