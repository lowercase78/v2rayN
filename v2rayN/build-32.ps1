param (
	[Parameter()]
	[ValidateNotNullOrEmpty()]
	[string]
	$OutputPath = '.\bin\v2rayN-32'
)

Write-Host 'Building'

dotnet publish `
	.\v2rayN\v2rayN.csproj `
	-r win-x86 `
	-c Release `
	--self-contained false `
	-p:PublishReadyToRun=true `
	-p:PublishSingleFile=true `
	-o $OutputPath

dotnet publish `
	.\v2rayUpgrade\v2rayUpgrade.csproj `
	-r win-x86 `
	-c Release `
	--self-contained false `
	-p:PublishReadyToRun=true `
	-p:PublishSingleFile=true `
	-o $OutputPath

if ( -Not $? ) {
	exit $lastExitCode
	}

if ( Test-Path -Path .\bin\v2rayN-32 ) {
    rm -Force "$OutputPath\*.pdb"
    rm -Force "$OutputPath\*.xml"
}

Write-Host 'Build done'

ls $OutputPath
7z a  v2rayN-32.zip $OutputPath
exit 0