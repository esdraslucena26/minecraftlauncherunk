@echo off
setlocal

REM Build script for Windows: generates MinecraftLauncher.exe using jpackage.
REM Requirements:
REM - JDK 17+ with javac, jar and jpackage in PATH

set APP_NAME=MinecraftLauncher
set MAIN_CLASS=MinecraftLauncher
set MAIN_JAR=%APP_NAME%.jar

where javac >nul 2>nul || (
  echo [ERRO] javac nao encontrado no PATH. Instale JDK 17+.
  exit /b 1
)

where jar >nul 2>nul || (
  echo [ERRO] jar nao encontrado no PATH. Instale JDK 17+.
  exit /b 1
)

where jpackage >nul 2>nul || (
  echo [ERRO] jpackage nao encontrado no PATH. Instale JDK 17+ completo.
  exit /b 1
)

if not exist out mkdir out
if not exist dist mkdir dist

javac -d out src\MinecraftLauncher.java
if errorlevel 1 (
  echo [ERRO] Falha ao compilar.
  exit /b 1
)

jar --create --file dist\%MAIN_JAR% -C out .
if errorlevel 1 (
  echo [ERRO] Falha ao criar JAR.
  exit /b 1
)

jpackage ^
  --type exe ^
  --name %APP_NAME% ^
  --input dist ^
  --main-jar %MAIN_JAR% ^
  --main-class %MAIN_CLASS% ^
  --dest dist ^
  --win-shortcut ^
  --win-menu

if errorlevel 1 (
  echo [ERRO] Falha ao gerar EXE com jpackage.
  exit /b 1
)

echo [OK] EXE gerado em dist\%APP_NAME%\
endlocal
