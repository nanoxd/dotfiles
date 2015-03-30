# Ngrok.fish created by Fernando Paredes<nano@fdp.io>

# Options
complete -c ngrok -A -o authtoken= -d 'Authentication token for identifying on ngrok.com'
complete -c ngrok -A -o config= -d 'Path to ngrok configuration file'
complete -c ngrok -A -f -o hostname= -d 'Request a custom hostname'
complete -c ngrok -A -f -o httpauth= -d 'username:password HTTP basic auth creds'
complete -c ngrok -A -o log= -d 'Write log messages to file'
complete -c ngrok -A -f -o proto= -d 'The protocol of traffic over the tunnel'
complete -c ngrok -A -f -o subdomain= -d 'Request a custom subdomain from server'

# Commands
complete -c ngrok -f -a 'version' -d 'Print version'
complete -c ngrok -f -a 'help' -d 'Print help'
complete -c ngrok -f -a 'start' -d 'Start tunnels by name from config file'
