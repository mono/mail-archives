VSINSTALLDIR="/c/ProgramFiles/MicrosoftVisualStudio.NET2003/Common7/IDE"
VCINSTALLDIR="/c/ProgramFiles/MicrosoftVisualStudio.NET2003"
FrameworkDir="/c/WINDOWS/Microsoft.NET/Framework"
FrameworkVersion="v1.1.4322"
FrameworkSDKDir="/c/ProgramFiles/MicrosoftVisualStudio.NET2003/SDK/v1.1"
DevEnvDir="$VSINSTALLDIR"
MSVCDir="$VCINSTALLDIR/VC7"
PATH="$DevEnvDir:$MSVCDir/BIN:$VCINSTALLDIR/Common7/Tools:$VCINSTALLDIR/Common7/Tools/bin/prerelease:$VCINSTALLDIR/Common7/Tools/bin:$FrameworkSDKDir/bin:$FrameworkDir/$FrameworkVersion:$PATH:"
INCLUDE="$MSVCDir/ATLMFC/INCLUDE:$MSVCDir/INCLUDE:$MSVCDir/PlatformSDK/include/prerelease:$MSVCDir/PlatformSDK/include:$FrameworkSDKDir/include:$INCLUDE"
LIB="$MSVCDir/ATLMFC/LIB:$MSVCDir/LIB:$MSVCDir/PlatformSDK/lib/prerelease:$MSVCDir/PlatformSDK/lib:$FrameworkSDKDir/lib:$LIB"

export VSINSTALLDIR VCINSTALLDIR
export FrameworkDir FrameworkVersion FrameworkSDKDir DevEnvDir
export PATH INCLUDE LIB
