# refer to https://unix.stackexchange.com/questions/533655/tmux-split-panes-and-ssh-to-multiple-servers-via-script

ssh_list=( gpu2 gpu3 )

split_list=()
for ssh_entry in "${ssh_list[@]:1}"; do
    split_list+=( split-pane ssh "$ssh_entry" ';' )
done

tmux new-session -s multi-pane ssh "${ssh_list[0]}" ';' \
    "${split_list[@]}" \
    select-layout tiled ';' \
    set-option -w synchronize-panes
