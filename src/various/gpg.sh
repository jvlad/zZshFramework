_main_gpg-sourceDir() {
  # debugLogFunc-args {$@}
  local srcDir="$1"

  gpgSetupGuideForGithub() {
    print$(zsf) gpgGenerateKey
    print$(zsf) gpgCopyExportedKeyToClipboard-keyId
    print$(zsf) paste the key to GitHub web GUI
    print$(zsf) gitConfigSet-signingKeyId
    print$(zsf) For troubleshooting see "https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key"
  }
  
  gpgGenerateKey$(zsf)() {
    # https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key
    if ! isCommandExist-command gpg ;then
      print-errorMessage "gpg not found"
      return $(error$(zsf))
    fi
    $(_gpgCommand$(zsf)) --default-new-key-algo rsa4096 --gen-key
    $(_gpgCommand$(zsf)) --list-secret-keys --keyid-format=long
  }

  gpgPrintExported-keyId$(zsf)() {
    $(_gpgCommand$(zsf)) --armor --export ${1}
  }

  gpgCopyExportedKeyToClipboard-keyId$(zsf)() {
    local keyId=${1}
    sysClipboardCopy-args "$(gpgPrintExported-keyId$(zsf) ${keyId})"
  }

  gpgListKeys$(zsf)() {
    $(_gpgCommand$(zsf)) --list-secret-keys --keyid-format=long
  }

  _gpgCommand$(zsf)() {
    print$(zsf) "gpg"
  }
}
_callAndForget-function-args _main_gpg-sourceDir $(dirname $0)