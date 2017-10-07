echo "Copy the harvester jar file"
sudo cp -r /mnt/git/Harvesters/OAI_PMH/harvester_oai/target/* .

JARFILE=harvester_oai-1.3.7.jar

sudo java -jar $JARFILE harvest-figshare.properties
