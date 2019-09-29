run:
	docker-compose up -d

stop:
	docker-compose stop

redis-cli:
	docker exec -it feed-api_redis_cache_1 redis-cli

