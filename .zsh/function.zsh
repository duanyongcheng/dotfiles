function l(){
  ls -lah
}

function lg(){
  lazygit
}

function n(){
  neofetch
}

function tls(){
  tmux list-sessions | fzf
}

function tns(){
  tmux new -s $1
}

function tas(){
  tid=`tmux list-sessions | fzf | awk -F: '{print $1}'`
  # echo $tid
  tmux attach -t $tid;
}

function jos(){
  joshuto
}

function zls(){
  zellij list-sessions | fzf
}

function zns(){
  zellij -s $1
}

function zas(){
  zid=`zellij list-sessions | fzf`
  zellij a $zid
}

function zka(){
  zellij ka
}

function zks(){
  zid=`zellij list-sessions | fzf`
  zellij k $zid
}

