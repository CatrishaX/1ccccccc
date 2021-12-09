﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Возвращает номер версии, для трансляции с которой предназначен обработчик.
// @skip-warning ПустойМетод - особенность реализации.
// 
// Возвращаемое значение:
//   Строка - исходная версия.
//
Функция ИсходнаяВерсия() Экспорт
КонецФункции

// Возвращает пространство имен версии, для трансляции с которой предназначен обработчик.
// @skip-warning ПустойМетод - особенность реализации.
// 
// Возвращаемое значение:
//   Строка - пакет исходной версии.
//
Функция ПакетИсходнойВерсии() Экспорт
КонецФункции

// Возвращает номер версии, для трансляции в которую предназначен обработчик.
// @skip-warning ПустойМетод - особенность реализации.
// 
// Возвращаемое значение:
//   Строка - результирующая версия.
//
Функция РезультирующаяВерсия() Экспорт
КонецФункции

// Возвращает пространство имен версии, для трансляции в которую предназначен обработчик.
// @skip-warning ПустойМетод - особенность реализации.
// 
// Возвращаемое значение:
//   Строка - пакет результирующей версии.
//
Функция ПакетРезультирующейВерсии() Экспорт
КонецФункции

// Обработчик проверки выполнения стандартной обработки трансляции.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//  ИсходноеСообщение - ОбъектXDTO - транслируемое сообщение,
//  СтандартнаяОбработка - Булево - для отмены выполнения стандартной обработки трансляции
//    этому параметру внутри данной процедуры необходимо установить значение Ложь.
//    При этом вместо выполнения стандартной обработки трансляции будет вызвана функция.
//    ТрансляцияСообщения() обработчика трансляции.
//
Процедура ПередТрансляцией(Знач ИсходноеСообщение, СтандартнаяОбработка) Экспорт
КонецПроцедуры

// Обработчик выполнения произвольной трансляции сообщения. Вызывается только в том случае,
//  если при выполнении процедуры ПередТрансляцией значению параметра СтандартнаяОбработка
//  было установлено значение Ложь.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//  ИсходноеСообщение - ОбъектXDTO - транслируемое сообщение.
//
// Возвращаемое значение:
//  ОбъектXDTO - результат произвольной трансляции сообщения.
//
Функция ТрансляцияСообщения(Знач ИсходноеСообщение) Экспорт
КонецФункции

#КонецОбласти



