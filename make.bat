@ECHO OFF

set current=%date:~2,2%%date:~5,2%%date:~8,2%
pushd %~dp0

if "%1" == "" goto make
if "%1" == "pages" goto pages
if "%1" == "clean" goto clean

:pages
pushd %~dp0\build\html
git add .
git commit -am "%current%"
git push -u origin gh-pages
popd
goto end

:clean
pushd %~dp0\build
rmdir /S/Q temp
del /q html\*.*
rmdir /S/Q html\_images
rmdir /S/Q html\_static
rmdir /S/Q html\checklist
popd
goto end

:make
sphinx-build -M html index build/temp/index
sphinx-build -M html checklist build/temp/checklist
Robocopy build\temp\index\html build\html /e
Robocopy build\temp\checklist\html build\html\checklist /e
del /q build\html\.buildinfo build\html\objects.inv build\html\checklist\.buildinfo build\html\checklist\objects.inv 

:end
popd
