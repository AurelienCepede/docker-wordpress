include .env
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
	sudo rm -R www db

wp-install-core:
	docker-compose exec web wp --allow-root core install \
		--url="${WP_URL}" \
		--title="${WP_TITLE}" \
		--admin_user="${WP_USERNAME}" \
		--admin_password="${WP_PASS}" \
		--admin_email="${WP_EMAIL}" \
		--locale="${WP_LOCAL}" \
		--skip-email

wp-install-plugins:
	docker-compose exec web wp --allow-root plugin delete --all
	docker-compose exec web wp --allow-root plugin install ${WP_PLUGINS} --activate

wp-install-theme:
	docker-compose exec web wp --allow-root theme \
		install ${WP_THEME} --activate
	docker-compose exec web wp --allow-root theme \
		delete $$(docker-compose exec web wp theme --allow-root list --status=inactive --field=name)

god-mod:
	docker-compose exec web chmod -R 777 ./

wp-install: wp-install-core wp-install-plugins wp-install-theme god-mod

deactivate-disposable-plugins:
	docker-compose exec web wp --allow-root plugin deactivate acf-content-analysis-for-yoast-seo wp-rocket secupress-pro really-simple-ssl post-smtp