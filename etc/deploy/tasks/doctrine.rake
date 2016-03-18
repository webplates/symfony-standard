namespace :doctrine do
    namespace :schema do
        desc "Drop doctrine schema"
        task :drop do
            on roles(:db) do
                invoke "symfony:console", "doctrine:schema:drop", "--force"
            end
        end

        desc "Create doctrine schema"
        task :create do
            on roles(:db) do
                invoke "symfony:console", "doctrine:schema:create"
            end
        end
    end

    namespace :migrations do
        desc "Execute doctrine migrations"
        task :migrate do
            on roles(:db) do
                invoke "symfony:console", "doctrine:migrations:migrate", "--no-interaction"
            end
        end
    end

    namespace :fixtures do
        desc "Load doctrine fixtures"
        task :load do
            on roles(:db) do
                invoke "symfony:console", "doctrine:fixtures:load", "--no-interaction"
            end
        end
    end
end
