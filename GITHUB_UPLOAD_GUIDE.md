# GitHub 上传指南

## 第一步：在 GitHub 创建新仓库

1. 访问 https://github.com
2. 点击右上角 "+" 按钮，选择 "New repository"
3. 填写以下信息：
   - **Repository name**: `mp4-to-audio-converter`（或你喜欢的名称）
   - **Description**: "MP4 转音频转换器 - 支持多种音频格式输出的视频转音频提取工具"
   - **Visibility**: 选择 **Public**（公开）
   - **Initialize this repository with**: 全部**不要勾选**
4. 点击 "Create repository" 按钮

## 第二步：生成 GitHub Personal Access Token

1. 访问 https://github.com/settings/tokens
2. 点击 "Generate new token (classic)"
3. 填写信息：
   - **Note**: `MP4 Converter Upload`
   - **Expiration**: 选择 `No expiration`（或根据需要选择）
   - **Select scopes**: 勾选 `repo`（完整仓库权限）
4. 点击 "Generate token"
5. **重要**：复制生成的 token（只会显示一次！）

## 第三步：配置远程仓库

在项目中打开终端，执行以下命令（替换为你的 GitHub 用户名和仓库名）：

```bash
# 添加远程仓库（将 YOUR_USERNAME 替换为你的 GitHub 用户名）
git remote add origin https://YOUR_USERNAME@github.com/YOUR_USERNAME/mp4-to-audio-converter.git

# 或者使用 HTTPS + Token 方式（将 TOKEN 和 YOUR_USERNAME 替换为实际值）
git remote add origin https://TOKEN@github.com/YOUR_USERNAME/mp4-to-audio-converter.git
```

## 第四步：推送到 GitHub

```bash
# 推送到 main 分支（或 master）
git branch -M main
git push -u origin main
```

如果使用 HTTPS 方式，可能会提示输入密码，此时使用你的 GitHub Token 作为密码。

## 第五步：验证上传

1. 刷新 GitHub 仓库页面
2. 确认所有文件已上传成功
3. 检查 README.md 是否正确显示

## 常见问题

### Q: 推送失败，提示认证错误
A: 确保使用了正确的 GitHub Token，并且 Token 有 repo 权限。

### Q: 远程仓库已存在
A: 先执行 `git remote remove origin`，然后重新添加。

### Q: 推送到错误的分支
A: 使用 `git push origin main:main` 强制推送到 main 分支。

## 完整的命令示例

```bash
# 1. 添加远程仓库（替换为你的 GitHub 用户名）
git remote add origin https://github.com/YOUR_USERNAME/mp4-to-audio-converter.git

# 2. 重命名分支为 main
git branch -M main

# 3. 推送（会提示输入用户名和密码，密码使用 GitHub Token）
git push -u origin main
```

## 使用 SSH 方式（可选）

如果你更喜欢使用 SSH：

```bash
# 1. 生成 SSH 密钥（如果没有）
ssh-keygen -t ed25519 -C "your_email@example.com"

# 2. 将公钥添加到 GitHub
# 访问 https://github.com/settings/keys
# 点击 "New SSH key"，粘贴 ~/.ssh/id_ed25519.pub 的内容

# 3. 使用 SSH 方式添加远程仓库
git remote add origin git@github.com:YOUR_USERNAME/mp4-to-audio-converter.git

# 4. 推送
git branch -M main
git push -u origin main
```

## 仓库创建后的公开访问链接

创建成功后，你的项目链接将是：
```
https://github.com/YOUR_USERNAME/mp4-to-audio-converter
```

可以将此链接分享给他人访问你的开源项目！
