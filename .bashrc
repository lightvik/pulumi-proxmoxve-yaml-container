if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  source /etc/bash_completion
fi