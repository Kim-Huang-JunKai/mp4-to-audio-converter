# GitHub Release 创建脚本 - PowerShell 版本
# 使用方法：
#   1. 设置 Token: $env:GH_TOKEN="你的 Token"
#   2. 运行脚本：.\create_github_release.ps1

param(
    [switch]$Help
)

if ($Help) {
    Write-Host @"
GitHub Release 创建脚本

使用方法:
  1. 设置 GitHub Token:
     `$env:GH_TOKEN="ghp_xxxxxxxxxxxxxxxxxxxx"
  
  2. 运行脚本:
     .\create_github_release.ps1
  
  3. (可选) 清除 Token:
     Remove-Item Env:\GH_TOKEN

功能:
  - 检查可执行文件是否存在
  - 创建 GitHub Release
  - 上传可执行文件

"@
    exit
}

Write-Host "====================================" -ForegroundColor Cyan
Write-Host "GitHub Release 创建脚本" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

# 检查 Token 是否设置
if (-not $env:GH_TOKEN) {
    Write-Host "错误：未设置 GH_TOKEN 环境变量" -ForegroundColor Red
    Write-Host ""
    Write-Host "请先设置 Token:" -ForegroundColor Yellow
    Write-Host '  $env:GH_TOKEN="你的 Token"' -ForegroundColor Yellow
    Write-Host ""
    exit 1
}

# 检查可执行文件
Write-Host "[1/4] 检查可执行文件..." -ForegroundColor Cyan
$exePath = "dist\MP4 转音频转换器.exe"
if (-not (Test-Path $exePath)) {
    Write-Host "错误：未找到 $exePath" -ForegroundColor Red
    Write-Host "请先运行 build_with_ffmpeg.bat 进行打包" -ForegroundColor Yellow
    exit 1
}
$exeSize = (Get-Item $exePath).Length / 1MB
Write-Host "✓ 可执行文件存在 (大小：{0:N1} MB)" -f $exeSize -ForegroundColor Green

# 检查 GitHub CLI
Write-Host "[2/4] 检查 GitHub CLI..." -ForegroundColor Cyan
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    Write-Host "错误：未找到 GitHub CLI" -ForegroundColor Red
    exit 1
}
Write-Host "✓ GitHub CLI 已安装" -ForegroundColor Green

# 检查登录状态
Write-Host "[3/4] 检查登录状态..." -ForegroundColor Cyan
$authStatus = gh auth status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "未登录，正在使用 Token 登录..." -ForegroundColor Yellow
    $env:GH_TOKEN | gh auth login --with-token
    if ($LASTEXITCODE -ne 0) {
        Write-Host "登录失败" -ForegroundColor Red
        exit 1
    }
    Write-Host "✓ 登录成功" -ForegroundColor Green
} else {
    Write-Host "✓ 已登录" -ForegroundColor Green
}

# 创建 Release
Write-Host "[4/4] 创建 Release v1.1.0..." -ForegroundColor Cyan

# 检查 Release 是否已存在
$existingRelease = gh release view v1.1.0 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "Release v1.1.0 已存在，是否删除并重新创建？" -ForegroundColor Yellow
    $response = Read-Host "删除并重新创建？(y/n)"
    if ($response -eq 'y' -or $response -eq 'Y') {
        Write-Host "删除现有 Release..." -ForegroundColor Yellow
        gh release delete v1.1.0 --yes --cleanup-tag 2>$null
    } else {
        Write-Host "取消创建 Release" -ForegroundColor Yellow
        exit 0
    }
}

# 创建 Release
Write-Host "正在创建 Release..." -ForegroundColor Yellow
gh release create v1.1.0 $exePath `
    --title "v1.1.0 - 初始版本（集成 FFmpeg）" `
    --notes @"
## 🎉 MP4 转音频转换器 v1.1.0

### ✨ 主要特性
- 🎯 支持多种视频格式输入（MP4、AVI、MKV、MOV、WMV、FLV）
- 🎵 支持 7 种音频格式输出（MP3、WAV、AAC、FLAC、OGG、M4A、WMA）
- 🎚️ 可调节音质（128k、192k、256k、320k）
- 📦 **已集成 FFmpeg，无需单独安装**
- 🖥️ 简洁友好的 Windows 界面
- ⚡ 多线程处理，不阻塞界面

### 🔧 技术细节
- **内置 FFmpeg**: 程序已包含完整 FFmpeg，无需单独安装
- **单文件分发**: 一个 EXE 文件包含所有功能
- **跨机器兼容**: 在任何 Windows 机器上都能运行

### 📋 使用说明
1. 下载 MP4 转音频转换器.exe
2. 双击运行
3. 选择视频文件
4. 选择输出格式和音质
5. 点击"开始转换"

### 🎯 更新内容
- ✅ 集成 FFmpeg 到程序中
- ✅ 无需单独安装 FFmpeg
- ✅ 优化打包流程
- ✅ 完善文档说明

### 📄 许可证
MIT License
"@

if ($LASTEXITCODE -ne 0) {
    Write-Host "创建 Release 失败" -ForegroundColor Red
    Write-Host "可能原因：文件上传超时或网络问题" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "请手动创建 Release:" -ForegroundColor Yellow
    Write-Host "1. 访问：https://github.com/KimHuang02/mp4-to-audio-converter/releases/new" -ForegroundColor Cyan
    Write-Host "2. Tag version: v1.1.0" -ForegroundColor Cyan
    Write-Host "3. 上传文件：$exePath" -ForegroundColor Cyan
    Write-Host "4. 点击 Publish release" -ForegroundColor Cyan
    exit 1
}

Write-Host "✓ Release 创建成功" -ForegroundColor Green

Write-Host ""
Write-Host "====================================" -ForegroundColor Green
Write-Host "Release 创建成功!" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green
Write-Host ""
Write-Host "查看 Release: https://github.com/KimHuang02/mp4-to-audio-converter/releases/tag/v1.1.0" -ForegroundColor Cyan
Write-Host ""
Write-Host "提示：完成后请清除 Token" -ForegroundColor Yellow
Write-Host '  Remove-Item Env:\GH_TOKEN' -ForegroundColor Cyan
Write-Host ""
