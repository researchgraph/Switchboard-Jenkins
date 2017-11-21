NCINEO4J=$1
SOURCE=$2

rm -rf ./R.Neo4j
cp -r $NCINEO4J .

./R.Neo4j/bin/neo4j start
sleep 15s

./R.Neo4j/bin/neo4j status

rm ./errors.txt

echo "Testing the data integrity"
python data-integrity-test.py $SOURCE

./R.Neo4j/bin/neo4j stop

if [ -f ./errors.txt ]; then
    echo "There are errors"
fi