@echo off
echo Installing required Ace3 libraries...
echo.

if not exist "..\sArena_Reloaded\Ace3" (
    echo ERROR: sArena_Reloaded not found in parent directory!
    echo Please make sure sArena_Reloaded is installed in the same AddOns folder.
    pause
    exit /b 1
)

echo Copying LibStub...
robocopy "..\sArena_Reloaded\Ace3\LibStub" "Libs\LibStub" /E /NFL /NDL /NJH /NJS /nc /ns /np

echo Copying CallbackHandler-1.0...
robocopy "..\sArena_Reloaded\Ace3\CallbackHandler-1.0" "Libs\CallbackHandler-1.0" /E /NFL /NDL /NJH /NJS /nc /ns /np

echo Copying AceDB-3.0...
robocopy "..\sArena_Reloaded\Ace3\AceDB-3.0" "Libs\AceDB-3.0" /E /NFL /NDL /NJH /NJS /nc /ns /np

echo.
echo Installation complete!
echo You can now use sArena DR Tracker.
echo.
pause

