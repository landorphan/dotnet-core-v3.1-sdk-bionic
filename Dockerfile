FROM mcr.microsoft.com/dotnet/core/sdk:3.1-bionic

RUN apt-get update; \
    mkdir ~/.aws; \
    DEBIAN_FRONTEND=noninteractive \
    ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime; \
    apt-get install -y tzdata; \
    dpkg-reconfigure --frontend noninteractive tzdata; \
    apt-get install awscli -y; \
    printf "[default]\naws_access_key_id = $AWS_ID\naws_secret_access_key = $AWS_KEY" > ~/.aws/credentials; \
    apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y; \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -; \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"; \
    apt-get update; \
    apt-get install zip unzip; \
    apt-get install docker-ce docker-ce-cli containerd.io -y; \
    apt-get install systemd -y; \
    systemctl enable docker.service; \
    curl -L -o /tmp/Landorphan.DotNetCoreBuildTools.zip https://www.nuget.org/api/v2/package/Landorphan.DotNetCoreBuildTools; \
    unzip /tmp/Landorphan.DotNetCoreBuildTools.zip -d /tmp/Landorphan.DotNetCoreBuildTools; \
    find /tmp/Landorphan.DotNetCoreBuildTools/content -name '*.sh' | xargs chmod 777; \
    find /tmp/Landorphan.DotNetCoreBuildTools/lib/netcoreapp3.1/ -type f | xargs chmod 777; 