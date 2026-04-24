FROM node:20-alpine

WORKDIR /app

RUN npm install -g pnpm

# Development environment defaults for hot-reload
ENV NODE_ENV=development
ENV PORT=3003
ENV HOST=0.0.0.0
# Enable polling so file changes from host mounts are detected reliably
ENV CHOKIDAR_USEPOLLING=true
ENV CHOKIDAR_INTERVAL=100

COPY package.json pnpm-lock.yaml* ./
RUN pnpm install

COPY . .

EXPOSE 3003

# Run Next.js in dev mode, binding to 0.0.0.0 so the container is accessible
CMD ["pnpm", "dev", "--", "-H", "0.0.0.0", "-p", "3003"]