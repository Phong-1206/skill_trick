#!/usr/bin/env bash
#
# install.sh - Cài đặt Docker CE trên Ubuntu/Debian
# Sử dụng: sudo bash install.sh
#

set -euo pipefail

# --- Kiểm tra quyền root ---
if [[ $EUID -ne 0 ]]; then
    echo "❌ Vui lòng chạy script với quyền root (sudo)." >&2
    exit 1
fi

# --- Kiểm tra hệ điều hành ---
if [[ ! -f /etc/os-release ]]; then
    echo "❌ Không tìm thấy /etc/os-release. Script chỉ hỗ trợ Ubuntu/Debian." >&2
    exit 1
fi

source /etc/os-release
echo "📦 Hệ điều hành: ${PRETTY_NAME}"

# --- 1. Cập nhật hệ thống và cài dependencies ---
echo "🔧 [1/5] Cập nhật apt và cài đặt gói phụ trợ..."
apt-get update
apt-get install -y ca-certificates curl gnupg lsb-release

# --- 2. Tạo thư mục keyrings ---
echo "🔑 [2/5] Tạo thư mục /etc/apt/keyrings..."
mkdir -p /etc/apt/keyrings

# --- 3. Thêm GPG key của Docker ---
echo "🔐 [3/5] Thêm GPG key chính thức của Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# --- 4. Thêm Docker repository ---
echo "📝 [4/5] Thêm Docker repository vào APT sources..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update

# --- 5. Cài đặt Docker Engine ---
echo "🐳 [5/5] Cài đặt Docker Engine, CLI, containerd và Compose plugin..."
apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-compose-plugin

# --- Kiểm tra kết quả ---
echo ""
echo "✅ Cài đặt hoàn tất!"
docker --version
docker compose version

# --- (Tùy chọn) Thêm user hiện tại vào group docker ---
if [[ -n "${SUDO_USER:-}" ]]; then
    echo ""
    echo "👤 Thêm user '$SUDO_USER' vào group 'docker'..."
    usermod -aG docker "$SUDO_USER"
    echo "ℹ️  Vui lòng đăng xuất và đăng nhập lại (hoặc chạy 'newgrp docker') để dùng Docker không cần sudo."
fi

echo ""
echo "🎉 Docker đã sẵn sàng! Kiểm tra bằng lệnh: docker run hello-world"
