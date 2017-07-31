param(
    [string]$packageDir = ".\jspm_packages\npm",
    [bool]$verbose = $false,
    [string]$outPath
)

$numberOfLicenses = 0
$output = @()

$cwd = pwd
cd $packageDir
$depDirNames = Get-ChildItem -Path $packageDir -Directory

ForEach ($depDir in $depDirNames) {
    $licType = "???"
    $licFound = $false
    cd $depDir
    $depDirStr = [string]$depDir
    $depName = $depDirStr.Split("@")[0]
    $depVer = $depDirStr.Split("@")[1]

    if (Test-Path "package.json") {
        $jsonPackageInfo = cat 'package.json' | ConvertFrom-Json
        if ($jsonPackageInfo.license -Or $jsonPackageInfo.licenses) {
            if ($jsonPackageInfo.license) { 
                $licType = $jsonPackageInfo.license
            } elseif ($jsonPackageInfo.licenses) {
                if ($jsonPackageInfo.licenses[0].type) {
                    $licType = $jsonPackageInfo.licenses[0].type
                } 
                else {
                    $licType = $jsonPackageInfo.licenses
                }
            }          
            $numberOfLicenses++
            $licFound = $true
        }   
    }

    $output += "$depName,$depVer,$licType"
    cd $packageDir
}

if ($outPath) {
    if ($outPath.Substring(1,3) -ne ":\") {
        $outputPath = "$cwd\$outPath"
        $output | Out-File $outputPath
    } 
    else  {
        $output | Out-File $outputPath
    }
    
}
else {
    ForEach ($line in $output) {
        Write-Host $line
    }
    
}

if ($verbose) {
    Write-Host "Number of packages $($depDirNames.Length)"
    Write-Host "Number of licenses discovered: $numberOfLicenses"
}
cd $cwd
