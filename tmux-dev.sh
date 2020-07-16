NEW_SESSION="tmux new-session"
[ $# -eq 1 ] && NEW_SESSION="tmux new-session -s $1"
${NEW_SESSION} \; split-window -h -p 30 \; \
    select-pane -t 0 \; \
    split-window -v -p 30 \; \
    split-window -h -p 50 \; \
    select-pane -t 0 \; \
    send-keys 'cd ~/jitsuin/avid && nvim' C-m \; \
    send-keys ':NERDTree' C-m \; \


