import tkinter as tk
from tkinter import filedialog, messagebox, ttk
import subprocess
import os
import threading
from pathlib import Path


class AudioConverterApp:
    def __init__(self, root):
        self.root = root
        self.root.title("MP4 转音频转换器")
        self.root.geometry("600x400")
        self.root.resizable(False, False)
        
        self.input_file = None
        self.converting = False
        
        self.setup_ui()
        self.check_ffmpeg()
    
    def setup_ui(self):
        main_frame = ttk.Frame(self.root, padding="20")
        main_frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        
        self.root.columnconfigure(0, weight=1)
        self.root.rowconfigure(0, weight=1)
        main_frame.columnconfigure(1, weight=1)
        
        title_label = ttk.Label(
            main_frame, 
            text="MP4 转音频转换器", 
            font=('Microsoft YaHei UI', 16, 'bold')
        )
        title_label.grid(row=0, column=0, columnspan=3, pady=(0, 20))
        
        file_frame = ttk.LabelFrame(main_frame, text="文件选择", padding="10")
        file_frame.grid(row=1, column=0, columnspan=3, sticky=(tk.W, tk.E), pady=(0, 15))
        file_frame.columnconfigure(1, weight=1)
        
        ttk.Label(file_frame, text="输入文件:").grid(row=0, column=0, sticky=tk.W, padx=(0, 10))
        
        self.file_entry = ttk.Entry(file_frame, state='readonly')
        self.file_entry.grid(row=0, column=1, sticky=(tk.W, tk.E), padx=(0, 10))
        
        browse_btn = ttk.Button(file_frame, text="浏览...", command=self.browse_file)
        browse_btn.grid(row=0, column=2)
        
        format_frame = ttk.LabelFrame(main_frame, text="转换设置", padding="10")
        format_frame.grid(row=2, column=0, columnspan=3, sticky=(tk.W, tk.E), pady=(0, 15))
        format_frame.columnconfigure(1, weight=1)
        
        ttk.Label(format_frame, text="输出格式:").grid(row=0, column=0, sticky=tk.W, padx=(0, 10))
        
        self.format_var = tk.StringVar(value="mp3")
        formats = ["mp3", "wav", "aac", "flac", "ogg", "m4a", "wma"]
        self.format_combo = ttk.Combobox(
            format_frame, 
            textvariable=self.format_var, 
            values=formats,
            state="readonly",
            width=15
        )
        self.format_combo.grid(row=0, column=1, sticky=tk.W)
        
        ttk.Label(format_frame, text="音质:").grid(row=0, column=2, sticky=tk.W, padx=(20, 10))
        
        self.quality_var = tk.StringVar(value="192k")
        qualities = ["128k", "192k", "256k", "320k"]
        self.quality_combo = ttk.Combobox(
            format_frame, 
            textvariable=self.quality_var, 
            values=qualities,
            state="readonly",
            width=10
        )
        self.quality_combo.grid(row=0, column=3, sticky=tk.W)
        
        progress_frame = ttk.LabelFrame(main_frame, text="转换进度", padding="10")
        progress_frame.grid(row=3, column=0, columnspan=3, sticky=(tk.W, tk.E), pady=(0, 15))
        progress_frame.columnconfigure(0, weight=1)
        
        self.progress_var = tk.StringVar(value="就绪")
        progress_label = ttk.Label(progress_frame, textvariable=self.progress_var)
        progress_label.grid(row=0, column=0, sticky=tk.W, pady=(0, 5))
        
        self.progress_bar = ttk.Progressbar(
            progress_frame, 
            mode='indeterminate',
            length=500
        )
        self.progress_bar.grid(row=1, column=0, sticky=(tk.W, tk.E))
        
        btn_frame = ttk.Frame(main_frame)
        btn_frame.grid(row=4, column=0, columnspan=3)
        
        self.convert_btn = ttk.Button(
            btn_frame, 
            text="开始转换", 
            command=self.start_conversion,
            width=15
        )
        self.convert_btn.grid(row=0, column=0, padx=(0, 10))
        
        clear_btn = ttk.Button(
            btn_frame, 
            text="清除", 
            command=self.clear_all,
            width=15
        )
        clear_btn.grid(row=0, column=1)
        
        self.status_label = ttk.Label(
            main_frame, 
            text="", 
            foreground="green",
            font=('Microsoft YaHei UI', 9)
        )
        self.status_label.grid(row=5, column=0, columnspan=3, pady=(10, 0))
    
    def check_ffmpeg(self):
        try:
            result = subprocess.run(
                ['ffmpeg', '-version'],
                capture_output=True,
                text=True,
                timeout=5
            )
            if result.returncode == 0:
                self.status_label.config(text="✓ FFmpeg 已检测到", foreground="green")
            else:
                self.show_ffmpeg_error()
        except (FileNotFoundError, subprocess.TimeoutExpired):
            self.show_ffmpeg_error()
    
    def show_ffmpeg_error(self):
        self.status_label.config(text="✗ 未检测到 FFmpeg，请安装 FFmpeg 并添加到系统 PATH", foreground="red")
        messagebox.showerror(
            "FFmpeg 未找到",
            "未检测到 FFmpeg！\n\n"
            "请安装 FFmpeg:\n"
            "1. 访问 https://ffmpeg.org/download.html\n"
            "2. 下载并安装 FFmpeg\n"
            "3. 将 FFmpeg 添加到系统 PATH 环境变量\n"
            "4. 重启程序"
        )
    
    def browse_file(self):
        file_path = filedialog.askopenfilename(
            title="选择视频文件",
            filetypes=[
                ("视频文件", "*.mp4 *.avi *.mkv *.mov *.wmv *.flv"),
                ("所有文件", "*.*")
            ]
        )
        if file_path:
            self.input_file = file_path
            self.file_entry.config(state='normal')
            self.file_entry.delete(0, tk.END)
            self.file_entry.insert(0, file_path)
            self.file_entry.config(state='readonly')
            self.progress_var.set("文件已选择，准备转换")
    
    def start_conversion(self):
        if not self.input_file:
            messagebox.showwarning("警告", "请先选择一个视频文件！")
            return
        
        if self.converting:
            return
        
        output_format = self.format_var.get()
        quality = self.quality_var.get()
        
        output_path = Path(self.input_file).with_suffix(f'.{output_format}')
        
        if os.path.exists(output_path):
            if not messagebox.askyesno(
                "文件已存在", 
                f"文件 {output_path.name} 已存在，是否覆盖？"
            ):
                return
        
        self.converting = True
        self.convert_btn.config(state='disabled')
        self.progress_bar.start(10)
        self.progress_var.set("正在转换中...")
        self.status_label.config(text="")
        
        thread = threading.Thread(
            target=self.convert_audio,
            args=(self.input_file, str(output_path), output_format, quality),
            daemon=True
        )
        thread.start()
    
    def convert_audio(self, input_path, output_path, output_format, quality):
        try:
            if output_format == 'mp3':
                cmd = [
                    'ffmpeg', '-i', input_path,
                    '-vn',
                    '-acodec', 'libmp3lame',
                    '-b:a', quality,
                    '-y',
                    output_path
                ]
            elif output_format == 'wav':
                cmd = [
                    'ffmpeg', '-i', input_path,
                    '-vn',
                    '-acodec', 'pcm_s16le',
                    '-ar', '44100',
                    '-ac', '2',
                    '-y',
                    output_path
                ]
            elif output_format == 'aac':
                cmd = [
                    'ffmpeg', '-i', input_path,
                    '-vn',
                    '-acodec', 'aac',
                    '-b:a', quality,
                    '-y',
                    output_path
                ]
            elif output_format == 'flac':
                cmd = [
                    'ffmpeg', '-i', input_path,
                    '-vn',
                    '-acodec', 'flac',
                    '-y',
                    output_path
                ]
            elif output_format == 'ogg':
                cmd = [
                    'ffmpeg', '-i', input_path,
                    '-vn',
                    '-acodec', 'libvorbis',
                    '-b:a', quality,
                    '-y',
                    output_path
                ]
            elif output_format == 'm4a':
                cmd = [
                    'ffmpeg', '-i', input_path,
                    '-vn',
                    '-acodec', 'aac',
                    '-b:a', quality,
                    '-y',
                    output_path
                ]
            elif output_format == 'wma':
                cmd = [
                    'ffmpeg', '-i', input_path,
                    '-vn',
                    '-acodec', 'wmav2',
                    '-b:a', quality,
                    '-y',
                    output_path
                ]
            else:
                cmd = [
                    'ffmpeg', '-i', input_path,
                    '-vn',
                    '-acodec', 'libmp3lame',
                    '-b:a', quality,
                    '-y',
                    output_path
                ]
            
            process = subprocess.Popen(
                cmd,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                universal_newlines=True
            )
            
            _, stderr = process.communicate()
            
            if process.returncode == 0:
                self.root.after(0, self.conversion_success, output_path)
            else:
                self.root.after(0, self.conversion_error, stderr)
        
        except Exception as e:
            self.root.after(0, self.conversion_error, str(e))
    
    def conversion_success(self, output_path):
        self.converting = False
        self.convert_btn.config(state='normal')
        self.progress_bar.stop()
        self.progress_var.set("转换完成！")
        self.status_label.config(text=f"✓ 已保存至：{output_path}", foreground="green")
        
        messagebox.showinfo(
            "转换成功",
            f"音频提取成功！\n\n"
            f"输出文件：{output_path}\n"
            f"格式：{self.format_var.get().upper()}\n"
            f"音质：{self.quality_var.get()}"
        )
        
        if messagebox.askyesno("打开文件夹", "是否打开输出文件所在文件夹？"):
            os.startfile(os.path.dirname(output_path))
    
    def conversion_error(self, error_msg):
        self.converting = False
        self.convert_btn.config(state='normal')
        self.progress_bar.stop()
        self.progress_var.set("转换失败")
        self.status_label.config(text="✗ 转换失败", foreground="red")
        
        messagebox.showerror(
            "转换失败",
            f"转换过程中发生错误：\n\n{error_msg}"
        )
    
    def clear_all(self):
        if self.converting:
            messagebox.showwarning("警告", "正在转换中，请稍候...")
            return
        
        self.input_file = None
        self.file_entry.config(state='normal')
        self.file_entry.delete(0, tk.END)
        self.file_entry.config(state='readonly')
        self.format_var.set("mp3")
        self.quality_var.set("192k")
        self.progress_var.set("就绪")
        self.progress_bar.stop()
        self.status_label.config(text="")


def main():
    root = tk.Tk()
    
    try:
        root.iconbitmap(default='')
    except:
        pass
    
    app = AudioConverterApp(root)
    root.mainloop()


if __name__ == "__main__":
    main()
