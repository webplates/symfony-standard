set :application, "webplates/symfony"
set :repo_url, "git@github.com:webplates/symfony-standard.git"
set :branch, ENV["BRANCH"] || "master"


# Symfony settings
set :session_path, fetch(:var_path) + "/sessions"
set :controllers_to_clear, ["app_*.php", "config.php"]


# NPM config
set :npm_flags, "--silent --no-progress"


# Banner
set :banner_path, fetch(:deploy_path) + "/banner.txt"
set :banner_options, {
    :pause => true
}


# Shared content
set :linked_files, [fetch(:app_config_path) + "/parameters.yml"]
set :linked_dirs, [
    fetch(:log_path),
    fetch(:session_path),
    fetch(:web_path) + "/uploads"
]
set :copy_files, [
    "bower_components/",
    "node_modules/",
    "vendor/"
]


# Deploy hooks
namespace :deploy do
    after :starting, "composer:install_executable"
    after :updated, "symfony:assets:install"
end

before "symfony:assets:install", "gulp"


# System settings
set :ssh_options, forward_agent: true


# Airbrussh settings
Airbrussh.configure do |config|
    config.log_file = "var/logs/capistrano.log"
end
