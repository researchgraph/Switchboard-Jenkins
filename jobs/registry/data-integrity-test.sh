MNTDATA=$1
SOURCE=$2

echo "Creating the local Neo4j instance by copying from data folder"
rm -rf ./R.Neo4j
cp -r $MNTDATA/$SOURCE/R.Neo4j/. ./R.Neo4j

./R.Neo4j/bin/neo4j start
sleep 25s

./R.Neo4j/bin/neo4j status

rm -f ./errors.txt

echo "Testing the data integrity"
python data-integrity-test.py $SOURCE

./R.Neo4j/bin/neo4j stop

if [ -f ./errors.txt ]; then
    exit 1
fi