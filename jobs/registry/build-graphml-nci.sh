NCINEO4J=$1

rm -rf ./R.Neo4j
cp -r $NCINEO4J .

cd ./R.Neo4j
echo "Downloading neo4j-shell-tools"
curl http://dist.neo4j.org/jexp/shell/neo4j-shell-tools_3.0.1.zip -o neo4j-shell-tools.zip
unzip -f neo4j-shell-tools.zip -d lib

chmod +x ./bin/neo4j-shell

./bin/neo4j start
sleep 15s

./bin/neo4j status

echo "Exporting GraphML using Neo4j-Shell"
./bin/neo4j-shell  -v -c -file  ../build-graphml-nci.cli

./bin/neo4j stop
