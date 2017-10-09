GITLOCALFOLDER=$1

echo "Copy the harvester jar file"
sudo cp -r $GITLOCALFOLDER/Harvesters/OAI_PMH/harvester_oai/target/* .

JARFILE=harvester_oai-1.3.8.jar

sudo java -jar $JARFILE harvest-figshare.properties
