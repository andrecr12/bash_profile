# debugging
echo "Sourcing $HOME/gitws/bash_profile/bash_profile"

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
    # alias reload='source ~/.zprofile'         # login shells
    alias reload='source ~/.zshrc'              # interactive terminals
elif [ "$(ps -p$$ -ocommand=)" = "-bash" ]  # in case of bash terminal
then
    alias reload='source ~/.bash_profile'
fi

# entitle tab with current pwd
tab() {
    tab_label=${PWD/${HOME}/\~}
    echo -ne "\e]1;${tab_label: -24}\a"
}

# terminal architecture ( x86_64 vs ARM )
# switch terminal architecture type
alias x86="$env /usr/bin/arch -x86_64 /bin/zsh ---login"
alias arm="$env /usr/bin/arch -arm64 /bin/zsh ---login"

# custom prompt prefix
PS1="($(arch)) ${PS1}"

# default architecture in login (WIP)
# /usr/bin/arch -x86_64 /bin/zsh


# Sublime Text CLI in $PATH
sublime_path="/Applications/Sublime Text.app"
if [ -d $sublime_path ]
then
    export PATH="$PATH:${sublime_path}/Contents/SharedSupport/bin"
fi

# VSCode CLI in $PATH
vscode_path="/Applications/Visual Studio Code.app"
if [ -d $vscode_path ]
then
    export PATH="$PATH:${vscode_path}/Contents/Resources/app/bin"
fi


# pyenv
# export PYENV_ROOT="$HOME/.pyenv"
export PYENV_ROOT="$HOME/devtools/pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# pyenv-virtualenv (for auto-activation of virtualenvs)
eval "$(pyenv virtualenv-init -)"

# python debugpy higher timeout (for VSCode debugger)
export DEBUGPY_PROCESS_SPAWN_TIMEOUT=1200

# set up dev tools manually
if [ -z $CDT_REMOTE_CONFIG_URL ]
then
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
    export GRADLE_USER_HOME=$HOME/.gradle

    # Homebrew (arm64)
    # eval "$(/opt/homebrew/bin/brew shellenv)"
    # Homebrew (x86_64)
    eval "$(/usr/local/bin/brew shellenv)"

    # Setting PATH for Python 3.9
    PATH="/Library/Frameworks/Python.framework/Versions/3.9/bin:${PATH}"
    export PATH

    alias python='python3'
    alias pip='pip3'

    # Nodejs@16 (arm64)
    # export PATH="/opt/homebrew/opt/node@16/bin:$PATH"
    # Nodejs@10 (x86_64)
    export PATH="/usr/local/opt/node@10/bin:$PATH"
    export LDFLAGS="-L/usr/local/opt/node@10/lib"
    export CPPFLAGS="-I/usr/local/opt/node@10/include"

    # nvm (Node Version Manager)
    export NVM_DIR="$HOME/.nvm"
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


    # # dotNET x64 for MAC OS Apple Silicon
    # export DOTNETLOCATION=/usr/local/share/dotnet/x64
    # export PATH="$DOTNETLOCATION:$PATH"

fi


######## utils ########

jq_new_example() {
    # duplicates last pair of examples for FL configurations
    #
    # example:
    #   % cd tracking/event-mapper-configurations/configurations
    #   % jq_new_example com.appid.example/event_name
    #
    DIR=$1

    # check if directory is provided and exists
    if [[ -z "$DIR" || ! -d "$DIR" ]]; then
      echo "Please provide a valid directory."
      return 1
    fi

    examples_dir="${DIR}/examples"

    # find the file with the largest integer at the beginning of its name
    last_example_nb=$(ls "$examples_dir" | grep -E '^[0-9]+-input' | sort -n | tail -1 | grep -oE '^[0-9]+')

    # if no files with leading integers are found
    if [[ -z "$last_example_nb" ]]; then
      echo "No files with leading integers found in the directory."
      return 1
    fi

    # increment the largest integer
    new_example_nb=$((last_example_nb + 1))

    # find the corresponding file with the largest number
    last_input=$(ls "$examples_dir" | grep -E "^$last_example_nb-input")
    last_output=$(ls "$examples_dir" | grep -E "^$last_example_nb-output")

    # create a new filename by replacing the largest number with the new number
    new_input="${last_input/$last_example_nb/$new_example_nb}"
    new_output="${last_output/$last_example_nb/$new_example_nb}"

    # copy the file to the new filename
    cp "$examples_dir/$last_input" "$examples_dir/$new_input"
    echo "Copied $examples_dir/$last_input to $examples_dir/$new_input"
    
    cp "$examples_dir/$last_output" "$examples_dir/$new_output"
    echo "Copied $examples_dir/$last_output to $examples_dir/$new_output"
}

