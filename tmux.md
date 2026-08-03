# Sử dụng Tmux

## Cái gói
```
sudo apt update && sudo apt install tmux -y
```
## Tạo new session
```
tmux new -s myapp
```
## Xem các session đã tạo
```
tmux ls
```
## Truy cập vào các sesion
```
tmux attach -t <tên session>
```
## Dừng hoặc xóa sesion
```
tmux kill-session -t <tên session>
```
## Lệnh gộp
```
tmux new-session -d -s fastapi \
"cd /home/user/my_fastapi_project && source venv/bin/activate && uvicorn main:app --host 0.0.0.0 --port 8000"****
```
## Thoát trở lại home 
## Tổ hợp phím: Ctrl+ B, nhấn D 
