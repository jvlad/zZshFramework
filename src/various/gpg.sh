_main_gpg-sourceDir() {
    # debugLogFunc-args {$@}
  local srcDir="$1"
  
  gpgGenerateKey() {
    # https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key
    if
    gpg --default-new-key-algo rsa4096 --gen-key
  }
  
}
_callAndForget-function-args _main_gpg-sourceDir $(dirname $0)