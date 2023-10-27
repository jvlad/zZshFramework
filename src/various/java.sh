
javaHomeDir$(zsf)() {
  /usr/libexec/java_home
}

javaHomeCopyPathToClipboard() {
  if isCommandExist-command java ;then
    sysClipboardCopyVerbose-args $(javaHomeDir$(zsf))
  else
    print-errorMessage "java not installed"
    return $(error$(zsf))
  fi
}