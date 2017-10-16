GITLOCALFOLDER=$1

echo "Get the Jenkins files"
aws s3 --region us-west-2 sync s3://jenkins.switchboard.researchgraph/jobs/synthesis .

echo "Get the Synthesis Program..."
cp -r $GITLOCALFOLDER/Synthesis/target/* .

JARFILE=sync-1.0.6.jar

java -jar $JARFILE synthesis-monash-figshare.properties

