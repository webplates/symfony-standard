namespace :deploy do
    namespace :assets do
        desc "Precompile assets on local machine and upload them to the server"
        task :upload do
            on roles(:web) do
                within release_path do
                    upload! "./app/Resources/views/favicons.html.twig", "#{release_path}/#{fetch(:app_path)}/Resources/views/"
                    upload! "./web/assets/", "#{release_path}/#{fetch(:web_path)}", recursive: true
                    upload! "./web/android-chrome-192x192.png", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/manifest.json", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/coast-228x228.png", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/favicon-16x16.png", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/favicon-32x32.png", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/favicon-96x96.png", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/favicon-230x230.png", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/favicon.ico", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/yandex-browser-manifest.json", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/apple-touch-icon-57x57.png", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/apple-touch-icon-60x60.png", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/apple-touch-icon-72x72.png", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/apple-touch-icon-76x76.png", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/apple-touch-icon-114x114.png", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/apple-touch-icon-120x120.png", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/apple-touch-icon-144x144.png", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/apple-touch-icon-152x152.png", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/apple-touch-icon-180x180.png", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/mstile-144x144.png", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/browserconfig.xml", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/twitter.png", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/open-graph.png", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/apple-touch-startup-image-320x460.png", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/apple-touch-startup-image-640x920.png", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/apple-touch-startup-image-640x1096.png", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/apple-touch-startup-image-750x1294.png", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/apple-touch-startup-image-1182x2208.png", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/apple-touch-startup-image-1242x2148.png", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/apple-touch-startup-image-748x1024.png", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/apple-touch-startup-image-768x1004.png", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/apple-touch-startup-image-1496x2048.png", "#{release_path}/#{fetch(:web_path)}"
                    upload! "./web/apple-touch-startup-image-1536x2008.png", "#{release_path}/#{fetch(:web_path)}"
                end
            end
        end
    end
end
