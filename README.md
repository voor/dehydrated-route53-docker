# Dehydrated with AWS CLI in a Docker Container

[Dehydrated](https://dehydrated.io/) is a very simple shell script that implements the letsencrypt/acme client protocol and impressively facilitates an easy DNS based challenge to [Route 53](https://aws.amazon.com/route53/), the benefits of the DNS challenge is that you will not expose any services to the internet, and you can even run this as part of a CI/CD pipeline without having any servers.

In particular, this container is leveraged in a [Concourse](https://concourse-ci.org/) pipeline to get the necessary publicly trusted certificates that a [PCF](https://pivotal.io/platform) installation would need without exposing anything.

## Usage

If this is your first time using the container:

1. Go into the directory you want to save your letsencrypt account (it'll end up in an `accounts` folder), your certificates (ends up in a `certs` folder).  
2. Create a `domains.txt` folder that contains the domain you want to create, for example:
    ```
    example.com *.example.com *.dev.example.com *.sys.dev.example.com *.uaa.sys.dev.example.com *.login.sys.dev.example.com *.apps.dev.example.com
    ```
3. Make sure your AWS credentials are populated in environment variables:
    ```
    export AWS_ACCESS_KEY_ID=blahblahblah
    export AWS_SECRET_ACCESS_KEY=blahblahblah
    ```
4. Then run `run.sh` (or look at the docker `run` command inside it for a general idea of what is going on)
