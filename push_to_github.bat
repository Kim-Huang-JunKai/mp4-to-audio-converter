@echo off
chcp 65001 >nul
echo ====================================
echo 推送到 GitHub 脚本
echo ====================================
echo.

echo 请按照以下步骤操作：
echo.
echo 1. 在 GitHub 创建新仓库：
echo    访问：https://github.com/new
echo    仓库名：mp4-to-audio-converter
echo    可见性：选择 Public（公开）
echo    不要初始化仓库（不要勾选任何选项）
echo.
echo 2. 按任意键继续...
pause >nul

echo.
set /p GITHUB_USER="请输入你的 GitHub 用户名："
if "%GITHUB_USER%"=="" (
    echo 错误：用户名不能为空
    pause
    exit /b 1
)

echo.
echo 正在配置远程仓库...
git remote remove origin 2>nul
git remote add origin https://github.com/%GITHUB_USER%/mp4-to-audio-converter.git

if errorlevel 1 (
    echo 错误：无法添加远程仓库
    pause
    exit /b 1
)

echo.
echo 远程仓库配置成功！
echo.
echo 正在重命名分支为 main...
git branch -M main

echo.
echo ====================================
echo 准备推送代码到 GitHub
echo ====================================
echo.
echo 注意：首次推送需要输入 GitHub Token
echo 获取 Token: https://github.com/settings/tokens
echo 需要勾选的权限：repo
echo.
echo 按任意键开始推送...
pause >nul

echo.
echo 正在推送代码...
git push -u origin main

if errorlevel 1 (
    echo.
    echo ====================================
    echo 推送失败！
    echo ====================================
    echo.
    echo 可能的原因：
    echo 1. 仓库不存在 - 请先在 GitHub 创建仓库
    echo 2. 认证失败 - 请使用 GitHub Token 作为密码
    echo 3. Token 权限不足 - 确保勾选了 repo 权限
    echo.
    echo 获取 Token: https://github.com/settings/tokens
    echo.
    pause
    exit /b 1
)

echo.
echo ====================================
echo 推送成功！
echo ====================================
echo.
echo 项目已上传到：
echo https://github.com/%GITHUB_USER%/mp4-to-audio-converter
echo.
echo 按任意键打开项目页面...
pause >nul
start https://github.com/%GITHUB_USER%/mp4-to-audio-converter

echo.
echo 完成！
pause
