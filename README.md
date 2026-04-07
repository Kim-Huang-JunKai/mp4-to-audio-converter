# 🚀 快速上传指南

## 一步完成上传

```powershell
# 1. 获取 GitHub Token: https://github.com/settings/tokens

# 2. 登录并上传
$env:GH_TOKEN="你的 Token"
gh auth login --with-token
gh repo create KimHuang02/mp4-to-audio-converter --public --source=. --remote=origin --push

# 3. 创建 Release（可选）
gh release create v1.1.0 "dist\MP4 转音频转换器.exe" --title "v1.1.0" --notes "MP4 转音频转换器"
```

## 🔗 仓库地址

创建成功后访问：
https://github.com/KimHuang02/mp4-to-audio-converter
