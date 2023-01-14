.PHONY: front

ps:
	docker-compose ps
destroy:
	docker-compose down --rmi all --volumes --remove-orphans
build:
	docker-compose build --no-cache --force-rm
up:
	docker-compose up -d
down:
	docker-compose down --remove-orphans
app:
	docker-compose exec app bash
front:
	docker-compose exec -it front bash
db:
	docker-compose exec db sh
app/install:
	docker-compose exec app composer install
app/laravel-init:
	docker-compose exec app cp .env.example .env
	docker-compose exec app php artisan storage:link
	docker-compose exec app php artisan migrate
	docker-compose exec app php artisan db:seed
init:
	@make build
	@make up
	@make app/install
	@make app/laravel-init
