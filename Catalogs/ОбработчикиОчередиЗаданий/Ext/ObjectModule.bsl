﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	Использование = Истина;
	Расписание = Новый ХранилищеЗначения(Справочники.ОбработчикиОчередиЗаданий.РасписаниеПоУмолчанию());
	
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	Авто = Ложь;
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	ПроверитьВозможностьИзменения();
	
	Проверка = Методы.Выгрузить(, "Метод");
	Проверка.Свернуть("Метод");
	Если Проверка.Количество() <> Методы.Количество() Тогда
		ОбщегоНазначения.СообщитьПользователю(НСтр("ru = 'Обнаружены дубли методов'"), , "Методы", , Отказ);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ПроверитьВозможностьИзменения();
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередУдалением(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ПроверитьВозможностьИзменения();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПроверитьВозможностьИзменения()
	
	Если Авто Тогда
		ВызватьИсключение НСтр("ru = 'Редактирование этой настройки выполняется только в Менеджере сервиса'");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли