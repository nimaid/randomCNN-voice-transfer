@echo off
docker run --gpus all -it -v C:\Users\ellag\docker_data:/root/data -p 8888:8888 nimaid/voctrans
