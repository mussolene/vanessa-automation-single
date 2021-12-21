﻿
///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

&НаКлиенте
// контекст фреймворка Vanessa-Behavior
Перем Ванесса;
 
&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;

// Делает отключение модуля
&НаКлиенте
Функция ОтключениеМодуля() Экспорт

	Ванесса = Неопределено;
	Контекст = Неопределено;
	КонтекстСохраняемый = Неопределено;

КонецФункции

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,ОписаниеШага,ТипШага,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ТабличныйДокументСоответствуетМакету(Парам01,Парам02)","ТабличныйДокументСоответствуетМакету","И табличный документ ""РеквизитТабличныйДокумент"" соответствует макету ""ИмяМакета""");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ОбластьТабличногоДокументаСоответствуетМакету(Парам01,Парам02,Парам03)","ОбластьТабличногоДокументаСоответствуетМакету","И область ""R1C1:R10C10"" табличного документа ""РеквизитТабличныйДокумент"" соответствует макету ""ИмяМакета""");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ОбластьТабличногоДокументаРавнаМакету(Парам01,Парам02,Парам03)","ОбластьТабличногоДокументаРавнаМакету","И область ""R1C1:R10C10"" табличного документа ""РеквизитТабличныйДокумент"" равна макету ""ИмяМакета""","Сравнивает значения указанной области макета с эталоном. Макет ищется сначала в обработке фича файла, затем в каталоге проекта.  Чтобы получить mxl файл из TestClient, в тонком клиенте будет сделана попытка сохранить табличный документ в файл. В Web клиенте он всегда будет считываться по ячейкам. Детали в справке, в разделе, посвященному сравнению табличного документа с эталоном.","UI.Табличный документ.Проверка значения табличного документа.Эталонный макет.Область");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ОбластьТабличногоДокументаРавнаМакетуПоШаблону(Парам01,Парам02,Парам03)","ОбластьТабличногоДокументаРавнаМакетуПоШаблону","И область ""R1C1:R10C10"" табличного документа ""РеквизитТабличныйДокумент"" равна макету ""ИмяМакета"" по шаблону","Сравнивает значения указанной области макета с эталоном. В значениях допусается использовать символы *. Макет ищется сначала в обработке фича файла, затем в каталоге проекта.  Чтобы получить mxl файл из TestClient, в тонком клиенте будет сделана попытка сохранить табличный документ в файл. В Web клиенте он всегда будет считываться по ячейкам. Детали в справке, в разделе, посвященному сравнению табличного документа с эталоном.","UI.Табличный документ.Проверка значения табличного документа.Эталонный макет.Область");

	Возврат ВсеТесты;
КонецФункции
	
&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции
	
&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

&НаКлиенте
// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт
	
КонецПроцедуры

&НаКлиенте
// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт
	
КонецПроцедуры

///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//И табличный документ "ТабДок" соответствует макету "Макет1"
//@ТабличныйДокументСоответствуетМакету(Парам01,Парам02)
Процедура ТабличныйДокументСоответствуетМакету(ИмяРеквизита,ИмяМакета) Экспорт
	Макет = Ванесса.ПолучитьМакетОбработки(ИмяМакета);
	
	ТабДокБыло = Макет;
	Если Макет = Неопределено Тогда
		//будем искать макет в каталоге проекта
		ТабДокБыло = Ванесса.НайтиМакетВКаталогеПроекта(ИмяМакета);
	КонецЕсли;	 
	
	ПолеТабличногоДокумента = Ванесса.НайтиРеквизитОткрытойФормыПоЗаголовку(ИмяРеквизита,Истина);
	
	ТабДокСтало = Ванесса.ПолучитьТабличныйДокументTestClient(ПолеТабличногоДокумента);
	
	Попытка
		Ванесса.ПроверитьРавенствоТабличныхДокументовТолькоПоЗначениям(ТабДокБыло, ТабДокСтало);
	Исключение
		ТекстИсключения = ОписаниеОшибки();
		Ванесса.УстановитьЗначенияТаблицДляСравнения(ТабДокБыло,ТабДокСтало);
		
		Ванесса.ПрикрепитьМакетКСценарию(ТабДокСтало,Ванесса.Локализовать("ТекущееЗначениеМакета"));
		Ванесса.ПрикрепитьМакетКСценарию(ТабДокБыло,Ванесса.Локализовать("ЭталонноеЗначениеМакета"));
		Если Ванесса.РежимСовместимостиБольшеИлиРавен837 Тогда
			Ванесса.ПрикрепитьМакетКСценарию(Ванесса.ПолучитьРазличияВМакетах(ТабДокБыло, ТабДокСтало), Ванесса.Локализовать("Различия"));
		КонецЕсли;	 
		
		Ванесса.ПрикрепитьКСценариюДополнительныеФайлыСравненияЗначенияСЭталоном(ТабДокБыло, ТабДокСтало);
		
		ВызватьИсключение ТекстИсключения
	КонецПопытки;
	
КонецПроцедуры


&НаКлиенте
//И табличный документ "ТабДок" соответствует макету "Макет1"
//@ОбластьТабличногоДокументаСоответствуетМакету(Парам01,Парам02,Парам03)
Процедура ОбластьТабличногоДокументаСоответствуетМакету(ИмяОбласти,ИмяРеквизита,ИмяМакета,СравнениеПоШаблону = Ложь) Экспорт
	НачСтр = -1;
	НачКол = -1;
	КолСтр = -1;
	КолКол = -1;
	Попытка
		Ванесса.ПолучитьПараметрыОбластиМакета(ИмяОбласти,НачСтр,НачКол,КолСтр,КолКол);
	Исключение
		ТекстСообщения = Ванесса.ПолучитьТекстСообщенияПользователю("Не верный формат области <%1>. %2");
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",ИмяОбласти);
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%2",ОписаниеОшибки());
		ВызватьИсключение ТекстСообщения;
	КонецПопытки;
	
	
	//запомним предыдущее значение параметров считывания макета
	Попытка
		//ТекстШага = "Тогда Я задаю параметры считывания макета НачСтр " + XMLСтрока(НачСтр) + " НачКол  " + XMLСтрока(НачКол) + "  КолСтр  " + XMLСтрока(КолСтр) + "  КолКол  " + XMLСтрока(КолКол);
		//Ванесса.Шаг(ТекстШага);
		
		Макет = Ванесса.ПолучитьМакетОбработки(ИмяМакета);
		
		ТабДокБыло = Макет;
		Если Макет = Неопределено Тогда
			//будем искать макет в каталоге проекта
			ТабДокБыло = Ванесса.НайтиМакетВКаталогеПроекта(ИмяМакета);
		КонецЕсли;	 
		
		ПолеТабличногоДокумента   = Ванесса.НайтиРеквизитОткрытойФормыПоЗаголовку(ИмяРеквизита,Истина);
		
		ДопПараметры = Новый Структура;
		ДопПараметры.Вставить("СчитываниеПоЯчейкам",Ложь);
		ДопПараметры.Вставить("НадоСчитатьОбласть",Истина);
		ДопПараметры.Вставить("НачСтр",НачСтр);
		ДопПараметры.Вставить("НачКол",НачКол);
		ДопПараметры.Вставить("КолСтр",КолСтр);
		ДопПараметры.Вставить("КолКол",КолКол);
		ТабДокСтало = Ванесса.ПолучитьТабличныйДокументTestClient(ПолеТабличногоДокумента,ДопПараметры);
		
		//Если НЕ ДопПараметры.СчитываниеПоЯчейкам Тогда
		//	//т.к. при считывании по ячейкам уже была считана только нужная область табличного документа
		//	ТабДокСтало = ОставитьЧастьМакетаСогласноПараметровЧтенияМакета(ТабДокСтало,НачСтр,НачКол,КолСтр,КолКол);
		//КонецЕсли;	 
		
		Если СравнениеПоШаблону Тогда
			ДопПараметры = Новый Структура;
			ДопПараметры.Вставить("СравнениеПоШаблону",Истина);
		Иначе
			ДопПараметры = Неопределено;
		КонецЕсли;	 
		
		Попытка
			Ванесса.ПроверитьРавенствоТабличныхДокументовТолькоПоЗначениям(ТабДокБыло, ТабДокСтало,,,,ДопПараметры);
		Исключение
			ТекстИсключения = ОписаниеОшибки();
			Ванесса.УстановитьЗначенияТаблицДляСравнения(ТабДокБыло,ТабДокСтало);
			
			Ванесса.ПрикрепитьМакетКСценарию(ТабДокСтало,Ванесса.Локализовать("ТекущееЗначениеМакета"));
			Ванесса.ПрикрепитьМакетКСценарию(ТабДокБыло,Ванесса.Локализовать("ЭталонноеЗначениеМакета"));
			Если Ванесса.РежимСовместимостиБольшеИлиРавен837 Тогда
				Ванесса.ПрикрепитьМакетКСценарию(Ванесса.ПолучитьРазличияВМакетах(ТабДокБыло, ТабДокСтало), Ванесса.Локализовать("Различия"));
			КонецЕсли;	 
			
			Ванесса.ПрикрепитьКСценариюДополнительныеФайлыСравненияЗначенияСЭталоном(ТабДокБыло, ТабДокСтало);
			
			ВызватьИсключение ТекстИсключения;
		КонецПопытки;
	Исключение
		ВызватьИсключение ОписаниеОшибки();
	КонецПопытки;
	
КонецПроцедуры

&НаКлиенте
//И табличный документ "ТабДок" равна макету "Макет1"
//@ОбластьТабличногоДокументаРавнаМакету(Парам01,Парам02,Парам03)
Процедура ОбластьТабличногоДокументаРавнаМакету(ИмяОбласти,ИмяРеквизита,ИмяМакета) Экспорт
	ОбластьТабличногоДокументаСоответствуетМакету(ИмяОбласти,ИмяРеквизита,ИмяМакета);
КонецПроцедуры

&НаКлиенте
//И табличный документ "ТабДок" равна макету "Макет1" по шаблону
//@ОбластьТабличногоДокументаРавнаМакетуПоШаблону(Парам01,Парам02,Парам03)
Процедура ОбластьТабличногоДокументаРавнаМакетуПоШаблону(ИмяОбласти,ИмяРеквизита,ИмяМакета) Экспорт
	ОбластьТабличногоДокументаСоответствуетМакету(ИмяОбласти,ИмяРеквизита,ИмяМакета,Истина);
КонецПроцедуры
