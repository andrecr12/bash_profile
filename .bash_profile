# set promp format and colors
export PS1="\[\033[1;34m\]\!\[\033[0m\] \[\033[1;35m\]\u\[\033[0m\]:\[\033[1;35m\]\w\[\033[0m\]$ "

# ls alias for color-mode and more

alias ll="ls -FGlAhp"
# grep with color
alias grep='grep --color=auto'

# simple ip
alias ip='ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d " " -f2'
# more details
alias ip1="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
# external ip
alias ip2="curl -s http://www.showmyip.com/simple/ | awk '{print $1}'"

# lock computer
alias lock='/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend'

# hibernation and sleep settings
alias hibernate='sudo pmset -a hibernatemode 25'
alias sleep='sudo pmset -a hibernatemode 0'
alias safesleep='sudo pmset -a hibernatemode 3'
alias smartsleep='sudo pmset -a hibernatemode 2'

# processes
#alias ps='ps -ax'

# refresh shell
alias reload='source ~/.bash_profile'

# git completion for branch names
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
