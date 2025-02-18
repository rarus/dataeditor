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

	Параметры.Свойство("ОтображатьСиноним", ОтображатьСиноним);
	Параметры.Свойство("СоответствиеТаблицИСтраниц", СоответствиеТаблицИСтраниц);

	Если Параметры.Свойство("ТабличныеЧасти") Тогда
		// BSLLS:UsingServiceTag-off
		//@skip-check unknown-form-parameter-access
		// BSLLS:UsingServiceTag-on
		ТабличныеЧасти.Загрузить(Параметры.ТабличныеЧасти.Выгрузить());
		НаименованиеТЧ = ПолучитьНаименованиеТаблиц("Табличные части", ТабличныеЧасти);
		ЗаполнитьДерево(НаименованиеТЧ, ТабличныеЧасти, БиблиотекаКартинок.ВложеннаяТаблица);
	КонецЕсли;

	Если Параметры.Свойство("ДобавленныеРегистрыСведений") Тогда
		// BSLLS:UsingServiceTag-off
		//@skip-check unknown-form-parameter-access
		// BSLLS:UsingServiceTag-on
		ДобавленныеРегистрыСведений.Загрузить(Параметры.ДобавленныеРегистрыСведений.Выгрузить());
		НаименованиеРС = ПолучитьНаименованиеТаблиц("Регистры сведений", ДобавленныеРегистрыСведений);
		ЗаполнитьДерево(НаименованиеРС, ДобавленныеРегистрыСведений, БиблиотекаКартинок.РегистрСведений);
	КонецЕсли;

	Если Параметры.Свойство("ДобавленныеРегистрыНакопления") Тогда
		// BSLLS:UsingServiceTag-off
		//@skip-check unknown-form-parameter-access
		// BSLLS:UsingServiceTag-on
		ДобавленныеРегистрыНакопления.Загрузить(Параметры.ДобавленныеРегистрыНакопления.Выгрузить());
		НаименованиеРН = ПолучитьНаименованиеТаблиц("Регистры накопления", ДобавленныеРегистрыНакопления);
		ЗаполнитьДерево(НаименованиеРН, ДобавленныеРегистрыНакопления, БиблиотекаКартинок.РегистрНакопления);
	КонецЕсли;

	Если Параметры.Свойство("ДобавленныеРегистрыБухгалтерии") Тогда
		// BSLLS:UsingServiceTag-off
		//@skip-check unknown-form-parameter-access
		// BSLLS:UsingServiceTag-on
		ДобавленныеРегистрыБухгалтерии.Загрузить(Параметры.ДобавленныеРегистрыБухгалтерии.Выгрузить());
		НаименованиеРБ = ПолучитьНаименованиеТаблиц("Регистры бухгалтерии", ДобавленныеРегистрыБухгалтерии);
		ЗаполнитьДерево(НаименованиеРБ, ДобавленныеРегистрыБухгалтерии, БиблиотекаКартинок.РегистрБухгалтерии);
	КонецЕсли;

	Если Параметры.Свойство("ДобавленныеРегистрыРасчета") Тогда
		// BSLLS:UsingServiceTag-off
		//@skip-check unknown-form-parameter-access
		// BSLLS:UsingServiceTag-on
		ДобавленныеРегистрыРасчета.Загрузить(Параметры.ДобавленныеРегистрыРасчета.Выгрузить());
		НаименованиеРР = ПолучитьНаименованиеТаблиц("Регистры расчета", ДобавленныеРегистрыРасчета);
		ЗаполнитьДерево(НаименованиеРР, ДобавленныеРегистрыРасчета, БиблиотекаКартинок.РегистрРасчета);
	КонецЕсли;

	СтрокаРодитель = ЗаполнитьДерево("Планы обмена", , БиблиотекаКартинок.ПланОбмена);

	СтрокаСоответствия = СоответствиеТаблицИСтраниц.НайтиПоЗначению("ПланыОбменаОбъекта");

	Если Параметры.Свойство("ПланыОбменаОбъекта") Тогда
		// BSLLS:UsingServiceTag-off
		//@skip-check unknown-form-parameter-access
		// BSLLS:UsingServiceTag-on
		Для Каждого ЭлементПланОбмена Из Параметры.ПланыОбменаОбъекта.ПолучитьЭлементы() Цикл
			ДобавитьЭлементПланОбмена(ПланыОбменаОбъекта, ЭлементПланОбмена);

			НоваяСтрока = СтрокаРодитель.ПолучитьЭлементы().Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, ЭлементПланОбмена);
			НоваяСтрока.ИмяТаблицы = ЭлементПланОбмена.Имя;
			НоваяСтрока.Отметка = СтрокаСоответствия.Пометка;
		КонецЦикла;
	КонецЕсли;

	НаименованиеПО = ПолучитьНаименованиеТаблиц("Планы обмена", ПланыОбменаОбъекта.ПолучитьЭлементы());
	СтрокаРодитель.ИмяТаблицы = НаименованиеПО;
	СтрокаРодитель.Синоним = НаименованиеПО;
	СтрокаРодитель.Имя = "ПланыОбменаОбъекта";

	Элементы.ДеревоТаблицИмяТаблицы.Видимость = Не ОтображатьСиноним;
	Элементы.ДеревоТаблицСиноним.Видимость = ОтображатьСиноним;

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	Для Каждого ГруппаТаблиц Из ДеревоТаблиц.ПолучитьЭлементы() Цикл
		ВыставитьОтметкиУРодителейДереваТаблиц(ГруппаТаблиц);
	КонецЦикла;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыДеревоТаблиц

&НаКлиенте
Процедура ДеревоТаблицОтметкаПриИзменении(Элемент)

	ТекущиеДанные = Элементы.ДеревоТаблиц.ТекущиеДанные;

	ТекущиеДанные.Отметка = ?(ТекущиеДанные.Отметка = 2, 0, ТекущиеДанные.Отметка); // BSLLS:MagicNumber-off

	ВыставитьОтметкуВСпискеСоответствия(ТекущиеДанные.Имя, ТекущиеДанные.Отметка);

	Родитель = ТекущиеДанные.ПолучитьРодителя();

	Если Родитель = Неопределено Тогда
		УстановитьСнятьОтметку(ТекущиеДанные.Отметка, ТекущиеДанные);
	Иначе
		Если СтрНайти(Родитель.ИмяТаблицы, "Планы обмена") > 0 Тогда
			ТекущиеДанные.Отметка = Родитель.Отметка;
			Возврат;
		КонецЕсли;

		ВыставитьОтметкиУРодителейДереваТаблиц(Родитель);

	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПрименитьИзменения(Команда)

	ОповеститьОВыборе(СоответствиеТаблицИСтраниц);

КонецПроцедуры

&НаКлиенте
Процедура ОтметитьВсе(Команда)
	УстановитьСнятьОтметку(Истина, ДеревоТаблиц);
КонецПроцедуры

&НаКлиенте
Процедура СнятьВсе(Команда)
	УстановитьСнятьОтметку(Ложь, ДеревоТаблиц);
КонецПроцедуры

&НаКлиенте
Процедура ТолькоЗаполненные(Команда)

	Для Каждого ГруппаТаблиц Из ДеревоТаблиц.ПолучитьЭлементы() Цикл
		Для Каждого ТекущаяТаблица Из ГруппаТаблиц.ПолучитьЭлементы() Цикл
			ТекущаяТаблица.Отметка = (ТекущаяТаблица.КоличествоЗаписей > 0);
			ВыставитьОтметкуВСпискеСоответствия(ТекущаяТаблица.Имя, ТекущаяТаблица.Отметка);
		КонецЦикла;

		ВыставитьОтметкиУРодителейДереваТаблиц(ГруппаТаблиц);
	КонецЦикла;

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура УстановитьСнятьОтметку(Отметка, Родитель)

	Для Каждого ЭлементДерева Из Родитель.ПолучитьЭлементы() Цикл
		ЭлементДерева.Отметка = Отметка;
		ВыставитьОтметкуВСпискеСоответствия(ЭлементДерева.Имя, Отметка);
		УстановитьСнятьОтметку(Отметка, ЭлементДерева);
	КонецЦикла;

КонецПроцедуры

&НаСервере
Процедура ДобавитьЭлементПланОбмена(Родитель, ИсходнаяСтрока)

	НоваяСтрока = Родитель.ПолучитьЭлементы().Добавить();
	ЗаполнитьЗначенияСвойств(НоваяСтрока, ИсходнаяСтрока);

	Для Каждого ЭлементПланОбмена Из ИсходнаяСтрока.ПолучитьЭлементы() Цикл
		ДобавитьЭлементПланОбмена(НоваяСтрока, ЭлементПланОбмена);
	КонецЦикла;

КонецПроцедуры

&НаСервере
Функция ЗаполнитьДерево(Вид, ДобавленныеТаблицы = Неопределено, Картинка = Неопределено)

	СтрокаРодитель = ДеревоТаблиц.ПолучитьЭлементы().Добавить();
	СтрокаРодитель.ИмяТаблицы = Вид;
	СтрокаРодитель.Синоним = Вид;
	СтрокаРодитель.Картинка = Картинка;

	Если ДобавленныеТаблицы = Неопределено Тогда
		Возврат СтрокаРодитель;
	КонецЕсли;

	Для Каждого ТекущаяТаблица Из ДобавленныеТаблицы Цикл
		НоваяСтрока = СтрокаРодитель.ПолучитьЭлементы().Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, ТекущаяТаблица);

		Если ТекущаяТаблица.КоличествоЗаписей > 0 Тогда
			НоваяСтрока.ИмяТаблицы = СтрШаблон("%1 (%2)", НоваяСтрока.ИмяТаблицы, ТекущаяТаблица.КоличествоЗаписей);
			НоваяСтрока.Синоним = СтрШаблон("%1 (%2)", НоваяСтрока.Синоним, ТекущаяТаблица.КоличествоЗаписей);
		КонецЕсли;

		СтрокаСоответствия = СоответствиеТаблицИСтраниц.НайтиПоЗначению(ТекущаяТаблица.Имя);
		НоваяСтрока.Отметка = СтрокаСоответствия.Пометка;
	КонецЦикла;

	Возврат СтрокаРодитель;

КонецФункции

&НаСервере
Функция ПолучитьНаименованиеТаблиц(Наименование, ДобавленныеТаблицы)

	Если ДобавленныеТаблицы.Количество() > 0 Тогда
		Возврат СтрШаблон("%1 (%2)", Наименование, ДобавленныеТаблицы.Количество());
	Иначе
		Возврат СтрШаблон("%1", Наименование);
	КонецЕсли;

КонецФункции

&НаКлиенте
Процедура ВыставитьОтметкиУРодителейДереваТаблиц(Родитель)

	КоличествоОтметок = 0;
	ПодчиненныеЭлементыДерева = Родитель.ПолучитьЭлементы();

	Для Каждого ПодчиненныйЭлемент Из ПодчиненныеЭлементыДерева Цикл
		КоличествоОтметок = КоличествоОтметок + ПодчиненныйЭлемент.Отметка;
	КонецЦикла;

	Если КоличествоОтметок = ПодчиненныеЭлементыДерева.Количество() И ПодчиненныеЭлементыДерева.Количество() > 0 Тогда
		Родитель.Отметка = 1;
	Иначе
		Родитель.Отметка = ?(КоличествоОтметок > 0, 2, КоличествоОтметок);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ВыставитьОтметкуВСпискеСоответствия(Имя, Пометка)

	СтрокаСоответствия = СоответствиеТаблицИСтраниц.НайтиПоЗначению(Имя);

	Если СтрокаСоответствия <> Неопределено Тогда
		СтрокаСоответствия.Пометка = Пометка;
	КонецЕсли;

КонецПроцедуры

#КонецОбласти