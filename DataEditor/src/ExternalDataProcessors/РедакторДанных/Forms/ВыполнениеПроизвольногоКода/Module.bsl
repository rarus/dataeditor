///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022-2025, ООО 1С-Рарус
// Все права защищены. Эта программа и сопроводительные материалы предоставляются
// в соответствии с условиями лицензии Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by-sa/4.0/
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Параметры.Свойство("ГруппаМетаданных", ГруппаМетаданных);
	Параметры.Свойство("ИмяОбъекта", ИмяОбъекта);
	Параметры.Свойство("ТекущийОбъект", ТекущийОбъект);

	ЗаполнитьПодсказкуПоКоду();

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	ЗаписатьОперациюБизнесСтатистики("ДействиеВыполнитьКод");

	ВсегоСтрок = СтрЧислоСтрок(ИсполняемыйКод.ПолучитьТекст());
	Элементы.ИсполняемыйКод.УстановитьГраницыВыделения(ВсегоСтрок + 1, 1, ВсегоСтрок + 1, 1);

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВыполнитьКод(Команда)

	ВыполнитьКодНаСервере();

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ВыполнитьКодНаСервере()

	ТекстОшибки = "";

	РедактируемыйОбъект = ?(ГруппаМетаданных = "Константы", Константы[ИмяОбъекта], ТекущийОбъект);

	РеквизитФормыВЗначение("Объект").ВыполнитьПроизвольныйКод(
		ИсполняемыйКод.ПолучитьТекст(),
		РедактируемыйОбъект,
		ТекстОшибки);

	Если Не ПустаяСтрока(ТекстОшибки) Тогда
		Сообщение = Новый СообщениеПользователю();
		Сообщение.Текст = ТекстОшибки;
		Сообщение.Поле = "ИсполняемыйКод";
		Сообщение.Сообщить();
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьПодсказкуПоКоду()

	Если ГруппаМетаданных = "ПланыОбмена" Тогда
		НаименованиеТипаДанных = НСтр("ru = 'ПланОбменаСсылка.%1'");

	ИначеЕсли ГруппаМетаданных = "Константы" Тогда
		НаименованиеТипаДанных = НСтр("ru = 'КонстантаМенеджер.%1'");

	ИначеЕсли ГруппаМетаданных = "Справочники" Тогда
		НаименованиеТипаДанных = НСтр("ru = 'СправочникСсылка.%1'");

	ИначеЕсли ГруппаМетаданных = "Документы" Тогда
		НаименованиеТипаДанных = НСтр("ru = 'ДокументСсылка.%1'");

	ИначеЕсли ГруппаМетаданных = "ПланыВидовХарактеристик" Тогда
		НаименованиеТипаДанных = НСтр("ru = 'ПланВидовХарактеристикСсылка.%1'");

	ИначеЕсли ГруппаМетаданных = "ПланыСчетов" Тогда
		НаименованиеТипаДанных = НСтр("ru = 'ПланСчетовСсылка.%1'");

	ИначеЕсли ГруппаМетаданных = "ПланыВидовРасчета" Тогда
		НаименованиеТипаДанных = НСтр("ru = 'ПланВидовРасчетаСсылка.%1'");

	ИначеЕсли ГруппаМетаданных = "БизнесПроцессы" Тогда
		НаименованиеТипаДанных = НСтр("ru = 'БизнесПроцессСсылка.%1'");

	ИначеЕсли ГруппаМетаданных = "Задачи" Тогда
		НаименованиеТипаДанных = НСтр("ru = 'ЗадачаСсылка.%1'");

	ИначеЕсли ГруппаМетаданных = "РегистрыСведений" Тогда
		НаименованиеТипаДанных = НСтр("ru = 'РегистрСведенийКлючЗаписи.%1'");
	КонецЕсли;

	НаименованиеТипаДанных = СтрШаблон(НаименованиеТипаДанных, ИмяОбъекта);

	ШаблонПодсказки = НСтр("ru = '// Для работы с объектом используйте параметр ""Объект""
						   |// Объект - %1'");
	ТекстПодсказки = СтрШаблон(ШаблонПодсказки, НаименованиеТипаДанных);

	ИсполняемыйКод.УстановитьТекст(ТекстПодсказки + Символы.ПС + Символы.ПС);

КонецПроцедуры

&НаСервере
Процедура ЗаписатьОперациюБизнесСтатистики(Знач ИмяОперации, Знач Значение = 1, Знач Комментарий = "")

	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	ОбработкаОбъект.ЗаписатьОперациюБизнесСтатистики(ИмяОперации, Значение, Комментарий);

КонецПроцедуры

#КонецОбласти