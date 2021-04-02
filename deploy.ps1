# check for environment
param (
    [Parameter(Mandatory=$true)]
    [string]$bucket,

    [Parameter(Mandatory=$true)]
    [string]$appName,

    [Parameter(Mandatory=$true)]
    [string]$envName,

    [Parameter(Mandatory=$true)]
    [string]$warPath,

    [Parameter(Mandatory=$false)]
    [string]$version = "v$(Get-Date -Format yyyyMMddHHmm)"
)

# Build new deployment
[string]$warName = "$appName-$version.war"
aws s3 cp $warPath s3://$bucket/$warName
aws elasticbeanstalk create-application-version --application-name $appName --version-label $version --source-bundle S3Bucket=$bucket,S3Key=$warName
aws elasticbeanstalk update-environment --environment-name $envName --version-label $version

exit
