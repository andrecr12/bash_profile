# set promp format and colors
# export PS1="\[\033[1;34m\]\!\[\033[0m\] \[\033[1;35m\]\u\[\033[0m\]:\[\033[1;35m\]\w\[\033[0m\]$ "

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
if [ "$(ps -p$$ -ocommand=)" = "-zsh" ]     # in case of zsh terminal
then
    alias reload='source ~/.zprofile'
elif [ "$(ps -p$$ -ocommand=)" = "-bash" ]  # in case of bash terminal
then
    alias reload='source ~/.bash_profile'
fi

# git completion for branch names
if [ -f ~/.git-completion.bash ]
then
    . ~/.git-completion.bash
fi

# Programming Languages
# Java
# if [ -f /usr/libexec/java_home ]
# then
#     export JAVA_HOME=/usr/libexec/java_home
# fi
# Gradle
export GRADLE_USER_HOME=$HOME/.gradle_home


# Homebrew (arm64)
# eval "$(/opt/homebrew/bin/brew shellenv)"
# Homebrew (x86_64)
eval "$(/usr/local/bin/brew shellenv)"

# Setting PATH for Python 3.9
PATH="/Library/Frameworks/Python.framework/Versions/3.9/bin:${PATH}"
export PATH

alias python='python3'
alias pip='pip3'

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# pyenv-virtualenv (for auto-activation of virtualenvs)
eval "$(pyenv virtualenv-init -)"

# Nodejs@16 (arm64)
# export PATH="/opt/homebrew/opt/node@16/bin:$PATH"
# Nodejs@10 (x86_64)
export PATH="/usr/local/opt/node@10/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/node@10/lib"
export CPPFLAGS="-I/usr/local/opt/node@10/include"

