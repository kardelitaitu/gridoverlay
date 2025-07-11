Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create the overlay form
$form = New-Object System.Windows.Forms.Form
$form.Text = "GridOverlay"  # ✅ Sets title used in taskbar and window manager
$form.FormBorderStyle = 'None'
$form.TopMost = $true
$form.Activate()
$form.Focus()
$form.BringToFront()
$form.BackColor = [System.Drawing.Color]::Black
$form.Opacity = 0.15  # 20% overall opacity
$form.ShowInTaskbar = $true
$form.StartPosition = 'Manual'

$form.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon("GridOverlay.exe")

# Get full virtual desktop bounds
$screen = [System.Windows.Forms.SystemInformation]::VirtualScreen
$form.Location = [System.Drawing.Point]::new($screen.Left, $screen.Top)
$form.Bounds   = [System.Drawing.Rectangle]::FromLTRB($screen.Left, $screen.Top, $screen.Right, $screen.Bottom)

# Get primary screen bounds
$primary = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$coordLabel = New-Object System.Windows.Forms.Label
$coordLabel.ForeColor = [System.Drawing.Color]::White
$coordLabel.BackColor = [System.Drawing.Color]::Transparent
$coordLabel.Font = New-Object System.Drawing.Font("Verdana", 16, [System.Drawing.FontStyle]::Bold)
$coordLabel.AutoSize = $true
$coordLabel.Location = [System.Drawing.Point]::new(($primary.Width / 2) - 50, 10)  # Center-top with horizontal offset
$form.Controls.Add($coordLabel)

# Timer to update cursor position every 100ms
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 100
$timer.Add_Tick({
    $pos = [System.Windows.Forms.Cursor]::Position
    $coordLabel.Text = "X: $($pos.X)   Y: $($pos.Y)"
})
$timer.Start()



# Draw grid lines
$form.Add_Paint({
    $gfx = $_.Graphics
    $gridColor = [System.Drawing.Color]::Yellow  # fully opaque red
    $pen = New-Object System.Drawing.Pen($gridColor, 1)
    $step = 100

    for ($x = 0; $x -le $form.Width; $x += $step) {
        $gfx.DrawLine($pen, $x, 0, $x, $form.Height)
    }
    for ($y = 0; $y -le $form.Height; $y += $step) {
        $gfx.DrawLine($pen, 0, $y, $form.Width, $y)
    }

    $pen.Dispose()
})

# WinAPI declarations for click-through
if (-not ("WinAPI" -as [type])) {
    Add-Type @"
    using System;
    using System.Runtime.InteropServices;
    public class WinAPI {
        [DllImport("user32.dll")]
        public static extern int GetWindowLong(IntPtr hWnd, int nIndex);
        [DllImport("user32.dll")]
        public static extern int SetWindowLong(IntPtr hWnd, int nIndex, int dwNewLong);
    }
"@
}

# Apply layered + transparent styles
$GWL_EXSTYLE     = -20
$WS_EX_LAYERED   = 0x80000
$WS_EX_TRANSPARENT = 0x20

$handle = $form.Handle
$null = $handle




$currentStyle = [WinAPI]::GetWindowLong($handle, $GWL_EXSTYLE)
$newStyle     = $currentStyle -bor $WS_EX_LAYERED -bor $WS_EX_TRANSPARENT
[WinAPI]::SetWindowLong($handle, $GWL_EXSTYLE, $newStyle)

# Show the overlay
[System.Windows.Forms.Application]::Run($form)