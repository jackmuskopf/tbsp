# used from https://powershell.one/tricks/input-devices/detect-key-press
# and https://renenyffenegger.ch/notes/Windows/PowerShell/examples/WinAPI/modify-mouse-speed
# or python https://stackoverflow.com/questions/45100234/change-mouse-pointer-speed-in-windows-using-python

param (
  [validateRange(1,20)]
  [int] $newSpeed
)

set-strictMode -version latest

$winApi = add-type -name user32 -namespace tq84 -passThru -memberDefinition '
[DllImport("user32.dll")]
public static extern bool SystemParametersInfo(
  uint uiAction,
  uint uiParam ,
  uint pvParam ,
  uint fWinIni
);
'

$SPI_SETMOUSESPEED = 0x0071

"MouseSensitivity before WinAPI call:  $((get-itemProperty 'hkcu:\Control Panel\Mouse').MouseSensitivity)"

$null = $winApi::SystemParametersInfo($SPI_SETMOUSESPEED, 0, $newSpeed, 0)

#
##    Calling SystemParametersInfo() does not permanently store the modification
#    of the mouse speed. It needs to be changed in the registry as well
#    #
#    "MouseSensitivity after WinAPI call:  $((get-itemProperty 'hkcu:\Control Panel\Mouse').MouseSensitivity)"
#
#    set-itemProperty 'hkcu:\Control Panel\Mouse' -name MouseSensitivity -value $newSpeed
