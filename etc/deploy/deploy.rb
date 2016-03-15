set :application, "symfony"
set :repo_url, "git@github.com:symfony/#{fetch(:application)}.git"
set :branch, ENV["BRANCH"] || "master"


# Symfony settings
set :symfony_directory_structure, 3
set :sensio_distribution_version, 5
set :session_path, fetch(:var_path) + "/sessions"

set :controllers_to_clear, ["app_*.php", "config.php"]


# Banner
set :banner_path, fetch(:deploy_path) + "/banner.txt"
set :banner_options, {
    :pause => true
}


# Shared content
set :linked_files, ["app/config/parameters.yml"]
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
