#!/usr/bin/env zsh  

_main_android() {
    
    androidSDKDir() {
        print "`userLibraryDir`/Android/sdk"
    }

    androidSDKSetupEnv() {
        export GRADLE_USER_HOME="`userHomeDir`/.gradle"
        export ANDROID_HOME="`androidSDKDir`"
        export ANDROID_SDK_ROOT="$ANDROID_HOME"
    }

    androidStudioOpen:ProjectDir_optional() {
        macOpen:AppName:Args_array "android studio" "$1"
    }

    androidEmulatorsCloseAll() {
        adbRunOnAllConnectedDevices:Commands emu kill
    }

    android8StartEmulator() {
        androidStart:EmulatorName 8_api26
    }

    android8.1StartEmulator() {
        androidStart:EmulatorName 8.1_api27
    }

    androidStart:EmulatorName() {
        androidEmulator -avd "$1" &
    }

    androidStudioSettingsBackupDir() {
        print "`linuxConfigDir`/IDESettings/AndroidStudio"
    }

    androidStudioDocumentationSettingsEdit(){
        `codeEditor` `androidStudioDocumentationSettingsFile`
    }

    androidStudioDocumentationSettingsFile() {
        print "`androidStudioSettingsDir`/options/jdk.table.xml"
    }

    androidStudioSettingsDir() {
        print "`userLibraryDir`/Preferences/AndroidStudio4.0"
    }

    androidToolsDirGoto() {
        cd `androidToolsDir`
    }

    androidToolsDir(){
        print "`androidSDKDir`/tools"
    }

    androidSDKManager() {
        "`androidToolsDir`/bin/sdkmanager" $@
    }

    alias android="`androidToolsDir`/android"
    alias androidEmulator="`androidToolsDir`/emulator"

    androidDeabfuscate_logFile_mappingFile_outputFile() {
        retrace -verbose "$2" "$1" > "$3"
    }

    androidPlatformToolsGoto() {
        cd "`androidPlatformToolsDir`"
    }

    androidPlatformToolsDir() {
        print "`androidSDKDir`/platform-tools"
    }
    alias adb="`androidPlatformToolsDir`/adb"

    adbRunOnAllConnectedDevices:Commands(){
        adb devices | while read line
        do
            if [ ! "$line" = "" ] && [ `echo $line | awk '{print $2}'` = "device" ]
            then
                device=`echo $line | awk '{print $1}'`
                adbRunOn:DeviceId:Commands ${device} ${@}
            fi
        done
    }

    adbStayAwakeEnable(){
        adbRunOnAllConnectedDevices:Commands shell settings put global stay_on_while_plugged_in 3
        # Reference:
        # https://developer.android.com/reference/android/provider/Settings.Global#stay_on_while_plugged_in
    }

    adbStayAwakeDisable(){
        adbRunOnAllConnectedDevices:Commands shell settings put global stay_on_while_plugged_in 0
        # Reference:
        # https://developer.android.com/reference/android/provider/Settings.Global#stay_on_while_plugged_in
    }

    adbGotoSettings:DeviceId(){
        adbRunOn:DeviceId:Commands "$1" shell am start -n com.android.settings/.DevelopmentSettings
    }

    adbRunGetApkFrom:DeviceId:AppPackageId(){
        adbRunOn:DeviceId:Commands "$1" pull /data/app/"$2"/base.apk
    }

    adbClearDataFromDevices:AppPackageId(){
        adbRunOnAllConnectedDevices:Commands shell pm clear "$1"
    }

    adbSet24HoursFormatOn:DeviceId(){
        adbRunOn:DeviceId:Commands "$1" shell settings put system time_12_24 24
    }

    adbSet12HoursFormatOn:DeviceId(){
        adbRunOn:DeviceId:Commands "$1" shell settings put system time_12_24 12
    }

    adbRemoveFrom:DeviceId:AppPackageId(){
        adbRunOn:DeviceId:Commands "$1" uninstall "$2"
    }

    adbRemoveFromAllDevices:AppPackageId(){
        adbRunOnAllConnectedDevices:Commands uninstall "$1"
    }

    adbInstallOn:DeviceId:Apk() {
        adbRunOn:DeviceId:Commands "$1" install "$2"
    }

    adbInstallOnAllDevices_apk() {
        adbRunOnAllConnectedDevices:Commands install -r "$1"
    }

    adbStartOn:DeviceId:PackageName:ActivityClassFullName(){
        adbRunOn:DeviceId:Commands "$1" shell am start -n "$2"/"$3"
    }

    adbStartOnAllDevices_packageName_mainActivityClassFullName(){
        adbRunOnAllConnectedDevices:Commands shell am start -n "$1"/"$2"
    }

    adbRemoveFromAllDevices:PathToFile(){
        adbRunOnAllConnectedDevices:Commands shell rm -r "$1"
    }

    adbOSVersionOfAllDevices(){
        adbRunOnAllConnectedDevices:Commands shell getprop ro.build.version.release
    }

    adbResetPermissionsAtAllDevices:AppPackageId(){
        adbRunOnAllConnectedDevices:Commands shell pm reset-permissions "$1"
    }

    facebookAndroidKeyHashcode:KeyAlias:KeystoreFilePath(){
        do_facebookAndroidKeyHashcode:KeyAlias:KeystoreFilePath(){
            keytool -exportcert -alias "$1" -keystore "$2" | openssl sha1 -binary | openssl base64
        }
        if isEmpty:String $1 || isEmpty:String $2; then
            print "Looking for DEBUG key. Use 'Android' as a password"
            do_facebookAndroidKeyHashcode:KeyAlias:KeystoreFilePath androiddebugkey "~/.android/debug.keystore"
        else
            do_facebookAndroidKeyHashcode:KeyAlias:KeystoreFilePath "$1" "$2"
        fi
    }  

    androidSDKVersionsDescription() {
        local values=(
            API_level Code_name     Version_number       Release_date         Linux_kernel_ver \
            "1"       "1.0"         "(No codename)"      "September 23, 2008" "?"                                 
            "2"       "1.1"         "Petit Four"         "February 9, 2009"   "2.6"                               
            "2"       "1.1"         "Petit Four"         "February 9, 2009"   "2.6"                               
            "3"       "1.5"         "Cupcake"            "April 27, 2009"     "2.6.27"                            
            "4"       "1.6"         "Donut"              "September 15, 2009" "2.6.29"                            
            "5 – 7"   "2.0 – 2.1"   "Eclair"             "October 26, 2009"   "2.6.29"                            
            "8"       "2.2 – 2.2.3" "Froyo"              "May 20, 2010"       "2.6.32"                            
            "9 – 10"  "2.3 – 2.3.7" "Gingerbread"        "December 6, 2010"   "2.6.35"                            
            "11 – 13" "3.0 – 3.2.6" "Honeycomb"          "February 22, 2011"  "2.6.36"                            
            "14 – 15" "4.0 – 4.0.4" "Ice Cream Sandwich" "October 18, 2011"   "3.0.1"                             
            "16 – 18" "4.1 – 4.3.1" "Jelly Bean"         "July 9, 2012"       "3.0.31 to 3.4.39"                  
            "19 – 20" "4.4 – 4.4.4" "KitKat"             "October 31, 2013"   "3.10"                              
            "21 – 22" "5.0 – 5.1.1" "Lollipop"           "November 12, 2014"  "3.16"                              
            "23"      "6.0 – 6.0.1" "Marshmallow"        "October 5, 2015"    "3.18"                              
            "24 – 25" "7.0 – 7.1.2" "Nougat"             "August 22, 2016"    "4.4"                               
            "26 – 27" "8.0 – 8.1"   "Oreo"               "August 21, 2017"    "4.10"                              
            "28"      "9.0"         "Pie"                "August 6, 2018"     "4.4.107, 4.9.84, and 4.14.42"      
            "29"      "10.0"        "Android Q"          ""                   ""                                  
        )
        print -arC5 -- "$values[@]"
    }

    adbLogsFetchFromDevicesTo:File() {
        adbRunOnAllConnectedDevices:Commands logcat >> "$1"
    }

    adbRunOn:DeviceId:Commands() {
        echo "\nGoing to run commands: ${@:2}\n on device: $1"
        adb -s "$1" ${@:2} </dev/null  
    }

    adbListAllInstalledApps() {
        adbRunOnAllConnectedDevices:Commands shell pm list packages -f
    }

    androidCopyReleaseBuildArtifactsFrom:AppModuleDirTo:BuildNumber:TargetDir() {
        targetDir="$3/`monthDirName`/$2"
        filePrepareDirAt:Path "$targetDir"
        copyFiles:FromDir:NameMatchingPattern:ToDir \
                "$1/build/outputs/apk/release/" \
                "*$2*.apk" \
                "$targetDir" && \
        cp "$1/build/outputs/mapping/release/mapping.txt" "$targetDir"
    }

    androidCheckSignatureOf:APK() {
        jarsigner -verify -verbose -certs "$1"
    }  

    androidScreenSpecifierDir_specifiersArray() {
        local targetDir="values"
        for specifier in ${@} ;do
            targetDir="$targetDir-$specifier"
        done
        print "$targetDir"
    }

    androidScreenIndicatorStrResource_specifiersArray() {
        local nameAttr="screen_indicator"
        local templatePrefix="<?xml version=\"1.0\" encoding=\"utf-8\"?> <resources>\
    <string name=\"$nameAttr\" translatable=\"false\">"
        local templatePostfix="</string></resources>"
        
        local template="$templatePrefix"
        for specifier in ${@} ;do
            template="$template$specifier, "
        done
        print "$template$templatePostfix"
    }

    # reimplement in TS accepting array of sets 
    androidGenerateScreenIndicatorXml_specifiersToCombineArray() {
        if ! isEnclosingDirNameEqualsTo_name "res"  ;then
            print "Error: running NOT within res directory"
            return 1
        fi
        local destFile="`androidScreenSpecifierDir_specifiersArray $@`/screen_size_indicator.xml"
        fileMoveToTrashFileAt:Path "$destFile"
        local content="`androidScreenIndicatorStrResource_specifiersArray $@`"
        filePrint:Text:ToFile "$content" "$destFile"
        printSuccessAdding:Message "$destFile\ncreated"
    }

    androidSDKSetupEnv
}
_callAndForget_functions _main_android