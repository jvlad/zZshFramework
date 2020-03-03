created ###### Fri Jan 24 04:52:59 MSK 2020  
updated ###### Tue Mar  3 17:49:30 MSK 2020

# zZshFramework  
Command line utilities for Zsh (Z-Shell) to work with files, strings, clipboard, git and other applications.  

## User NOTE  
> These tools were developed, used and tested under MacOS. I'm not sure how well it plays in other environments.  

## How to enable zZshFramework on Unix based system  
1. locate or create `.zhsrc` file at your user home directory 

2. open .zshrc in any text editor and add to the end:  
    ``` bash
    # in ~/.zshrc
    
    source "<PATH_TO_THIS_DIR>/src/1_zZshFramework_main.sh"
    ```

    E. g. 
    `source "/Users/JohnDoe/zZshFramework/src/1_zZshFramework_main.sh"`

3. Reopen your terminal or relaunch ZSH. Alternatively, run:  
    ```
    source ~/.zshrc
    ```

4. Ensure zZshFramework enabled:    
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
