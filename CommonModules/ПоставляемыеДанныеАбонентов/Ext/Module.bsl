﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// См. ОчередьЗаданийПереопределяемый.ПриОпределенииПсевдонимовОбработчиков
// @skip-warning ПустойМетод - особенность реализации.
//
Процедура ПриОпределенииПсевдонимовОбработчиков(СоответствиеИменПсевдонимам) Экспорт
КонецПроцедуры

#Область ОбработчикиОчередиЗаданий

// Выполняет обработку поставляемых данных абонента.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//  ИдентификаторФайла - Строка - идентификатор файла для обработки (длина 36).
//
// Пример:
// Пример содержимого файла файла: {"upload": [{"file":"base_data.json","handler":"base_data"}]}, где
//  - upload - секция с описаниями порядка обработки, может содержать несколько элементов.
//  - file - имя файла начальных данных для обработки.
//  - handler - идентификатор обработчика файла начальных данных.
//
Процедура ОбработатьДанные(ИдентификаторФайла) Экспорт
КонецПроцедуры

#КонецОбласти

#КонецОбласти

