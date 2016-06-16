tab-color() {
    echo -ne "\033]6;1;bg;red;brightness;$1\a"
    echo -ne "\033]6;1;bg;green;brightness;$2\a"
    echo -ne "\033]6;1;bg;blue;brightness;$3\a"
}
function tabc() {
  NAME=$1; if [ -z "$NAME" ]; then NAME="Default"; fi
  # if you have trouble with this, change
  # "Default" to the name of your default theme
  echo -e "\033]50;SetProfile=$NAME\a"
}
# reset the color after the connection closes
tab-reset() {
    echo -ne "\033]6;1;bg;*;default\a"
    echo -e "\033]50;SetProfile=Default\a"
}

# Change the color of the tab when SSHing
color-ssh() {
    if [[ -n "$ITERM_SESSION_ID" ]]; then
        trap "tab-reset" INT EXIT
        # replace SERVERNAME with at least part of your servername
        if [[ "$*" =~ "SERVERNAME" ]]; then
            # purple
            tab-color 83 12 72
            tabc SSH
        else
            tab-color 0 0 0
        fi
    fi
    ssh $*
}
compdef _ssh color-ssh=ssh

alias ssh=color-ssh
