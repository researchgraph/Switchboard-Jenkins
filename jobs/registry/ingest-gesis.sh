RNEO4J=$1
MNTDATA=$2
SOURCE=gesis

echo "Create clean Neo4j Folder..."
rm -rf $MNTDATA/$SOURCE/R.Neo4j
mkdir $MNTDATA/$SOURCE/R.Neo4j
cp -r $RNEO4J/. $MNTDATA/$SOURCE/R.Neo4j

aws s3 --region eu-west-2 cp  s3://$SOURCE.registry.researchgraph/csv-$SOURCE.tar.gz .
tar xvzf csv-$SOURCE.tar.gz

