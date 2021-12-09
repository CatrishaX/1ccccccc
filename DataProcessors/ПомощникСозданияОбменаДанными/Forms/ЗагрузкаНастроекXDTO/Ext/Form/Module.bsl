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
	
	УзелОбмена = Параметры.УзелОбмена;
	
	НаименованиеКорреспондента = Строка(УзелОбмена);
	
	Элементы.ДекорацияНадписьОжидание.Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		Элементы.ДекорацияНадписьОжидание.Заголовок, НаименованиеКорреспондента);
	
	Элементы.ДекорацияНадписьОшибка.Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		Элементы.ДекорацияНадписьОшибка.Заголовок, НаименованиеКорреспондента);
	
	Заголовок = НСтр("ru = 'Загрузка параметров обмена данными'");
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Элементы.ПанельОсновная.ТекущаяСтраница = Элементы.СтраницаДлительнаяОперация;
	Элементы.ФормаКомандаГотово.КнопкаПоУмолчанию = Ложь;
	Элементы.ФормаКомандаГотово.Доступность = Ложь;
	
	ПодключитьОбработчикОжидания("ПриНачалеЗагрузкиНастроекXDTO", 1, Истина);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КомандаГотово(Команда)
	
	Результат = Новый Структура;
	Результат.Вставить("ПродолжитьНастройку",            Ложь);
	Результат.Вставить("ПолученыДанныеДляСопоставления", Ложь);
	
	Закрыть(Результат);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПриНачалеЗагрузкиНастроекXDTO()
	
	ПродолжитьОжидание = Истина;
	ПриНачалеЗагрузкиНастроекXDTOНаСервере(ПродолжитьОжидание);
	
	Если ПродолжитьОжидание Тогда
		ОбменДаннымиКлиент.ИнициализироватьПараметрыОбработчикаОжидания(
			ПараметрыОбработчикаОжидания);
			
		ПодключитьОбработчикОжидания("ПриОжиданииЗагрузкиНастроекXDTO",
			ПараметрыОбработчикаОжидания.ТекущийИнтервал, Истина);
	Иначе
		ПриЗавершенииЗагрузкиНастроекXDTO();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОжиданииЗагрузкиНастроекXDTO()
	
	ПродолжитьОжидание = Ложь;
	ПриОжиданииЗагрузкиНастроекXDTOНаСервере(ПараметрыОбработчика, ПродолжитьОжидание);
	
	Если ПродолжитьОжидание Тогда
		ОбменДаннымиКлиент.ОбновитьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжидания);
		
		ПодключитьОбработчикОжидания("ПриОжиданииЗагрузкиНастроекXDTO",
			ПараметрыОбработчикаОжидания.ТекущийИнтервал, Истина);
	Иначе
		ПараметрыОбработчикаОжидания = Неопределено;
		ПриЗавершенииЗагрузкиНастроекXDTO();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗавершенииЗагрузкиНастроекXDTO()
	
	СообщениеОбОшибке = "";
	НастройкиЗагружены = Ложь;
	ПолученыДанныеДляСопоставления = Ложь;
	ПриЗавершенииЗагрузкиНастроекXDTOНаСервере(ПараметрыОбработчика, НастройкиЗагружены, ПолученыДанныеДляСопоставления, СообщениеОбОшибке);
	
	Если НастройкиЗагружены Тогда
		
		Результат = Новый Структура;
		Результат.Вставить("ПродолжитьНастройку",            Истина);
		Результат.Вставить("ПолученыДанныеДляСопоставления", ПолученыДанныеДляСопоставления);
		
		Закрыть(Результат);
	Иначе
		Элементы.ПанельОсновная.ТекущаяСтраница = Элементы.СтраницаОшибка;
		Элементы.ФормаКомандаГотово.КнопкаПоУмолчанию = Истина;
		Элементы.ФормаКомандаГотово.Доступность = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриНачалеЗагрузкиНастроекXDTOНаСервере(ПродолжитьОжидание)
	
	МодульПомощникНастройки = ОбменДаннымиСервер.МодульПомощникСозданияОбменаДанными();
	
	НастройкиЗагрузки = Новый Структура;
	НастройкиЗагрузки.Вставить("УзелОбмена", УзелОбмена);
	
	МодульПомощникНастройки.ПриНачалеЗагрузкиНастроекXDTO(НастройкиЗагрузки, ПараметрыОбработчика, ПродолжитьОжидание);
	
КонецПроцедуры
	
&НаСервереБезКонтекста
Процедура ПриОжиданииЗагрузкиНастроекXDTOНаСервере(ПараметрыОбработчика, ПродолжитьОжидание)
	
	МодульПомощникНастройки = ОбменДаннымиСервер.МодульПомощникСозданияОбменаДанными();
	
	ПродолжитьОжидание = Ложь;
	МодульПомощникНастройки.ПриОжиданииЗагрузкиНастроекXDTO(ПараметрыОбработчика, ПродолжитьОжидание);
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ПриЗавершенииЗагрузкиНастроекXDTOНаСервере(ПараметрыОбработчика, НастройкиЗагружены, ПолученыДанныеДляСопоставления, СообщениеОбОшибке)
	
	МодульПомощникНастройки = ОбменДаннымиСервер.МодульПомощникСозданияОбменаДанными();
	
	СтатусЗавершения = Неопределено;
	МодульПомощникНастройки.ПриЗавершенииЗагрузкиНастроекXDTO(ПараметрыОбработчика, СтатусЗавершения);
		
	Если СтатусЗавершения.Отказ Тогда
		НастройкиЗагружены = Ложь;
		ПолученыДанныеДляСопоставления = Ложь;
		СообщениеОбОшибке = СтатусЗавершения.СообщениеОбОшибке;
	Иначе
		НастройкиЗагружены = СтатусЗавершения.Результат.НастройкиЗагружены;
			
		Если Не НастройкиЗагружены Тогда
			ПолученыДанныеДляСопоставления = Ложь;
			СообщениеОбОшибке = СтатусЗавершения.Результат.СообщениеОбОшибке;
		Иначе
			ПолученыДанныеДляСопоставления = СтатусЗавершения.Результат.ПолученыДанныеДляСопоставления;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры 

#КонецОбласти
