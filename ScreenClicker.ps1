# Define Core Class, fun innit!
$cSource = @'
using System;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Windows.Forms;
public class Clicker
{
//https://msdn.microsoft.com/en-us/library/windows/desktop/ms646270(v=vs.85).aspx
[StructLayout(LayoutKind.Sequential)]
struct INPUT
{ 
    public int        type; // 0 = INPUT_MOUSE,
                            // 1 = INPUT_KEYBOARD
                            // 2 = INPUT_HARDWARE
    public MOUSEINPUT mi;
}

//https://msdn.microsoft.com/en-us/library/windows/desktop/ms646273(v=vs.85).aspx
[StructLayout(LayoutKind.Sequential)]
struct MOUSEINPUT
{
    public int    dx ;
    public int    dy ;
    public int    mouseData ;
    public int    dwFlags;
    public int    time;
    public IntPtr dwExtraInfo;
}

//This covers most use cases although complex mice may have additional buttons
//There are additional constants you can use for those cases, see the msdn page
const int MOUSEEVENTF_MOVED      = 0x0001 ;
const int MOUSEEVENTF_LEFTDOWN   = 0x0002 ;
const int MOUSEEVENTF_LEFTUP     = 0x0004 ;
const int MOUSEEVENTF_RIGHTDOWN  = 0x0008 ;
const int MOUSEEVENTF_RIGHTUP    = 0x0010 ;
const int MOUSEEVENTF_MIDDLEDOWN = 0x0020 ;
const int MOUSEEVENTF_MIDDLEUP   = 0x0040 ;
const int MOUSEEVENTF_WHEEL      = 0x0080 ;
const int MOUSEEVENTF_XDOWN      = 0x0100 ;
const int MOUSEEVENTF_XUP        = 0x0200 ;
const int MOUSEEVENTF_ABSOLUTE   = 0x8000 ;

const int screen_length = 0x10000 ;

//https://msdn.microsoft.com/en-us/library/windows/desktop/ms646310(v=vs.85).aspx
[System.Runtime.InteropServices.DllImport("user32.dll")]
extern static uint SendInput(uint nInputs, INPUT[] pInputs, int cbSize);

public static void LeftClickAtPoint(int x, int y)
{
    //Move the mouse
    INPUT[] input = new INPUT[3];
    input[0].mi.dx = x*(65535/System.Windows.Forms.Screen.PrimaryScreen.Bounds.Width);
    input[0].mi.dy = y*(65535/System.Windows.Forms.Screen.PrimaryScreen.Bounds.Height);
    input[0].mi.dwFlags = MOUSEEVENTF_MOVED | MOUSEEVENTF_ABSOLUTE;
    //Left mouse button down
    input[1].mi.dwFlags = MOUSEEVENTF_LEFTDOWN;
    //Left mouse button up
    input[2].mi.dwFlags = MOUSEEVENTF_LEFTUP;
    SendInput(3, input, Marshal.SizeOf(input[0]));
}
}
'@
Add-Type -TypeDefinition $cSource -ReferencedAssemblies System.Windows.Forms,System.Drawing

$wshell = New-Object -ComObject wscript.shell

# Bring to front and set focus to Phasmophobia.
# Update this to the name of the app you with to use, 
# obviously, the app must already be running.
$wshell.AppActivate('Phasmophobia')

# Sleep for half a second to allow App window to come into focus, it may be a bit blind :D
Start-Sleep -Milliseconds 500

# Array of coordinates (update these to your desired screen click positions,
# The current coordinates are for Phasmophobia add all items with the windows
# screen setting set to 1920x1080 with screen scaling at 100%.
$coords = @(
    @(900,354),
    @(900,384),
    @(900,414),
    @(900,445),
    @(900,470),
    @(900,500),
    @(900,530),
    @(900,557),
    @(900,588),
    @(900,620),
    @(900,648),
    @(900,677),
    @(900,709),
    @(900,736),
    @(900,765),
    @(900,765),

    @(1436,354),
    @(1436,384),
    @(1436,414),
    @(1436,445),
    @(1436,470),
    @(1436,500),
    @(1436,530)
)

# The pause in between clicks
$sleepyTime = 50

# Total clicks per coordinate, 
# Some apps cannot keep up and may miss a click, so 
# having more than one click per coord words well.
$totalClicks = 2

# Lets do this thang!
foreach ($xy in $coords)
{
    for ($n = 1; $n -le $totalClicks; $n++)
    {
        [Clicker]::LeftClickAtPoint($xy[0],$xy[1])
        Start-Sleep -Milliseconds $SleepyTime
    }
}

# Set focus to App again
$wshell = New-Object -ComObject wscript.shell
$wshell.AppActivate('Phasmophobia')

