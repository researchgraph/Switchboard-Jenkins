GITLOCALFOLDER=$1

echo "Create clean Neo4j Folder..."
rm -rf ./R.Neo4j
git clone https://github.com/researchgraph/R.Neo4j.git

echo "Get the Import Program..."
sudo cp -r $GITLOCALFOLDER/Import-XML/target/* .

echo "Get the crosswalks from github.."
sudo curl https://raw.githubusercontent.com/researchgraph/Crosswalks/master/figshare.com/figshareRDF_to_researchgraph.xsl > ./crosswalk.xsl

SOURCE=figshare

sudo mkdir ./versions
sudo mkdir ./versions/figshare

JARFILE=import-xml-1.3.6.jar

#Switch one an off the VERBOSE output
VERBOSE=false #for production
#VERBOSE=true #for testing and debuging 

sudo java -jar $JARFILE \
  -n ./R.Neo4j/ -s $SOURCE -b xml.rd-switchboard \
  -p figshare/rdf -C crosswalk.xsl -v ./versions -V "$VERBNOSE"