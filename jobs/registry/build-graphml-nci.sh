MNTDATA=$1

rm -rf ./R.Neo4j
cp -r $MNTDATA/$SOURCE/R.Neo4j/. ./R.Neo4j

cd ./R.Neo4j

./bin/neo4j start
sleep 25s

./bin/neo4j status

echo "Exporting GraphML using Neo4j-Shell"
./bin/neo4j-shell  -v -c -file  ../../build-graphml-nci.cli

./bin/neo4j stop
