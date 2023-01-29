
javaHomeCopyPathToClipboard() {
  if isCommandExist-command java ;then
    sysClipboardCopyVerbose-args ${JAVA_HOME}
  else
    print-errorMessage "java not installed"
    return $(error$(zsf))
  fi
}