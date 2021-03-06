///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.Свойство("ПрерываниеРазрешено", ПрерываниеРазрешено);
	
	ЗаголовокДиалога = Параметры.ЗаголовокДиалога;
	Если ЗначениеЗаполнено(ЗаголовокДиалога) Тогда
		ЭтотОбъект.Заголовок = ЗаголовокДиалога;
		ЭтотОбъект.АвтоЗаголовок = Ложь;
	КонецЕсли;
	
	Если НЕ ПрерываниеРазрешено Тогда
		Элементы.ДекорацияПоясняющийТекстДлительнойОперации.Подсказка = НСтр("ru = 'Операцию нельзя прервать до окончания выполнения'");
		Элементы.ДекорацияПоясняющийТекстДлительнойОперации.ОтображениеПодсказки = ОтображениеПодсказки.ОтображатьСнизу;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Если ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;
	
	ОперацияПрервана = Истина;
	
	Отказ = НЕ ПрерываниеРазрешено;
			
КонецПроцедуры

#КонецОбласти