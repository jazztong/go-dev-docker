git-init:
	git remote set-url origin https://${GITHUB_TOKEN}@github.com/jazztong/go-dev-docker.git > /dev/null 2>&1
  	git config --global user.email "jazz.twk@gmail.com"
  	git config --global user.name "Jazz Tong"

build:
	docker build -t jazztong/godev .

release:
	standard-version
	git push --follow-tags origin HEAD:master