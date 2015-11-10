set :application, "symfony"
set :repo_url, "git@github.com:symfony/#{fetch(:application)}.git"
set :branch, ENV["BRANCH"] || "master"


# Symfony settings
set :bin_path, "bin"
set :var_path, "var"
set :log_path, fetch(:var_path) + "/logs"
set :cache_path, fetch(:var_path) + "/cache"
set :session_path, fetch(:var_path) + "/sessions"
set :symfony_console_path, fetch(:bin_path) + "/console"

set :controllers_to_clear, ["app_*.php", "config.php"]


# Banner
set :banner_path, fetch(:deploy_path) + "/banner.txt"
set :banner_options, {
    :pause => true
}


# Block deployment
set :deploy_block_host, -> { primary(:app) }


# Pending commits hack
# See https://github.com/a2ikm/capistrano-pending/issues/3
set :capistrano_pending_role, :app


# Log tailing
set :logtail_files, ["#{fetch(:current_path)}/#{fetch(:log_path)}/#{fetch(:symfony_env)}.log"]
set :logtail_lines, 50


# Secret path configuration
set :secret_dir, fetch(:deploy_path) + "/secret"


# Shared content
set :linked_files, ["app/config/parameters.yml"]
set :linked_dirs, [
    fetch(:log_path),
    fetch(:session_path),
    fetch(:web_path) + "/uploads"
]


# Deploy hooks
namespace :deploy do
    after :starting, "composer:install_executable"
end


# System settings
set :ssh_options, forward_agent: true
