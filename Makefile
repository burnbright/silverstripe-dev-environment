basedir = ../..

up:
	docker-compose up

build-container:
	docker-compose build

deploy:
	$(basedir)/dep deploy

gitlab-keygen:
	ssh-keygen -t rsa -N '' -f './gitlab_key' -b 4096 -C "gitlab"