function tmux-window
    # 获取当前会话的所有窗口并通过 fzf 选择
    set windows (tmux list-windows -F "#{window_index}: #{window_name}" 2>/dev/null)
    # 检查是否有窗口
    if test -z "$windows"
        echo "No tmux windows found."
        return
    end
    # 使用 fzf 选择窗口并提取窗口索引
    set window (echo $windows | fzf --height=10 --border --prompt="Select window: " | awk '{print $1}')
    # 检查是否选择了一个窗口
    if test -n "$window"
        set window_index (string split ':' $window)[1]
        tmux select-window -t $window_index
    else
        echo "No window selected."
    end
end
