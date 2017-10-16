GITLOCALFOLDER=$1

echo "Get the Jenkins files"
aws s3 --region us-west-2 sync s3://jenkins.switchboard.researchgraph/ .

echo "Get the Synthesis Program..."
sudo cp -r $GITLOCALFOLDER/mnt/Synthesis/target/* .

#echo "Create clean Neo4j Folder..."
#rm -rf ./R.Neo4j
#cp -r $GITLOCALFOLDER/R.Neo4j .


JARFILE=sync-1.0.6.jar

#sudo java -jar $JARFILE synthesis-monash-figshare.properties

