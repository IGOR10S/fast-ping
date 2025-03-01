@echo off
setlocal enabledelayedexpansion

:: Controlla se è stato passato un file con gli indirizzi IP
if "%~1"=="" (
    echo Usage: .\%~nx0 .\name_file.txt
    echo NOTE: The file must contain one IP/Hostname per line.
    exit /b
)

:: Controlla se il file esiste
if not exist "%~1" (
    echo The file %~1 does not exist.
    exit /b
)

:: Crea o svuota il file di report
> fast_report.txt echo Ping results:
echo ---------------------------------- >> fast_report.txt

set count=1

:: Legge gli indirizzi IP dal file e li pinga uno a uno
for /f "usebackq tokens=*" %%I in ("%~1") do (
    echo [!count!] Pinging "%%I" ...
    ping "%%I" -n 4 -w 2000 > nul
    if errorlevel 1 (
        echo     UNREACHABLE
        echo UNREACHABLE - %%I >> fast_report.txt
    ) else (
        echo     REACHABLE
        echo REACHABLE - %%I >> fast_report.txt
    )
    echo -------------------------
    set /a count+=1
)

echo Report saved in fast_report.txt
pause
