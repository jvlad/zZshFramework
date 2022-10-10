###### Fri Jan 24 04:52:59 MSK 2020 created  
###### Mon Oct 10 14:07:10 PDT 2022 updated  

# zZshFramework  
Command line utilities for Zsh (Z-Shell) to work with files, strings, clipboard, git and other applications.  

## User NOTE  
> These tools were developed, used and tested under MacOS. I'm not sure how well it plays in other environments.  


## Tested in environment  
###### Mon Oct 10 13:28:10 PDT 2022
* MacOS Monterey 12.5.1  
* zsh 5.8.1 (x86_64-apple-darwin21.0)  


## How to enable zZshFramework on Unix based system  
1. locate or create `.zhsrc` file at your user home directory 

2. open .zshrc in any text editor and add to the end:  
    ``` bash
    # in ~/.zshrc
    
    source "<$PATH_TO_THIS_DIR>/src/mainzZshFramework.sh"  
    ```

    E. g. 
    `source "/Users/JohnDoe/zZshFramework/src/mainzZshFramework.sh"`  

3. Reopen your terminal or relaunch ZSH. Alternatively, run:  
    ```
    source ~/.zshrc
    ```

4. Recheck zZshFramework enabled by running:  
    ```
    version__zsf
    ```

    Example of expected output:  
    `zZshFramework 1.1.2.20200124`  


## Coding Conventions (Style and Logic)
###### Mon Nov 1 09:00:03 CET 2021  

### Functions    
Function name should be written in a camelCase with `-` before each parameter  

E. g.  
1. `printWarning-message` means that the function expects a single parameter with 'message' semantics  

2. `print-prefix-message` – the function expects two parameters: the prefix and the message  

Other details of the applied style are demonstrated below:  

``` bash
# 0. There is NO space before `()`, there IS a space before opening brace ` {`
print-prefix-message() {
    # 1.    In the beginning of the implementation introduce local variables to provide 
    #       a meaningful local-scope name for each argument
    # 2.    Use `${...}` (a full form) everywhere for variable substitution
    local prefix="${1}" 
    local subject="${2}"
    # 3.    Use `$(...)` (a full form) everywhere for function call substitution
    local procedureResult=$(testProcedure)
    
    isEmpty-string $subject \
    # 4.    Add a line break before logical operators like `&&`, `||`, etc. 
    # 5.    Use scoped-name function like `print$(zsf)` and others `...$(zsf)` functions 
    #       in favor of built-in and zsh-specific functions
        && print$(zsf) "${prefix}" \
        || print$(zsf) "${prefix}:\n${subject}\n"
}
```

[Deprecated] style:  
* using `_` as a parameter-prefix. E. g. `print_prefix_message`  
* using `:` as a parameter-prefix. E. g. `print:prefix:message`  
* direct usage of `__zsf` postfix in function names. E. g. `isEmpty-string__zsf`  

---
---

Author: Vlad Zams – Solutions Architect @ Mobile App Soft  
https://t.me/vladZams  
<vz@mobileappsoft.com>  
https://mobileAppSoft.com  