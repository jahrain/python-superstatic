@echo off
SET PYTHON_VERSION=2.7.8
REM SET PATH=%CD%\tools\NASM;%CD%\tools\7-Zip;%CD%\tools\Perl\bin;%PATH%
SET LIB_OUTPUT_DIR=%CD%\python-static-%PYTHON_VERSION%\lib
SET INCLUDE_OUTPUT_DIR=%CD%\python-static-%PYTHON_VERSION%\include
SET MODULES_OUTPUT_DIR=%CD%\python-static-%PYTHON_VERSION%\modules
call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat"
REM nmake clean
nmake

del /s /f /q "%LIB_OUTPUT_DIR%"
del /s /f /q "%INCLUDE_OUTPUT_DIR%"
del /s /f /q "%MODULES_OUTPUT_DIR%"

mkdir "%LIB_OUTPUT_DIR%"
mkdir "%INCLUDE_OUTPUT_DIR%"
mkdir "%MODULES_OUTPUT_DIR%"

xcopy /Y /E /F /I "%CD%\Python-%PYTHON_VERSION%\Include" "%INCLUDE_OUTPUT_DIR%"
xcopy /Y /E /F /I "%CD%\Python-%PYTHON_VERSION%\Lib" "%MODULES_OUTPUT_DIR%"
copy /Y "%CD%\Python-%PYTHON_VERSION%\PCBuild\pythonembed.lib" "%LIB_OUTPUT_DIR%"

pushd "%MODULES_OUTPUT_DIR%"
for /d /r %%G in ("*test*") do del /s /q /f "%%G"
for /d /r %%G in ("*test*") do rmdir /s /q "%%G"
for /d /r %%G in ("plat-*") do del /s /q /f "%%G"
for /d /r %%G in ("plat-*") do rmdir /s /q "%%G"
popd