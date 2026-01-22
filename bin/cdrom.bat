@echo off
setlocal enableextensions

set CDROM_ID=FDCD0001

if exist \bin\shsucdx.com (
  \bin\shsucdx.com /D:%CDROM_ID% /L:Z
  goto done
)
if exist \shsucdx.com (
  \shsucdx.com /D:%CDROM_ID% /L:Z
  goto done
)
if exist \bin\mscdex.exe (
  \bin\mscdex.exe /D:%CDROM_ID% /L:Z
  goto done
)
if exist \mscdex.exe (
  \mscdex.exe /D:%CDROM_ID% /L:Z
  goto done
)

echo CD-ROM redirector not found. Copy SHSUCDX.COM or MSCDEX.EXE to \bin.

done
endlocal
