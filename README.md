# MP4 转音频转换器

一个简单易用的视频转音频提取工具，支持多种音频格式输出。

## 功能特点

- 🎯 支持多种视频格式输入（MP4、AVI、MKV、MOV、WMV、FLV）
- 🎵 支持多种音频格式输出（MP3、WAV、AAC、FLAC、OGG、M4A、WMA）
- 🎚️ 可调节音质（128k、192k、256k、320k）
- 📊 实时转换进度显示
- 🖥️ 简洁友好的 Windows 界面
- ⚡ 多线程处理，不阻塞界面
- 📦 **已集成 FFmpeg，无需单独安装**

## 快速开始

### 方法一：使用可执行文件（推荐）

1. **下载程序**
   - 从 [Releases](https://github.com/YOUR_USERNAME/mp4-to-audio-converter/releases) 下载最新版本
   - 或从 `dist` 目录获取已编译的 EXE 文件

2. **运行程序**
   - 双击 `MP4 转音频转换器.exe`
   - **无需安装 FFmpeg，程序已内置**

3. **开始转换**
   - 选择视频文件
   - 选择输出格式和音质
   - 点击"开始转换"

### 方法二：从源代码运行

```bash
# 1. 克隆仓库
git clone https://github.com/YOUR_USERNAME/mp4-to-audio-converter.git
cd mp4-to-audio-converter

# 2. 运行程序（需要 FFmpeg）
python converter.py
```

**注意**：从源代码运行需要单独安装 FFmpeg，或确保 `ffmpeg` 文件夹存在于项目目录中。

## 打包说明

### 打包为单个可执行文件（包含 FFmpeg）

```bash
# Windows
build_with_ffmpeg.bat

# 或手动执行
python -m PyInstaller --onefile --windowed --name "MP4 转音频转换器" --add-data "ffmpeg;ffmpeg" converter.py
```

打包完成后，可执行文件位于 `dist\MP4 转音频转换器.exe`，大小约 200MB（包含完整 FFmpeg）。

### 打包（不包含 FFmpeg）

```bash
# Windows
build.bat
```

此方式打包的 EXE 文件较小（约 20MB），但需要与 `ffmpeg` 文件夹一起分发。

## 支持的格式

### 输入格式
- MP4 (.mp4)
- AVI (.avi)
- MKV (.mkv)
- MOV (.mov)
- WMV (.wmv)
- FLV (.flv)

### 输出格式
- **MP3** - 最常用的音频格式，兼容性好
- **WAV** - 无损音频格式，音质最佳
- **AAC** - 高效音频编码，Apple 设备常用
- **FLAC** - 无损压缩音频格式
- **OGG** - 开源免费音频格式
- **M4A** - Apple 设备音频格式
- **WMA** - Windows 媒体音频格式

## 音质说明

- **128k** - 标准音质，文件较小
- **192k** - 良好音质，推荐默认选项
- **256k** - 高质量音质
- **320k** - 最佳音质，文件最大

## 技术说明

### 程序架构
- **GUI 框架**: Python tkinter
- **转换引擎**: FFmpeg
- **打包工具**: PyInstaller
- **Python 版本**: 3.6+

### FFmpeg 集成方式

程序会自动检测 FFmpeg：
1. 优先使用内置的 `ffmpeg` 文件夹中的 `ffmpeg.exe`
2. 如果不存在，则使用系统 PATH 中的 `ffmpeg`

打包时使用 `--add-data "ffmpeg;ffmpeg"` 参数将 FFmpeg 集成到 EXE 中。

### 目录结构

```
mp4tomp3/
├── converter.py              # 主程序
├── ffmpeg/                   # FFmpeg 可执行文件（打包时集成到 EXE）
│   ├── ffmpeg.exe
│   ├── ffplay.exe
│   └── ffprobe.exe
├── dist/                     # 打包输出目录
│   └── MP4 转音频转换器.exe
├── build.bat                 # 打包脚本（不含 FFmpeg）
├── build_with_ffmpeg.bat     # 打包脚本（含 FFmpeg）
├── README.md                 # 使用说明
└── requirements.txt          # 依赖说明
```

## 常见问题

### Q: 程序提示"未检测到 FFmpeg"
A: 
- **使用 EXE 版本**: 确保从官方渠道下载完整版本
- **源代码运行**: 确保 `ffmpeg` 文件夹存在于程序同目录
- 或从 https://ffmpeg.org/download.html 下载 FFmpeg 并添加到 PATH

### Q: 转换失败
A: 检查以下几点：
- 确认输入文件没有损坏
- 检查磁盘空间是否充足
- 尝试重新选择输出格式

### Q: 转换速度慢
A: 转换速度取决于：
- 视频文件大小和时长
- 电脑性能
- 选择的音质（音质越高转换越慢）

### Q: EXE 文件太大
A: 由于集成了 FFmpeg，文件较大（约 200MB）。这是正常的，因为：
- 包含了完整的 FFmpeg 功能
- 无需用户单独安装
- 开箱即用，方便分发

如需减小体积，可以：
- 使用精简版 FFmpeg（只包含必要的编码器）
- 或打包时不包含 FFmpeg，让用户自行安装

## 开发说明

### 本地开发环境

```bash
# 1. 克隆仓库
git clone https://github.com/YOUR_USERNAME/mp4-to-audio-converter.git

# 2. 安装依赖（仅开发需要）
pip install pyinstaller

# 3. 运行程序
python converter.py
```

### 贡献代码

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

## 更新日志

### v1.1.0
- ✅ 集成 FFmpeg 到程序中
- ✅ 无需单独安装 FFmpeg
- ✅ 自动下载 FFmpeg 功能
- ✅ 优化打包脚本

### v1.0.0
- 初始版本发布
- 支持 7 种音频格式输出
- 支持 4 档音质选择
- 实时进度显示

## 许可证

本项目使用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件

## 致谢

- [FFmpeg](https://ffmpeg.org/) - 强大的音视频转换工具
- [PyInstaller](https://www.pyinstaller.org/) - Python 打包工具

---

**作者**: KimHuang  
**创建时间**: 2026-04-07  
**版本**: v1.1.0
