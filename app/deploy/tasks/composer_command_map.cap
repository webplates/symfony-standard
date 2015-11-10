namespace :composer do
    desc "Set the composer executable path"
    task :set_composer_command_map do
        SSHKit.config.command_map[:composer] = "#{shared_path.join("composer.phar")}"
    end
end

# Apply composer for stages
Capistrano::DSL.stages.each do |stage|
    after stage, "composer:set_composer_command_map"
end
