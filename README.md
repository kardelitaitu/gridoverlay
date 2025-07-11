# 🧭 GridOverlay v1.0.1 — Enhanced Precision Display Utility

A lightweight, transparent overlay tool for developers, designers, and productivity enthusiasts who need real-time cursor feedback and precise visual alignment.

---

## ✨ Features

- 🔲 **Customizable Grid Overlay**  
  Displays evenly spaced lines across all monitors for layout alignment.

- 🖱️ **Live Cursor Coordinates**  
  Shows current cursor position (`X:` / `Y:`) at the top-center of the primary display.

- 🖥️ **Multi-Monitor Support**  
  Automatically spans across all connected screens using `VirtualScreen` bounds.

- 🪟 **Click-Through Interface**  
  Does not obstruct window interaction — works seamlessly over other apps.

- 🎨 **Subtle Transparency**  
  Configurable opacity for minimal visual interference.

- 🧼 **Console-Silent Execution**  
  No console window or numeric artifacts when compiled to `.exe`.

- 📌 **Always on Top**  
  Stays visually dominant, even during full-screen workflows.

---

## ⚠️ Requirements

- ✅ **Windows OS only**  
  Compatible with Windows 10, 11 (PowerShell & .NET Framework required)

- ✅ **Admin permissions recommended**  
  For silent execution and grid overlay on secure desktops

- ✅ **PowerShell 5.0+ recommended**  
  Or use compiled `.exe` for standalone use

---

## 🚀 Installation & Usage

1. Download `gridoverlay.ps1` or `gridoverlay.exe`.
2. For script:  
   Run using PowerShell in desktop folder:

   ```powershell
   C:\Users\<YourUsername>\Desktop\gridoverlay.ps1
   ```

3. For `.exe`:  
   Double-click or create a shortcut. Optionally pin it to the taskbar.

---

## 🔧 Compilation (Optional)

Use [PS2EXE](https://github.com/MScholtes/PS2EXE) to compile your `.ps1` into `.exe`:

```powershell
Invoke-PS2EXE -InputFile .\gridoverlay.ps1 -OutputFile .\gridoverlay.exe -IconFile .\GridOverlay.ico -NoConsole
```

---

## 📄 License & Credits

This tool is released under MIT License.  
Concept and scripting by **Norino** — built for precision, privacy, and practicality.

---

Known bug:

Some pop up if compiled to .exe
