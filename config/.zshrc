# git command alias
alias gal='git add .'
alias gcm='git commit -m'
alias gco='git checkout'
alias gdf='git diff'
alias gpl='git pull'
alias gps='git push'
alias grt='cd $(git rev-parse --show-toplevel)'
alias gs='git status'
# add some scripts
export PATH="/Users/<user>/<project_path>/scripts/shell:$PATH"

alias mgp=my_git_push.sh
alias mms=my_mount_sshfs.sh 
alias mpf=my_port_forward.sh