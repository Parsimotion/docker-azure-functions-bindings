FROM microsoft/dotnet:2.2-sdk as builder

WORKDIR /build

### AZURE FUNCTIONS DEPENDENCIES ###
RUN apt-get update && \
	apt-get install -y gnupg && \
	curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
	apt-get update && \
	apt-get install -y nodejs && \
	rm -rf /var/lib/apt/lists/*

RUN npm install -g azure-functions-core-tools@core --unsafe-perm true && \
    func init --worker-runtime=node && \
    func extensions install -p Microsoft.Azure.WebJobs.Extensions.ServiceBus -v 4.1.0 && \
    func extensions install -p Microsoft.Azure.WebJobs.Extensions.Storage -v 3.0.10 && \
    func extensions install -p Microsoft.Azure.WebJobs.Extensions -v 3.0.6 && \
    func extensions install -p AzureFunctions.Extension.SQS -v 1.3.0

FROM mcr.microsoft.com/azure-functions/node:2.0

COPY --from=builder /build/bin /home/site/wwwroot/bin
