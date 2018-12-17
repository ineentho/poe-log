#!/usr/bin/env playonlinux-bash
 
# https://www.playonlinux.com/sv/app-1366-Path_of_Exile.html
# CHANGELOG
# [contessaxd] (2018-03-07  21-55)
#   Updated download location
# [deanmsands3] (2018-03-12 19-49)
#   Installer is now EXE, removed msiexec from POL_Wine command.
 
# Date : 2012-08-16 21-12
# Last revision : 2018-03-12 19-49
# Wine version used : 1.4
# Distribution used to test : Gentoo x86_64
# Author : xyz
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Path of Exile"
PREFIX="pathofexile"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 1366
POL_SetupWindow_presentation "$TITLE" "Grinding Gear Games" "http://www.pathofexile.com" "xyz" "$PREFIX"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "4.0-rc1"
 
POL_System_TmpCreate "$PREFIX"
 
cd "$POL_System_TmpDir"
POL_Download "https://www.pathofexile.com/downloads/PathOfExileInstaller.exe"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$POL_System_TmpDir/PathOfExileInstaller.exe"
 
POL_System_TmpDelete
 
POL_Wine_OverrideDLL "native,builtin" "openal32"

# POL_Wine_OverrideDLL "native,builtin" "d3dcompiler_47"
# d3dcompiler_47 (native, builtin)

 
POL_Shortcut "PathOfExile.exe" "$TITLE" "$TITLE.png"
  
POL_SetupWindow_Close
exit
