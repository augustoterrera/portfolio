# Etapa 1 - Build
FROM node:24-alpine AS builder
RUN npm install -g pnpm
WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install
COPY . .
RUN pnpm run build

# Etapa 2 - Servidor
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80