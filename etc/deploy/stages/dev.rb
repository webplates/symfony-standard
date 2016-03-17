server "dev.symfony.com", user: "fabien", roles: [:app, :web]

set :composer_install_flags, "--no-interaction --quiet --optimize-autoloader"

set :symfony_env, "dev"

after "deploy:updated", :build do
    invoke "doctrine:migrations:migrate"
    invoke "symfony:console", "h:d:f:l", "--no-interaction"
    invoke "symfony:console", "cache:clear", "--env prod"
end
