start:
	docker-compose up -d

stop:
	docker-compose stop

update_all_wp:
	docker-compose exec web wp --allow-root plugin update --all
	docker-compose exec web wp --allow-root theme update --all
	docker-compose exec web wp --allow-root core update
	docker-compose exec web wp --allow-root language plugin update --all
	docker-compose exec web wp --allow-root language theme update --all
	docker-compose exec web wp --allow-root language core update
# 	docker-compose exec web wp --allow-root wc update // woocommerce

clean:
	docker-compose down
	sudo rm -R www datamysql