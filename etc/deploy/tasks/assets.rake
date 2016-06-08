namespace :deploy do
    namespace :assets do
        desc "Precompile assets on local machine and upload them to the server"
        task :upload do
            on roles(:web) do
                info "Uploading assets"
                upload! "#{fetch(:web_path)}/assets/", "#{release_path}/#{fetch(:web_path)}", recursive: true

                info "Uploading favicon list"
                upload! "#{fetch(:app_path)}/Resources/views/favicons.html.twig", "#{release_path}/#{fetch(:app_path)}/Resources/views/"

                info "Uploading favicons"
                Dir["#{fetch(:web_path)}/*.png"].each do |favicon|
                    upload! favicon, "#{release_path}/#{fetch(:web_path)}"
                end

                %w[ browserconfig.xml favicon.ico manifest.json manifest.webapp yandex-browser-manifest.json ].each do |f|
                    upload! "#{fetch(:web_path)}/" + f, "#{release_path}/#{fetch(:web_path)}"
                end
            end
        end
    end
end
