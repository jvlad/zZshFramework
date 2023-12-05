###### Fri Jan 24 04:52:59 MSK 2020 created  

# zZshFramework  
Some utility functions for Zsh (Z-Shell) to make it easier to deal with files, strings, clipboard, java, git, android, iOS, homebrew, curl and other applications commonly used by software engineers.  

## User NOTE  
> These tools were developed, used and tested under MacOS. I'm not sure how well they'll play in other environments. Some of them will not for sure.  


## Tested in environment  
###### Mon Oct 10 13:28:10 PDT 2022
* MacOS 13.0 (you can check yours by running `sw_vers -productVersion`)  
* zsh 5.8.1 (x86_64-apple-darwin22.0) (check yours with `zsh --version`)  


## How to import zZshFramework to Zsh on a Unix-based system:  
1. locate or create `.zhsrc` file at your user-home dir

2. open .zshrc in any text editor and add to the end:  
    ``` bash
    # in ~/.zshrc
    source "${PATH_TO_THIS_DIR}/mainzZshFramework.sh"
    ```
  
    E. g. 
    `source "/Users/${your-user-name}/zZshFramework/src/mainzZshFramework.sh"`

3. Reopen your terminal or relaunch Zsh. Alternatively, run:  
  source ~/.zshrc

4. Recheck zZshFramework imported by running:  
  version$(z39)

      Expected output should look like:  
      zZshFramework 8.1.30.20231205


## Coding Conventions (Style and Logic)

### Functions    
Function name should be written in a camelCase with the `-` before each parameter  

E. g.  
1. `printWarning-message` means that the function expects a single parameter with 'message' semantics  

2. `print-prefix-message` – the function expects two parameters: the prefix and the message  

Other details of the applied style are demonstrated below:  

``` bash
# 1. There is NO space before `()`, and there IS a space before opening brace ` {`
# 2. Use scoped-name function like `print$(z39)` and others `...$(z39)` functions 
# in favor of zsh built-ins  
print-prefix-message$(z39)() {
## Documentation about this function goes here, starting with [##] and ending with a blank
# line. Each new line of the doc starts with a single [#], not [##].
# @arg prefix parameter description goes here
# @arg message another parameter description  
# @sideEffects: stdout, fs, createProcess, exitProcess # comma-separated list
# @error 3 prefix is too long 
# @error 15 message is too long
# each error code in the doc starts on a separate line  
  
  # 3. In the beginning of the implementation introduce local variables to provide 
  #    a meaningful local-scope name for each argument matching the parts of the function name
  # 4. Use `${...}` (a full form) everywhere for variable substitutions
  # 5. Use 2 spaces as a tab
  local prefix="${1}" 
  local subject="${2}"
  # 6. Use `$(...)` (a full form) everywhere for function call substitutions
  local procedureResult=$(testProcedure)
  isEmpty-string$(z39) ${subject} \
  # 7. When line gets longer, add a line break _before_ logical operators
      && print$(z39) "${prefix}" \
      || print$(z39) "${prefix}:\n${subject}\n"
}
```

[Deprecated] style:  
* using `_` as a parameter-prefix. E. g. `print_prefix_message`  
* using `:` as a parameter-prefix. E. g. `print:prefix:message`  
* direct usage of `__zsf` postfix in function names. E. g. `isEmpty-string__zsf`  

---
---

## Author
Vlad Zams – Software Engineering Manager and consultant  
pub@vladzams.com  
