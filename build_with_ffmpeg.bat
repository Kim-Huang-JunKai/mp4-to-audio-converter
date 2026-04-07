@echo off
chcp 65001 >nul
echo ====================================
echo MP4 转音频转换器 - 完整打包脚本
echo (FFmpeg 集成到单个 EXE)
echo ====================================
echo.

echo [1/4] 检查 PyInstaller 是否安装...
python -m pip show pyinstaller >nul 2>&1
if errorlevel 1 (
    echo PyInstaller 未安装，正在安装...
    python -m pip install pyinstaller
) else (
    echo PyInstaller 已安装
)

echo.
echo [2/4] 检查 FFmpeg 是否存在...
if not exist "ffmpeg\ffmpeg.exe" (
    echo FFmpeg 未找到，正在下载...
    powershell -Command "Invoke-WebRequest -Uri 'https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl.zip' -OutFile 'ffmpeg.zip' -UseBasicParsing"
    echo 解压 FFmpeg...
    powershell -Command "Expand-Archive -Path 'ffmpeg.zip' -DestinationPath 'ffmpeg_temp' -Force"
    powershell -Command "Copy-Item -Path 'ffmpeg_temp\ffmpeg-master-latest-win64-gpl\bin\*' -Destination 'ffmpeg' -Recurse -Force"
    powershell -Command "Remove-Item -Path 'ffmpeg.zip' -Force"
    powershell -Command "Remove-Item -Path 'ffmpeg_temp' -Recurse -Force"
    echo FFmpeg 下载完成
) else (
    echo FFmpeg 已存在
)

echo.
echo [3/4] 开始打包程序（包含 FFmpeg）...
REM 使用 --add-data 将 ffmpeg 文件夹打包到 exe 中
python -m PyInstaller --onefile --windowed --name "MP4 转音频转换器" --add-data "ffmpeg;ffmpeg" converter.py

if errorlevel 1 (
    echo.
    echo 打包失败！
    pause
    exit /b 1
)

echo.
echo [4/4] 清理临时文件...
if exist "build" (
    rmdir /s /q build
    echo 已删除 build 文件夹
)

echo.
echo ====================================
echo 打包完成！
echo ====================================
echo.
echo 输出文件：dist\MP4 转音频转换器.exe
echo.
echo 特点:
echo - 单个可执行文件
echo - 已集成 FFmpeg
echo - 无需额外文件
echo - 可直接分发使用
echo.
echo 注意：由于集成了 FFmpeg，文件较大（约 80-100MB）
echo ====================================
echo.
pause
