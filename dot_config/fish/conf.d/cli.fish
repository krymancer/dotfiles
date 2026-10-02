# Same eza aliases CachyOS ships, so macOS behaves like the Linux boxes
if command -q eza
    alias ls='eza -al --color=always --group-directories-first --icons=always'
    alias la='eza -a --color=always --group-directories-first --icons=always'
    alias ll='eza -l --color=always --group-directories-first --icons=always'
    alias lt='eza -aT --color=always --group-directories-first --icons=always'
    alias l.="eza -a | grep -e '^\.'"
end

# Colored man pages through bat
if command -q bat
    set --export MANPAGER "sh -c 'col -bx | bat -l man -p'"
end

# z <dir> / zi (interactive, uses fzf)
if command -q zoxide
    zoxide init fish | source
end
