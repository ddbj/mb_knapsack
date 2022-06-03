
OUT_PATH=`date "+%Y-%m-%d"`
echo $OUT_PATH
ruby knapsack_core2rdf.rb > rdf/knapsack-core.ttl 
ruby knapsack_na2rdf.rb > rdf/knapsack-na.ttl 
ruby knapsack_ma2rdf.rb > rdf/knapsack-ma.ttl 
mkdir rdf/$OUT_PATH
rapper -g -o turtle rdf/knapsack-core.ttl > rdf/$OUT_PATH/knapsack-core-rapper.ttl
sed -e 's/ NaN/ "NaN"^^xsd:double/' rdf/$OUT_PATH/knapsack-core-rapper.ttl > rdf/$OUT_PATH/knapsack-core.ttl 
rm  rdf/$OUT_PATH/knapsack-core-rapper.ttl
rapper -g -o turtle rdf/knapsack-na.ttl > rdf/$OUT_PATH/knapsack-natural-activity.ttl
rapper -g -o turtle rdf/knapsack-ma.ttl > rdf/$OUT_PATH/knapsack-metabolite-activity.ttl

cp rdf/knapsack-xref-pubchem.ttl rdf/$OUT_PATH/knapsack-xref-pubchem.ttl
cp rdf/knapsack-xref-chebi.ttl rdf/$OUT_PATH/knapsack-xref-chebi.ttl
cp rdf/knapsack-owl.ttl cp rdf/$OUT_PATH/knapsack-owl.ttl
