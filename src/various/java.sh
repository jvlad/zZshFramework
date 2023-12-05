
javaHomeDir$(z39)() {
  /usr/libexec/java_home
}

javaHomeCopyPathToClipboard() {
  if isCommandExist-command java ;then
    sysClipboardCopyVerbose-args $(javaHomeDir$(z39))
  else
    print-errorMessage "java not installed"
    return $(error$(z39))
  fi
}