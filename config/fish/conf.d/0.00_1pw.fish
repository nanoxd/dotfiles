set -l sock "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
if test -S $sock
    set -gx SSH_AUTH_SOCK $sock
end
