@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo === DEPLOIEMENT SITE PROFS EDUCPASS ===
echo.

if not exist ".git" (
    echo Premiere publication : initialisation du depot Git...
    git init
    git branch -M main
    git remote add origin https://github.com/Flasschoen/fiches-profs-2026.git
) else (
    echo Nettoyage verrous git...
    del /f /q ".git\index.lock" 2>nul
    del /f /q ".git\HEAD.lock" 2>nul
)

echo.
echo Copie de FICHIER PROFS 2026.html (dossier parent) vers index.html...
copy /Y "..\FICHIER PROFS 2026.html" "index.html" >nul

echo.
echo Ajout du fichier...
git rm --cached "FICHIER PROFS 2026.html" >nul 2>nul
git add index.html
git status

echo.
echo Commit...
git commit -m "Mise a jour site Profs"
echo (code: %ERRORLEVEL%)

echo.
echo Push vers GitHub...
git push -u origin main 2>&1
set PUSH_ERR=%ERRORLEVEL%

echo.
if %PUSH_ERR% EQU 0 (
    echo ===================================
    echo SUCCES - GitHub Pages se met a jour dans 1-2 minutes.
    echo Adresse du site : https://flasschoen.github.io/fiches-profs-2026/
    echo ===================================
) else (
    echo ===================================
    echo ERREUR PUSH - Code: %PUSH_ERR%
    echo Verifiez votre connexion et vos identifiants GitHub.
    echo ===================================
)
echo.
pause
