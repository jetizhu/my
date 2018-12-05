function log2syslog
{
   declare COMMAND
   COMMAND=$(fc -ln -0)
   logger -p local1.notice -t bash -i -- "${USER}:${COMMAND}"
}
trap log2syslog DEBUG

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
