FROM microsoft/dotnet:2.2-sdk

WORKDIR /build

### AZURE FUNCTIONS DEPENDENCIES ###
RUN apt-get update && \
	apt-get install -y gnupg && \
	curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
	apt-get update && \
	apt-get install -y nodejs && \
	rm -rf /var/lib/apt/lists/*

RUN npm install -g azure-functions-core-tools@core --unsafe-perm true && \
    func init --docker --worker-runtime=node && \
    func extensions install -p Microsoft.Azure.WebJobs.Extensions.ServiceBus -v 3.0.2 && \
    func extensions install -p Microsoft.Azure.WebJobs.Extensions -v 3.0.1