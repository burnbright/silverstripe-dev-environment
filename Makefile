basedir = ../..

up:
	docker-compose up

up-php5:
	docker-compose --file docker-compose.php5.yml up

down:
	docker-compose down

build-container:
	docker-compose build

deploy:
	$(basedir)/dep deploy

gitlab-keygen:
	ssh-keygen -t rsa -N '' -f './gitlab_key' -b 4096 -C "gitlab"