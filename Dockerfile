FROM golang:latest
LABEL maintainer="Jazz Tong <jazz.twk@gmail.com>"
# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Configure apt, install packages and tools
RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils dialog 2>&1

# Configure pip3
RUN apt update \
    && apt install -y python3-pip

# python tools
RUN pip3 install pre-commit

# Install node and npm
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get install -y nodejs \
    && node -v \
    && npm -v

# Install standard version
RUN npm i -g standard-version

RUN apt-get -y install git procps lsb-release wget unzip
# Install AWS
RUN pip3 install awscli --force-reinstall --upgrade
#
# Install terraform
RUN curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash \
    && tfswitch 0.12.13
#
# Install gocode-gomod
RUN go get -x -d github.com/stamblerre/gocode 2>&1 \
    && go build -o gocode-gomod github.com/stamblerre/gocode \
    && mv gocode-gomod $GOPATH/bin/
#
# Install Go tools
RUN go get -u -v \
    github.com/mdempsky/gocode \
    github.com/uudashr/gopkgs/cmd/gopkgs \
    github.com/ramya-rao-a/go-outline \
    github.com/acroca/go-symbols \
    github.com/godoctor/godoctor \
    golang.org/x/tools/cmd/guru \
    golang.org/x/tools/cmd/gorename \
    github.com/rogpeppe/godef \
    github.com/zmb3/gogetdoc \
    github.com/haya14busa/goplay/cmd/goplay \
    github.com/sqs/goreturns \
    github.com/josharian/impl \
    github.com/davidrjenni/reftools/cmd/fillstruct \
    github.com/fatih/gomodifytags \
    github.com/cweill/gotests/... \
    golang.org/x/tools/cmd/goimports \
    golang.org/x/lint/golint \
    golang.org/x/tools/cmd/gopls \
    github.com/alecthomas/gometalinter \
    honnef.co/go/tools/... \
    github.com/golangci/golangci-lint/cmd/golangci-lint \
    github.com/mgechev/revive \
    github.com/derekparker/delve/cmd/dlv 2>&1
# Clean up
RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*