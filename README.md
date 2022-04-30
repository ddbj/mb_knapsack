# knapsack2rdf

## Retrieve Pubmed ID

```
ruby knapsack2reference.rb knapsack-references-uniq-20210823 > knapsack-references-uniq-20210823.pmid
```

## Convert to RDF
### KNApSAcK Core

* input
   * 有田先生用_20210806/id_data.dat
   * 有田先生用_20210806/in_chi_key.dat
   * 有田先生用_20210806/cas_id.dat
   * 有田先生用_20210806/start_substance.dat
   * 有田先生用_20210806/smiles_inchi.dat
   * 有田先生用_20210806/family_kingdom.dat
   * knapsack-references-uniq-20210823.pmid
   * knapsack_mw-tmp.txt.gz
   * knapsack_20210806_id_data.tsv

```
ruby knapsack2rdf.rb > rdf/knapsack-core.ttl

#ruby knapsack2rdf.rb C00000001 > C00000001.ttl
#ruby knapsack2rdf.rb C00000091 > C00000091.ttl
```

### KNApSAcK Natural Activity

```
ruby knapsack_na2rdf.rb  > rdf/kanapsac_na.ttl
rapper -g -o turtle rdf/kanapsac_na.ttl > rdf/dev/kanapsac_na.ttl
```
### KNApSAcK MetaboLite Activity

```
ruby knapsack_ma2rdf.rb  > rdf/kanapsac_ma.ttl
```
