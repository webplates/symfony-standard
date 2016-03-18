server "symfony.webplates.xyz", user: "webplates", roles: [:app, :db, :web]

after "deploy:updated", "doctrine:migrations:migrate"
