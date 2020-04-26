ARG ARCH="amd64"

FROM alpine AS builder

# Download QEMU, see https://github.com/docker/hub-feedback/issues/1261
ENV QEMU_URL https://github.com/multiarch/qemu-user-static/releases/download/v4.0.0-2/qemu-s390x-static.tar.gz
RUN apk add curl && curl -L ${QEMU_URL} | tar zxvf - -C /usr/bin/

FROM s390x/node:10-alpine

# Add QEMU
COPY --from=builder /usr/bin/qemu-s390x-static /usr/bin/

RUN ls -la /usr/bin/
# Install pm2

RUN npm install pm2 -g

# Expose ports needed to use Keymetrics.io
EXPOSE 80 443 43554

# Start pm2.json process file
CMD ["pm2-runtime", "start", "pm2.json"]
