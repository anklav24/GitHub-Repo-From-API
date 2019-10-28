cls
@echo off
@CHCP 1251
cls

echo ���� ����� ����� ��� ������������� �������� �������� �� GitHub / ��������� �� Win 10 ������ 1803 x64
echo ��� ���������� ������ ����� ������ ������ �� ������� ���� �������� �������.
echo.

:start

echo ============================================================
echo ��������! ���� ����� ������� ����������� GitHub ������������
echo ============================================================
echo.

REM ����������� ���������� ������ �������� ����� ������ �������� ����� ���� ������������ ������ �� ������.
set ProjectName=""
set /p ProjectName="1. ������� �������� �������: "

set GitProfileName=""
set /p GitProfileName="2. ������� ��� ������ ������� �� GitHub � ������� "anklav24" (��� �������): "

set GitHubTOKEN=""
set /p GitHubTOKEN="3. ������� ����� �� GitHub: "
echo.

echo �������� ����� ����� � ������ �������� GitHub.
echo https://github.com/settings/tokens
echo.

REM ��������� ����, ���� ������ ����������� ��������� �������� �� ���� ����
if %ProjectName%=="" (set ProjectName=New-Project)
if %GitProfileName%=="" (set GitProfileName=Anklav24)
if %GitHubTOKEN%=="" (set GitHubTOKEN=YOUR_TOKEN)

REM echo ���� ������� ������ JSON �� �� Windows ���� ������������ ������� �������� "\"
REM echo If you are a windows system, you need to modify the json format.
REM echo Examples: '{"token":"asdfas"}' replaced by  "{\"Hello\":\"Karl\"}"
REM echo.

curl -i -X DELETE -H "Authorization: token %GitHubTOKEN%" https://api.github.com/repos/%GitProfileName%/%ProjectName%

:question
REM �� ������� ��� ������� ���������� ������������ ��������� �� ������
set EndSctipt=""
set /p EndSctipt="������� ��� �����������? (��/���): "
REM ���� /i ���������� ��� ����� ��������
if /i "%EndSctipt%"=="��" (echo. && goto start)
if /i "%EndSctipt%"=="Lf" (echo. && goto start)
if /i "%EndSctipt%"=="�" (echo. && goto start)
if /i "%EndSctipt%"=="Y" (echo. && goto start)
if /i "%EndSctipt%"=="Yes" (echo. && goto start)
if /i "%EndSctipt%"=="���" (exit)
if /i "%EndSctipt%"=="Ytn" (exit)
if /i "%EndSctipt%"=="�" (exit)
if /i "%EndSctipt%"=="N" (exit)
if /i "%EndSctipt%"=="No" (exit)
if /i "%EndSctipt%" NEQ "" (goto question)