# text-generation-webui-nvidia-docker
### 简介
自用nvidia显卡tgw docker镜像, 代码和脚本基本都是复制自[text-generation-webui-docker](https://github.com/Atinoda/text-generation-webui-docker)

### 安装步骤
1. clone all source code
```
git clone https://github.com/ftdlyc/text-generation-webui-nvidia-docker.git --recursive
```
2. build docker image
```
cd text-generation-webui-nvidia-docker
docker build -t text-generation-webui-nvidia-tensorrt-llm .
```
3. run docker container
```
docker-compose up
```
