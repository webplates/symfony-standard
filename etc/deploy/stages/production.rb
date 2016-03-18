server "symfony.com", user: "fabien", roles: [:app, :db, :web]

after "deploy:updated", "doctrine:migrations:migrate"
