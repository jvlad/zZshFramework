###### Fri Jan 24 04:52:59 MSK 2020

# zZshFramework  
Command line utilities to work with files, strings, clipboard, git, etc.  

## Tested in environment  

###### Sun Aug 2 12:48:56 MSK 2020
GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin18)
Copyright (C) 2007 Free Software Foundation, Inc.

MacOS Mojave 10.14.6 (18G103)

## How to enable zZshFramework on Unix based system  
1. locate or create `.zhsrc` file at your user home directory 

2. open .zshrc in any text editor and add to the end:  
    ``` bash
    # in ~/.zshrc
    
    source "<path/to/this/dir/src/1_zZshFramework_main.sh>"
    ```

    E. g. 
    `source "/Users/JohnDoe/zZshFramework/src/1_zZshFramework_main.sh"`

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

---
Author: Vlad Zamskoi – iOS & Android developer.  
https://t.me/vladZamskoi  
<v.mobileAppSoft@gmail.com>  
mobileAppSoft.com