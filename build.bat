@echo off
chcp 65001 >nul
echo ====================================
echo MP4 转音频转换器 - 打包脚本
echo ====================================
echo.

echo [1/3] 检查 PyInstaller 是否安装...
python -m pip show pyinstaller >nul 2>&1
if errorlevel 1 (
    echo PyInstaller 未安装，正在安装...
    python -m pip install pyinstaller
) else (
    echo PyInstaller 已安装
)

echo.
echo [2/3] 开始打包程序...
python -m PyInstaller --onefile --windowed --name "MP4 转音频转换器" --icon=NONE --add-data "README.md;." converter.py

echo.
echo [3/3] 清理临时文件...
if exist "build" (
    rmdir /s /q build
    echo 已删除 build 文件夹
)

echo.
echo ====================================
echo 打包完成！
echo 可执行文件位置：dist\MP4 转音频转换器.exe
echo ====================================
echo.
pause
