# freedock

> 使用 docker-compose 部署 v2ray 和 trojan

### 食用前自备

1. 域名一枚
2. Cloudflare CDN 账户一个
3. 独立 VPS一台

### 服务端配置

#### 1. 安装 docker、docker-compose 和 Git

如果你的 VPS 使用的是 Debian 系列的系统，可以执行下面的命令一键安装：

```shell
sudo apt install docker.io docker-compose git
```

其他系统的话自行解决。

#### 2. 克隆项目并进入项目目录

```shell
git clone https://github.com/kullex/freedock.git && cd freedock
```

#### 3. 复制环境变量文件

```shell
cp ./env-sample ./.env
vim ./.env
```

#### 4. 配置环境变量

```shell
### SSL ###################################################

CLOUDFLARE_EMAIL=你的 Cloudflare 登陆邮箱
CLOUDFLARE_API_KEY=你的 Cloudflare API Key

### DOMAIN ################################################

DOMAIN=你要绑定的域名

### V2Ray #################################################

V2RAY_PORT=v2ray 端口号，使用 vmess 协议，可以做后置代理

V2RAY_BACKEND_UUID=做后置用时验证的 UUID，配合 V2RAY_PORT + IP 食用
V2RAY_FRONTEND_UUID=做前置用时验证的 UUID，配合 域名 + ws + tls 食用

V2RAY_PATH=随便一串字符串，WebSocket 路径

### Trojan ################################################

TROJAN_PASSWORD=Trojan 登陆密码
```

#### 5. 配置 docker-compose.yml

```shell
cp ./docker-compose.full.yml ./docker-compose.yml
```

##### 仅部署 v2ray

1. 删除 `docker-compose.yml` 中 trojan 部分配置文件
2. 修改 `.env` 文件中 `CADDY_HOST_HTTPS_PORT` 为 `443`

##### 仅部署 Trojan

1. 删除 `docker-compose.yml` 中 v2ray 部分配置

#### 6. OK，开始吧

启动服务：

```shell
sudo docker-compose up -d
```

停止的话：

```shell
sudo docker-compose stop
```

如果修改了配置，需要重新 Build 镜像

```shell
sudo docker-compose up -d --build
```
