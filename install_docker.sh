#!/bin/bash

# Thiết lập script dừng lại nếu có bất kỳ lệnh nào bị lỗi
set -e

echo "========================================="
echo "BẮT ĐẦU CÀI ĐẶT DOCKER TRÊN UBUNTU"
echo "========================================="

# 1. Cập nhật hệ thống và cài đặt các package phụ thuộc
echo "[1/4] Cập nhật hệ thống và cài đặt tiện ích..."
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg lsb-release -y

# 2. Tạo thư mục chứa key và tải GPG key của Docker
echo "[2/4] Thiết lập GPG Key cho Docker..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://docker.com | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# 3. Thêm Docker Repository vào apt sources
echo "[3/4] Thêm Docker Repository vào hệ thống..."
echo \
 "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
 https://docker.com $(lsb_release -cs) stable" | \
 sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 4. Cập nhật lại apt và cài đặt các thành phần Docker
echo "[4/4] Đang cài đặt Docker CE, CLI và Plugins..."
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

echo "========================================="
echo "CHÚC MỪNG! ĐÃ CÀI ĐẶT DOCKER THÀNH CÔNG!"
echo "========================================="
