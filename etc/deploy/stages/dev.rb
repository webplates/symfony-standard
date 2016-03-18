server "dev.symfony.com", user: "fabien", roles: [:app, :db, :web]

set :composer_install_flags, "--no-interaction --quiet --optimize-autoloader"

set :symfony_env, "dev"

after "deploy:updated", :build do
    invoke "doctrine:migrations:migrate"
    symfony_console, "h:d:f:l", "--no-interaction"
    symfony_console, "cache:clear", "--env prod"
end
