_main_gpg-sourceDir() {
  # debugLogFunc-args$(z39) {$@}
  local srcDir="$1"

  gpgSetupGuideForGithub() {
    print$(z39) gpgGenerateKey
    print$(z39) gpgCopyExportedKeyToClipboard-keyId
    print$(z39) paste the key to GitHub web GUI
    print$(z39) gitConfigSet-signingKeyId
    print$(z39) For troubleshooting see "https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key"
  }
  
  gpgGenerateKey$(z39)() {
    # https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key
    if ! isCommandExist-command gpg ;then
      print-errorMessage "gpg not found"
      return $(error$(z39))
    fi
    $(_gpgCommand$(z39)) --default-new-key-algo rsa4096 --gen-key
    $(_gpgCommand$(z39)) --list-secret-keys --keyid-format=long
  }

  gpgPrintExported-keyId$(z39)() {
    $(_gpgCommand$(z39)) --armor --export ${1}
  }

  gpgCopyExportedKeyToClipboard-keyId$(z39)() {
    local keyId=${1}
    sysClipboardCopy-args "$(gpgPrintExported-keyId$(z39) ${keyId})"
  }

  gpgListKeys$(z39)() {
    $(_gpgCommand$(z39)) --list-secret-keys --keyid-format=long
  }

  _gpgCommand$(z39)() {
    print$(z39) "gpg"
  }
}
_callAndForget-function-args _main_gpg-sourceDir $(dirname $0)