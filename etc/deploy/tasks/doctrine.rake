namespace :doctrine do
    namespace :schema do
        desc "Drop doctrine schema"
        task :drop do
            on roles(:db) do
                symfony_console "doctrine:schema:drop", "--force"
            end
        end

        desc "Drop full schema"
        task :drop_full do
            on roles(:db) do
                symfony_console "doctrine:schema:drop", "--full-database --force"
            end
        end

        desc "Create doctrine schema"
        task :create do
            on roles(:db) do
                symfony_console "doctrine:schema:create"
            end
        end
    end

    namespace :migrations do
        desc "Execute doctrine migrations"
        task :migrate do
            on roles(:db) do
                symfony_console "doctrine:migrations:migrate", "--no-interaction"
            end
        end
    end

    namespace :fixtures do
        desc "Load doctrine fixtures"
        task :load do
            on roles(:db) do
                symfony_console "doctrine:fixtures:load", "--no-interaction"
            end
        end
    end
end
