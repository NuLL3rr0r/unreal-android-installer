################################################################################
# Copyright Notice
################################################################################

#  (The MIT License)
#
#  Copyright (c) 2025 Mamadou Babaei
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in
#  all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#  THE SOFTWARE.

################################################################################
# PowerShell Script Configuration
################################################################################

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$PSDefaultParameterValues["*:ErrorAction"] = "Stop"

Set-Variable -Name EXECUTION_TIMESTAMP -Value (
    Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
) -Option Constant

################################################################################
# Options Constants
################################################################################

Set-Variable -Name LOG_TO_FILE -Value $True -Option Constant

Set-Variable -Name ANDROID_BUILD_TOOLS_VERSION -Value "35.0.1" -Option Constant
Set-Variable -Name ANDROID_COMMAND_LINE_TOOLS_VERSION -Value ("13114758") -Option Constant
Set-Variable -Name ANDROID_NDK_VERSION -Value "27.2.12479018" -Option Constant
Set-Variable -Name ANDROID_PLATFORMS_VERSION -Value "android-34" -Option Constant
Set-Variable -Name ANDROID_STUDIO_VERSION -Value "2024.1.2.13" -Option Constant
Set-Variable -Name CMAKE_VERSION -Value "3.22.1" -Option Constant
Set-Variable -Name JDK_VERSION -Value "21.0.9" -Option Constant

Set-Variable -Name ANDROID_COMMAND_LINE_TOOLS_CHECKSUM -Value (
    "98b565cb657b012dae6794cefc0f66ae1efb4690c699b78a614b4a6a3505b003"
) -Option Constant
Set-Variable -Name ANDROID_STUDIO_CHECKSUM -Value (
    "e36b2ba026032f10111d2a6bb895bb31628d8a1bc3ffe6718a67b20d4c211a0f"
) -Option Constant
Set-Variable -Name JDK_CHECKSUM -Value (
    "6d183e2f35fefd3a196d3c7163ca8f1a7ca8f25bdaac15eadd9c9b22e9efdfdd"
)    -Option Constant

Set-Variable -Name JDK_MAJOR_VERSION -Value (
    $JDK_VERSION.Split('.')[0]
) -Option Constant

################################################################################
# Download Constants
################################################################################

Set-Variable -Name ANDROID_COMMAND_LINE_TOOLS_ARCHIVE_NAME -Value (
    "commandlinetools-win-$ANDROID_COMMAND_LINE_TOOLS_VERSION`_latest.zip"
) -Option Constant
Set-Variable -Name ANDROID_COMMAND_LINE_TOOLS_URL -Value (
    "https://dl.google.com/android/repository/$ANDROID_COMMAND_LINE_TOOLS_ARCHIVE_NAME"
) -Option Constant

Set-Variable -Name ANDROID_STUDIO_ARCHIVE_NAME -Value (
    "android-studio-$ANDROID_STUDIO_VERSION`-windows.zip"
) -Option Constant
Set-Variable -Name ANDROID_STUDIO_URL -Value (
    "https://redirector.gvt1.com/edgedl/android/studio/ide-zips/$ANDROID_STUDIO_VERSION/$ANDROID_STUDIO_ARCHIVE_NAME"
) -Option Constant

Set-Variable -Name JDK_ARCHIVE_NAME -Value (
    "jdk-$JDK_VERSION`_windows-x64_bin.zip"
) -Option Constant
Set-Variable -Name JDK_URL -Value (
    "https://download.oracle.com/java/$JDK_MAJOR_VERSION/archive/$JDK_ARCHIVE_NAME"
)    -Option Constant

################################################################################
# Installation Prefix Constants
################################################################################

Set-Variable -Name LOCAL_APP_DATA -Value (
    [System.Environment]::GetEnvironmentVariable('LOCALAPPDATA', 'Process')
) -Option Constant

Set-Variable -Name INSTALL_PREFIX_DIR -Value (
    Join-Path -Path "$LOCAL_APP_DATA" -ChildPath "Android"
) -Option Constant

Set-Variable -Name ANDROID_SDK_DIR_NAME -Value "Sdk" -Option Constant
Set-Variable -Name ANDROID_SDK_DIR -Value (
    Join-Path -Path ($INSTALL_PREFIX_DIR) -ChildPath ($ANDROID_SDK_DIR_NAME)
) -Option Constant

Set-Variable -Name ANDROID_COMMAND_LINE_TOOLS_DIR_NAME -Value (
    "cmdline-tools"
) -Option Constant
Set-Variable -Name ANDROID_COMMAND_LINE_TOOLS_DIR -Value (
    Join-Path -Path ($ANDROID_SDK_DIR) -ChildPath ($ANDROID_COMMAND_LINE_TOOLS_DIR_NAME)
) -Option Constant
Set-Variable -Name ANDROID_COMMAND_LINE_TOOLS_BIN_DIR -Value (
    Join-Path -Path (
        Join-Path -Path ($ANDROID_COMMAND_LINE_TOOLS_DIR) -ChildPath "latest"
    ) -ChildPath "bin"
) -Option Constant

Set-Variable -Name ANDROID_PLATFORM_TOOLS_DIR -Value (
    Join-Path -Path ($ANDROID_SDK_DIR) -ChildPath "platform-tools"
) -Option Constant

Set-Variable -Name ANDROID_NDK_DIR -Value (
    Join-Path -Path ($ANDROID_SDK_DIR) -ChildPath "ndk"
) -Option Constant

Set-Variable -Name ANDROID_SDK_MANAGER_BIN_NAME -Value "sdkmanager.bat"
Set-Variable -Name ANDROID_SDK_MANAGER -Value (
    Join-Path -Path (
        $ANDROID_COMMAND_LINE_TOOLS_BIN_DIR
    ) -ChildPath ($ANDROID_SDK_MANAGER_BIN_NAME)
) -Option Constant

Set-Variable -Name ANDROID_STUDIO_DIR_NAME -Value (
    "android-studio"
) -Option Constant
Set-Variable -Name ANDROID_STUDIO_DIR -Value (
    Join-Path -Path ($INSTALL_PREFIX_DIR) -ChildPath ($ANDROID_STUDIO_DIR_NAME)
) -Option Constant

Set-Variable -Name JDK_DIR_NAME -Value "jdk-$JDK_VERSION" -Option Constant
Set-Variable -Name JDK_DIR -Value (
    Join-Path -Path ($INSTALL_PREFIX_DIR) -ChildPath ($JDK_DIR_NAME)
) -Option Constant

################################################################################
# Temporary Directory Constants
################################################################################

Set-Variable -Name TEMP_DIR -Value (
    Join-Path -Path (
        [System.IO.Path]::GetTempPath()
    ) -ChildPath ([guid]::NewGuid().ToString())
) -Option Constant

Set-Variable -Name ANDROID_COMMAND_LINE_TOOLS_ARCHIVE_PATH -Value (
    Join-Path -Path (
        $TEMP_DIR
    ) -ChildPath ($ANDROID_COMMAND_LINE_TOOLS_ARCHIVE_NAME)
) -Option Constant
Set-Variable -Name ANDROID_COMMAND_LINE_TOOLS_DIR_FROM_TEMP -Value (
    Join-Path -Path (
        $TEMP_DIR
    ) -ChildPath ($ANDROID_COMMAND_LINE_TOOLS_DIR_NAME)
) -Option Constant

Set-Variable -Name ANDROID_SDK_MANAGER_FROM_TEMP -Value (
    Join-Path -Path (
        Join-Path -Path (
            $ANDROID_COMMAND_LINE_TOOLS_DIR_FROM_TEMP
        ) -ChildPath "bin"
    ) -ChildPath "$ANDROID_SDK_MANAGER_BIN_NAME"
) -Option Constant

Set-Variable -Name ANDROID_STUDIO_ARCHIVE_PATH -Value (
    Join-Path -Path ($TEMP_DIR) -ChildPath ($ANDROID_STUDIO_ARCHIVE_NAME)
) -Option Constant
Set-Variable -Name JDK_ARCHIVE_PATH -Value (
    Join-Path -Path ($TEMP_DIR) -ChildPath ($JDK_ARCHIVE_NAME)
) -Option Constant

################################################################################
# Registry Variables Constants
################################################################################

Set-Variable -Name ANDROID_STUDIO_REGISTRY_PATH -Value (
    "HKLM:\SOFTWARE\Android Studio"
) -Option Constant

################################################################################
# Environment Variables Constants
################################################################################

Set-Variable -Name ANDROID_HOME -Value ($ANDROID_SDK_DIR) -Option Constant
Set-Variable -Name JAVA_HOME -Value ($JDK_DIR) -Option Constant
Set-Variable -Name NDK_ROOT -Value ($ANDROID_NDK_DIR) -Option Constant
Set-Variable -Name NDKROOT -Value ($NDK_ROOT) -Option Constant
Set-Variable -Name STUDIO_PATH -Value ($ANDROID_STUDIO_DIR) -Option Constant
Set-Variable -Name STUDIO_SDK_PATH -Value ($ANDROID_HOME) -Option Constant

Set-Variable -Name OLD_PATH -Value (
    [System.Environment]::GetEnvironmentVariable('PATH', 'User')
) -Option Constant

Set-Variable -Name PATH -Value (
    (
        (
            @(
                $ANDROID_COMMAND_LINE_TOOLS_BIN_DIR,
                $ANDROID_PLATFORM_TOOLS_DIR,
                $NDK_ROOT,
                $JAVA_HOME
            ) + ($OLD_PATH -split ';')
        ) |
        Where-Object { $_ -and ($_ -ne '') } |
        Select-Object -Unique
    ) -join ';'
) -Option Constant

################################################################################
# Formatting Constants
################################################################################

Set-Variable -Name FMT_HEADER_ROW -Value (
    "================================================================================"
) -Option Constant
Set-Variable -Name FMT_HEADER_PREFIX -Value "!!" -Option Constant

################################################################################
# Logging Setup
################################################################################

Set-Variable -Name SCRIPT_PATH -Value (
    $MyInvocation.MyCommand.Path
) -Option Constant
Set-Variable -Name SCRIPT_DIR -Value (
    Split-Path -Path $SCRIPT_PATH
) -Option Constant
Set-Variable -Name SCRIPT_NAME -Value (
    [System.IO.Path]::GetFileNameWithoutExtension($SCRIPT_PATH)
) -Option Constant

Set-Variable -Name LOG_FILE_NAME -Value (
    "$SCRIPT_NAME`-$EXECUTION_TIMESTAMP`.log"
) -Option Constant

Set-Variable -Name LOG_FILE -Value (
    Join-Path -Path $SCRIPT_DIR -ChildPath $LOG_FILE_NAME
) -Option Constant

################################################################################
# Functions
################################################################################

function M-Log {
    param (
        [string]$Message
    )

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $line = "[$timestamp] $Message"

    Write-Output "$line"

    if ($LOG_TO_FILE -and $LOG_FILE) {
        "$line" | Out-File -FilePath $LOG_FILE -Append -Encoding utf8
    }
}

function M-Log-No-Timestamp {
    param (
        [string]$Message
    )

    Write-Output "$Message"

    if ($LOG_TO_FILE -and $LOG_FILE) {
        $Message | Out-File -FilePath $LOG_FILE -Append -Encoding utf8
    }
}

function M-LogFatal() {
    Param(
        [Parameter(Mandatory=$True)]
        [String]$Error
    )

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $line = "[$timestamp] FATAL: $Error"

    Write-Host "$line" -ForegroundColor Red

    if ($LOG_TO_FILE -and $LOG_FILE) {
        "$line" | Out-File -FilePath $LOG_FILE -Append -Encoding utf8
    }

    Write-Host "" -ForegroundColor Red
    Write-Host "Press Enter to exit..." -ForegroundColor Red
    Write-Host "" -ForegroundColor Red

    [void][System.Console]::ReadLine()

    Exit 1
}

function M-PrintHeader() {
    Param(
        [Parameter(Mandatory=$True)]
        [String]$Header
    )

    M-Log-No-Timestamp ""
    M-Log-No-Timestamp "$FMT_HEADER_ROW"
    M-Log-No-Timestamp "$FMT_HEADER_PREFIX $Header"
    M-Log-No-Timestamp "$FMT_HEADER_ROW"
    M-Log-No-Timestamp ""
}

function M-EnsureElevation {
    M-PrintHeader -Header "Administrator Elevation Check"

    M-Log "Checking if the script is running with administrator privileges..."

    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    $isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

    if (-not $isAdmin) {
        Write-Host "Elevation required. Relaunching script as administrator..."
        Start-Process -FilePath "powershell.exe" `
                      -ArgumentList "-NoProfile", "-ExecutionPolicy Bypass", "-File `"$PSCommandPath`"" `
                      -Verb RunAs
        Exit
    }
}

function M-PrintSetupInfo() {
    M-PrintHeader -Header "Setup Information"
    M-Log ""
    M-Log "Android Build Tools Version        : $ANDROID_BUILD_TOOLS_VERSION"
    M-Log "Android Command-line Tools Version : $ANDROID_COMMAND_LINE_TOOLS_VERSION"
    M-Log "Android NDK Version                : $ANDROID_NDK_VERSION"
    M-Log "Android Platforms Version          : $ANDROID_PLATFORMS_VERSION"
    M-Log "Android Studio Version             : $ANDROID_STUDIO_VERSION"
    M-Log "CMake Version                      : $CMAKE_VERSION"
    M-Log "JDK Version                        : $JDK_VERSION"
    M-Log "JDK Major Version                  : $JDK_MAJOR_VERSION"
    M-Log ""
    M-Log "Android Command-line Tools Checksum : $ANDROID_COMMAND_LINE_TOOLS_CHECKSUM"
    M-Log "Android NDK Checksum                : $ANDROID_STUDIO_CHECKSUM"
    M-Log "JDK Checksum                        : $JDK_CHECKSUM"
    M-Log ""
    M-Log "Android Command-line Tools URL : $ANDROID_COMMAND_LINE_TOOLS_URL"
    M-Log "Android Studio URL             : $ANDROID_STUDIO_URL"
    M-Log "JDK URL                        : $JDK_URL"
    M-Log ""
    M-Log "Temporary Directory : $TEMP_DIR"
    M-Log ""
    M-Log "ANDROID_HOME    : $ANDROID_HOME"
    M-Log "JAVA_HOME       : $JAVA_HOME"
    M-Log "NDK_ROOT        : $NDK_ROOT"
    M-Log "NDKROOT         : $NDKROOT"
    M-Log "STUDIO_PATH     : $STUDIO_PATH"
    M-Log "STUDIO_SDK_PATH : $STUDIO_SDK_PATH"
    M-Log "PATH            : $PATH"
}

function M-SafeRemoveInstallPrefix() {
    M-PrintHeader -Header "Installation Safety Checks"

    M-Log "Checking if the installation directory '$INSTALL_PREFIX_DIR' exists..."
    if (Test-Path $INSTALL_PREFIX_DIR) {
        M-Log "Installation directory '$INSTALL_PREFIX_DIR' already exists..."
        $response = Read-Host "Are you sure you want to delete it? (y/N)"
        if ($response -match '^(y|yes)$') {
            Write-Progress -Activity "Installation Safety Checks" `
                -Status "Cleaning up the old installation '$INSTALL_PREFIX_DIR'..." `
                -PercentComplete 0

            try {
                M-Log "Removing existing installation '$INSTALL_PREFIX_DIR'..."
                Remove-Item -Path $INSTALL_PREFIX_DIR -Recurse -Force
                M-Log "Existing installation has been removed successfully!"
            } catch {
                Write-Progress -Activity "Installation Safety Checks" `
                    -Status "Cleaning up the old installation has failed!" `
                    -PercentComplete 100 `
                    -Completed

                M-LogFatal "Failed to clean up the old installation; it may be in use (e.g. adb.exe is running)!"
            }

            Write-Progress -Activity "Installation Safety Checks" `
                -Status "Cleaned up the old installation successfully!" `
                -PercentComplete 100 `
                -Completed
        } else {
            M-Log ""
            M-Log "Installation canceled by user!"
            M-Log ""
            Exit 1
        }
    } else {
        M-Log "Installation directory does not exist; skipping..."
    }
}

function M-CreateTempDir() {
    M-PrintHeader -Header "Temporary Directory Creation"

    M-Log "Creating temporary directory '$TEMP_DIR'..."
    New-Item -ItemType Directory -Force -Path $TEMP_DIR | Out-Null
    M-Log "Temporary directory created!"
}

function M-CleanupTempDir() {
    M-PrintHeader -Header "Temporary Directory Cleanup"

    Write-Progress -Activity "Temporary Directory Cleanup" `
        -Status "Cleaning up temporary directory '$TEMP_DIR'..." `
        -PercentComplete 0

    M-Log "Cleaning up temporary directory '$TEMP_DIR'..."
    Remove-Item -Path $TEMP_DIR -Recurse -Force
    M-Log "Temporary directory cleaned up!"

    Write-Progress -Activity "Temporary Directory Cleanup" `
        -Status "Temporary directory cleaned up!" `
        -PercentComplete 100 `
        -Completed
}

function M-DownloadArchive() {
    Param(
        [Parameter(Mandatory=$True)]
        [String]$Url,
        [Parameter(Mandatory=$True)]
        [String]$Path
    )

    M-PrintHeader -Header "Archive Download"

    M-Log "Downloading Archive..."
    M-Log "  - URL  : $Url"
    M-Log "  - Path : $Path"
    M-Log ""

    Start-BitsTransfer -Source $Url -Destination $Path

    M-Log "Download completed successfully!"
}

function M-VerifyArchive() {
    Param(
        [Parameter(Mandatory=$True)]
        [String]$Path,
        [Parameter(Mandatory=$True)]
        [String]$Checksum
    )

    M-PrintHeader -Header "Archive Checksum Verification"

    M-Log "Verifying Archive Checksum..."
    M-Log "  - Path     : $Path"
    M-Log "  - Checksum : $Checksum"
    M-Log ""

    $ActualChecksum = Get-FileHash -Algorithm SHA256 -Path $Path | Select-Object -ExpandProperty Hash

    if ($ActualChecksum -ne $Checksum) {
        M-LogFatal "Checksum mismatch; file may be corrupted or tampered with!"
    }

    M-Log "Archive checksum verified successfully!"
}

function M-ExtractArchive() {
    Param(
        [Parameter(Mandatory=$True)]
        [String]$Path,
        [Parameter(Mandatory=$True)]
        [String]$DestinationPath,
        [Parameter(Mandatory=$True)]
        [String]$ExtractionPath
    )

    M-PrintHeader -Header "Archive Extraction"

    M-Log "Extracting Archive..."
    M-Log "  - Path                 : $Path"
    M-Log "  - Destination Path     : $DestinationPath"
    M-Log "  - Extraction Directory : $ExtractionPath"
    M-Log ""

    Expand-Archive -Path $Path -DestinationPath $DestinationPath -Force

    M-Log "Archive extracted successfully!"
}

function M-RemoveArchive() {
    Param(
        [Parameter(Mandatory=$True)]
        [String]$Path
    )

    M-PrintHeader -Header "Archive Removal"

    M-Log "Removing Archive..."
    M-Log "  - Path : $Path"
    M-Log ""

    Remove-Item -Path $Path -Force

    M-Log "Archive removed successfully!"
}

function M-AcceptAndroidSDKLicenses() {
    M-PrintHeader -Header "Android SDK Licenses Agreement"

    $env:JAVA_HOME = $JAVA_HOME
    $env:PATH = "$JAVA_HOME\bin;$OLD_PATH"

    ("y`n" * 100) | & "$ANDROID_SDK_MANAGER_FROM_TEMP" --sdk_root="$ANDROID_HOME" --licenses

    M-Log "Android SDK Licenses accepted successfully!"
}

function M-InstallAndroidSDKManager() {
    M-PrintHeader -Header "Latest Android SDK Manager Installation"

    $env:JAVA_HOME = $JAVA_HOME
    $env:PATH = "$JAVA_HOME\bin;$OLD_PATH"

    & "$ANDROID_SDK_MANAGER_FROM_TEMP" --sdk_root="$ANDROID_HOME" "cmdline-tools;latest"

    M-Log "Latest version of Android SDK Manager has been installed successfully!"
}

function M-InstallAndroidSDK() {
    M-PrintHeader -Header "Android SDK Components Installation"

    & "$ANDROID_SDK_MANAGER" `
        "build-tools;$ANDROID_BUILD_TOOLS_VERSION" `
        "cmake;$CMAKE_VERSION" `
        "extras;google;usb_driver" `
        "ndk;$ANDROID_NDK_VERSION" `
        "platform-tools" `
        "platforms;$ANDROID_PLATFORMS_VERSION"

    M-Log "Required Android SDK components have been installed successfully!"
}

function M-SetRegistryKeysValues() {
    M-PrintHeader -Header "Registry Keys/Values Setup"

    M-Log "Setting $ANDROID_STUDIO_REGISTRY_PATH`..."
    M-Log "  - Path    : $STUDIO_PATH"
    M-Log "  - SdkPath : $STUDIO_SDK_PATH"

    if (-not (Test-Path $ANDROID_STUDIO_REGISTRY_PATH)) {
        New-Item -Path $ANDROID_STUDIO_REGISTRY_PATH -Force | Out-Null
    }
    
    New-ItemProperty -Path $ANDROID_STUDIO_REGISTRY_PATH `
        -Name "Path" -Value $STUDIO_PATH -PropertyType "String" -Force
    New-ItemProperty -Path $ANDROID_STUDIO_REGISTRY_PATH `
        -Name "SdkPath" -Value $STUDIO_SDK_PATH -PropertyType "String" -Force

    M-Log "Required Android Studio registry keys/values have been set up successfully!"
}

function M-SetEnvVars() {
    M-PrintHeader -Header "Environment Variables Setup"

    M-Log "Setting..."
    M-Log "  - ANDROID_HOME    : $ANDROID_HOME"
    M-Log "  - JAVA_HOME       : $JAVA_HOME"
    M-Log "  - NDK_ROOT        : $NDK_ROOT"
    M-Log "  - NDKROOT         : $NDKROOT"
    M-Log "  - STUDIO_PATH     : $STUDIO_PATH"
    M-Log "  - STUDIO_SDK_PATH : $STUDIO_SDK_PATH"
    M-Log "  - PATH            : $PATH"
    M-Log ""

    Write-Progress -Activity "Environment Variables Setup" `
        -Status "Setting up required environment variables..." `
        -PercentComplete 0

    [Environment]::SetEnvironmentVariable("ANDROID_HOME", "$ANDROID_HOME", "User")
    [Environment]::SetEnvironmentVariable("JAVA_HOME", "$JAVA_HOME", "User")
    [Environment]::SetEnvironmentVariable("NDK_ROOT", "$NDK_ROOT", "User")
    [Environment]::SetEnvironmentVariable("NDKROOT", "$NDKROOT", "User")
    [Environment]::SetEnvironmentVariable("STUDIO_PATH", "$STUDIO_PATH", "User")
    [Environment]::SetEnvironmentVariable("STUDIO_SDK_PATH", "$STUDIO_SDK_PATH", "User")
    [Environment]::SetEnvironmentVariable("PATH", "$PATH", "User")

    Write-Progress -Activity "Environment Variables Setup" `
        -Status "Required environment variables has been set!" `
        -PercentComplete 100 `
        -Completed

    M-Log "Verifying..."
    M-Log "  - ANDROID_HOME    : $([System.Environment]::GetEnvironmentVariable('ANDROID_HOME', 'User'))"
    M-Log "  - JAVA_HOME       : $([System.Environment]::GetEnvironmentVariable('JAVA_HOME', 'User'))"
    M-Log "  - NDK_ROOT        : $([System.Environment]::GetEnvironmentVariable('NDK_ROOT', 'User'))"
    M-Log "  - NDKROOT         : $([System.Environment]::GetEnvironmentVariable('NDKROOT', 'User'))"
    M-Log "  - STUDIO_PATH     : $([System.Environment]::GetEnvironmentVariable('STUDIO_PATH', 'User'))"
    M-Log "  - STUDIO_SDK_PATH : $([System.Environment]::GetEnvironmentVariable('STUDIO_SDK_PATH', 'User'))"
    M-Log "  - PATH            : $([System.Environment]::GetEnvironmentVariable('PATH', 'User'))"
}

function M-FinishAndWait() {
    M-PrintHeader -Header "Done"

    M-Log "Installation has completed successfully!"
    M-Log ""
    M-Log "To ensure your Android build environment is healthy and functional:"
    M-Log ""
    M-Log "  > cd \Path\To\UnrealEngine\Directory\Engine\Extras\Android"
    M-Log "  > SetupAndroid.bat"
    M-Log ""
    M-Log "If you see a 'Success' message after running SetupAndroid.bat, your environment is ready to use."
    M-Log ""

    Write-Host ""
    Write-Host "Press Enter to continue..."
    Write-Host ""

    [void][System.Console]::ReadLine()
}

################################################################################
# Execution Flow
################################################################################

function M-Execute() {
    M-EnsureElevation

    M-PrintSetupInfo

    M-SafeRemoveInstallPrefix

    M-CreateTempDir

    M-DownloadArchive `
        -Url $ANDROID_COMMAND_LINE_TOOLS_URL `
        -Path $ANDROID_COMMAND_LINE_TOOLS_ARCHIVE_PATH
    M-VerifyArchive `
        -Path $ANDROID_COMMAND_LINE_TOOLS_ARCHIVE_PATH `
        -Checksum $ANDROID_COMMAND_LINE_TOOLS_CHECKSUM
    M-ExtractArchive `
        -Path $ANDROID_COMMAND_LINE_TOOLS_ARCHIVE_PATH `
        -DestinationPath $TEMP_DIR `
        -ExtractionPath $ANDROID_COMMAND_LINE_TOOLS_DIR
    M-RemoveArchive -Path $ANDROID_COMMAND_LINE_TOOLS_ARCHIVE_PATH

    M-DownloadArchive `
        -Url $ANDROID_STUDIO_URL `
        -Path $ANDROID_STUDIO_ARCHIVE_PATH
    M-VerifyArchive `
        -Path $ANDROID_STUDIO_ARCHIVE_PATH `
        -Checksum $ANDROID_STUDIO_CHECKSUM
    M-ExtractArchive `
        -Path $ANDROID_STUDIO_ARCHIVE_PATH `
        -DestinationPath $INSTALL_PREFIX_DIR `
        -ExtractionPath $ANDROID_STUDIO_DIR
    M-RemoveArchive -Path $ANDROID_STUDIO_ARCHIVE_PATH

    M-DownloadArchive `
        -Url $JDK_URL `
        -Path $JDK_ARCHIVE_PATH
    M-VerifyArchive `
        -Path $JDK_ARCHIVE_PATH `
        -Checksum $JDK_CHECKSUM
    M-ExtractArchive `
        -Path $JDK_ARCHIVE_PATH `
        -DestinationPath $INSTALL_PREFIX_DIR `
        -ExtractionPath $JDK_DIR
    M-RemoveArchive -Path $JDK_ARCHIVE_PATH

    M-AcceptAndroidSDKLicenses
    M-InstallAndroidSDKManager
    M-InstallAndroidSDK

    M-CleanupTempDir

    M-SetRegistryKeysValues
    M-SetEnvVars

    M-FinishAndWait
}

M-Execute