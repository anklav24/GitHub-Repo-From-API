cls
@echo off
@CHCP 1251
cls

:start

echo =============================================================================================================
echo Этот скрипт нужен для автоматизации добавления чистого проекта на GitHub / Проверено на Win 10 Версия 1803 x64
echo Для правильной работы скрипт должен лежать на каталог выше каталога проекта.
echo Не забудьте установить Git for Windows на ваш ПК.
echo =============================================================================================================
echo.

REM Присваиваем переменным пустые значения чтобы пройти проверку ввода если пользователь ничего не введет.
set ProjectName=""
set /p ProjectName="1. Введите название проекта: "

set CommitComment=""
set /p CommitComment="2. Введите комментарий к коммиту: "

set GitProfileName=""
set /p GitProfileName="3. Введите имя вашего профиля на GitHub в формате "anklav24" (Без кавычек): "

set GitHubTOKEN=""
set /p GitHubTOKEN="4. Введите токен от GitHub: "
echo.

echo Получить токен можно в личном кабинете GitHub.
echo https://github.com/settings/tokens
echo.

echo ==================================
echo Рекомендации по оформленю коммитов
echo ==================================
echo.

echo Стараться соблюдать правило: один коммит - одна решенная задача!
echo.

echo Как правило, ваши сообщения должны начинаться кратким однострочным описанием не 
echo более 50 символов, затем должна идти пустая строка, после которой следует более 
echo детальное описание. Проект Git требует, чтобы детальное описание включало вашу мотивацию 
echo при внесении изменения и сравнение с текущей реализацией - это хороший пример для 
echo подражания. Так же хорошей идеей будет использование фраз в повелительном наклонении 
echo настоящего времени. Другими словами - используйте команды. Вместо “Я добавил тесты для” 
echo или “Добавление тестов для”, используйте “Добавить тесты для”. Ниже представлен шаблон, 
echo написанный Tim Pope:
echo.
echo Краткое (50 символов или меньше) описание изменений
echo.
echo Текст более детального описания, если необходим. Старайтесь
echo не первышать длинну строки в 72 символа. В некоторых случаях
echo первая строка подразумевается как тема письма, а всё остальное -
echo тело письма. Пустая строка, разделяющая сообщение, критически важна
echo если существует детальное описание); такие утилиты как rebase
echo могут запутаться, если вы запустите сразу две.
echo.
echo Последующие параграфы должны отделяться пустыми строками.
echo.
echo   - Списки тоже подходят
echo.
echo   - Обычно, элементы списка обозначаются с помощью тире или звёздочки,
echo     предваряются одиночным пробелом, а разделяются пустой строкой, но
echo     соглашения могут отличаться
echo.

REM Проверяем ввод, если пустой присваиваем дефолтные значения на свой вкус
if %ProjectName%=="" (set ProjectName=New-Project)
if %CommitComment%=="" (set CommitComment=Auto Commit)
if %GitProfileName%=="" (set GitProfileName=Anklav24)
if %GitHubTOKEN%=="" (set GitHubTOKEN=YOUR_TOKEN)

echo Заходим в папку со скриптом:
echo %~dp0
cd %~dp0
echo.

echo Создаем папку проекта "%ProjectName%":
mkdir "%ProjectName%"
echo.

echo Заходим в папку проекта:
echo %~dp0%ProjectName%
cd %~dp0%ProjectName%
echo.

echo =======================
echo Создаем служебные файлы
echo =======================
echo.
echo - Добавляем в папку файл .gitignore и записываем/перезаписываем в него игнорируемые файлы
echo (В данном случае файл оптимизирован для Python и редакторов от компании JetBrains)

REM Здесь мои исключения
echo # You can use site gitignore.io for create .gitignore > .gitignore
echo # https://www.gitignore.io >> .gitignore
echo Your ignored files >> .gitignore
echo .idea/ >> .gitignore
REM .gitignore >> .gitignore
REM Здесь рекомендации для Python от GitHub
echo # Byte-compiled / optimized / DLL files >> .gitignore
echo __pycache__/ >> .gitignore
echo *.py[cod] >> .gitignore
echo *$py.class >> .gitignore
echo. >> .gitignore
echo # C extensions >> .gitignore
echo *.so >> .gitignore
echo. >> .gitignore
echo # Distribution / packaging >> .gitignore
echo .Python >> .gitignore
echo build/ >> .gitignore
echo develop-eggs/ >> .gitignore
echo dist/ >> .gitignore
echo downloads/ >> .gitignore
echo eggs/ >> .gitignore
echo .eggs/ >> .gitignore
echo lib/ >> .gitignore
echo lib64/ >> .gitignore
echo parts/ >> .gitignore
echo sdist/ >> .gitignore
echo var/ >> .gitignore
echo wheels/ >> .gitignore
echo *.egg-info/ >> .gitignore
echo .installed.cfg >> .gitignore
echo *.egg >> .gitignore
echo MANIFEST >> .gitignore
echo. >> .gitignore
echo # PyInstaller >> .gitignore
echo #  Usually these files are written by a python script from a template >> .gitignore
echo #  before PyInstaller builds the exe, so as to inject date/other infos into it. >> .gitignore
echo *.manifest >> .gitignore
echo *.spec >> .gitignore
echo. >> .gitignore
echo # Installer logs >> .gitignore
echo pip-log.txt >> .gitignore
echo pip-delete-this-directory.txt >> .gitignore
echo. >> .gitignore
echo # Unit test / coverage reports >> .gitignore
echo htmlcov/ >> .gitignore
echo .tox/ >> .gitignore
echo .coverage >> .gitignore
echo .coverage.* >> .gitignore
echo .cache >> .gitignore
echo nosetests.xml >> .gitignore
echo coverage.xml >> .gitignore
echo *.cover >> .gitignore
echo .hypothesis/ >> .gitignore
echo .pytest_cache/ >> .gitignore
echo. >> .gitignore
echo # Translations >> .gitignore
echo *.mo >> .gitignore
echo *.pot >> .gitignore
echo. >> .gitignore
echo # Django stuff: >> .gitignore
echo *.log >> .gitignore
echo local_settings.py >> .gitignore
echo db.sqlite3 >> .gitignore
echo. >> .gitignore
echo # Flask stuff: >> .gitignore
echo instance/ >> .gitignore
echo .webassets-cache >> .gitignore
echo. >> .gitignore
echo # Scrapy stuff: >> .gitignore
echo .scrapy >> .gitignore
echo. >> .gitignore
echo # Sphinx documentation >> .gitignore
echo docs/_build/ >> .gitignore
echo. >> .gitignore
echo # PyBuilder >> .gitignore
echo target/ >> .gitignore
echo. >> .gitignore
echo # Jupyter Notebook >> .gitignore
echo .ipynb_checkpoints >> .gitignore
echo. >> .gitignore
echo # pyenv >> .gitignore
echo .python-version >> .gitignore
echo. >> .gitignore
echo # celery beat schedule file >> .gitignore
echo celerybeat-schedule >> .gitignore
echo. >> .gitignore
echo # SageMath parsed files >> .gitignore
echo *.sage.py >> .gitignore
echo echo  >> .gitignore
echo # Environments >> .gitignore
echo .env >> .gitignore
echo .venv >> .gitignore
echo env/ >> .gitignore
echo venv/ >> .gitignore
echo ENV/ >> .gitignore
echo env.bak/ >> .gitignore
echo venv.bak/ >> .gitignore
echo echo  >> .gitignore
echo # Spyder project settings >> .gitignore
echo .spyderproject >> .gitignore
echo .spyproject >> .gitignore
echo. >> .gitignore
echo # Rope project settings >> .gitignore
echo .ropeproject >> .gitignore
echo. >> .gitignore
echo # mkdocs documentation >> .gitignore
echo /site >> .gitignore
echo. >> .gitignore
echo # mypy >> .gitignore
echo .mypy_cache/ >> .gitignore

REM Здесь рекомендации для PyCharm от GitHub и JetBrains
echo # Covers JetBrains IDEs: IntelliJ, RubyMine, PhpStorm, AppCode, PyCharm, CLion, Android Studio and WebStorm >> .gitignore
echo # Reference: https://intellij-support.jetbrains.com/hc/en-us/articles/206544839 >> .gitignore
echo. >> .gitignore
echo # User-specific stuff >> .gitignore
echo .idea/**/workspace.xml >> .gitignore
echo .idea/**/tasks.xml >> .gitignore
echo .idea/**/usage.statistics.xml >> .gitignore
echo .idea/**/dictionaries >> .gitignore
echo .idea/**/shelf >> .gitignore
echo. >> .gitignore
echo # Generated files >> .gitignore
echo .idea/**/contentModel.xml >> .gitignore
echo. >> .gitignore
echo # Sensitive or high-churn files >> .gitignore
echo .idea/**/dataSources/ >> .gitignore
echo .idea/**/dataSources.ids >> .gitignore
echo .idea/**/dataSources.local.xml >> .gitignore
echo .idea/**/sqlDataSources.xml >> .gitignore
echo .idea/**/dynamic.xml >> .gitignore
echo .idea/**/uiDesigner.xml >> .gitignore
echo .idea/**/dbnavigator.xml >> .gitignore
echo. >> .gitignore
echo # Gradle >> .gitignore
echo .idea/**/gradle.xml >> .gitignore
echo .idea/**/libraries >> .gitignore
echo. >> .gitignore
echo # Gradle and Maven with auto-import >> .gitignore
echo # When using Gradle or Maven with auto-import, you should exclude module files, >> .gitignore
echo # since they will be recreated, and may cause churn.  Uncomment if using >> .gitignore
echo # auto-import. >> .gitignore
echo # .idea/modules.xml >> .gitignore
echo # .idea/*.iml >> .gitignore
echo # .idea/modules >> .gitignore
echo # *.iml >> .gitignore
echo # *.ipr >> .gitignore
echo. >> .gitignore
echo # CMake >> .gitignore
echo cmake-build-*/ >> .gitignore
echo. >> .gitignore
echo # Mongo Explorer plugin >> .gitignore
echo .idea/**/mongoSettings.xml >> .gitignore
echo. >> .gitignore
echo # File-based project format >> .gitignore
echo *.iws >> .gitignore
echo. >> .gitignore
echo # IntelliJ >> .gitignore
echo out/ >> .gitignore
echo. >> .gitignore
echo # mpeltonen/sbt-idea plugin >> .gitignore
echo .idea_modules/ >> .gitignore
echo. >> .gitignore
echo # JIRA plugin >> .gitignore
echo atlassian-ide-plugin.xml >> .gitignore
echo. >> .gitignore
echo # Cursive Clojure plugin >> .gitignore
echo .idea/replstate.xml >> .gitignore
echo. >> .gitignore
echo # Crashlytics plugin (for Android Studio and IntelliJ) >> .gitignore
echo com_crashlytics_export_strings.xml >> .gitignore
echo crashlytics.properties >> .gitignore
echo crashlytics-build.properties >> .gitignore
echo fabric.properties >> .gitignore
echo. >> .gitignore
echo # Editor-based Rest Client >> .gitignore
echo .idea/httpRequests >> .gitignore
echo. >> .gitignore
echo # Android studio 3.1+ serialized cache file >> .gitignore
echo .idea/caches/build_file_checksums.ser >> .gitignore
REM Windows лишние файлы
echo ### Windows ### >> .gitignore
echo # Windows thumbnail cache files >> .gitignore
echo Thumbs.db >> .gitignore
echo Thumbs.db:encryptable >> .gitignore
echo ehthumbs.db >> .gitignore
echo ehthumbs_vista.db >> .gitignore
echo.  >> .gitignore
echo # Dump file >> .gitignore
echo *.stackdump >> .gitignore
echo.  >> .gitignore
echo # Folder config file >> .gitignore
echo [Dd]esktop.ini >> .gitignore
echo.  >> .gitignore
echo # Recycle Bin used on file shares >> .gitignore
echo $RECYCLE.BIN/ >> .gitignore
echo.  >> .gitignore
echo # Windows Installer files >> .gitignore
echo *.cab >> .gitignore
echo *.msi >> .gitignore
echo *.msix >> .gitignore
echo *.msm >> .gitignore
echo *.msp >> .gitignore
echo.  >> .gitignore
echo # Windows shortcuts >> .gitignore
echo *.lnk >> .gitignore
echo.

echo - Создаем файл LICENSE записываем/перезаписываем в него версию лицензирования
echo В данном случае Apache License Version 2.0

echo                                  Apache License > LICENSE
echo                            Version 2.0, January 2004 >> LICENSE
echo                         http://www.apache.org/licenses/ >> LICENSE
echo. >> LICENSE
echo    TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION >> LICENSE
echo.  >> LICENSE
echo    1. Definitions. >> LICENSE
echo. >> LICENSE
echo       "License" shall mean the terms and conditions for use, reproduction, >> LICENSE
echo       and distribution as defined by Sections 1 through 9 of this document. >> LICENSE
echo. >> LICENSE
echo       "Licensor" shall mean the copyright owner or entity authorized by >> LICENSE
echo       the copyright owner that is granting the License. >> LICENSE
echo. >> LICENSE
echo       "Legal Entity" shall mean the union of the acting entity and all >> LICENSE
echo       other entities that control, are controlled by, or are under common >> LICENSE
echo       control with that entity. For the purposes of this definition, >> LICENSE
echo       "control" means (i) the power, direct or indirect, to cause the >> LICENSE
echo       direction or management of such entity, whether by contract or >> LICENSE
echo       otherwise, or (ii) ownership of fifty percent (50%) or more of the >> LICENSE
echo       outtanding shares, or (iii) beneficial ownership of such entity. >> LICENSE
echo. >> LICENSE
echo       "You" (or "Your") shall mean an individual or Legal Entity >> LICENSE
echo       exercising permissions granted by this License. >> LICENSE
echo. >> LICENSE
echo       "Source" form shall mean the preferred form for making modifications, >> LICENSE
echo       including but not limited to software source code, documentation >> LICENSE
echo       source, and configuration files. >> LICENSE
echo. >> LICENSE
echo       "Object" form shall mean any form resulting from mechanical >> LICENSE
echo       transformation or translation of a Source form, including but >> LICENSE
echo       not limited to compiled object code, generated documentation, >> LICENSE
echo       and conversions to other media types. >> LICENSE
echo. >> LICENSE
echo       "Work" shall mean the work of authorship, whether in Source or >> LICENSE
echo       Object form, made available under the License, as indicated by a >> LICENSE
echo       copyright notice that is included in or attached to the work >> LICENSE
echo       (an example is provided in the Appendix below). >> LICENSE
echo. >> LICENSE
echo       "Derivative Works" shall mean any work, whether in Source or Object >> LICENSE
echo       form, that is based on (or derived from) the Work and for which the >> LICENSE
echo       editorial revisions, annotations, elaborations, or other modifications >> LICENSE
echo       represent, as a whole, an original work of authorship. For the purposes >> LICENSE
echo       of this License, Derivative Works shall not include works that remain >> LICENSE
echo       separable from, or merely link (or bind by name) to the interfaces of, >> LICENSE
echo       the Work and Derivative Works thereof. >> LICENSE
echo. >> LICENSE
echo       "Contribution" shall mean any work of authorship, including >> LICENSE
echo       the original version of the Work and any modifications or additions >> LICENSE
echo       to that Work or Derivative Works thereof, that is intentionally >> LICENSE
echo       submitted to Licensor for inclusion in the Work by the copyright owner >> LICENSE
echo       or by an individual or Legal Entity authorized to submit on behalf of >> LICENSE
echo       the copyright owner. For the purposes of this definition, "submitted" >> LICENSE
echo       means any form of electronic, verbal, or written communication sent >> LICENSE
echo       to the Licensor or its representatives, including but not limited to >> LICENSE
echo       communication on electronic mailing lists, source code control systems, >> LICENSE
echo       and issue tracking systems that are managed by, or on behalf of, the >> LICENSE
echo       Licensor for the purpose of discussing and improving the Work, but >> LICENSE
echo       excluding communication that is conspicuously marked or otherwise >> LICENSE
echo       designated in writing by the copyright owner as "Not a Contribution." >> LICENSE
echo. >> LICENSE
echo       "Contributor" shall mean Licensor and any individual or Legal Entity >> LICENSE
echo       on behalf of whom a Contribution has been received by Licensor and >> LICENSE
echo       subsequently incorporated within the Work. >> LICENSE
echo. >> LICENSE
echo    2. Grant of Copyright License. Subject to the terms and conditions of >> LICENSE
echo       this License, each Contributor hereby grants to You a perpetual, >> LICENSE
echo       worldwide, non-exclusive, no-charge, royalty-free, irrevocable >> LICENSE
echo       copyright license to reproduce, prepare Derivative Works of, >> LICENSE
echo       publicly display, publicly perform, sublicense, and distribute the >> LICENSE
echo       Work and such Derivative Works in Source or Object form. >> LICENSE
echo. >> LICENSE
echo    3. Grant of Patent License. Subject to the terms and conditions of >> LICENSE
echo       this License, each Contributor hereby grants to You a perpetual, >> LICENSE
echo       worldwide, non-exclusive, no-charge, royalty-free, irrevocable >> LICENSE
echo       (except as stated in this section) patent license to make, have made, >> LICENSE
echo       use, offer to sell, sell, import, and otherwise transfer the Work, >> LICENSE
echo       where such license applies only to those patent claims licensable >> LICENSE
echo       by such Contributor that are necessarily infringed by their >> LICENSE
echo       Contribution(s) alone or by combination of their Contribution(s) >> LICENSE
echo       with the Work to which such Contribution(s) was submitted. If You >> LICENSE
echo       institute patent litigation against any entity (including a >> LICENSE
echo       cross-claim or counterclaim in a lawsuit) alleging that the Work >> LICENSE
echo       or a Contribution incorporated within the Work constitutes direct >> LICENSE
echo       or contributory patent infringement, then any patent licenses >> LICENSE
echo       granted to You under this License for that Work shall terminate >> LICENSE
echo       as of the date such litigation is filed. >> LICENSE
echo. >> LICENSE
echo    4. Redistribution. You may reproduce and distribute copies of the >> LICENSE
echo       Work or Derivative Works thereof in any medium, with or without >> LICENSE
echo       modifications, and in Source or Object form, provided that You >> LICENSE
echo       meet the following conditions: >> LICENSE
echo. >> LICENSE
echo       (a) You must give any other recipients of the Work or >> LICENSE
echo           Derivative Works a copy of this License; and >> LICENSE
echo. >> LICENSE
echo       (b) You must cause any modified files to carry prominent notices >> LICENSE
echo           stating that You changed the files; and >> LICENSE
echo. >> LICENSE
echo       (c) You must retain, in the Source form of any Derivative Works >> LICENSE
echo           that You distribute, all copyright, patent, trademark, and >> LICENSE
echo           attribution notices from the Source form of the Work, >> LICENSE
echo           excluding those notices that do not pertain to any part of >> LICENSE
echo           the Derivative Works; and >> LICENSE >> LICENSE
echo. >> LICENSE
echo       (d) If the Work includes a "NOTICE" text file as part of its >> LICENSE
echo           distribution, then any Derivative Works that You distribute must >> LICENSE
echo           include a readable copy of the attribution notices contained >> LICENSE
echo           within such NOTICE file, excluding those notices that do not >> LICENSE
echo           pertain to any part of the Derivative Works, in at least one >> LICENSE
echo           of the following places: within a NOTICE text file distributed >> LICENSE
echo           as part of the Derivative Works; within the Source form or >> LICENSE
echo           documentation, if provided along with the Derivative Works; or, >> LICENSE
echo           within a display generated by the Derivative Works, if and >> LICENSE
echo           wherever such third-party notices normally appear. The contents >> LICENSE
echo           of the NOTICE file are for informational purposes only and >> LICENSE
echo           do not modify the License. You may add Your own attribution >> LICENSE
echo           notices within Derivative Works that You distribute, alongside >> LICENSE
echo           or as an addendum to the NOTICE text from the Work, provided >> LICENSE
echo           that such additional attribution notices cannot be construed >> LICENSE
echo           as modifying the License. >> LICENSE
echo. >> LICENSE
echo       You may add Your own copyright statement to Your modifications and >> LICENSE
echo       may provide additional or different license terms and conditions >> LICENSE
echo       for use, reproduction, or distribution of Your modifications, or >> LICENSE
echo       for any such Derivative Works as a whole, provided Your use, >> LICENSE
echo       reproduction, and distribution of the Work otherwise complies with >> LICENSE
echo       the conditions stated in this License. >> LICENSE
echo. >> LICENSE
echo    5. Submission of Contributions. Unless You explicitly state otherwise, >> LICENSE
echo       any Contribution intentionally submitted for inclusion in the Work >> LICENSE
echo       by You to the Licensor shall be under the terms and conditions of >> LICENSE
echo       this License, without any additional terms or conditions. >> LICENSE
echo       Notwithstanding the above, nothing herein shall supersede or modify >> LICENSE
echo       the terms of any separate license agreement you may have executed >> LICENSE
echo       with Licensor regarding such Contributions. >> LICENSE
echo. >> LICENSE
echo    6. Trademarks. This License does not grant permission to use the trade >> LICENSE
echo       names, trademarks, service marks, or product names of the Licensor, >> LICENSE
echo       except as required for reasonable and customary use in describing the >> LICENSE
echo       origin of the Work and reproducing the content of the NOTICE file. >> LICENSE
echo. >> LICENSE
echo    7. Disclaimer of Warranty. Unless required by applicable law or >> LICENSE
echo       agreed to in writing, Licensor provides the Work (and each >> LICENSE
echo       Contributor provides its Contributions) on an "AS IS" BASIS, >> LICENSE
echo       WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or >> LICENSE
echo       implied, including, without limitation, any warranties or conditions >> LICENSE
echo       of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A >> LICENSE
echo       PARTICULAR PURPOSE. You are solely responsible for determining the >> LICENSE
echo       appropriateness of using or redistributing the Work and assume any >> LICENSE
echo       risks associated with Your exercise of permissions under this License. >> LICENSE
echo. >> LICENSE
echo    8. Limitation of Liability. In no event and under no legal theory, >> LICENSE
echo       whether in tort (including negligence), contract, or otherwise, >> LICENSE
echo       unless required by applicable law (such as deliberate and grossly >> LICENSE
echo       negligent acts) or agreed to in writing, shall any Contributor be >> LICENSE
echo       liable to You for damages, including any direct, indirect, special, >> LICENSE
echo       incidental, or consequential damages of any character arising as a >> LICENSE
echo       result of this License or out of the use or inability to use the >> LICENSE
echo       Work (including but not limited to damages for loss of goodwill, >> LICENSE
echo       work stoppage, computer failure or malfunction, or any and all >> LICENSE
echo       other commercial damages or losses), even if such Contributor >> LICENSE
echo       has been advised of the possibility of such damages. >> LICENSE
echo. >> LICENSE
echo    9. Accepting Warranty or Additional Liability. While redistributing >> LICENSE
echo       the Work or Derivative Works thereof, You may choose to offer, >> LICENSE
echo       and charge a fee for, acceptance of support, warranty, indemnity, >> LICENSE
echo       or other liability obligations and/or rights consistent with this >> LICENSE
echo       License. However, in accepting such obligations, You may act only >> LICENSE
echo       on Your own behalf and on Your sole responsibility, not on behalf >> LICENSE
echo       of any other Contributor, and only if You agree to indemnify, >> LICENSE
echo       defend, and hold each Contributor harmless for any liability >> LICENSE
echo       incurred by, or claims asserted against, such Contributor by reason >> LICENSE
echo       of your accepting any such warranty or additional liability. >> LICENSE
echo. >> LICENSE
echo    END OF TERMS AND CONDITIONS >> LICENSE
echo. >> LICENSE
echo    APPENDIX: How to apply the Apache License to your work. >> LICENSE
echo. >> LICENSE
echo       To apply the Apache License to your work, attach the following >> LICENSE
echo       boilerplate notice, with the fields enclosed by brackets "[]" >> LICENSE
echo       replaced with your own identifying information. (Don't include >> LICENSE
echo       the brackets!)  The text should be enclosed in the appropriate >> LICENSE
echo       comment syntax for the file format. We also recommend that a >> LICENSE
echo       file or class name and description of purpose be included on the >> LICENSE
echo       same "printed page" as the copyright notice for easier >> LICENSE
echo       identification within third-party archives. >> LICENSE
echo. >> LICENSE
echo    Copyright 2019-2020 %GitProfileName%@gmail.com >> LICENSE
echo. >> LICENSE
echo    Licensed under the Apache License, Version 2.0 (the "License"); >> LICENSE
echo    you may not use this file except in compliance with the License. >> LICENSE
echo    You may obtain a copy of the License at >> LICENSE
echo. >> LICENSE
echo        http://www.apache.org/licenses/LICENSE-2.0 >> LICENSE
echo. >> LICENSE
echo    Unless required by applicable law or agreed to in writing, software >> LICENSE
echo    distributed under the License is distributed on an "AS IS" BASIS, >> LICENSE
echo    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. >> LICENSE
echo    See the License for the specific language governing permissions and >> LICENSE
echo    limitations under the License. >> LICENSE
echo.

echo - Создаем файл README.md записываем/перезаписываем в него название проекта
echo # %ProjectName%> README.md

echo ## Потрудитесь нормально задокументировать проект!>> README.md
echo.>> README.md
echo ### Для чего предназначен проект:>> README.md
echo.>> README.md
echo ### Инструкции по конфигурации и установке:>> README.md
echo.>> README.md
echo ### Примеры использования:>> README.md
echo.>> README.md
echo ### Используемая лицензия: Apache License Version 2.0, January 2004>> README.md
echo.>> README.md
echo ### Правила участия в проекте:>> README.md
echo.

echo - Создаем файл CHANGELOG.md файл для ведения лога изменений
echo # Changelog> CHANGELOG.md
echo.>> CHANGELOG.md
echo All notable changes to this project will be documented in this file.>> CHANGELOG.md
echo.>> CHANGELOG.md
echo The format is based on:
echo * https://keepachangelog.com/ru/0.3.0/>> CHANGELOG.md
echo * https://github.com/olivierlacan/keep-a-changelog>> CHANGELOG.md
echo * https://semver.org/lang/ru/>> CHANGELOG.md
echo.>> CHANGELOG.md
echo # Example:>> CHANGELOG.md
echo.>> CHANGELOG.md
echo ## [0.1.0] - 2019-10-04>> CHANGELOG.md
echo.>> CHANGELOG.md
echo #### *Added:*>> CHANGELOG.md
echo.>> CHANGELOG.md
echo * New feature. Input Token from keyboard.>> CHANGELOG.md
echo.>> CHANGELOG.md
echo #### *Changed:*>> CHANGELOG.md
echo.>> CHANGELOG.md
echo * Documentation readme.>> CHANGELOG.md
echo.>> CHANGELOG.md
echo ## [0.0.1] - 2019-09-13>> CHANGELOG.md
echo.>> CHANGELOG.md
echo #### *Added:*>> CHANGELOG.md
echo.>> CHANGELOG.md
echo * New documetation.>> CHANGELOG.md
echo * New documetation.>> CHANGELOG.md
echo.>> CHANGELOG.md
echo #### *Changed:*>> CHANGELOG.md
echo.>> CHANGELOG.md
echo * Comments in code.>> CHANGELOG.md
echo * Comments in code.>> CHANGELOG.md
echo.>> CHANGELOG.md
echo #### *Fixed:*>> CHANGELOG.md
echo.>> CHANGELOG.md
echo * Fix Licence extention from .md.>> CHANGELOG.md
echo * Fix Licence extention from .md.>> CHANGELOG.md
echo.>> CHANGELOG.md
echo #### *Removed:*>> CHANGELOG.md
echo.>> CHANGELOG.md
echo * Token API.>> CHANGELOG.md
echo * Token API.>> CHANGELOG.md
echo.

echo - Создаем файл CONTRIBUTING.md руководство для людей
echo участвующих в проекте через запросы на слияние
echo # Создание запроса на слияние при наличии файла CONTRIBUTING.md:> CONTRIBUTING.md
echo.>> CONTRIBUTING.md
echo Идея состоит в том, что вы можете указать конкретные вещи, которые вы хотите или не хотите>> CONTRIBUTING.md
echo видеть в новых запросах на слияние. Таким образом люди могут ознакомится с руководством,>> CONTRIBUTING.md
echo перед тем как создавать новый запрос на слияние.>> CONTRIBUTING.md
echo.>> CONTRIBUTING.md
echo Если в вашем репозитории будет файл CONTRIBUTING с любым расширением, то GitHub будет>> CONTRIBUTING.md
echo показывать ссылку на него при создании любого запроса на слияние.>> CONTRIBUTING.md
echo.

echo ======================================================
echo 1. Инициализируем git "git init", создается папка .git
echo ======================================================
echo.
git init
echo.

echo Проверяем состояние гита после инициализации:
echo.
git status
echo.

echo ========================================================
echo 2. Добавляем все не игнорируемые файлы в Git "git add ."
echo ========================================================
echo.
git add .

echo Проверяем состояние гита после "git add .":
echo.
git status
echo.

echo ====================================
echo 3. Коммитим и комментируем изменения
echo ====================================
echo.
git commit -m "%CommitComment%"
echo.

echo Проверяем состояние гита после коммита:
echo.
git status
echo.

echo Добавляем удалённые репозитории:
git remote add origin https://github.com/%GitProfileName%/%ProjectName%
echo.

echo Проверяем ссылки удаленных репозиториев:
git remote -v
echo.

echo Проверяем историю последних 20 коммитов:
git log -20 --abbrev-commit --pretty=oneline
echo.

echo ================================
echo 4. Создаем репозиторий на GitHub
echo ================================
echo.

echo Ожидайте...
echo.

REM echo Если валятся ошибки JSON
REM echo If you are a windows system, you need to modify the json format.
REM echo Examples: '{"token":"asdfas"}' replaced by  "{\"Hello\":\"Karl\"}"
REM echo.

REM Создаем пустой репозиторий
curl -i -H "Authorization: token %GitHubTOKEN%" -d "{\"name\": \"%ProjectName%\"}" https://api.github.com/user/repos
REM Можно также дописать аргументы -d '{"name": "{name of repo}", "auto_init": REM true, "private": true, "gitignore_template": "nanoc"}' 
echo.

echo ========================
echo 5. Пушим изменения в гит
echo ========================
echo.
echo Ожидайте...
timeout 3 /NOBREAK
echo.

git push origin master
echo.

echo ================
echo Скрипт завершен.
echo ================
echo.

:question
REM Не большой луп который спрашивает пользователя повторить ли скрипт
set EndSctipt=""
set /p EndSctipt="Создать еще один проект на GitHub? (Да/Нет): "
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