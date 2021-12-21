﻿# language: ru
# encoding: utf-8
#parent ua:
@UA9_загружать_features
#parent uf:
@UF1_загрузка_и_обработка_features

@IgnoreOn82Builds
@IgnoreOnOFBuilds
@IgnoreOnWeb

@tree

Функционал: Проверка загрузки структуры сценария


Контекст: 
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий


Сценарий: Проверка загрузки структуры сценария старый парсер с апострофами
	Когда Я открываю VanessaAutomation в режиме TestClient со стандартной библиотекой
	И В поле с именем "КаталогФичСлужебный" я указываю путь к служебной фиче "ПроверкиЗагрузкиСтруктурыСценария\ДляПроверкиЗагрузкиСтруктурыСценария2"
	И я перехожу к закладке с именем "ГруппаНастройки"
	И я снимаю флаг с именем 'ИспользоватьПарсерGherkinИзКомпонентыVanessaExt'
	И я снимаю флаг с именем 'ИспользоватьКомпонентуVanessaExt'

	И Я нажимаю на кнопку перезагрузить сценарии в Vanessa-Automation TestClient

	И я перехожу к закладке с именем "ГруппаЗапускТестов"

	И я перехожу к закладке с именем "ГруппаСлужебная"
	И я нажимаю на кнопку с именем 'РазвернутьВсеСтрокиДереваСлужебный'
	И я перехожу к закладке с именем "ГруппаЗапускТестов"
		
	Тогда таблица "ДеревоТестов" стала равной:
		| 'Наименование'                                          |
		| 'ДляПроверкиЗагрузкиСтруктурыСценария2.feature'         |
		| 'Название функциональности'                             |
		| 'Структура сценария 1'                                  |
		| 'Дано Начальные условия <Параметр1>'                    |
		| 'Затем я выполняю действия <Параметр2>'                 |
		| 'Тогда я получаю результат <Параметр3>'                 |
		| 'Примеры'                                               |
		| '\| \'Параметр1\' \| \'Параметр2\' \| \'Параметр3\' \|' |
		| '\| \'Значение1\' \| \'Значение2\' \| \'Значение3\' \|' |
		| 'Дано Начальные условия "Значение1"'                    |
		| 'Затем я выполняю действия "Значение2"'                 |
		| 'Тогда я получаю результат "Значение3"'                 |
		| '\| \'Значение3\' \| \'Значение4\' \| \'Значение5\' \|' |
		| 'Дано Начальные условия "Значение3"'                    |
		| 'Затем я выполняю действия "Значение4"'                 |
		| 'Тогда я получаю результат "Значение5"'                 |
	
	


Сценарий: Проверка загрузки структуры сценария основная
	Когда Я открываю VanessaAutomation в режиме TestClient со стандартной библиотекой
	И В поле с именем "КаталогФичСлужебный" я указываю путь к служебной фиче "ПроверкиЗагрузкиСтруктурыСценария\ДляПроверкиЗагрузкиСтруктурыСценария1"
	И Я нажимаю на кнопку перезагрузить сценарии в Vanessa-Automation TestClient
	
	

	Если в сообщениях пользователю есть строка "Таблица параметров должна начинаться с символа" Тогда
		Тогда я вызываю исключение 'Найдена строка "Таблица параметров должна начинаться с символа"'
		
	И Я нажимаю на кнопку выполнить сценарии в Vanessa-Automation TestClient
	
	Тогда элемент формы с именем "Статистика" стал равен '1/1/10, 2/2/0'
	
	Если Версия платформы ">=" "8.3.10" Тогда
			И в таблице "ДеревоТестов" я сворачиваю строку:
				| '№'        | 'Наименование'                                                        |
				| '6'        | 'Если служебное условие в которое передаётся таблица выполнено Тогда' |
			
			
			И в таблице "ДеревоТестов" я сворачиваю строку:
				| 'Наименование'                         | 'Статус'   |
				| 'Дано Я задаю таблицу строк "Таблица"' |    ''      |


			И в таблице "ДеревоТестов" я сворачиваю строку:
				| '№' | 'Наименование'                         |
				| '14'       | 'Дано Я задаю таблицу строк "Таблица"' |
				
			И в таблице "ДеревоТестов" я сворачиваю строку:
				| '№' | 'Наименование'                         |
				| '23'       | 'Дано Я задаю таблицу строк "Таблица"' |

	
			Тогда таблица "ДеревоТестов" стала равной:
				| 'Статус'  | 'Снипет'                                                            |
				| ''        | ''                                                                  |
				| ''        | ''                                                                  |
				| 'Failed'  | ''                                                                  |
				| ''        | 'ЯЗадаюТаблицуСтрок(Парам01,ТабПарам)'                              |
				| ''        | 'СлужебноеУсловиеВКотороеПередаётсяТаблицаВыполненоТогда(ТабПарам)' |
				| ''        | 'ОткрылосьОкно(Парам01)'                                            |
				| 'Failed'  | ''                                                                  |
				| ''        | ''                                                                  |
				| 'Failed'  | ''                                                                  |
				| 'Success' | 'ЯЗадаюТаблицуСтрок(Парам01,ТабПарам)'                              |
				| 'Failed'  | 'СлужебноеУсловиеВКотороеПередаётсяТаблицаВыполненоТогда(ТабПарам)' |
				| ''        | ''                                                                  |
				| ''        | ''                                                                  |
				| 'Failed'  | 'ЯВызываюИсключение(Парам01)'                                       |
				| ''        | 'ОткрылосьОкно(Парам01)'                                            |
				| 'Failed'  | ''                                                                  |
				| 'Success' | 'ЯЗадаюТаблицуСтрок(Парам01,ТабПарам)'                              |
				| 'Failed'  | 'СлужебноеУсловиеВКотороеПередаётсяТаблицаВыполненоТогда(ТабПарам)' |
				| ''        | ''                                                                  |
				| ''        | ''                                                                  |
				| 'Failed'  | 'ЯВызываюИсключение(Парам01)'                                       |
				| ''        | 'ОткрылосьОкно(Парам01)'                                            |
			
							


	//Если Версия платформы "<" "8.3.10" Тогда
	И я перехожу к закладке "Служебная"
	И я нажимаю на кнопку 'Развернуть все строки дерева служебный'
	И я перехожу к закладке "Запуск сценариев"
	Тогда таблица "ДеревоТестов" стала равной:
		| 'Наименование'                                                                                         | 'Статус'  |
		| 'ДляПроверкиЗагрузкиСтруктурыСценария1.feature'                                                        | ''        |
		| 'Тест 3'                                                                                               | ''        |
		| 'Тест'                                                                                                 | 'Failed'  |
		| 'Дано Я задаю таблицу строк "Таблица"'                                                                 | ''        |
		| '\| \'Товар1\' \|'                                                                                     | ''        |
		| '\| \'Товар2\' \|'                                                                                     | ''        |
		| 'Если служебное условие в которое передаётся таблица выполнено Тогда'                                  | ''        |
		| '\| \'Уникальный номер\'   \|'                                                                         | ''        |
		| '\| \'<Уникальный номер>\' \|'                                                                         | ''        |
		| 'Тогда я вызываю исключение "Сработало исключение"'                                                    | ''        |
		| 'Тогда открылось окно "Это шаг не должен выполнятся, т.к. должно было быть вызвано исключение ранее."' | ''        |
		| 'Примеры'                                                                                              | 'Failed'  |
		| '\| Уникальный номер  \|'                                                                              | ''        |
		| '\| \'111111111111111\' \|'                                                                            | 'Failed'  |
		| 'Дано Я задаю таблицу строк "Таблица"'                                                                 | 'Success' |
		| '\| \'Товар1\' \|'                                                                                     | ''        |
		| '\| \'Товар2\' \|'                                                                                     | ''        |
		| 'Если служебное условие в которое передаётся таблица выполнено Тогда'                                  | 'Failed'  |
		| '\| \'Уникальный номер\' \|'                                                                           | ''        |
		| '\| \'111111111111111\'  \|'                                                                           | ''        |
		| 'Тогда я вызываю исключение "Сработало исключение"'                                                    | 'Failed'  |
		| 'Тогда открылось окно "Это шаг не должен выполнятся, т.к. должно было быть вызвано исключение ранее."' | ''        |
		| '\| \'222222222222222\' \|'                                                                            | 'Failed'  |
		| 'Дано Я задаю таблицу строк "Таблица"'                                                                 | 'Success' |
		| '\| \'Товар1\' \|'                                                                                     | ''        |
		| '\| \'Товар2\' \|'                                                                                     | ''        |
		| 'Если служебное условие в которое передаётся таблица выполнено Тогда'                                  | 'Failed'  |
		| '\| \'Уникальный номер\' \|'                                                                           | ''        |
		| '\| \'222222222222222\'  \|'                                                                           | ''        |
		| 'Тогда я вызываю исключение "Сработало исключение"'                                                    | 'Failed'  |
		| 'Тогда открылось окно "Это шаг не должен выполнятся, т.к. должно было быть вызвано исключение ранее."' | ''        |
	
	