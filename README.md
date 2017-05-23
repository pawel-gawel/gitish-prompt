# Git-ish prompt for bash

When you move to directory with `.git` subdir, it will change your prompt showing current branch, current tags, as well as rest of branches that point at this commit.
#### TL;DR
```
cd ~ && git clone ssh://git@code.intive.com/bro/gitish-prompt.git && echo "source ~/gitish-prompt/index.sh" >> ~/.bash_profile
```


## Installation


Clone the repository to your home directory
```
git clone ssh://git@code.intive.com/bro/gitish-prompt.git
```
then add this line to your `.bash_profile` (or `.bashrc`) file
```
source ~/gitish-prompt/index.sh
```
Now open new terminal window and go to some repository's directory. You should see something like

![bash](http://i.imgur.com/2oOrhZ4.png)

