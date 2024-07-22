# 构建应用
# 使用node基础镜像
FROM node:18 AS builder

# 在容器中创建一个工作目录
WORKDIR /app

# 将项目的package.json和yarn.lock复制到工作目录
COPY package*.json yarn.lock ./

# 使用Yarn安装项目依赖
RUN yarn install 

# 将项目文件复制到工作目录
COPY . .

# 添加设置
RUN [ ! -e ".env" ] && cp .env.example .env || true
# 制作镜像
RUN yarn build

# 最小化镜像
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
RUN yarn global add http-server

EXPOSE 12445
CMD ["http-server", "dist", "-p", "12445"]