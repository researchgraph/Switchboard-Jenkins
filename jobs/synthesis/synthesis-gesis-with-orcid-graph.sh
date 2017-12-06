echo "Get the Synthesis Program..."
cp -r $JENKINS_HOME/jobs/Build-Switchboard-Synthesis/workspace/target/* .

JARFILE=sync-1.1.1.jar

java -jar $JARFILE synthesis-base.properties