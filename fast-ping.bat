@echo off
setlocal enabledelayedexpansion

:: Controlla se è stato passato un file con gli indirizzi IP
if "%~1"=="" (
    echo Usage: %~nx0 fast_ip.txt
    echo The file must contain one IP per line.
    pause
    exit /b
)

:: Controlla se il file esiste
if not exist "%~1" (
    echo The file %~1 does not exist.
    pause
    exit /b
)

:: Crea o svuota il file di report
> fast_report.txt echo Ping results:
echo ---------------------------------- >> fast_report.txt

:: Legge gli indirizzi IP dal file e li pinga uno a uno
for /f "usebackq tokens=*" %%I in ("%~1") do (
    echo Pinging %%I ...
    ping %%I -n 4 -w 2000 > nul
    if errorlevel 1 (
        echo %%I - UNREACHABLE >> fast_report.txt
        echo %%I - UNREACHABLE
    ) else (
        echo %%I - REACHABLE >> fast_report.txt
        echo %%I - REACHABLE
    )
    echo -------------------------
)

echo Report saved in fast_report.txt
pause
