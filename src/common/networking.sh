
_main_networking() {
    
    webPublicIp() {
        curl 'https://api.ipify.org?format=text'
    }
    
}
_callAndForget_functions _main_networking
