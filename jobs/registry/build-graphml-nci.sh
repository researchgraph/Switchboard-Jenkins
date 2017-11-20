cd R.Neo4j
curl http://dist.neo4j.org/jexp/shell/neo4j-shell-tools_3.0.1.zip -o neo4j-shell-tools.zip
unzip neo4j-shell-tools.zip -d lib

chmod +x ./bin/neo4j-shell

echo "Starting Neo4j"
./bin/neo4j start

sleep 10s

echo "Exporting GraphML using Neo4j-Shell"
./bin/neo4j-shell  -v -c -file  ../build-graphml-nci.cli

echo "Stopping Neo4j"
./bin/neo4j stop
