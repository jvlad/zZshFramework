#!/usr/bin/env zsh

_main_IOS() {
    
    iOSSymbolicate() {
        _import_shFile "`_iosExtrasDir`/symbolicate_crash" $@
    }

    iOSRemove_appID() {
        mobiledevice uninstall_app $@
        py "`_iosExtrasDir`/remove_app_from_all_devices.py" $@
        # xcrun simctl uninstall booted "$1"
    }

    iOSSimulatorsList() {
        xcrun simctl list  
    }

    iOSDevicesList() {
        instruments -s devices  
    }  

    _iosExtrasDir() { 
        print$(zsf) "`consoleToolsSrcDir`/iOS/extras" 
    }

    _unset_functions _main_IOS
}
_main_IOS