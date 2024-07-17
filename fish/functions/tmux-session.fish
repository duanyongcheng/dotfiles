function tmux-session
    # 获取所有会话并通过 fzf 选择
    set sessions (tmux ls 2>/dev/null)
    # 检查是否有会话
    if test -z "$sessions"
        echo "No tmux sessions found."
        return
    end
    # 使用 fzf 选择会话并提取会话名称
    set session (echo $sessions | fzf --height=10 --border --prompt="Select session: " | awk '{print $1}')
    # 检查是否选择了一个会话
    if test -n "$session"
        set session_name (string split ':' $session)[1]
        
        # 附加到一个新的 tmux 会话，然后切换到选定的会话
        tmux attach-session -t $session_name
    else
        echo "No session selected."
    end
end
