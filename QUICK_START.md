# 🚀 快速上传到 GitHub

## 一分钟完成上传

### 步骤 1: 获取 GitHub Token

1. 访问：https://github.com/settings/tokens
2. 点击 **Generate new token (classic)**
3. Note: `MP4 Converter Upload`
4. Expiration: `No expiration`
5. Select scopes: 勾选 **`repo`**
6. 点击 **Generate token** 并复制 Token

### 步骤 2: 运行 PowerShell 脚本

打开 PowerShell，运行以下命令：

```powershell
# 1. 设置 Token（替换为你的实际 Token）
$env:GH_TOKEN="ghp_xxxxxxxxxxxxxxxxxxxx"

# 2. 上传代码
.\upload_to_github.ps1

# 3. 创建 Release（上传可执行文件）
.\create_github_release.ps1

# 4. 清除 Token（安全）
Remove-Item Env:\GH_TOKEN
```

完成！🎉

---

## 📝 详细说明

### 脚本功能

#### upload_to_github.ps1
- ✅ 检查 GitHub CLI 是否安装
- ✅ 使用 Token 登录 GitHub
- ✅ 创建仓库（如果不存在）
- ✅ 推送代码到 GitHub

#### create_github_release.ps1
- ✅ 检查可执行文件是否存在
- ✅ 创建 GitHub Release
- ✅ 上传 `MP4 转音频转换器.exe`
- ✅ 添加版本说明

### 手动上传（可选）

如果不想使用脚本，可以手动执行：

```powershell
# 登录
$env:GH_TOKEN="你的 Token"
gh auth login --with-token

# 创建仓库
gh repo create KimHuang02/mp4-to-audio-converter --public --source=. --remote=origin --push

# 创建 Release
gh release create v1.1.0 "dist\MP4 转音频转换器.exe" `
    --title "v1.1.0 - 初始版本（集成 FFmpeg）" `
    --notes "MP4 转音频转换器 - 初始发布版本"
```

---

## 🔐 安全提示

- ✅ Token 不会提交到 Git（已在 .gitignore 中）
- ✅ 使用后立即清除：`Remove-Item Env:\GH_TOKEN`
- ✅ 不要分享你的 Token

---

## ❓ 故障排除

### 问题：找不到 gh 命令
**解决**: 安装 GitHub CLI
```powershell
winget install GitHub.cli
```

### 问题：认证失败
**解决**: 检查 Token 是否正确，确保有 `repo` 权限

### 问题：Release 上传失败
**解决**: 文件较大（217MB），请确保网络稳定，或手动在浏览器中上传

---

## 🔗 相关链接

- **仓库**: https://github.com/KimHuang02/mp4-to-audio-converter
- **Releases**: https://github.com/KimHuang02/mp4-to-audio-converter/releases
- **Token 设置**: https://github.com/settings/tokens

---

**提示**: 批处理文件（.bat）已排除在 Git 之外，使用 PowerShell 脚本更安全！
