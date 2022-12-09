@ECHO OFF

pushd %~dp0
if "%1" == "" goto make
if "%1" == "clean" goto clean

:clean
rmdir /S/Q _build
goto end

:make
sphinx-build -M html index _build/temp/index
sphinx-build -M html checklist _build/temp/checklist
Robocopy _build\temp\index\html _build\html /e
Robocopy _build\temp\checklist\html _build\html\checklist /e
del /q _build\html\.buildinfo _build\html\objects.inv _build\html\checklist\.buildinfo _build\html\checklist\objects.inv 

:end
popd
