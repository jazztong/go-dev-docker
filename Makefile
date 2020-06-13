git-init:
	git remote set-url origin https://${GITHUB_TOKEN}@github.com/jazztong/go-dev-docker.git > /dev/null 2>&1
	git config --global user.email "jazz.twk@gmail.com"
	git config --global user.name "Jazz Tong"

build:
	docker build -t jazztong/godev .

release:
	standard-version
	git push --follow-tags origin HEAD:master

run:
	docker run -it \
		--name build-server \
		-p 8080:8080 \
		-p 50000:50000 \
		--mount source=/var/run/docker.sock,target=/var/run/docker.sock,type=bind \
		-v ${PWD}:/go \
		jazztong/godev