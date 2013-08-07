# Скрипты для работы с Git

Установка:
    
    wget --no-check-certificate -q -O - https://github.com/h4/git-tools/raw/master/contrib/git-tools-installer.sh | sudo bash

или

    curl -L -O https://github.com/h4/git-tools/raw/master/contrib/git-tools-installer.sh
	sudo bash git-tools-installer.sh

## clean-merged

Удалить все локальные смёрженные ветки

Использование: 

	git-tools clean-merged <params>

Параметры

* -h - показать справку
* -v - показать версию
* -f - удаление без подтверждения
* -l - вывести список веток, которые можно удалить
* -b BRANCH_NAME - имя целевой ветки. По умолчанию — develop
