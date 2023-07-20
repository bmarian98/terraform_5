# Use Alpine Linux as the base image
FROM alpine:latest

# Set environment variables for Terraform version and URL
ENV TERRAFORM_VERSION=1.5.3
ENV TERRAFORM_URL=https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Install required dependencies (unzip)
RUN apk add --no-cache unzip

# Install curl 
RUN apk add -y --no-cache curl

# Download and install Terraform
RUN wget ${TERRAFORM_URL} -O /tmp/terraform.zip && \
    unzip /tmp/terraform.zip -d /usr/local/bin && \
    rm /tmp/terraform.zip

WORKDIR /app

CMD ["terraform", "--version"]