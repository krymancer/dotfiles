fish_add_path -g $HOME/.local/bin

# Tools installed by their own installers
for dir in $HOME/.bun/bin $HOME/.opencode/bin $HOME/.grok/bin
    if test -d $dir
        fish_add_path -g $dir
    end
end

if test -f $HOME/.railway/env.fish
    source $HOME/.railway/env.fish
end
