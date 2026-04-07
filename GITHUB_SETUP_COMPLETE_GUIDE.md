# GitHub 仓库创建和发布指南

## 🎯 目标
1. 在 GitHub 创建 `mp4-to-audio-converter` 仓库
2. 上传所有代码
3. 创建 Release 并发布可执行文件

---

## 📝 步骤一：创建 GitHub Personal Access Token

### 1. 访问 Token 设置页面
打开浏览器，访问：https://github.com/settings/tokens

### 2. 生成新 Token
- 点击 **"Generate new token"**
- 选择 **"Generate new token (classic)"**

### 3. 填写 Token 信息
- **Note**: `MP4 Converter Upload`
- **Expiration**: `No expiration`（或根据需要选择）
- **Select scopes**: 勾选以下权限：
  - ✅ `repo` (Full control of private repositories)
  - ✅ `workflow` (Update GitHub Action workflows)

### 4. 生成并复制 Token
- 点击页面底部的 **"Generate token"** 按钮
- **重要**：立即复制显示的 Token（只会显示一次！）
- 将 Token 保存到安全的地方，例如：`你的 Token: ________________________`

---

## 🚀 步骤二：使用脚本自动创建和上传（推荐）

### 方法 A: 使用自动化脚本

1. **运行认证脚本**
   ```
   双击运行：gh_auth_and_create.bat
   ```

2. **输入 Token**
   - 粘贴你刚才复制的 GitHub Token
   - 按 Enter 确认

3. **等待完成**
   - 脚本会自动创建仓库
   - 推送所有代码
   - 显示成功消息

### 方法 B: 手动执行命令

如果脚本失败，可以手动执行以下命令：

```powershell
# 1. 设置 Token（替换 YOUR_TOKEN 为你的实际 Token）
$env:GH_TOKEN="YOUR_TOKEN"

# 2. 登录 GitHub
gh auth login --with-token

# 3. 创建仓库（如果已存在会报错，可忽略）
gh repo create KimHuang02/mp4-to-audio-converter --public --source=. --remote=origin --push

# 4. 确保分支为 main
git branch -M main

# 5. 推送到 GitHub
git push -u origin main
```

---

##  步骤三：创建 Release 并发布软件

### 1. 访问 Releases 页面
在浏览器中打开：
```
https://github.com/KimHuang02/mp4-to-audio-converter/releases/new
```

### 2. 填写 Release 信息

**Tag version**: 
```
v1.1.0
```

**Release title**: 
```
v1.1.0 - 初始版本（集成 FFmpeg）
```

**Describe this release**: 
```markdown
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
1. 下载 `MP4 转音频转换器.exe`
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
MIT License - 自由使用、修改和分发
```

### 3. 上传可执行文件

**方式一：直接拖放**
1. 打开文件资源管理器
2. 导航到：`E:\python_code\mp4tomp3\dist`
3. 将 `MP4 转音频转换器.exe` 拖放到 Release 页面的附件区域

**方式二：点击上传**
1. 点击 "Attach binaries by dropping them here or selecting them."
2. 选择文件：`E:\python_code\mp4tomp3\dist\MP4 转音频转换器.exe`
3. 等待上传完成（文件约 217MB，可能需要几分钟）

### 4. 发布 Release
- 确认所有信息填写正确
- 点击 **"Publish release"** 按钮

---

## ✅ 验证结果

### 1. 检查仓库
访问：https://github.com/KimHuang02/mp4-to-audio-converter

应该看到：
- ✅ 所有源代码文件
- ✅ README.md 正确显示
- ✅ 最新的提交记录

### 2. 检查 Release
访问：https://github.com/KimHuang02/mp4-to-audio-converter/releases

应该看到：
- ✅ v1.1.0 版本
- ✅ 可执行文件已上传
- ✅ 下载链接可用

---

## 🔍 故障排除

### 问题 1: Token 认证失败
**错误**: `Bad credentials`

**解决方法**:
1. 检查 Token 是否正确复制（没有多余空格）
2. 确认 Token 有 `repo` 权限
3. 重新生成 Token 并重试

### 问题 2: 仓库已存在
**错误**: `Repository already exists`

**解决方法**:
这说明仓库已经创建过了，直接推送代码即可：
```powershell
git push -u origin main
```

### 问题 3: 上传 Release 失败
**错误**: 文件太大或上传超时

**解决方法**:
1. 确保网络连接稳定
2. 使用浏览器上传（不要使用命令行）
3. 如果文件确实太大，可以考虑：
   - 使用精简版 FFmpeg
   - 或提供下载链接（如百度网盘）

### 问题 4: Git 推送失败
**错误**: `Authentication failed`

**解决方法**:
```powershell
# 清除缓存的凭据
git credential-manager-core erase

# 重新推送（会提示输入凭据）
git push -u origin main

# 用户名：KimHuang02
# 密码：使用 GitHub Token（不是你的 GitHub 密码）
```

---

## 📊 完整命令参考

### 使用 GitHub CLI
```powershell
# 登录
gh auth login --with-token

# 创建仓库
gh repo create KimHuang02/mp4-to-audio-converter --public --source=. --remote=origin --push

# 查看仓库
gh repo view KimHuang02/mp4-to-audio-converter

# 创建 Release（命令行方式，可选）
gh release create v1.1.0 dist/"MP4 转音频转换器.exe" --title "v1.1.0 - 初始版本" --notes "详见 Release 页面"
```

### 使用 Git
```powershell
# 重命名分支
git branch -M main

# 添加远程仓库
git remote add origin https://github.com/KimHuang02/mp4-to-audio-converter.git

# 推送代码
git push -u origin main

# 强制推送（如果需要）
git push -f origin main
```

---

## 🎉 完成后的链接

- **仓库主页**: https://github.com/KimHuang02/mp4-to-audio-converter
- **Releases 页面**: https://github.com/KimHuang02/mp4-to-audio-converter/releases
- **代码提交记录**: https://github.com/KimHuang02/mp4-to-audio-converter/commits/main

---

## 💡 提示

1. **Token 安全**: 不要将 Token 提交到 Git 仓库或分享给他人
2. **文件大小**: 可执行文件约 217MB，上传可能需要时间
3. **公开仓库**: 创建时选择 Public，任何人都可以访问
4. **后续更新**: 修改代码后，直接 `git push` 即可更新

---

**祝你发布顺利！如有问题，请检查错误信息并参考上述故障排除部分。**
