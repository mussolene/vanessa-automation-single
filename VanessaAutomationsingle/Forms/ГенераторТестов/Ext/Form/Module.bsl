﻿&НаКлиенте
Перем Ванесса;

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("СоответствиеТекстовСообщений") Тогда
		Если  ТипЗнч(Параметры.СоответствиеТекстовСообщений) = Тип("Соответствие") Тогда 
			СоответствиеТекстовСообщений = Новый ФиксированноеСоответствие(Параметры.СоответствиеТекстовСообщений);
		КонецЕсли;
	КонецЕсли;
	
	ДеревоМетаданныхЗаполнить();
	
КонецПроцедуры

#КонецОбласти

#Область ЭкспортныеПроцедурыИфункции

&НаКлиенте
Процедура Инициализация(Парам) Экспорт
	Ванесса = Парам;
КонецПроцедуры 

// Делает отключение модуля
&НаКлиенте
Функция ОтключениеМодуля() Экспорт

	Ванесса = Неопределено;
	
КонецФункции

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	ОтключениеМодуля();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура СформироватьСценарии(Команда)
	ПодготовитьДанныеДерева();
КонецПроцедуры

&НаКлиенте
Процедура ПодготовитьСценарииКВыполнению(Команда)

	ИмяВременногоFeature = ПолучитьИмяВременногоФайла("feature");
	ВременныйФайл = Новый Файл(ИмяВременногоFeature);
	КаталогВременныхФайлов = ВременныйФайл.Путь;

	КаталогФайлов = КаталогВременныхФайлов + "vanessa-automation";
	ИмяВременногоФайла = КаталогФайлов + ПолучитьРазделительПути() + "temp.feature";

	Если НЕ Ванесса.ФайлСуществуетКомандаСистемы(КаталогФайлов) Тогда
		Ванесса.СоздатьКаталогКомандаСистемы(КаталогФайлов);
	КонецЕсли;	 
	
	ЗаписьТекста = Новый ЗаписьТекста(ИмяВременногоФайла, КодировкаТекста.UTF8);
	ЗаписьТекста.ЗаписатьСтроку(СгенерированныйСценарий);
	ЗаписьТекста.Закрыть();

	ДопПараметры = Новый Структура("КаталогФич, УстановитьТекущийЭлемент", ИмяВременногоФайла, Истина);
	
	Ванесса.ЗагрузитьФичи(ДопПараметры);

КонецПроцедуры

&НаКлиенте
Процедура УстановитьПоУмолчанию(Команда)
	//TODO: Вставить содержимое обработчика
КонецПроцедуры

&НаКлиенте
Процедура УстановитьОткрытиеФормы(Команда)
	//TODO: Вставить содержимое обработчика
КонецПроцедуры

&НаКлиенте
Процедура УстановитьЗаписьНового(Команда)
	//TODO: Вставить содержимое обработчика
КонецПроцедуры

&НаКлиенте
Процедура УстановитьЗаписьСуществующего(Команда)
	//TODO: Вставить содержимое обработчика
КонецПроцедуры

&НаКлиенте
Процедура УстановитьВводНаОсновании(Команда)
	//TODO: Вставить содержимое обработчика
КонецПроцедуры

&НаКлиенте
Процедура ВыгрузитьНастройки(Команда)
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);		
	Диалог.Заголовок = Локализовать("Сохранение настроек");
	Диалог.ПредварительныйПросмотр = Ложь;
	Диалог.МножественныйВыбор = Ложь;
	Диалог.Фильтр = Локализовать("Настройки (*.json)|*.json");
	Диалог.ПолноеИмяФайла = "SmokeParams";
	Диалог.Расширение = "json";
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ВыгрузитьНастройкиЗавершение", ЭтаФорма);
	Диалог.Показать(ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьНастройки(Команда)
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	Диалог.МножественныйВыбор = Ложь;
	Диалог.Заголовок = Локализовать("Выберите файл настроек генератора сценариев.");
	Диалог.Фильтр = Локализовать("Настройки (*.json)|*.json");
	ОписаниеОповещения = Новый ОписаниеОповещения("ЗагрузитьНастройкиОбработчикОповещения", ЭтаФорма);
	Диалог.Показать(ОписаниеОповещения);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыОбработчикиСобытийЭлементовТаблицыФормы

&НаКлиенте
Процедура ДеревоОбъектовМетаданныхФлажокПриИзменении(Элемент)

	ЭлементДерева = ТекущийЭлемент.ТекущиеДанные;
	ПриПометкеЭлементаДерева(ЭлементДерева, "Пометка");

КонецПроцедуры

&НаКлиенте
Процедура ДеревоОбъектовМетаданныхСценарийЗаписьСуществующегоПриИзменении(Элемент)

	ЭлементДерева = ТекущийЭлемент.ТекущиеДанные;
	ПриПометкеЭлементаДерева(ЭлементДерева, "СценарийЗаписьСуществующего");

КонецПроцедуры

&НаКлиенте
Процедура ДеревоОбъектовМетаданныхСценарийОткрытьФормуПриИзменении(Элемент)

	ЭлементДерева = ТекущийЭлемент.ТекущиеДанные;
	ПриПометкеЭлементаДерева(ЭлементДерева, "СценарийОткрытьФорму");

КонецПроцедуры

&НаКлиенте
Процедура ДеревоОбъектовМетаданныхСценарийЗаписьНовогоПриИзменении(Элемент)

	ЭлементДерева = ТекущийЭлемент.ТекущиеДанные;
	ПриПометкеЭлементаДерева(ЭлементДерева, "СценарийЗаписьНового");

КонецПроцедуры

&НаКлиенте
Процедура ДеревоОбъектовМетаданныхСценарийВводНаОснованииПриИзменении(Элемент)

	ЭлементДерева = ТекущийЭлемент.ТекущиеДанные;
	ПриПометкеЭлементаДерева(ЭлементДерева, "СценарийВводНаОсновании");

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ЗагрузитьНастройкиОбработчикОповещения(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт 
	Если ВыбранныеФайлы = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПолноеИмяФайла = ВыбранныеФайлы[0];
	
	// Проверяем, есть ли в дереве установленные настройки
	ВерхнийУровень = ДеревоОбъектовМетаданных.ПолучитьЭлементы()[0];
	Если ВерхнийУровень.Пометка <> ПометкаФлажокНеУстановлен() Тогда
		ОписаниеОповещения = Новый ОписаниеОповещения("ЗагрузитьНастройкиПродолжение", ЭтотОбъект, ПолноеИмяФайла);
		ТекстВопроса = Локализовать("Обнаружены настройки в дереве конфигурации. Очистить?");
		ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, РежимДиалогаВопрос.ДаНетОтмена);
	Иначе 
		ЗагрузитьНастройкиЗавершение(ПолноеИмяФайла);
	КонецЕсли;
КонецПроцедуры 

// Добавляет новую строку в дерево значений формы (дерево),
// а также заполняет полный набор строк из метаданных по переданному параметру.
//
// Если параметр Подсистемы заполнен, то вызывается рекурсивно для всех дочерних подсистем.
//
// Параметры:
//   ПараметрыЭлемента - Структура с полями:
//     Имя           - Строка - имя родительского элемента.
//     Синоним       - Строка - синоним родительского элемента.
//     Пометка       - Булево - начальная пометка коллекции или объекта метаданных.
//     Картинка      - Число - код картинки родительского элемента.
//     КартинкаОбъекта - Число - код картинки подэлемента.
//     Родитель        - ссылка на элемента дерева значений, который является корнем
//                       для добавляемого элемента.
//   Подсистемы      - если заполнен, то содержит значение Метаданные.Подсистемы (коллекцию элементов).
//   Проверять       - Булево - признак проверки на принадлежность родительским подсистемам.
// 
// Возвращаемое значение:
// 
//   Строка дерева объектов метаданных.
//
&НаСервере
Функция ДобавитьЭлементДереваОбъектовМетаданных(ПараметрыЭлемента, 	Проверять = Истина)

	Если Метаданные[ПараметрыЭлемента.Имя].Количество() = 0 Тогда
		Возврат Неопределено;
	КонецЕсли;

	НоваяСтрока = НоваяСтрокаДерева(ПараметрыЭлемента, Ложь);

	Для Каждого ЭлементКоллекцииМетаданных Из Метаданные[ПараметрыЭлемента.Имя] Цикл

		ПараметрыЭлемента = ПараметрыЭлементаДереваОбъектовМетаданных();
		ПараметрыЭлемента.Имя = ЭлементКоллекцииМетаданных.Имя;
		ПараметрыЭлемента.ПолноеИмя = ЭлементКоллекцииМетаданных.ПолноеИмя();
		ПараметрыЭлемента.Синоним = ЭлементКоллекцииМетаданных.Синоним;
		ПараметрыЭлемента.КартинкаОбъекта = ПараметрыЭлемента.КартинкаОбъекта;
		ПараметрыЭлемента.Родитель = НоваяСтрока;
		ПараметрыЭлемента.Тип = ТипОбъектаМетаданных(ЭлементКоллекцииМетаданных);
		НоваяСтрокаДерева(ПараметрыЭлемента, Истина);

	КонецЦикла;

	Возврат НоваяСтрока;

КонецФункции

// Добавляет новую строку в таблицу значений видов объектов метаданных
// конфигурации.
//
// Параметры:
// Имя           - имя объекта метаданных или вида объекта метаданных.
// Синоним       - синоним объекта метаданных.
// Картинка      - картинка поставленная в соответствие объекту метаданных
//                 или виду объекта метаданных.
// ЭтоКоллекцияОбщие - признак того, что текущий элемент содержит подэлементы.
//
&НаСервере
Процедура КоллекцииОбъектовМетаданных_НоваяСтрока(Имя, Синоним, Картинка, КартинкаОбъекта, Таб)
	
	НоваяСтрока = Таб.Добавить();
	НоваяСтрока.Имя               = Имя;
	НоваяСтрока.Синоним           = Синоним;
	НоваяСтрока.Картинка          = Картинка;
	НоваяСтрока.КартинкаОбъекта   = КартинкаОбъекта;
	
КонецПроцедуры

// Возвращает новую структуру параметров элемента дерева объектов метаданных.
//
// Возвращаемое значение:
//   Структура с полями:
//     Имя           - Строка - имя родительского элемента.
//     Синоним       - Строка - синоним родительского элемента.
//     Пометка       - Булево - начальная пометка коллекции или объекта метаданных.
//     Картинка      - Число - код картинки родительского элемента.
//     КартинкаОбъекта - Число - код картинки подэлемента.
//     Родитель        - ссылка на элемента дерева значений, который является корнем
//                       для добавляемого элемента.
//
&НаСервере
Функция ПараметрыЭлементаДереваОбъектовМетаданных()
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("Имя", "");
	СтруктураПараметров.Вставить("ПолноеИмя", "");
	СтруктураПараметров.Вставить("Синоним", "");
	СтруктураПараметров.Вставить("Пометка", 0);
	СтруктураПараметров.Вставить("Картинка", 0);
	СтруктураПараметров.Вставить("КартинкаОбъекта", Неопределено);
	СтруктураПараметров.Вставить("Родитель", Неопределено);
	СтруктураПараметров.Вставить("Тип", "");
	
	Возврат СтруктураПараметров;
	
КонецФункции

&НаСервере
Функция НоваяСтрокаДерева(ПараметрыСтроки, ЭтоОбъектМетаданных = Ложь)
	
	Коллекция = ПараметрыСтроки.Родитель.ПолучитьЭлементы();
	НоваяСтрока = Коллекция.Добавить();
	НоваяСтрока.Имя                 = ПараметрыСтроки.Имя;
	НоваяСтрока.Представление       = ?(ЗначениеЗаполнено(ПараметрыСтроки.Синоним), ПараметрыСтроки.Синоним, ПараметрыСтроки.Имя);
	НоваяСтрока.Картинка            = ПараметрыСтроки.Картинка;
	НоваяСтрока.ПолноеИмя           = ПараметрыСтроки.ПолноеИмя;
	НоваяСтрока.ЭтоОбъектМетаданных = ЭтоОбъектМетаданных;
	НоваяСтрока.Тип                 = ПараметрыСтроки.Тип;
	Возврат НоваяСтрока;
	
КонецФункции

&НаКлиенте
Процедура ПодготовитьДанныеДерева()

	МассивСценариев = Новый Массив;

	ЗаполнитьМассивЗаданийРекурсивно(ДеревоОбъектовМетаданных, МассивСценариев);

	СформироватьТекстыСценариев(МассивСценариев);

	Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.СтраницаСценарийПоведения;

КонецПроцедуры

&НаСервере
Процедура СформироватьТекстыСценариев(МассивСценариев)
		
	ТекстовыйДокумент = Новый ТекстовыйДокумент();
	
	ТекстЗаголовка = ШаблонФункциональностьКонтекст();
	ТекстовыйДокумент.ДобавитьСтроку(ТекстЗаголовка);
	
	Для Каждого СтрокаСценария Из МассивСценариев Цикл
		
		Если СтрокаСценария.СценарийОткрытьФорму Тогда
			ТекстСценария = ШаблонСценарияОткрытьФорму(СтрокаСценария);
			
			ТекстовыйДокумент.ДобавитьСтроку(ТекстСценария);
		КонецЕсли;
		
		Если СтрокаСценария.СценарийЗаписьНового Тогда
			ТекстСценария = ШаблонСценарияЗаписьНового(СтрокаСценария);
			
			ТекстовыйДокумент.ДобавитьСтроку(ТекстСценария);
		КонецЕсли;
	
		Если СтрокаСценария.СценарийЗаписьСуществующего Тогда
			ТекстСценария = ШаблонСценарияЗаписьСуществующего(СтрокаСценария);
			
			ТекстовыйДокумент.ДобавитьСтроку(ТекстСценария);
		КонецЕсли;
	
		Если СтрокаСценария.СценарийВводНаОсновании Тогда
			ТекстСценария = ШаблонСценарияВводНаОсновании(СтрокаСценария);
			
			ТекстовыйДокумент.ДобавитьСтроку(ТекстСценария);
		КонецЕсли;
		
	КонецЦикла;
	
	СгенерированныйСценарий = ТекстовыйДокумент.ПолучитьТекст();
			
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьМассивЗаданийРекурсивно(ДеревоОбъектов, МассивСценариев)

	ЭлементыДерева = ДеревоОбъектов.ПолучитьЭлементы();

	Для Каждого СтрокаДерева Из ЭлементыДерева Цикл
		
		СтруктураСценария = СтруктураСценария();
		
		Если СтрокаДерева.ЭтоОбъектМетаданных И СтрокаДерева.Пометка Тогда
			ЗаполнитьЗначенияСвойств(СтруктураСценария, СтрокаДерева);
			МассивСценариев.Добавить(СтруктураСценария);
		КонецЕсли;

		ЗаполнитьМассивЗаданийРекурсивно(СтрокаДерева, МассивСценариев);

	КонецЦикла;

КонецПроцедуры

&НаКлиенте
Функция СтруктураСценария()

	СтруктураСценария = Новый Структура;
	СтруктураСценария.Вставить("Имя", "");
	СтруктураСценария.Вставить("ПолноеИмя", "");
	СтруктураСценария.Вставить("СценарийОткрытьФорму", Ложь);
	СтруктураСценария.Вставить("СценарийЗаписьНового", Ложь);
	СтруктураСценария.Вставить("СценарийЗаписьСуществующего", Ложь);
	СтруктураСценария.Вставить("СценарийВводНаОсновании", Ложь);
	СтруктураСценария.Вставить("Тип", "");
	
	Возврат СтруктураСценария;

КонецФункции

&НаСервере
Процедура ДеревоМетаданныхЗаполнить()

	КоллекцииОбъектовМетаданных = Новый ТаблицаЗначений;
	КоллекцииОбъектовМетаданных.Колонки.Добавить("Имя");
	КоллекцииОбъектовМетаданных.Колонки.Добавить("Синоним");
	КоллекцииОбъектовМетаданных.Колонки.Добавить("Картинка");
	КоллекцииОбъектовМетаданных.Колонки.Добавить("КартинкаОбъекта");
	КоллекцииОбъектовМетаданных.Колонки.Добавить("ПолноеИмя");
	КоллекцииОбъектовМетаданных.Колонки.Добавить("Родитель");
	КоллекцииОбъектовМетаданных.Колонки.Добавить("Тип");

	КоллекцииОбъектовМетаданных_НоваяСтрока("Справочники", "Справочники", БиблиотекаКартинок.Справочник, БиблиотекаКартинок.Справочник, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("Документы", "Документы", БиблиотекаКартинок.Документ, БиблиотекаКартинок.ДокументОбъект, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("Отчеты", "Отчеты", БиблиотекаКартинок.Отчет, БиблиотекаКартинок.Отчет, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("Обработки", "Обработки", БиблиотекаКартинок.Обработка, БиблиотекаКартинок.Обработка, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("РегистрыСведений", "Регистры сведений", БиблиотекаКартинок.РегистрСведений, БиблиотекаКартинок.РегистрСведений, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("РегистрыНакопления", "Регистры накопления", БиблиотекаКартинок.РегистрНакопления, БиблиотекаКартинок.РегистрНакопления, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("РегистрыБухгалтерии", "Регистры бухгалтерии", БиблиотекаКартинок.РегистрБухгалтерии, БиблиотекаКартинок.РегистрБухгалтерии, КоллекцииОбъектовМетаданных);

// Создание предопределенных элементов.
	ПараметрыЭлемента = ПараметрыЭлементаДереваОбъектовМетаданных();
	ПараметрыЭлемента.Имя = Метаданные.Имя;
	ПараметрыЭлемента.Синоним = Метаданные.Синоним;
	ПараметрыЭлемента.Картинка = 79;
	ПараметрыЭлемента.Родитель = ДеревоОбъектовМетаданных;
	ЭлементКонфигурация = НоваяСтрокаДерева(ПараметрыЭлемента);
		
	// Заполнение дерева объектов метаданных.
	Для Каждого Строка Из КоллекцииОбъектовМетаданных Цикл

			Строка.Родитель = ЭлементКонфигурация;			
			ДобавитьЭлементДереваОбъектовМетаданных(Строка);
	
	КонецЦикла;
	
КонецПроцедуры

#Область ВыгрузкаНастроек

&НаКлиенте
Процедура ВыгрузитьНастройкиЗавершение(Результат, ДополнительныеПараметры) Экспорт 
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;

	ПолноеИмяФайла = Результат[0];

	НастройкиГенератора = ПодготовитьНастройкиКВыгрузке();
	
	ЗаписьТекста = Новый ЗаписьТекста(ПолноеИмяФайла,,,, Символы.ПС);
	ЗаписьТекста.Записать(НастройкиГенератора);
	ЗаписьТекста.Закрыть();
	
КонецПроцедуры

&НаКлиенте
Функция ПодготовитьНастройкиКВыгрузке()
	
	СтруктураНастроекВыгрузки = СтруктураНастроекГенератора();
	
	ЗаполнитьНастройкиГенератора(ДеревоОбъектовМетаданных, СтруктураНастроекВыгрузки);
	
	ПараметрыЗаписиJSON = Новый ПараметрыЗаписиJSON(, Символы.Таб);			
	
	ЗаписьJSON = Новый ЗаписьJSON;
	ЗаписьJSON.ПроверятьСтруктуру = Ложь;
	ЗаписьJSON.УстановитьСтроку(ПараметрыЗаписиJSON);
	
	ЗаписатьJSON(ЗаписьJSON, СтруктураНастроекВыгрузки);
	
	Результат = ЗаписьJSON.Закрыть();
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура ЗаполнитьНастройкиГенератора(ЭлементДерева, СтруктураНстроек)
	
	ВложенныеЭлементы = ЭлементДерева.ПолучитьЭлементы();
	
	Для каждого ВложенныйЭлемент Из ВложенныеЭлементы Цикл
		
		Если ВложенныйЭлемент.Пометка = ПометкаФлажокУстановлен()
			И ВложенныйЭлемент.ЭтоОбъектМетаданных Тогда		
			СтруктураСценария = СтруктураСценария();
			ЗаполнитьЗначенияСвойств(СтруктураСценария, ВложенныйЭлемент);
			
			СтруктураНстроек.Настройки.Добавить(СтруктураСценария);
		КонецЕсли;
		
		ЗаполнитьНастройкиГенератора(ВложенныйЭлемент, СтруктураНстроек);
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Функция СтруктураНастроекГенератора()

	НастройкиСохранения = Новый Структура;
	НастройкиСохранения.Вставить("Настройки", Новый Массив);
	
	Возврат НастройкиСохранения;

КонецФункции

#КонецОбласти

#Область ЗагрузкаНастроек

&НаКлиенте
Процедура ДеревоМетаданныхСнятьПоментки(ЭлементДерева)
	
	ВложенныеЭлементы = ЭлементДерева.ПолучитьЭлементы();
	Для каждого ВложенныйЭлемент Из ВложенныеЭлементы Цикл
		
		Если ВложенныйЭлемент.Пометка <> ПометкаФлажокНеУстановлен() Тогда
			
			ВложенныйЭлемент.Пометка = ПометкаФлажокНеУстановлен();	
			
			ПометитьЭлементыРодителейРекурсивно(ВложенныйЭлемент, "Пометка");
			
			ПометитьОсновнойЭлемент(ВложенныйЭлемент, "Пометка");
		КонецЕсли;
		
		ДеревоМетаданныхСнятьПоментки(ВложенныйЭлемент);
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьНастройкиПродолжение(Ответ, ДополнительныеПараметры) Экспорт 
	
	Если Ответ = КодВозвратаДиалога.Отмена Тогда
		Возврат;	
	КонецЕсли;
	
	Если Ответ = КодВозвратаДиалога.Да Тогда
		ДеревоМетаданныхСнятьПоментки(ДеревоОбъектовМетаданных);
	КонецЕсли;	
	
	ЗагрузитьНастройкиЗавершение(ДополнительныеПараметры);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьНастройкиЗавершение(Знач ПолноеИмяФайла)
	
	
	ЧтениеJSON = Новый ЧтениеJSON;
	ЧтениеJSON.ОткрытьФайл(ПолноеИмяФайла);
	
	Попытка
		НастройкиJSON = ПрочитатьJSON(ЧтениеJSON);
		
	Исключение
		НастройкиJSON = Неопределено;
	КонецПопытки;
	
	ЧтениеJSON.Закрыть();
	
	Если НастройкиJSON = Неопределено Тогда
		Возврат;	
	КонецЕсли;
	
	Для каждого СтрокаНастроек Из НастройкиJSON.Настройки Цикл
		ЗаполнитьНастройкуИзСтруктуры(СтрокаНастроек, ДеревоОбъектовМетаданных);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьНастройкуИзСтруктуры(Знач СтрокаНастроек, ЭлементДерева)
	
	ВложенныеЭлементы = ЭлементДерева.ПолучитьЭлементы();
	
	Для каждого ВложенныйЭлемент Из ВложенныеЭлементы Цикл
		
		Если СтрокаНастроек.ПолноеИмя = ВложенныйЭлемент.ПолноеИмя 
			И ВложенныйЭлемент.ЭтоОбъектМетаданных Тогда
			
			Для каждого КлючИЗначениеНастройки Из СтрокаНастроек Цикл
				Если СтрНачинаетсяС(КлючИЗначениеНастройки.Ключ, "Сценарий")
					И ВложенныйЭлемент[КлючИЗначениеНастройки.Ключ] <> КлючИЗначениеНастройки.Значение Тогда
				      ВложенныйЭлемент[КлючИЗначениеНастройки.Ключ] = КлючИЗначениеНастройки.Значение;
					
				      ПриПометкеЭлементаДерева(ВложенныйЭлемент, КлючИЗначениеНастройки.Ключ);
				КонецЕсли;	
			КонецЦикла;			
			//ЗаполнитьЗначенияСвойств(ВложенныйЭлемент, СтрокаНастроек,, "ПолноеИмя, Имя, Тип");
		
		КонецЕсли;
		
		ЗаполнитьНастройкуИзСтруктуры(СтрокаНастроек, ВложенныйЭлемент);
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область Локализация

// Возвращает текст сообщения пользователю с учетом языка, на котором запущен Менеджер тестирования
// 
// Параметры:
// 	Сообщение - Строка
// Возвращаемое значение:
// 	Строка
//
&НаКлиенте
Функция Локализовать(Сообщение) Экспорт

	Если СоответствиеТекстовСообщений = Неопределено Тогда
		Возврат Сообщение;	
	КонецЕсли;
	
	Результат = ТекстСообщенияПользователюВызовСервера(Сообщение, СоответствиеТекстовСообщений);
	Возврат Результат;

КонецФункции	 

&НаСервере
Функция ЛокализоватьСервер(Сообщение) Экспорт
	
	Возврат ТекстСообщенияПользователюВызовСервера(Сообщение, СоответствиеТекстовСообщений);
	
КонецФункции	 

// Служебная
//
&НаСервереБезКонтекста
Функция ТекстСообщенияПользователюВызовСервера(Сообщение, Знач ТекстыСообщенийПользователю)
	
	Если ЗначениеЗаполнено(ТекстыСообщенийПользователю) Тогда
		Значение = ТекстыСообщенийПользователю[Сообщение];
		Если ЗначениеЗаполнено(Значение) Тогда
			Возврат Значение;
		КонецЕсли;
	КонецЕсли;

	Возврат Сообщение;
	
КонецФункции
	
#КонецОбласти

#КонецОбласти

&НаКлиенте
Процедура ПометитьОсновнойЭлемент(ЭлементДерева, ТекущаяКолонка)
	
	Если ЭлементДерева.Пометка <> ЭлементДерева[ТекущаяКолонка] Тогда
		ЭлементДерева.Пометка = ЭлементДерева[ТекущаяКолонка];
		ПриПометкеЭлементаДерева(ЭлементДерева, "Пометка");
	КонецЕсли;

КонецПроцедуры

// Параметры:
//  ЭлементДерева - ДанныеФормыЭлементДерева.
//      * Пометка             - Число  - Обязательный реквизит дерева.
//      * ЭтоОбъектМетаданных - Булево - Обязательный реквизит дерева.
//
&НаКлиенте
Процедура ПриПометкеЭлементаДерева(ЭлементДерева, ИмяКолонки)
	
	ЭлементДерева[ИмяКолонки] = СледующееЗначениеПометкиЭлемента(ЭлементДерева, ИмяКолонки);
	
	Если ТребуетсяПометитьВложенныеЭлементы(ЭлементДерева, ИмяКолонки) Тогда 
		ПометитьВложенныеЭлементыРекурсивно(ЭлементДерева, ИмяКолонки);
	КонецЕсли;
	
	Если ЭлементДерева[ИмяКолонки] = ПометкаФлажокНеУстановлен() Тогда 
		ЭлементДерева[ИмяКолонки] = ЗначениеПометкиОтносительноВложенныхЭлементов(ЭлементДерева, ИмяКолонки);
	КонецЕсли;
	
	ПометитьЭлементыРодителейРекурсивно(ЭлементДерева, ИмяКолонки);
	
	ПометитьОсновнойЭлемент(ЭлементДерева, ИмяКолонки);
	
КонецПроцедуры

&НаКлиенте
Функция СледующееЗначениеПометкиЭлемента(ЭлементДерева, ИмяКолонки)
		
	Если ЭлементДерева.ЭтоОбъектМетаданных Тогда
		// Предыдущее значение пометки = 2 : Установлен квадрат.
		Если ЭлементДерева[ИмяКолонки] = 0 Тогда
			Возврат ПометкаФлажокНеУстановлен();
		КонецЕсли;
	КонецЕсли;
	
	// Предыдущее значение пометки = 1 : Флажок установлен.
	Если ЭлементДерева[ИмяКолонки] = 2 Тогда 
		Возврат ПометкаФлажокНеУстановлен();
	КонецЕсли;
	
	Возврат ЭлементДерева[ИмяКолонки];
	
КонецФункции

&НаКлиенте
Функция ТребуетсяПометитьВложенныеЭлементы(ЭлементДерева, ИмяКолонки)
	
	Если ЭлементДерева.ЭтоОбъектМетаданных Тогда 
			
		СостояниеВложенныхЭлементов = СостояниеВложенныхЭлементов(ЭлементДерева, ИмяКолонки);
		
		ЕстьПомеченные   = СостояниеВложенныхЭлементов.ЕстьПомеченные;
		ЕстьНепомеченные = СостояниеВложенныхЭлементов.ЕстьНепомеченные;
		
		Если ЕстьПомеченные И ЕстьНепомеченные Тогда 
			Возврат Ложь;
		КонецЕсли;
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции

&НаКлиенте
Процедура ПометитьЭлементыРодителейРекурсивно(ЭлементДерева, ИмяКолонки)
	
	Родитель = ЭлементДерева.ПолучитьРодителя();
	
	Если Родитель = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ЭлементыРодителя = Родитель.ПолучитьЭлементы();
	Если ЭлементыРодителя.Количество() = 0 Тогда
		Родитель[ИмяКолонки] = ПометкаФлажокУстановлен();	
	ИначеЕсли ЭлементДерева.Пометка = ПометкаКвадрат() Тогда
		Родитель[ИмяКолонки] = ПометкаКвадрат();
	Иначе
		Родитель[ИмяКолонки] = ЗначениеПометкиОтносительноВложенныхЭлементов(Родитель, ИмяКолонки);
	КонецЕсли;
	
	ПометитьЭлементыРодителейРекурсивно(Родитель, ИмяКолонки);
	
КонецПроцедуры

&НаКлиенте
Функция ЗначениеПометкиОтносительноВложенныхЭлементов(ЭлементДерева, ИмяКолонки)
	
	СостояниеВложенныхЭлементов = СостояниеВложенныхЭлементов(ЭлементДерева, ИмяКолонки);
	
	ЕстьПомеченные   = СостояниеВложенныхЭлементов.ЕстьПомеченные;
	ЕстьНепомеченные = СостояниеВложенныхЭлементов.ЕстьНепомеченные;
	
	Если ЭлементДерева.ЭтоОбъектМетаданных Тогда 
		
		Если ЭлементДерева[ИмяКолонки] = ПометкаФлажокУстановлен() Тогда 
			// Оставляем флажок взведенным независимо от вложенных.
			Возврат ПометкаФлажокУстановлен();
		КонецЕсли;
		
		Если ЭлементДерева[ИмяКолонки] = ПометкаФлажокНеУстановлен()
			Или ЭлементДерева[ИмяКолонки] = ПометкаКвадрат() Тогда 
			
			Если ЕстьПомеченные Тогда
				Возврат ПометкаКвадрат();
			Иначе 
				Возврат ПометкаФлажокНеУстановлен();
			КонецЕсли;
		КонецЕсли;
		
	Иначе 
		
		Если ЕстьПомеченные Тогда
			
			Если ЕстьНепомеченные Тогда
				Возврат ПометкаКвадрат();
			Иначе
				Возврат ПометкаФлажокУстановлен();
			КонецЕсли;
			
		КонецЕсли;
		
		Возврат ПометкаФлажокНеУстановлен();
		
	КонецЕсли;
	
КонецФункции

&НаКлиенте
Функция СостояниеВложенныхЭлементов(ЭлементДерева, ИмяКолонки)
	
	ВложенныеЭлементы = ЭлементДерева.ПолучитьЭлементы();
	
	ЕстьПомеченные   = Ложь;
	ЕстьНепомеченные = Ложь;
	
	Для каждого ВложенныйЭлемент Из ВложенныеЭлементы Цикл
		
		Если ВложенныйЭлемент[ИмяКолонки] = ПометкаФлажокНеУстановлен() Тогда 
			ЕстьНепомеченные = Истина;
			Продолжить;
		КонецЕсли;
		
		Если ВложенныйЭлемент[ИмяКолонки] = ПометкаФлажокУстановлен() Тогда 
			ЕстьПомеченные = Истина;
			
			Если ВложенныйЭлемент.ЭтоОбъектМетаданных Тогда 
				
				Состояние = СостояниеВложенныхЭлементов(ВложенныйЭлемент, ИмяКолонки);
				ЕстьПомеченные   = ЕстьПомеченные   Или Состояние.ЕстьПомеченные;
				ЕстьНепомеченные = ЕстьНепомеченные Или Состояние.ЕстьНепомеченные;
			КонецЕсли;
			
			Продолжить;
		КонецЕсли;
		
		Если ВложенныйЭлемент[ИмяКолонки] = ПометкаКвадрат() Тогда 
			ЕстьПомеченные   = Истина;
			ЕстьНепомеченные = Истина;
			Продолжить;
		КонецЕсли;
		
	КонецЦикла;
	
	Результат = Новый Структура;
	Результат.Вставить("ЕстьПомеченные",   ЕстьПомеченные);
	Результат.Вставить("ЕстьНепомеченные", ЕстьНепомеченные);
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура ПометитьВложенныеЭлементыРекурсивно(ЭлементДерева, ИмяКолонки)
	
	ВложенныеЭлементы = ЭлементДерева.ПолучитьЭлементы();
	
	Для каждого ВложенныйЭлемент Из ВложенныеЭлементы Цикл
		
		ВложенныйЭлемент[ИмяКолонки] = ЭлементДерева[ИмяКолонки];
		ПометитьВложенныеЭлементыРекурсивно(ВложенныйЭлемент, ИмяКолонки);
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Функция ПометкаФлажокНеУстановлен()	
	
	Возврат 0;
	
КонецФункции

&НаКлиенте
Функция ПометкаФлажокУстановлен()
	
	Возврат 1;
	
КонецФункции

&НаКлиенте
Функция ПометкаКвадрат()
	
	Возврат 2;
	
КонецФункции

&НаСервере
Функция ТипОбъектаМетаданных(ОбъектМетаданных)

	Если Метаданные.Справочники.Содержит(ОбъектМетаданных) Тогда
		Возврат "Справочник";

	ИначеЕсли Метаданные.Документы.Содержит(ОбъектМетаданных) Тогда
		Возврат "Документ";

	ИначеЕсли Метаданные.Обработки.Содержит(ОбъектМетаданных) Тогда
		Возврат "Обработка";

	ИначеЕсли Метаданные.Отчеты.Содержит(ОбъектМетаданных) Тогда
		Возврат "Отчет";

	ИначеЕсли Метаданные.БизнесПроцессы.Содержит(ОбъектМетаданных) Тогда
		Возврат "БизнесПроцесс";

	ИначеЕсли Метаданные.ПланыВидовХарактеристик.Содержит(ОбъектМетаданных) Тогда
		Возврат "ПланВидовХарактеристик";

	ИначеЕсли Метаданные.ПланыСчетов.Содержит(ОбъектМетаданных) Тогда
		Возврат "ПланСчетов";

	ИначеЕсли Метаданные.ПланыВидовРасчета.Содержит(ОбъектМетаданных) Тогда
		Возврат "ПланВидовРасчета";

	ИначеЕсли Метаданные.Задачи.Содержит(ОбъектМетаданных) Тогда
		Возврат "Задача";

	ИначеЕсли Метаданные.ПланыОбмена.Содержит(ОбъектМетаданных) Тогда
		Возврат "ПланОбмена";

	ИначеЕсли Метаданные.РегистрыСведений.Содержит(ОбъектМетаданных) Тогда
		Возврат "РегистрСведений";

	ИначеЕсли Метаданные.РегистрыНакопления.Содержит(ОбъектМетаданных) Тогда
		Возврат "РегистрНакопления";
		
	ИначеЕсли Метаданные.РегистрыБухгалтерии.Содержит(ОбъектМетаданных) Тогда
		Возврат "РегистрБухгалтерии";
		
	ИначеЕсли Метаданные.РегистрыРасчета.Содержит(ОбъектМетаданных) Тогда
		Возврат "РегистрРасчета";
		
	ИначеЕсли Метаданные.Перечисления.Содержит(ОбъектМетаданных) Тогда
		Возврат "Перечисление";

	Иначе
		ТекстСообщения = ЛокализоватьСервер("Неверный тип значения параметра (%1)");
		ТекстСообщения = СтрЗаменить(ТекстСообщения, "%1", Строка(ОбъектМетаданных));
		ВызватьИсключение ТекстСообщения;

	КонецЕсли;

КонецФункции

#Область ШаблоныСценариев

&НаСервереБезКонтекста
Функция ШаблонФункциональностьКонтекст()

	Текст = "
		|#language: ru
		|
		|@tree
		|
		|Функциональность: Дымовые тесты
		|
		|Контекст:
		|	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий";

	Возврат Текст;

КонецФункции

&НаСервереБезКонтекста
Функция ШаблонСценарияОткрытьФорму(Параметры)

	Сценарий = "";

	Если Параметры.Тип <> "Обработка" И Параметры.Тип <> "Отчет" Тогда

		Сценарий = Сценарий + "	
			|Сценарий: Открытие формы списка ""%Имя%"" 
			|
			|	Дано Я открываю основную форму списка %ТипОбъекта% ""%Имя%""
			|	Если появилось предупреждение тогда
			|		Тогда я вызываю исключение ""Не удалось открыть форму %ТипОбъекта% %Имя%""
			|	И Я закрываю текущее окно
			|";

		Сценарий = СтрЗаменить(Сценарий, "%ПолноеИмя%", Параметры.ПолноеИмя);
		Сценарий = СтрЗаменить(Сценарий, "%ТипОбъекта%", РодительныйПадеж(Параметры.Тип));
		Сценарий = СтрЗаменить(Сценарий, "%Имя%", Параметры.Имя);

	КонецЕсли;

	Сценарий = Сценарий + "
		|Сценарий: Открытие формы объекта ""%Имя%""
		|
		|	Дано Я открываю основную форму %ТипОбъекта% ""%Имя%""
		|	Если появилось предупреждение тогда
		|		Тогда я вызываю исключение ""Не удалось открыть форму %ТипОбъекта% %Имя%""
		|	И Я закрываю текущее окно
		|";
		
	Сценарий = СтрЗаменить(Сценарий, "%ПолноеИмя%", Параметры.ПолноеИмя);
	Сценарий = СтрЗаменить(Сценарий, "%ТипОбъекта%", РодительныйПадеж(Параметры.Тип));
	Сценарий = СтрЗаменить(Сценарий, "%Имя%", Параметры.Имя);

	Возврат Сценарий;

КонецФункции

&НаСервереБезКонтекста
Функция ШаблонСценарияЗаписьНового(Параметры)

	Текст = "
	|Сценарий: Запись нового ...
	|
	|	Дано ...";

	Возврат Текст;

КонецФункции

&НаСервереБезКонтекста
Функция ШаблонСценарияЗаписьСуществующего(Параметры)

	Текст = "
	|
	|Сценарий: Запись существующего
	|
	|	Дано ...
	|
	|";

	Возврат Текст;

КонецФункции

&НаСервереБезКонтекста
Функция ШаблонСценарияВводНаОсновании(Параметры)

	Текст = "
	|Сценарий: Ввод на основании
	|
	|	Дано ...";

	Возврат Текст;

КонецФункции

&НаСервереБезКонтекста
Функция РодительныйПадеж(Слово)
	
	Слово = НРег(Слово);
	Если Слово = "справочник" Тогда
		Возврат "справочника";
	ИначеЕсли Слово = "документ" Тогда 
		Возврат "документа";
	ИначеЕсли Слово = "обработка" Тогда
		Возврат "обработки";
	ИначеЕсли Слово = "отчет" Тогда
		Возврат "отчета";
	ИначеЕсли Слово = "регистрнакопления" Тогда
		Возврат "регистра накопления";
	ИначеЕсли Слово = "регистрсведений" Тогда
		Возврат "регистра сведений";
	ИначеЕсли Слово = "регистрбухгалтерии" Тогда
		Возврат "регистра бухгалтерии";
	КонецЕсли;
		
КонецФункции

#КонецОбласти
