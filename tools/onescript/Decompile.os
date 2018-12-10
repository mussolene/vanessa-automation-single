﻿#Использовать v8runner
#Использовать logos

Перем Лог;
Перем УправлениеКонфигуратором;

Функция ДатуКСтроке(Дат)
	Возврат Формат(Дат,"ДФ=yyyy.MM.dd.HH.mm.ss");
КонецФункции	 

// Перемещаят найденные по маскам файлы с сохранением пути.
//
// Параметры:
//  КаталогКуда - Строка - Путь к каталогу в который переносятся файлы;
//  КаталогиОткуда 		 - Массив - Пути к каталогам в которых осуществляется поиск файлов;
//  МассивМасок 		 - Массив - Маски, по которым осуществляется поиск файлов.
//
// Взято из https://infostart.ru/public/537028/
Процедура ПереместитьФайлыВКаталог(КаталогКуда, КаталогиОткуда, МассивМасок)
 	
 	Для Каждого КаталогПоиска Из КаталогиОткуда Цикл
		КаталогПоискаОбъект = Новый Файл(КаталогПоиска);
		Если НЕ КаталогПоискаОбъект.Существует() Тогда
			Лог.Ошибка(НСтр("ru = 'Каталог не найден.'"));
			Продолжить;
		КонецЕсли;
		
		Для Каждого Маска Из МассивМасок Цикл
		
			МассивФайлов = НайтиФайлы(КаталогПоиска, Маска, Истина); 
			Для Каждого НайденныйФайл Из МассивФайлов Цикл
				
				НовыйПуть = СтрЗаменить(НайденныйФайл.Путь, КаталогПоиска, КаталогКуда);
				НовоеИмя = НайденныйФайл.Имя; 			
				
				Если НЕ ОбеспечитьКаталог(НовыйПуть) Тогда 
					Продолжить; 
				КонецЕсли;
				
				Если НайденныйФайл.ЭтоКаталог() Тогда
					Продолжить;
				КонецЕсли;	 
				
				
				ИмяФайлаДляПеремещения = ОбъединитьПути(НовыйПуть, НовоеИмя);
				УдалитьФайлы(ИмяФайлаДляПеремещения);
				
				Попытка
					ПереместитьФайл(НайденныйФайл.ПолноеИмя,ИмяФайлаДляПеремещения);
				Исключение
					Лог.Ошибка(СтрШаблон(НСтр("ru = 'Не удалось переместить файл:
						|%1'"), ОписаниеОшибки()));
					Продолжить;
				КонецПопытки;
								
				ФайлНаДиске = Новый Файл(ОбъединитьПути(НовыйПуть, НовоеИмя));
			    Если НЕ ФайлНаДиске.Существует() Тогда
					Лог.Ошибка(НСтр("ru = 'Не удалось корректно переместить файл.'"));
					Продолжить;
			    КонецЕсли;
			КонецЦикла;	
		
		КонецЦикла;	

  	КонецЦикла;	

КонецПроцедуры

// Проверяет наличия каталога и в случае его отсутствия создает новый.
//
// Параметры:
//  Каталог - Строка - Путь к каталогу, существование которого нужно проверить.
//
// Возвращаемое значение:
//  Булево - признак существования каталога.
//
// Взято из https://infostart.ru/public/537028/
Функция ОбеспечитьКаталог(Знач Каталог)
	
	Файл = Новый Файл(Каталог);
	Если Не Файл.Существует() Тогда
		Попытка 
			СоздатьКаталог(Каталог);
		Исключение
			Лог.Ошибка(СтрШаблон(НСтр("ru = 'Не удалось создать каталог %1.
				|%2'"), Каталог, ИнформацияОбОшибке()));
			Возврат Ложь;
		КонецПопытки;
	ИначеЕсли Не Файл.ЭтоКаталог() Тогда 
		Лог.Ошибка(СтрШаблон(НСтр("ru = 'Каталог %1 не является каталогом.'"), Каталог));
		Возврат Ложь;
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции

Процедура ВыгрузитьФайлВXML(ИмяФайла,ВерсииВсехФайлов)
	ФайлОбработкиИлиОтчета = Новый Файл(ИмяФайла);
	ВремяИзменения = ДатуКСтроке(ФайлОбработкиИлиОтчета.ПолучитьВремяИзменения());
	
	Если ВремяИзменения = ВерсииВсехФайлов[НРег(ФайлОбработкиИлиОтчета.ПолноеИмя)] Тогда
		Лог.Информация("Файл уже распакован.");
		Возврат;
	КонецЕсли;	 
	
	
	ВременныйКаталог = ПолучитьИмяВременногоФайла();
	СоздатьКаталог(ВременныйКаталог);
	
	ПараметрыЗапуска = УправлениеКонфигуратором.ПолучитьПараметрыЗапуска();
	ПараметрыЗапуска.Добавить("/DumpExternalDataProcessorOrReportToFiles """ + ВременныйКаталог + """  """ + ИмяФайла + """"); 
	
	ИмяФайлаOut = ПолучитьИмяВременногоФайла("txt");
	ПараметрыЗапуска.Добавить("/Out """ + ИмяФайлаOut + """"); 
	
	
	Попытка
		УправлениеКонфигуратором.ВыполнитьКоманду(ПараметрыЗапуска);
	Исключение
		Лог.Ошибка(ОписаниеОшибки());
		Лог.Ошибка(УправлениеКонфигуратором.ВыводКоманды());
		ВызватьИсключение "Выгрузка обработок в xml прервана.";
	КонецПопытки;
	
	
	ФайлXMLВКаталогеРаспаковки = НайтиФайлы(ВременныйКаталог,"*.xml",Ложь);
	Если ФайлXMLВКаталогеРаспаковки.Количество() <> 1 Тогда
		ВызватьИсключение "В каталоге распаковки найдено " + ФайлXMLВКаталогеРаспаковки.Количество() + " файлов xml, а должен быть только один.";
	КонецЕсли;	
	
	ФайлXmlОбработки     = ФайлXMLВКаталогеРаспаковки[0];
	ИмяКаталогаОбработки = ФайлXmlОбработки.ИмяБезРасширения;
	
	КаталогиОткуда = Новый Массив;
	КаталогиОткуда.Добавить(ВременныйКаталог);
	МассивМасок = Новый Массив;
	МассивМасок.Добавить("*.*");
	ПереместитьФайлыВКаталог(ФайлОбработкиИлиОтчета.Путь,КаталогиОткуда,МассивМасок);
	
	
	//запишем реальное имя файла
	ИмяОбработкиИлиОтчета = ФайлОбработкиИлиОтчета.Имя;
	
	
	КаталогГдеЛежатФайлыОбработкиИлиОтчета = ФайлОбработкиИлиОтчета.Путь + ПолучитьРазделительПути()+ ИмяКаталогаОбработки;
	ФайлКаталогГдеЛежатФайлыОбработкиИлиОтчета = Новый Файл(КаталогГдеЛежатФайлыОбработкиИлиОтчета);
	Если Не ФайлКаталогГдеЛежатФайлыОбработкиИлиОтчета.Существует() Тогда
		СоздатьКаталог(КаталогГдеЛежатФайлыОбработкиИлиОтчета);
	КонецЕсли;	 
	
	ИмяФайлаИмяОбработкиИлиОтчета = ФайлОбработкиИлиОтчета.Путь + ПолучитьРазделительПути()+ ИмяКаталогаОбработки + ПолучитьРазделительПути() + "filename";
	ФайлИмяФайлаИмяОбработкиИлиОтчета = Новый Файл(ИмяФайлаИмяОбработкиИлиОтчета);
	Если ФайлИмяФайлаИмяОбработкиИлиОтчета.Существует() Тогда
		УдалитьФайлы(ИмяФайлаИмяОбработкиИлиОтчета);
	КонецЕсли;	 
	
	
	
	ЗТ = Новый ЗаписьТекста(ИмяФайлаИмяОбработкиИлиОтчета,"UTF-8",,Истина); 
	ЗТ.Записать(ИмяОбработкиИлиОтчета); 
	ЗТ.Закрыть();
	
	//запишем версию файла
	ЗаписатьВерсиюОбработкиИлиОчета(ФайлОбработкиИлиОтчета,ИмяКаталогаОбработки,ИмяОбработкиИлиОтчета);
	
	
	Попытка
		УдалитьФайлы(ВременныйКаталог);
	Исключение
	КонецПопытки;
	
КонецПроцедуры

Функция ПолучитьВерсииФайловВКаталоге(Каталог)
	//Сообщить("Каталог="+Каталог);
	
	ТаблицаФайлов = Новый ТаблицаЗначений;
	ТаблицаФайлов.Колонки.Добавить("ПолноеИмя");
	ТаблицаФайлов.Колонки.Добавить("ЧастьПути");
	ТаблицаФайлов.Колонки.Добавить("ЭтоКаталог");
	ТаблицаФайлов.Колонки.Добавить("ВремяИзменения");
	
	Файлы = НайтиФайлы(Каталог,"*",Истина);
	Для Каждого Файл Из Файлы Цикл
		Если Нрег(Файл.Имя) = "filename" Тогда
			Продолжить;
		ИначеЕсли Нрег(Файл.Имя) = "fileversion" Тогда
			Продолжить;
		КонецЕсли;	 
		
		СтрокаТаблицаФайлов = ТаблицаФайлов.Добавить();
		СтрокаТаблицаФайлов.ПолноеИмя  = Файл.ПолноеИмя;
		СтрокаТаблицаФайлов.ЭтоКаталог = Файл.ЭтоКаталог();
		СтрокаТаблицаФайлов.ЧастьПути  = Сред(Файл.ПолноеИмя,СтрДлина(Каталог));
		
		//Сообщить("СтрокаТаблицаФайлов.ЧастьПути="+СтрокаТаблицаФайлов.ЧастьПути);
		
		Если СтрокаТаблицаФайлов.ЭтоКаталог Тогда
			Продолжить;
		КонецЕсли;	 
		
		СтрокаТаблицаФайлов.ВремяИзменения = ДатуКСтроке(Файл.ПолучитьВремяИзменения());
	КонецЦикла;	
	
	Возврат ТаблицаФайлов; 
КонецФункции	 

Процедура ЗаписатьВерсиюОбработкиИлиОчета(ФайлОбработкиИлиОтчета,ИмяКаталогаОбработки,ИмяОбработкиИлиОтчета)
	ИмяФайлаВерсии = ФайлОбработкиИлиОтчета.Путь + ИмяКаталогаОбработки + ПолучитьРазделительПути() + "fileversion";
	УдалитьФайлы(ИмяФайлаВерсии);
	ВремяИзменения = ДатуКСтроке(ФайлОбработкиИлиОтчета.ПолучитьВремяИзменения());
	
	ВерсииФайлов = ПолучитьВерсииФайловВКаталоге(ФайлОбработкиИлиОтчета.Путь + ИмяКаталогаОбработки + ПолучитьРазделительПути());
	
	ЗТ = Новый ЗаписьТекста(ИмяФайлаВерсии,"UTF-8",,Истина); 
	ЗТ.ЗаписатьСтроку(ВремяИзменения + "|" + ИмяОбработкиИлиОтчета); 
	
	Для Каждого СтрокаВерсииФайлов Из ВерсииФайлов Цикл
		Если СтрокаВерсииФайлов.ЭтоКаталог Тогда
			Продолжить;
		КонецЕсли;	 
		
		Стр = "" + СтрокаВерсииФайлов.ВремяИзменения + "|" + СтрокаВерсииФайлов.ЧастьПути;
		ЗТ.ЗаписатьСтроку(Стр); 
	КонецЦикла;	
	
	ЗТ.Закрыть();
КонецПроцедуры 

Функция ВерсииВсехФайлов(Файлы)
	Версии = Новый Соответствие;
	
	Для Каждого Файл Из Файлы Цикл
		Текст = Новый ЧтениеТекста;
		Текст.Открыть(Файл.ПолноеИмя,"UTF-8");
		
		
		Массив = Новый Массив;
		
		Пока Истина Цикл
			Стр = Текст.ПрочитатьСтроку();
			Если Стр = Неопределено Тогда
				Прервать;
			КонецЕсли;	 
			
			Массив.Добавить(Стр);
		КонецЦикла;	
		
		Текст.Закрыть();
		
		Если Массив.Количество() < 1 Тогда
			ВызватьИсключение "Не смог прочитать файл версии: " + Файл.ПолноеИм;
		КонецЕсли;	 
		
		Поз                  = Найти(Массив[0],"|");
		ВерсияСтрокой        = Лев(Массив[0],Поз-1);
		ИмяИзСтроки          = Сред(Массив[0],Поз+1);
		
		ПутьКОбработкеИлиОтчету = Новый Файл(Файл.Путь);
		
		ИмяОбработкиИлиОтчета = НРег(ПутьКОбработкеИлиОтчету.Путь + ИмяИзСтроки);
		
		Версии.Вставить(ИмяОбработкиИлиОтчета,ВерсияСтрокой);
	КонецЦикла;	
	
	Возврат Версии; 
КонецФункции	 

Процедура РаспаковатьФайлыПоМаске(Путь,Маска,ИскатьВПодкаталогах)
	Файлы = НайтиФайлы(Путь,Маска,ИскатьВПодкаталогах);
	Файлыfileversion = НайтиФайлы(Путь,"fileversion",ИскатьВПодкаталогах);
	ВерсииВсехФайлов = ВерсииВсехФайлов(Файлыfileversion);

	КоличествоФайлов = Файлы.Количество();
	НомерФайла = 0;
	Для Каждого Файл Из Файлы Цикл
		НомерФайла = НомерФайла + 1;
		Лог.Информация("Файл " + НомерФайла + " из " + КоличествоФайлов + ": " + Файл.ПолноеИмя);
		
		ВыгрузитьФайлВXML(Файл.ПолноеИмя,ВерсииВсехФайлов);
	КонецЦикла;	
	
КонецПроцедуры 

Процедура РазобратьОбработкуИлиОтчетВКаталогеИПодКаталогах(Путь)
	Файл = Новый Файл(Путь);
	Если НЕ Файл.Существует() Тогда
		ВызватьИсключение "Каталог <" + Путь + "> не существует.";
	КонецЕсли;	 
	
	РаспаковатьФайлыПоМаске(Путь,"*.erf",Истина);
	РаспаковатьФайлыПоМаске(Путь,"*.epf",Истина);
КонецПроцедуры 



Лог = Логирование.ПолучитьЛог("vb.decompile.log");
Лог.УстановитьУровень(УровниЛога.Отладка);

Если АргументыКоманднойСтроки.Количество() = 0 Тогда
	Лог.Ошибка("Не переданы параметры!");
ИначеЕсли АргументыКоманднойСтроки.Количество() > 1 Тогда
	Лог.Ошибка("Скрипт принимает только один параметр!");
Иначе
	УправлениеКонфигуратором  = Новый УправлениеКонфигуратором();
	
	ПутьКВерсииПлатформы8310 = УправлениеКонфигуратором.ПолучитьПутьКВерсииПлатформы("8.3.10");
	УправлениеКонфигуратором.ПутьКПлатформе1С(ПутьКВерсииПлатформы8310);
	
	КаталогБазы = ПолучитьИмяВременногоФайла();
	УправлениеКонфигуратором.СоздатьФайловуюБазу(КаталогБазы);
	УправлениеКонфигуратором.УстановитьКонтекст("/F""" + КаталогБазы + """","","");
	
	РазобратьОбработкуИлиОтчетВКаталогеИПодКаталогах(АргументыКоманднойСтроки[0]);
КонецЕсли;

Сообщить("////////////////////");
Сообщить("Обработка завершена.");
Sleep(5000);


