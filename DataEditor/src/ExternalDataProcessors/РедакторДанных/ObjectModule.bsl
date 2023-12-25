///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022-2024, ООО 1С-Рарус
// Все права защищены. Эта программа и сопроводительные материалы предоставляются
// в соответствии с условиями лицензии Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by-sa/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// Возвращает сведения о внешней обработке.
//
// Возвращаемое значение:
//   Структура - сведения о внешней обработке.
//
Функция СведенияОВнешнейОбработке() Экспорт

	// BSLLS:UsingServiceTag-off
	//@skip-check server-execution-safe-mode
	// BSLLS:UsingServiceTag-on
	МодульДополнительныеОтчетыИОбработки = Вычислить("ДополнительныеОтчетыИОбработки");

	// BSLLS:UsingServiceTag-off
	//@skip-check server-execution-safe-mode
	// BSLLS:UsingServiceTag-on
	МодульДополнительныеОтчетыИОбработкиКлиентСервер = Вычислить("ДополнительныеОтчетыИОбработкиКлиентСервер");

	ПараметрыРегистрации = МодульДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке("2.2.3.1");
	ПараметрыРегистрации.Информация = НСтр("ru = 'Редактор данных'");
	ПараметрыРегистрации.Вид = МодульДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка();
	ПараметрыРегистрации.Версия = ВерсияОбработки();

	Команда = ПараметрыРегистрации.Команды.Добавить();
	Команда.Представление = НСтр("ru = 'Редактор данных'");
	Команда.Использование = МодульДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	Команда.Идентификатор = "РедакторДанных";

	Возврат ПараметрыРегистрации;

КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Возвращает версию обработки.
//
// Возвращаемое значение:
//  Строка - Версия обработки
//
Функция ВерсияОбработки() Экспорт
	Возврат "1.0.1.5";
КонецФункции

// Предназначена для выполнения произвольного кода
//
// Параметры:
//  ИсполняемыйКод - Строка - выполняемый код.
//  Объект - Произвольный - объект, выбранный в текущий момент в редакторе.
//  ТекстОшибки - Строка - возвращает текст ошибки при выполнении кода.
//
Процедура ВыполнитьПроизвольныйКод(ИсполняемыйКод, Объект, ТекстОшибки) Экспорт

	// BSLLS:UsingServiceTag-off
	//@skip-check server-execution-safe-mode
	// BSLLS:UsingServiceTag-on
	Попытка
		Выполнить(ИсполняемыйКод);

	Исключение
		ТекстОшибки = ПолучитьОписаниеВозникшейОшибки(ИнформацияОбОшибке(), Истина);

		Позиция = СтрНайти(ТекстОшибки, "{<Неизвестный модуль>(");
		Если Позиция > 0 Тогда
			ТекстОшибки = Сред(ТекстОшибки, Позиция + 1);

			Позиция = СтрНайти(ТекстОшибки, ":");
			Если Позиция > 0 Тогда
				ТекстОшибки = Сред(ТекстОшибки, Позиция + 1);
			КонецЕсли;
		КонецЕсли;
	КонецПопытки;

КонецПроцедуры

// Функция возвращает список групп метаданных, обрабатываемых данным инструментом.
//
// Возвращаемое значение:
//   - Массив из см. ДобавитьГруппуМетаданных - список групп метаданных.
//
Функция ГруппыМетаданных() Экспорт

	ГруппыМетаданных = Новый Массив();

	ДобавитьГруппуМетаданных(ГруппыМетаданных, "ПланыОбмена", ПланыОбмена,
		"ПланОбмена", НСтр("ru = 'Планы обмена'"), 1);

	ДобавитьГруппуМетаданных(ГруппыМетаданных, "Константы", Константы,
		"Константа", НСтр("ru = 'Константы'"), 2);

	ДобавитьГруппуМетаданных(ГруппыМетаданных, "Справочники", Справочники,
		"Справочник", НСтр("ru = 'Справочники'"), 3);

	ДобавитьГруппуМетаданных(ГруппыМетаданных, "Документы", Документы,
		"Документ", НСтр("ru = 'Документы'"), 4);

	ДобавитьГруппуМетаданных(ГруппыМетаданных, "ПланыВидовХарактеристик", ПланыВидовХарактеристик,
		"ПланВидовХарактеристик", НСтр("ru = 'Планы видов характеристик'"), 5);

	ДобавитьГруппуМетаданных(ГруппыМетаданных, "ПланыСчетов", ПланыСчетов,
		"ПланСчетов", НСтр("ru = 'Планы счетов'"), 6);

	ДобавитьГруппуМетаданных(ГруппыМетаданных, "ПланыВидовРасчета", ПланыВидовРасчета,
		"ПланВидовРасчета", НСтр("ru = 'Планы видов расчета'"), 7);

	ДобавитьГруппуМетаданных(ГруппыМетаданных, "РегистрыСведений", РегистрыСведений,
		"РегистрСведений", НСтр("ru = 'Регистры сведений'"), 8);

	ДобавитьГруппуМетаданных(ГруппыМетаданных, "РегистрыНакопления", РегистрыНакопления,
		"РегистрНакопления", НСтр("ru = 'Регистры накопления'"), 9);

	ДобавитьГруппуМетаданных(ГруппыМетаданных, "РегистрыБухгалтерии", РегистрыБухгалтерии,
		"РегистрБухгалтерии", НСтр("ru = 'Регистры бухгалтерии'"), 10);

	ДобавитьГруппуМетаданных(ГруппыМетаданных, "РегистрыРасчета", РегистрыРасчета,
		"РегистрРасчета", НСтр("ru = 'Регистры расчета'"), 11);

	ДобавитьГруппуМетаданных(ГруппыМетаданных, "БизнесПроцессы", БизнесПроцессы,
		"БизнесПроцесс", НСтр("ru = 'Бизнес-процессы'"), 12);

	ДобавитьГруппуМетаданных(ГруппыМетаданных, "Задачи", Задачи,
		"Задача", НСтр("ru = 'Задачи'"), 13);

	Возврат ГруппыМетаданных;

КонецФункции

// Добавить группу метаданных.
//
// Параметры:
//  ГруппыМетаданных - Массив из см. ДобавитьГруппуМетаданных - Группа метаданных.
//  Имя - Строка - Имя группы.
//  МенеджерОбъектов - ПланыОбменаМенеджер
//                   - КонстантыМенеджер
//                   - СправочникиМенеджер
//                   - ДокументыМенеджер
//                   - ПланыВидовХарактеристикМенеджер
//                   - ПланыСчетовМенеджер
//                   - ПланыВидовРасчетаМенеджер
//                   - РегистрыСведенийМенеджер
//                   - БизнесПроцессыМенеджер
//                   - ЗадачиМенеджер - Менеджер объектов.
//  ПрефиксЗапроса - Строка - Префикс запроса.
//  Представление - Строка - Представление группы.
//  ИндексКартинки - Число - Индекс картинки.
//
Процедура ДобавитьГруппуМетаданных(ГруппыМетаданных, Имя, МенеджерОбъектов, ПрефиксЗапроса, Представление,
	ИндексКартинки)

	ОписаниеГруппы = Новый Структура();

	ОписаниеГруппы.Вставить("Имя", Имя);
	ОписаниеГруппы.Вставить("МенеджерОбъектов", МенеджерОбъектов);
	ОписаниеГруппы.Вставить("ПрефиксЗапроса", ПрефиксЗапроса);
	ОписаниеГруппы.Вставить("Представление", Представление);
	ОписаниеГруппы.Вставить("ИндексКартинки", ИндексКартинки);

	ГруппыМетаданных.Добавить(ОписаниеГруппы);

КонецПроцедуры

// Получить описание возникшей ошибки.
//
// Параметры:
//  ИнформацияОбОшибке - ИнформацияОбОшибке - информация о возникшей ошибке.
//  ПодробноеПредставлениеОшибки - Булево - признак необходимости формирования подробного текста ошибки.
//
// Возвращаемое значение:
//  Строка - описание возникшей ошибки.
//
Функция ПолучитьОписаниеВозникшейОшибки(ИнформацияОбОшибке, ПодробноеПредставлениеОшибки = Ложь) Экспорт

	СистемнаяИнформация = Новый СистемнаяИнформация();

	Если СравнитьВерсии(СистемнаяИнформация.ВерсияПриложения, "8.3.17.0") > 0 Тогда
		Если ПодробноеПредставлениеОшибки Тогда
			ВычисляемоеВыражение = "ОбработкаОшибок.ПодробноеПредставлениеОшибки(ИнформацияОбОшибке)";
		Иначе
			ВычисляемоеВыражение = "ОбработкаОшибок.КраткоеПредставлениеОшибки(ИнформацияОбОшибке)";
		КонецЕсли;

	Иначе
		Если ПодробноеПредставлениеОшибки Тогда
			ВычисляемоеВыражение = "ПодробноеПредставлениеОшибки(ИнформацияОбОшибке)";
		Иначе
			ВычисляемоеВыражение = "КраткоеПредставлениеОшибки(ИнформацияОбОшибке)";
		КонецЕсли;
	КонецЕсли;

	// BSLLS:UsingServiceTag-off
	//@skip-check server-execution-safe-mode
	// BSLLS:UsingServiceTag-on
	ОписаниеВозникшейОшибки = Вычислить(ВычисляемоеВыражение);

	Возврат ОписаниеВозникшейОшибки;

КонецФункции

// Сравнить две строки версий.
//
// Параметры:
//  СтрокаВерсии1  - Строка - номер версии в формате РР.{П|ПП}.ЗЗ.СС.
//  СтрокаВерсии2  - Строка - второй сравниваемый номер версии.
//
// Возвращаемое значение:
//   Число   - больше 0, если СтрокаВерсии1 > СтрокаВерсии2; 0, если версии равны.
//
Функция СравнитьВерсии(Знач СтрокаВерсии1, Знач СтрокаВерсии2) Экспорт

	Строка1 = ?(ПустаяСтрока(СтрокаВерсии1), "0.0.0.0", СтрокаВерсии1);
	Строка2 = ?(ПустаяСтрока(СтрокаВерсии2), "0.0.0.0", СтрокаВерсии2);

	ЧислоРазрядовВВерсии = 4;

	Версия1 = СтрРазделить(Строка1, ".");
	Если Версия1.Количество() <> ЧислоРазрядовВВерсии Тогда
		ВызватьИсключение СтрШаблон(
			НСтр("ru = 'Неправильный формат параметра %1: %2'"),
			"СтрокаВерсии1",
			СтрокаВерсии1);
	КонецЕсли;

	Версия2 = СтрРазделить(Строка2, ".");
	Если Версия2.Количество() <> ЧислоРазрядовВВерсии Тогда
		ВызватьИсключение СтрШаблон(
			НСтр("ru = 'Неправильный формат параметра %1: %2'"),
			"СтрокаВерсии2",
			СтрокаВерсии2);
	КонецЕсли;

	Результат = 0;
	Для Разряд = 0 По 3 Цикл
		Результат = Число(Версия1[Разряд]) - Число(Версия2[Разряд]);
		Если Результат <> 0 Тогда
			Возврат Результат;
		КонецЕсли;
	КонецЦикла;

	Возврат Результат;

КонецФункции

Функция ПолучитьСтруктуруПараметров(Значение) Экспорт

	ГруппыМетаданных = ГруппыМетаданных();

	ТипМетаданных = Метаданные.НайтиПоТипу(ТипЗнч(Значение));

	ПолноеИмя = ТипМетаданных.ПолноеИмя();
	ПозицияРазделителя = СтрНайти(ПолноеИмя, ".");

	ПрефиксЗапроса = Лев(ПолноеИмя, ПозицияРазделителя - 1);
	ИмяОбъекта = СтрЗаменить(ПолноеИмя, ПрефиксЗапроса + ".", "");

	СтруктураПараметров = Новый Структура();
	СтруктураПараметров.Вставить("ИмяОбъекта", ИмяОбъекта);
	СтруктураПараметров.Вставить("ПрефиксЗапроса", ПрефиксЗапроса);

	Для Каждого ЭлементГруппаМетаданных Из ГруппыМетаданных Цикл
		Если ЭлементГруппаМетаданных.ПрефиксЗапроса = ПрефиксЗапроса Тогда
			ГруппаМетаданных = ЭлементГруппаМетаданных.Имя;
			СтруктураПараметров.Вставить("ГруппаМетаданных", ГруппаМетаданных);
		КонецЕсли;
	КонецЦикла;

	Возврат СтруктураПараметров;

КонецФункции

Функция ПолныйПутьКФормеНаСервере(ИмяФормы) Экспорт

	Если Метаданные.Обработки.Найти("РедакторДанных") = Неопределено Тогда
		ПолныйПутьКФорме = "ВнешняяОбработка.РедакторДанных.Форма." + ИмяФормы;
	Иначе
		ПолныйПутьКФорме = "Обработка.РедакторДанных.Форма." + ИмяФормы;
	КонецЕсли;

	Возврат ПолныйПутьКФорме;

КонецФункции

Функция ПредставлениеТипаРеквизита(ОписаниеТипа, ЗначениеСвойства) Экспорт

	ПредставлениеТипа = "";

	Для Каждого ТекущийТип Из ОписаниеТипа.Типы() Цикл
		Если ТекущийТип = Тип("Строка") Тогда
			ШаблонТипа = "Строка (%1%2)";

			Если ОписаниеТипа.КвалификаторыСтроки.Длина = 0 Тогда
				ПредставлениеТекущегоТипа = СтрШаблон(
					// BSLLS:Typo-off
					ШаблонТипа, "Неогр", "");
					// BSLLS:Typo-on

			ИначеЕсли ОписаниеТипа.КвалификаторыСтроки.ДопустимаяДлина = ДопустимаяДлина.Фиксированная Тогда
				ПредставлениеТекущегоТипа = СтрШаблон(
					ШаблонТипа, "Ф", Формат(ОписаниеТипа.КвалификаторыСтроки.Длина, "ЧГ=0"));

			Иначе
				ПредставлениеТекущегоТипа = СтрШаблон(
					ШаблонТипа, "П", Формат(ОписаниеТипа.КвалификаторыСтроки.Длина, "ЧГ=0"));
			КонецЕсли;

		ИначеЕсли ТекущийТип = Тип("Число") Тогда
			ШаблонТипа = "Число (%1.%2%3)";

			Если ОписаниеТипа.КвалификаторыЧисла.ДопустимыйЗнак = ДопустимыйЗнак.Неотрицательный Тогда
				// BSLLS:Typo-off
				ТекстНеотрицательное = " неотр";
				// BSLLS:Typo-on
			Иначе
				ТекстНеотрицательное = "";
			КонецЕсли;

			ПредставлениеТекущегоТипа = СтрШаблон(
				ШаблонТипа,
				ОписаниеТипа.КвалификаторыЧисла.Разрядность,
				ОписаниеТипа.КвалификаторыЧисла.РазрядностьДробнойЧасти,
				ТекстНеотрицательное);

		ИначеЕсли ТекущийТип = Тип("Дата") Тогда
			ПредставлениеТекущегоТипа = Строка(ОписаниеТипа.КвалификаторыДаты.ЧастиДаты);
			Если ПустаяСтрока(ПредставлениеТекущегоТипа) Тогда
				ПредставлениеТекущегоТипа = "Дата";
			КонецЕсли;

		ИначеЕсли ТекущийТип = Тип("ХранилищеЗначения") Тогда
			ПредставлениеТекущегоТипа = НСтр("ru = 'Хранилище значения'");

		Иначе
			ПрикладнойОбъектМетаданных = Метаданные.НайтиПоТипу(ТекущийТип);

			Если ПрикладнойОбъектМетаданных = Неопределено Тогда
				ПредставлениеТекущегоТипа = Строка(ТекущийТип);
			Иначе
				ПредставлениеТекущегоТипа = ПрикладнойОбъектМетаданных.ПолноеИмя();
			КонецЕсли;
		КонецЕсли;

		ПредставлениеТипа = ПредставлениеТипа + ?(ПредставлениеТипа = "", "", ", ") + ПредставлениеТекущегоТипа;
	КонецЦикла;

	Возврат ПредставлениеТипа;

КонецФункции

#КонецОбласти

#КонецЕсли