
javaHomePathPrint$(zsf)() {
  /usr/libexec/java_home
}

javaHomeCopyPathToClipboard() {
  if isCommandExist-command java ;then
    sysClipboardCopyVerbose-args $(javaHomePathPrint$(zsf))
  else
    print-errorMessage "java not installed"
    return $(error$(zsf))
  fi
}