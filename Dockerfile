ARG ARCH="amd64"

FROM s390x/node:10-alpine

COPY qemu-s390x-static /usr/bin
# Install pm2
RUN npm install pm2 -g

# Expose ports needed to use Keymetrics.io
EXPOSE 80 443 43554

# Start pm2.json process file
CMD ["pm2-runtime", "start", "pm2.json"]
