# Dockerfile

# 使用官方 Golang 镜像作为构建阶段
FROM golang:1.21-alpine AS builder

# 设置工作目录
WORKDIR /app

# 将源代码复制到容器中
COPY . .

# 编译 Go 程序
RUN go build -o main .

# ========== 第二阶段：运行阶段 ==========
# 使用轻量级 Alpine 镜像
FROM alpine:latest

# 安装 curl（可选，用于测试）
RUN apk --no-cache add curl

# 设置工作目录
WORKDIR /root/

# 从 builder 阶段拷贝编译好的二进制文件
COPY --from=builder /app/main .

# 暴露端口
EXPOSE 8080

# 启动服务
CMD ["./main"]