# knapsack2rdf

## Retrieve Pubmed ID

```
ruby knapsack2reference.rb knapsack-references-uniq-20210823 > knapsack-references-uniq-20210823.pmid
```

## Convert to RDF
### KNApSAcK Core
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
