RNEO4J=$1
MNTDATA=$2
CSVFOLDER=$3 
SOURCE=$4

echo "Create clean Neo4j Folder..."
rm -rf $MNTDATA/$SOURCE/R.Neo4j
mkdir $MNTDATA/$SOURCE/R.Neo4j
cp -r $RNEO4J/. $MNTDATA/$SOURCE/R.Neo4j

aws s3 --region eu-west-2 cp  s3://$SOURCE.registry.researchgraph/csv-$SOURCE.tar.gz .
tar xvzf csv-$SOURCE.tar.gz

echo "Import into Neo4j"
NODE_FILE_PATH=$CSVFOLDER"/link_db_entities.csv"
NODE_FILE_PATH1=$CSVFOLDER"/link_db_entities_dataset.csv"
NODE_FILE_PATH2=$CSVFOLDER"/link_db_entities_institution.csv"
NODE_FILE_PATH3=$CSVFOLDER"/link_db_entities_project.csv"
NODE_FILE_PATH4=$CSVFOLDER"/link_db_entities_publication.csv"
NODE_FILE_PATH5=$CSVFOLDER"/link_db_entities_citedData.csv"
NODE_FILE_PATH6=$CSVFOLDER"/link_db_entities_instrument.csv"
RELATIONSHIP_FILE_PATH=$CSVFOLDER"/link_db_relationships.csv"
IMPORT_SCRIPT=$MNTDATA/$SOURCE"/R.Neo4j/bin/neo4j-import"
$DATABASE_PATH=$MNTDATA/$SOURCE"/R.Neo4j/data/databases/graph.db"

$MNTDATA/$SOURCE"/R.Neo4j/bin/neo4j-import" --into $MNTDATA/$SOURCE/R.Neo4j/data/databases/graph.db \
	--nodes $NODE_FILE_PATH1 \
	--nodes $NODE_FILE_PATH2 \
	--nodes $NODE_FILE_PATH3 \
	--nodes $NODE_FILE_PATH4 \
	--nodes $NODE_FILE_PATH5 \
	--nodes $NODE_FILE_PATH6 \
	--relationships $RELATIONSHIP_FILE_PATH

echo "Invalid relationships"
cat $MNTDATA/$SOURCE/R.Neo4j/data/databases/graph.db/bad.log