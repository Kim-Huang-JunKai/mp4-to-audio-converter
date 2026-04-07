# GitHub 上传指南（PowerShell 版本）

## 🎯 快速开始

### 第一步：获取 GitHub Token

1. 访问：https://github.com/settings/tokens
2. 点击 "Generate new token (classic)"
3. Note: `MP4 Converter Upload`
4. Expiration: `No expiration`
5. Select scopes: 勾选 `repo` 和 `workflow`
6. 点击 "Generate token" 并复制

### 第二步：运行 PowerShell 脚本

打开 PowerShell，导航到项目目录，然后运行：

```powershell
# 设置 Token（替换为你的实际 Token）
$env:GH_TOKEN="ghp_xxxxxxxxxxxxxxxxxxxx"

# 登录 GitHub
gh auth login --with-token

# 创建仓库并推送
.\upload_to_github.ps1

# 创建 Release
.\create_github_release.ps1
```

---

## 📝 详细步骤

### 方法一：使用自动化脚本（推荐）

#### 1. 上传代码到 GitHub

```powershell
# 设置你的 GitHub Token
$env:GH_TOKEN="你的 Token"

# 运行上传脚本
.\upload_to_github.ps1
```

#### 2. 创建 Release 并发布软件

```powershell
# 设置你的 GitHub Token
$env:GH_TOKEN="你的 Token"

# 运行 Release 创建脚本
.\create_github_release.ps1
```

### 方法二：手动执行命令

如果不想使用脚本，可以手动执行以下命令：

#### 1. 登录 GitHub

```powershell
$env:GH_TOKEN="你的 Token"
gh auth login --with-token
```

#### 2. 创建仓库

```powershell
gh repo create KimHuang02/mp4-to-audio-converter --public --source=. --remote=origin --push
```

#### 3. 确保分支为 main

```powershell
git branch -M main
```

#### 4. 推送代码

```powershell
git push -u origin main
```

#### 5. 创建 Release

```powershell
gh release create v1.1.0 "dist\MP4 转音频转换器.exe" `
    --title "v1.1.0 - 初始版本（集成 FFmpeg）" `
    --notes "MP4 转音频转换器 - 初始发布版本"
```

---

## 🔐 安全提示

### Token 安全

- ✅ **不要**将 Token 提交到 Git 仓库
- ✅ **不要**在公开场合分享 Token
- ✅ 使用后立即清除环境变量：`Remove-Item Env:\GH_TOKEN`
- ✅ 定期更换 Token

### 使用方式

推荐在运行时临时设置 Token：

```powershell
# 方式 1: 临时设置（推荐）
$env:GH_TOKEN="你的 Token"; .\upload_to_github.ps1

# 方式 2: 使用 secure string（更安全）
$secure = Read-Host "Enter Token" -AsSecureString
$token = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($secure)
)
$env:GH_TOKEN = $token
.\upload_to_github.ps1
Remove-Item Env:\GH_TOKEN
```

---

## 📋 脚本说明

### upload_to_github.ps1

功能：
- 检查 GitHub CLI 是否已登录
- 创建仓库（如果不存在）
- 推送代码到 GitHub

### create_github_release.ps1

功能：
- 检查可执行文件是否存在
- 创建 GitHub Release
- 上传可执行文件

---

## ❓ 常见问题

### Q: Token 认证失败
A: 检查 Token 是否正确，确保有 `repo` 权限

### Q: 仓库已存在
A: 直接运行推送命令即可：`git push -u origin main`

### Q: 上传 Release 失败
A: 文件较大（217MB），请确保网络稳定，或手动在浏览器中上传

---

## 🔗 相关链接

- **仓库主页**: https://github.com/KimHuang02/mp4-to-audio-converter
- **Releases 页面**: https://github.com/KimHuang02/mp4-to-audio-converter/releases
- **Token 设置**: https://github.com/settings/tokens

---

**注意**: 为了安全起见，批处理文件（.bat）已添加到 .gitignore，不会上传到 Git 仓库。
