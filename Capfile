# Override the path before running the setup
set :deploy_path, "app/deploy"
set :deploy_config_path, fetch(:deploy_path) + "/deploy.rb"
set :stage_config_path, fetch(:deploy_path) + "/stages/"

# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"

# Include Symfony specific tasks
require "capistrano/symfony"

# Include maintenance tasks
require "capistrano/maintenance"

# Airbrush - console output beautifier
require "airbrussh/capistrano"

# List stages
require "capistrano/list_stages"

# Invoke command
require "capistrano/invoke"

# Add custom banner
require "capistrano/banner"

# Allow deployments to be blocked (for whatever reasons)
require "capistrano/deploy_block"

# Load Dotenv-like files
require "capistrano/env-config"

# Check pending commits
require "capistrano-pending"

# Help with SSH related problems
require "capistrano/ssh_doctor"

# Log tailing
require "capistrano/logtail"

# Notifications
# require "capistrano/notifications"

# Store secrets
require "capistrano/secret"

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob(fetch(:deploy_path) + "/tasks/**/*.rb").each { |r| import r }
