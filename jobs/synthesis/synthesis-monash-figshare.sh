GITLOCALFOLDER=$1

echo "Get the Jenkins files"
aws s3 --region us-west-2 sync s3://jenkins.switchboard.researchgraph/ .

echo "Get the Synthesis Program..."
sudo cp -r $GITLOCALFOLDER/Synthesis/target/* .

JARFILE=sync-1.0.6.jar

sudo java -jar $JARFILE synthesis-monash-figshare.properties

