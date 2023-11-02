import subprocess
import os
import time
import signal

cwd = os.getcwd()
# 切换到指定目录
os.chdir('/home/ubuntu/YX/code/openpose')

# 启动进程
process = subprocess.Popen(['./python', '--image_dir', '/home/ubuntu/YX/code/openpose/examples/media', '--write_images', '/home/ubuntu/YX/utils/gpu_save_posemap', '--write_images_format', 'jpg', '--disable_blending', '--hand', '--display', '0'], env={'CUDA_VISIBLE_DEVICES': '4'})

# 等待5秒
time.sleep(10)

# 发送SIGSTOP信号暂停进程
process.send_signal(signal.SIGSTOP)

# 切换回原来的目录
os.chdir(cwd)