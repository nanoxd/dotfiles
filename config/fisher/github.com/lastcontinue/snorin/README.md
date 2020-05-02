# Snorin' 💤 🐟
## Oh-My-Zsh Sorin for Fish!
"Opinionated" (lazy) port of the Oh-My-Zsh "Sorin" theme for the Fish Shell. 

![default prompt](https://raw.githubusercontent.com/LastContinue/snorin/assets/default.png)

## What? Why? Isn't there already a Sorin theme for Fish?
Yes, in fact, there are two just in the main Fish repo alone (and probably an untold amount in the wild!) 

However, I found the one in `fish_config` to be lacking some features (Git), and [the second one](https://github.com/fish-shell/fish-shell/blob/988283c7177d8496f18c1fea1a1007aa8d45d984/share/tools/web_config/sample_prompts/sorin.fish) too complex to understand what was happending (especially when compairing the source for the [oh-my-zsh original](https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/sorin.zsh-theme)), so I started hacking.

## Installation

Fisher
```
fisher add lastcontinue/snorin
```

Oh-my-fish
```
omf install https://github.com/lastcontinue/snorin
```

## Features
Puts the Git repo info on the left, on the right it shows Git status
![git repo info](https://raw.githubusercontent.com/LastContinue/snorin/assets/git_stuff1.png)
![more git repo info](https://raw.githubusercontent.com/LastContinue/snorin/assets/git_stuff2.png)

* new files `✭`
* modified files `✹`
* removed files `✖`
* staged files `✚`
* file renamed (might not show up until you stage) `➜` 
* unmerged (usually shows up during merge conflict) `═`
* mystery condition (_something_ happened<sup id="a1">[1](#f1)</sup>) `◊`  

### Variable support  
![chevron example](https://raw.githubusercontent.com/LastContinue/snorin/assets/chevrons.png)

`snorin_chevrons`  

by default, this prompt will give you one green ❯ symbol (this is how the Oh-My-Zsh Sorin does it)  
However, the "Sorin" themes for Fish usually have three: a red ❯, a yellow ❯, and a green ❯ (something like `❯❯❯`) .  

I decided to let the user chose.  
You can have as many ❯ 's as you want with this theme by setting  

`set snorin_chevrons color1 color2 color3 .. color n`  

For example, I like the red, yellow, green, so I have mine set as  

`set -U snorin_chevrons red yellow green`

### Random Fun
I thought it might be fun to have the ability to have random colors generated for your prompts, so I wrote a little function that uses 
either `jot` or `shuf` (make sure you have at least one of these installed<sup id="a2">[2](#f2)</sup>) to help make some random colors for your prompts. It works like 
this  
```
snorin_random_chevrons N
```
(where N is the number of chevrons you want)

#### For Instance
If you want each new term session/tab to have a different prompt, then make sure that `snorin_chevrons` isn't set with the -U flag (easist way to do this is do `set -e snorin_chevrons` and that will unset it, and allow the random script to take over)

Then in your `fish_config` you can do something like
```
if type snorin_random_chevrons > /dev/null 2>&1
    snorin_random_chevrons 3 > /dev/null 2>&1
end
```
(`type X` will list the definition or location of a function/program if it exists. `> /dev/null 2>&1` shoves the output to oblivion, but `type` will still return with a status that `if` can check against. This confused me the first few times I saw it.)

That should give each new session/tab a different set of colors (maybe. I only defined 10 colors so duplicates will happen)

This is just a "for instance". There's hundreds of triggering events you could use to have a prompt
change colors or number of `❯`. Use your imagination!

**sources**:  
https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/sorin.zsh-theme  
https://github.com/fish-shell/fish-shell/pull/2243  
(I believe this eventually morphed into [this](https://github.com/fish-shell/fish-shell/blob/988283c7177d8496f18c1fea1a1007aa8d45d984/share/tools/web_config/sample_prompts/sorin.fish), however I found this shorter version better as inpiration)

**Footnotes**  
<b id="f1">1</b> Based on https://git-scm.com/docs/git-status there's are quite a few cases I didn't code for because I don't come across them very often. I figured `◊` looked innocent enough. If you come across this a lot, please help me out and file an issue with details or make a PR yourself 🙇‍♂️ [↩](#a1)

<b id="f2">2</b> Interestingly enough, `shuf` doesn't do duplicates, whereas `jot` does. I don't consider this an issue, but this might drive some people _crazy_ [↩](#a2)
