# refer to https://unix.stackexchange.com/questions/533655/tmux-split-panes-and-ssh-to-multiple-servers-via-script

# ssh_list=( gpu1 gpu2 gpu3 gpu4 gpu5 gpu6 gpu7 gpu8 gpu9 gpu10 gpu11 gpu12 )
ssh_list=( gpu1 gpu2 gpu3 gpu4 gpu5 gpu6 gpu7 gpu8 gpu9 gpu10 gpu11 gpu12 )
# ssh_list=( gpu2 gpu3 gpu4 gpu1 )

split_list=()
for ssh_entry in "${ssh_list[@]:1}"; do
    split_list+=( split-pane -p20000 -h ssh "$ssh_entry" ';' )
done

tmux new-session -s multi-pane ssh "${ssh_list[0]}" ';' \
    "${split_list[@]}" \
    select-layout tiled ';' \
    set-option -w synchronize-panes
