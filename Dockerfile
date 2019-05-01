FROM debian:stretch-slim

RUN apt-get update && apt-get install -y \
    curl \
    jq \
    python \
    python-pip \
    python-setuptools \
    --no-install-recommends \
    && pip install --upgrade awscli python-magic \
    && apt-get purge --auto-remove -y  \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd -r dehydrated && useradd -r -g dehydrated dehydrated \
    && mkdir -p /home/dehydrated /accounts /certs /chains \
    && chown dehydrated:dehydrated /home/dehydrated /accounts /certs /chains

WORKDIR /home/dehydrated

RUN curl -sSL https://github.com/lukas2511/dehydrated/releases/download/v0.6.2/dehydrated-0.6.2.tar.gz \
    | tar xvz --strip-components 1

RUN curl -SsL https://raw.githubusercontent.com/whereisaaron/dehydrated-route53-hook-script/v0.4.1/hook.sh \
    -o /home/dehydrated/hook.sh && chmod 755 /home/dehydrated/hook.sh

RUN curl -SsL https://github.com/barnybug/cli53/releases/download/0.8.15/cli53-linux-amd64 -o /bin/cli53 \
    && chmod +x /bin/cli53

COPY config /home/dehydrated/config

VOLUME ["/home/dehydrated/accounts", "/home/dehydrated/certs"]

USER dehydrated

ENTRYPOINT [ "/home/dehydrated/dehydrated" ]
CMD [ "--accept-terms", "-c" ]