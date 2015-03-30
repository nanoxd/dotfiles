# Completion for hk https://github.com/heroku/hk
# A heroku CLI client

function __fish_hk_no_subcommand --description 'Test if hk has yet to be given the subcommand'
    for i in (commandline -opc)
        if contains -- $i access access-add access-remove account-feature-disable account-feature-enable account-feature-info account-features addon-add addon-destroy addon-open addon-plan addon-plans addon-services addons api apps create creds destroy domain-add domain-remove domains drain-add drain-info drain-remove drains dynos env feature-disable feature-enable feature-info features get help info key-add key-remove keys log login logout maintenance maintenance-disable maintenance-enable members open orgs pg-info pg-list pg-unfollow psql regions release-info releases rename restart rollback run scale set ssl ssl-cert-add ssl-cert-rollback ssl-destroy status transfer transfer-accept transfer-cancel transfer-decline unset update url version which-app
            return 1
        end
    end
    return 0
end

function __fish_hk_regions -d 'Display heroku regions'
  hk regions | cut -f 1 -d ' '
end

# hk create
complete -c hk -f -n '__fish_hk_no_subcommand' -a create -d 'Create an app'
complete -c hk -A -x -n '__fish_seen_subcommand_from create' -s r -a 'us eu' -d 'Heroku region to create app in'
complete -c hk -A -f -n '__fish_seen_subcommand_from create' -s o -d 'name of Heroku org to create app in'
# complete -c docker -A -f -n '__fish_seen_subcommand_from attach' -l no-stdin -d 'Do not attach stdin'
# complete -c docker -A -f -n '__fish_seen_subcommand_from attach' -l sig-proxy -d 'Proxify all received signal to the process (even in non-tty mode)'
# complete -c docker -A -f -n '__fish_seen_subcommand_from attach' -a '(__fish_print_docker_containers running)' -d "Container"
