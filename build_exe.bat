@echo off
setlocal

REM Build script for Windows: generates MinecraftLauncher.exe (app image) using jpackage.
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

REM Gera um app-image com executável direto (.exe), sem instalador.
jpackage ^
  --type app-image ^
  --name %APP_NAME% ^
  --input dist ^
  --main-jar %MAIN_JAR% ^
  --main-class %MAIN_CLASS% ^
  --dest dist

if errorlevel 1 (
  echo [ERRO] Falha ao gerar EXE com jpackage.
  exit /b 1
)

if exist dist\%APP_NAME%\%APP_NAME%.exe (
  copy /Y dist\%APP_NAME%\%APP_NAME%.exe dist\%APP_NAME%.exe >nul
)

echo [OK] Executavel gerado: dist\%APP_NAME%\%APP_NAME%.exe
echo [OK] Atalho copiado para: dist\%APP_NAME%.exe
endlocal
