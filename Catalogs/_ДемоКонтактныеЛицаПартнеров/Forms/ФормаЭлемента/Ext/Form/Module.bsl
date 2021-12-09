﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	УправлениеКонтактнойИнформацией.ПриСозданииНаСервере(ЭтотОбъект, Объект.Ссылка,, ПоложениеЗаголовкаЭлементаФормы.Лево);
	
	СкрываемыеВиды = Новый Массив;
	СкрываемыеВиды.Добавить(УправлениеКонтактнойИнформацией.ВидКонтактнойИнформацииПоИмени("_ДемоEmailФизическогоЛица"));
	
	ДополнительныеПараметры = УправлениеКонтактнойИнформацией.ПараметрыКонтактнойИнформации();
	ДополнительныеПараметры.СкрываемыеВиды = СкрываемыеВиды;
	ДополнительныеПараметры.ИмяЭлементаДляРазмещения = "ГруппаКонтактнаяИнформацияФизическогоЛица";
	ДополнительныеПараметры.ПоложениеЗаголовкаКИ = ПоложениеЗаголовкаЭлементаФормы.Верх;
	УправлениеКонтактнойИнформацией.ПриСозданииНаСервере(ЭтотОбъект, ФизическоеЛицо, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация
	
	// Учесть возможность создания из взаимодействия.
	Взаимодействия.ПодготовитьОповещения(ЭтотОбъект,Параметры,Ложь);
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	Если ЗначениеЗаполнено(ТекущийОбъект.ФизическоеЛицо) Тогда
		ЗначениеВРеквизитФормы(ТекущийОбъект.ФизическоеЛицо.ПолучитьОбъект(), "ФизическоеЛицо");
	КонецЕсли;

	УправлениеКонтактнойИнформацией.ПриЧтенииНаСервере(ЭтотОбъект, ФизическоеЛицо, "ГруппаКонтактнаяИнформацияФизическогоЛица");
	УправлениеКонтактнойИнформацией.ПриЧтенииНаСервере(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом

КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	ФизическоеЛицоОбъект = РеквизитФормыВЗначение("ФизическоеЛицо");
	УправлениеКонтактнойИнформацией.ОбработкаПроверкиЗаполненияНаСервере(ЭтотОбъект, ФизическоеЛицоОбъект, Отказ);
	Если НЕ Отказ Тогда
		УправлениеКонтактнойИнформацией.ОбработкаПроверкиЗаполненияНаСервере(ЭтотОбъект, Объект, Отказ);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация

КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	УправлениеКонтактнойИнформацией.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	УправлениеКонтактнойИнформацией.ПередЗаписьюНаСервере(ЭтотОбъект, ЭтотОбъект.ФизическоеЛицо);
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация
	
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ФизическоеЛицоОбъект = РеквизитФормыВЗначение("ФизическоеЛицо");
	
	Если Не ФизическоеЛицоОбъект.Ссылка.Пустая() Тогда
		ФизическоеЛицоОбъект.Записать();
		ЗначениеВРеквизитФормы(ФизическоеЛицоОбъект, "ФизическоеЛицо");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	ВзаимодействияКлиент.КонтактПослеЗаписи(ЭтотОбъект,Объект,ПараметрыЗаписи,"_ДемоКонтактныеЛицаПартнеров");
	ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ПодключитьОбработчикОжидания("ПроверитьНеобходимостьБлокировкиФизическогоЛица", 1, Ложь);
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	Если ИмяСобытия = "Запись__ДемоФизическиеЛица" И Источник = Объект.ФизическоеЛицо Тогда
		ПрочитатьКонтактнуюИнформациюФизическогоЛица();
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ФизическоеЛицоПриИзменении(Элемент)
	Если ПустаяСтрока(Объект.Наименование) Тогда
		Объект.Наименование = ФизическоеЛицо.Наименование;
	КонецЕсли;
	ИзменитьДанныеФизическогоЛица();
	
КонецПроцедуры

// СтандартныеПодсистемы.КонтактнаяИнформация

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияПриИзменении(Элемент)
	УправлениеКонтактнойИнформациейКлиент.НачатьИзменение(ЭтотОбъект, Элемент);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	УправлениеКонтактнойИнформациейКлиент.НачатьВыбор(ЭтотОбъект, Элемент, , СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияПриНажатии(Элемент, СтандартнаяОбработка)
	УправлениеКонтактнойИнформациейКлиент.НачатьВыбор(ЭтотОбъект, Элемент, , СтандартнаяОбработка);
КонецПроцедуры

// Параметры:
//  Элемент - ПолеФормы
//  СтандартнаяОбработка - Булево
//
&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияОчистка(Элемент, СтандартнаяОбработка)
	УправлениеКонтактнойИнформациейКлиент.НачатьОчистку(ЭтотОбъект, Элемент.Имя);
КонецПроцедуры

// Параметры:
//  Команда - КомандаФормы
//
&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияВыполнитьКоманду(Команда)
	УправлениеКонтактнойИнформациейКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда.Имя);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)
	
	УправлениеКонтактнойИнформациейКлиент.АвтоПодборАдреса(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка);
	
КонецПроцедуры

// Параметры:
//  Элемент - ПолеФормы
//  ВыбранноеЗначение - Произвольный
//  СтандартнаяОбработка -Булево
//
&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	УправлениеКонтактнойИнформациейКлиент.ОбработкаВыбора(ЭтотОбъект, ВыбранноеЗначение, Элемент.Имя, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	УправлениеКонтактнойИнформациейКлиент.НачатьОбработкуНавигационнойСсылки(ЭтотОбъект, Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьОбновлениеКонтактнойИнформации(Результат, ДополнительныеПараметры) Экспорт
	ОбновитьКонтактнуюИнформацию(Результат);
КонецПроцедуры

&НаСервере
Процедура ОбновитьКонтактнуюИнформацию(Результат)
	УправлениеКонтактнойИнформацией.ОбновитьКонтактнуюИнформацию(ЭтотОбъект, Объект, Результат);
КонецПроцедуры

// Конец СтандартныеПодсистемы.КонтактнаяИнформация

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
	ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПроверитьНеобходимостьБлокировкиФизическогоЛица()
	Если Модифицированность И НЕ ФизическоеЛицо.Ссылка.Пустая() Тогда
		Если ЗаблокироватьФизическоеЛицоПриРедактированииНаСервере(ФизическоеЛицо.Ссылка, ЭтотОбъект.УникальныйИдентификатор) Тогда
			ОтключитьОбработчикОжидания("ПроверитьНеобходимостьБлокировкиФизическогоЛица");
		Иначе
			Прочитать();
			ВызватьИсключение НСтр("ru = 'Данные контактного лица не могут быть записаны, т.к. личные данные физического лица не доступны для изменения.
				|Возможно, эти данные физического лица редактируются другим пользователем.'");
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ИзменитьДанныеФизическогоЛица()
	
	Если ФизическоеЛицо.Ссылка.Пустая() Тогда
		ПрочитатьКонтактнуюИнформациюФизическогоЛица();
		Возврат;
	КонецЕсли;
	
	Если ЗаблокироватьФизическоеЛицоПриРедактированииНаСервере(Объект.ФизическоеЛицо, ЭтотОбъект.УникальныйИдентификатор) Тогда
		РазблокироватьФизическоеЛицоПриРедактированииНаСервере(ФизическоеЛицо.Ссылка, ЭтотОбъект.УникальныйИдентификатор);
		ПрочитатьКонтактнуюИнформациюФизическогоЛица();
	Иначе
		Объект.ФизическоеЛицо = ФизическоеЛицо.Ссылка;
		ВызватьИсключение НСтр("ru = 'Данные контактного лица не могут быть записаны, т.к. личные данные физического лица не доступны для изменения.
			|Возможно, эти данные физического лица редактируются другим пользователем.'");
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ЗаблокироватьФизическоеЛицоПриРедактированииНаСервере(ФизическоеЛицо, ФормаУникальныйИдентификатор)
	
	Попытка
		ЗаблокироватьДанныеДляРедактирования(ФизическоеЛицо, ФизическоеЛицо.ВерсияДанных, ФормаУникальныйИдентификатор);
	Исключение
		Возврат Ложь;
	КонецПопытки;
	
	Возврат Истина;
	
КонецФункции

&НаСервереБезКонтекста
Функция РазблокироватьФизическоеЛицоПриРедактированииНаСервере(ФизическоеЛицоСсылка, ФормаУникальныйИдентификатор)
	Попытка
		РазблокироватьДанныеДляРедактирования(ФизическоеЛицоСсылка, ФормаУникальныйИдентификатор);
	Исключение
		Возврат Ложь;
	КонецПопытки;
	
	Возврат Истина;
	
КонецФункции

&НаСервере
Процедура ПрочитатьКонтактнуюИнформациюФизическогоЛица()
	
	ЗначениеВРеквизитФормы(Объект.ФизическоеЛицо.ПолучитьОбъект(), "ФизическоеЛицо");
	// СтандартныеПодсистемы.КонтактнаяИнформация
	УправлениеКонтактнойИнформацией.ПриЧтенииНаСервере(ЭтотОбъект, ФизическоеЛицо.Ссылка, "ГруппаКонтактнаяИнформацияФизическогоЛица");
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация
	
КонецПроцедуры
	
#КонецОбласти
