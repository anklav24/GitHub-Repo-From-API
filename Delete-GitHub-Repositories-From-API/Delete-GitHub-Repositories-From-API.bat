cls
@echo off
@CHCP 1251
cls

echo Этот скрип нужен для автоматизации удаления проектов на GitHub / Проверено на Win 10 Версия 1803 x64
echo Для правильной работы скрип должен лежать на каталог выше каталога проекта.
echo.

:start

echo ============================================================
echo ВНИМАНИЕ! Этот скрип УДАЛЯЕТ репозитории GitHub БЕЗВОЗВРАТНО
echo ============================================================
echo.

REM Присваиваем переменным пустые значения чтобы пройти проверку ввода если пользователь ничего не введет.
set ProjectName=""
set /p ProjectName="1. Введите название проекта: "

set GitProfileName=""
set /p GitProfileName="2. Введите имя вашего профиля на GitHub в формате "anklav24" (Без кавычек): "

set GitHubTOKEN=""
set /p GitHubTOKEN="3. Введите токен от GitHub: "
echo.

echo Получить токен можно в личном кабинете GitHub.
echo https://github.com/settings/tokens
echo.

REM Проверяем ввод, если пустой присваиваем дефолтные значения на свой вкус
if %ProjectName%=="" (set ProjectName=New-Project)
if %GitProfileName%=="" (set GitProfileName=Anklav24)
if %GitHubTOKEN%=="" (set GitHubTOKEN=YOUR_TOKEN)

REM echo Если валятся ошибки JSON то на Windows надо экранировать кавычки символом "\"
REM echo If you are a windows system, you need to modify the json format.
REM echo Examples: '{"token":"asdfas"}' replaced by  "{\"Hello\":\"Karl\"}"
REM echo.

curl -i -X DELETE -H "Authorization: token %GitHubTOKEN%" https://api.github.com/repos/%GitProfileName%/%ProjectName%

:question
REM Не большой луп который спрашивает пользователя повторить ли скрипт
set EndSctipt=""
set /p EndSctipt="Удалить еще репозитории? (Да/Нет): "
REM Ключ /i сравнивает без учета регистра
if /i "%EndSctipt%"=="Да" (echo. && goto start)
if /i "%EndSctipt%"=="Lf" (echo. && goto start)
if /i "%EndSctipt%"=="Н" (echo. && goto start)
if /i "%EndSctipt%"=="Y" (echo. && goto start)
if /i "%EndSctipt%"=="Yes" (echo. && goto start)
if /i "%EndSctipt%"=="Нет" (exit)
if /i "%EndSctipt%"=="Ytn" (exit)
if /i "%EndSctipt%"=="Т" (exit)
if /i "%EndSctipt%"=="N" (exit)
if /i "%EndSctipt%"=="No" (exit)
if /i "%EndSctipt%" NEQ "" (goto question)