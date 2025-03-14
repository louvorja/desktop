@echo off
echo Mensagem
set /p  texto=

git add .
git commit -m "%texto%"
git push origin main