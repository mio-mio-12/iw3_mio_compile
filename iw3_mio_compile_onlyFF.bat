@echo off
set "source=%~dp0"

for /D %%P in ("%source%\*") do (
for /D %%F in ("%%P\*") do (
xcopy "%%~fF\*" "%source%" /E /I /Y
)
)


@echo off
REM Name of the merged CSV
set "output=mod.csv"

REM Start fresh
if exist "%output%" del "%output%"

REM Recurse through every subfolder for mod.csv…
for /r %%F in (mod.csv) do (
    echo Merging %%~F
    REM …and if we've already written at least one file, insert exactly one blank line
    if exist "%output%" (
        >>"%output%" echo(
    )
    REM then dump this file’s contents
    type "%%F" >> "%output%"
)

echo.
echo Done!  Combined file created: %output%


@echo off

cd %source%

xcopy english ..\..\raw\english\ /SY
xcopy images ..\..\raw\images\ /SY
xcopy weapons ..\..\raw\weapons\ /SY
xcopy material_properties ..\..\raw\material_properties\ /SY
xcopy materials ..\..\raw\materials\ /SY
xcopy maps ..\..\raw\maps\ /SY
xcopy mp ..\..\raw\mp\ /SY
xcopy shock ..\..\raw\shock\ /SY
xcopy sound ..\..\raw\sound\ /SY
xcopy soundaliases ..\..\raw\soundaliases\ /SY
xcopy ui ..\..\raw\ui\ /SY
xcopy ui_mp ..\..\raw\ui_mp\ /SY
xcopy xmodel ..\..\raw\xmodel\ /SY
xcopy xanim ..\..\raw\xanim\ /SY
xcopy xmodelparts ..\..\raw\xmodelparts\ /SY
xcopy xmodelpieces ..\..\raw\xmodelpieces\ /SY
xcopy xmodelsurfs ..\..\raw\xmodelsurfs\ /SY

copy mod.csv ..\..\zone_source /Y

cd ..\..\bin
linker_pc.exe -language english -compress -cleanup mod -verbose

cd ..\mods\MMMguns
copy ..\..\zone\english\mod.ff

cd %source%

for %%D in (
images
material_properties
materials
sound
soundaliases
weapons
xanim
xmodel
xmodelparts
xmodelsurfs
xmodelpieces
) do (rd /S /Q "%%D")
del /q mod.csv

pause
