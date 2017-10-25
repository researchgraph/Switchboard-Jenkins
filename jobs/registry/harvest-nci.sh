GITLOCALFOLDER=$1

echo "Create clean Neo4j Folder..."
rm -rf ./R.Neo4j
cp -r $GITLOCALFOLDER/R.Neo4j .


rm -rf csv
mkdir csv
sudo "Download CSV files..."
sudo curl https://raw.githubusercontent.com/researchgraph/nci/master/csv/datasets.csv > ./csv/datasets.csv
sudo curl https://raw.githubusercontent.com/researchgraph/nci/master/csv/researchers.csv > ./csv/researchers.csv
sudo curl https://raw.githubusercontent.com/researchgraph/nci/master/csv/relations.csv > ./csv/relations.csv

#Building Neo4j
sudo ./R.Neo4j/bin/neo4j-import --into ./R.Neo4j/data/databases/graph.db \
  --nodes ./csv/researcher.csv \
  --nodes ./csv/datasets.csv \
  --relationships ./csv/relations.csv \
  --ignore-empty-strings true

sudo zip "r-neo4j-nci.zip" ./R.Neo4j
aws s3 --region eu-west-2 cp "r-neo4j-nci.zip"  s3://nci.registry.researchgraph/neo4j/
