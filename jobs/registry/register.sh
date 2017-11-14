#Parameters
SOURCE=$1
REGION=$2
CSVFOLDER=$3
STATSFOLDER=$4
RAWFOLDER=$5


if [[ -z $SOURCE || -z $REGION || -z $CSVFOLDER || -z $STATSFOLDER  ]];
then
    echo `date`" - Missing mandatory arguments: Source, AWS Region, CSV Folder, Stats Folder. "
    echo `date`" - Usage: ./register.sh  [SOURCE] [REGION] [CSVFOLDER] [STATSFOLDER] (RAWFOLDER)."
    echo `date`" - Example: ./register.sh  ORCID us-west-2  /home/csv /home/stats /home/raw"
    echo `date`" - Note: (RAWFOLDER) is optional."
    echo `date`" - Full list of AWS Regions: http://docs.aws.amazon.com/general/latest/gr/rande.html"
    exit 1
fi


NOW="$(date +'%Y-%m-%d')"


#push the CSV files to registry
	tar -zcvf $SOURCE-csv.tar.gz CSVFOLDER
	aws s3 --region $REGION cp "$SOURCE-$NOW.tar.gz"  S3://$SOURCE.registry.researchgraph/ 

#push the stats files to registry
	aws s3 --region $REGION sync STATSFOLDER  S3://$SOURCE.registry.researchgraph/stats/ 

#push the raw files to archive
if [ -z "RAWFOLDER" ]
then
    echo "RAW FOLDER (The Last Parameter) is not set, so we are not going to archive the raw files."
else
	tar -zcvf $SOURCE-$NOW.tar.gz RAWFOLDER
	aws s3 --region $REGION cp "$SOURCE-$NOW.tar.gz"  S3://$SOURCE.archive.researchgraph/
fi


