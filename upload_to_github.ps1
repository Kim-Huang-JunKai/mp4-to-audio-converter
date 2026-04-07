# GitHub 上传脚本 - PowerShell 版本
# 使用方法：
#   1. 设置 Token: $env:GH_TOKEN="你的 Token"
#   2. 运行脚本：.\upload_to_github.ps1

param(
    [switch]$Help
)

if ($Help) {
    Write-Host @"
GitHub 上传脚本

使用方法:
  1. 设置 GitHub Token:
     `$env:GH_TOKEN="ghp_xxxxxxxxxxxxxxxxxxxx"
  
  2. 运行脚本:
     .\upload_to_github.ps1
  
  3. (可选) 清除 Token:
     Remove-Item Env:\GH_TOKEN

功能:
  - 检查 GitHub CLI 是否已登录
  - 创建仓库（如果不存在）
  - 推送代码到 GitHub

"@
    exit
}

Write-Host "====================================" -ForegroundColor Cyan
Write-Host "GitHub 上传脚本" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

# 检查 Token 是否设置
if (-not $env:GH_TOKEN) {
    Write-Host "错误：未设置 GH_TOKEN 环境变量" -ForegroundColor Red
    Write-Host ""
    Write-Host "请先设置 Token:" -ForegroundColor Yellow
    Write-Host '  $env:GH_TOKEN="你的 Token"' -ForegroundColor Yellow
    Write-Host ""
    Write-Host "获取 Token: https://github.com/settings/tokens" -ForegroundColor Yellow
    exit 1
}

# 检查 GitHub CLI 是否安装
Write-Host "[1/5] 检查 GitHub CLI..." -ForegroundColor Cyan
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    Write-Host "错误：未找到 GitHub CLI (gh)" -ForegroundColor Red
    Write-Host "请安装：https://github.com/cli/cli#installation" -ForegroundColor Yellow
    exit 1
}
Write-Host "✓ GitHub CLI 已安装" -ForegroundColor Green

# 检查是否已登录
Write-Host "[2/5] 检查登录状态..." -ForegroundColor Cyan
$authStatus = gh auth status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "未登录，正在使用 Token 登录..." -ForegroundColor Yellow
    $env:GH_TOKEN | gh auth login --with-token
    if ($LASTEXITCODE -ne 0) {
        Write-Host "登录失败，请检查 Token 是否正确" -ForegroundColor Red
        exit 1
    }
    Write-Host "✓ 登录成功" -ForegroundColor Green
} else {
    Write-Host "✓ 已登录" -ForegroundColor Green
}

# 检查可执行文件
Write-Host "[3/5] 检查项目文件..." -ForegroundColor Cyan
if (-not (Test-Path "converter.py")) {
    Write-Host "错误：未找到 converter.py" -ForegroundColor Red
    exit 1
}
Write-Host "✓ 项目文件存在" -ForegroundColor Green

# 创建或检查仓库
Write-Host "[4/5] 检查仓库..." -ForegroundColor Cyan
$repoExists = gh repo view KimHuang02/mp4-to-audio-converter 2>&1 | Out-Null
if ($LASTEXITCODE -ne 0) {
    Write-Host "仓库不存在，正在创建..." -ForegroundColor Yellow
    gh repo create KimHuang02/mp4-to-audio-converter --public --source=. --remote=origin --push
    if ($LASTEXITCODE -ne 0) {
        Write-Host "创建仓库失败" -ForegroundColor Red
        exit 1
    }
    Write-Host "✓ 仓库创建成功" -ForegroundColor Green
} else {
    Write-Host "✓ 仓库已存在" -ForegroundColor Green
}

# 推送代码
Write-Host "[5/5] 推送代码..." -ForegroundColor Cyan
git branch -M main 2>$null
git push -u origin main
if ($LASTEXITCODE -ne 0) {
    Write-Host "推送失败" -ForegroundColor Red
    exit 1
}
Write-Host "✓ 推送成功" -ForegroundColor Green

Write-Host ""
Write-Host "====================================" -ForegroundColor Green
Write-Host "上传成功!" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green
Write-Host ""
Write-Host "仓库地址：https://github.com/KimHuang02/mp4-to-audio-converter" -ForegroundColor Cyan
Write-Host ""
Write-Host "提示：运行 .\create_github_release.ps1 创建 Release" -ForegroundColor Yellow
Write-Host ""
