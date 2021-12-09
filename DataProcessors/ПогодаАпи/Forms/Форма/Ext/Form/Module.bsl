﻿&НаСервере
Процедура ЗагрузитьНаСервере()
Заголовки = Новый Соответствие;
Заголовки.Вставить("X-Yandex-API-Key", "10059d22-c7e5-420f-a6ea-b4fac2ada780");
 

HTTPСоединение = Новый HTTPСоединение("api.weather.yandex.ru");
HTTPЗапрос = Новый HTTPЗапрос(СтрШаблон("v2/forecast?lat=%1&lon=%2&[lang=ru_RU]",Город.Широта,Город.Долгота),Заголовки);
 
Результат = HTTPСоединение.Получить(HTTPЗапрос);
 
ЧтениеJSON = Новый ЧтениеJSON;
ЧтениеJSON.УстановитьСтроку(Результат.ПолучитьТелоКакСтроку());
ОбъектJSON = ПрочитатьJSON(ЧтениеJSON);
 
НоваяЗапись = РегистрыСведений.РегистрПогода.СоздатьМенеджерЗаписи();
 
Если Дата = ТекущаяДата() Тогда
	НоваяЗапись.ТемператураВоздуха = ОбъектJSON.fact.temp;
	НоваяЗапись.ОщущаемаяТемпература = ОбъектJSON.fact.feels_like;  
	НоваяЗапись.СкоростьВетра = ОбъектJSON.wind_speed;
	НоваяЗапись.Дата = Дата;
	НоваяЗапись.Город = Город;
 
	Ощущается = ОбъектJSON.fact.condition;
	Значения = Перечисления.Описание;
	Индекс = 0;
	Для Каждого Значение из Значения[0].Метаданные().ЗначенияПеречисления Цикл
		Если Значение.Имя = СтрЗаменить(Ощущается,"-","_") Тогда
		НоваяЗапись.Описание = Значения.Получить(Индекс);
		КонецЕсли;
		Индекс = Индекс + 1;
	КонецЦикла;
	Иначе
	Для каждого Строка из ОбъектJSON.forecasts Цикл
	Если Строка.date = Формат(Дата, "ДФ=гггг-ММ-дд") Тогда
	НоваяЗапись.ТемператураВоздуха = Строка.parts.day_short.temp;
	НоваяЗапись.ОщущаемаяТемпература = Строка.parts.day_short.feels_like; 
	НоваяЗапись.СкоростьВетра = Строка.parts.day_short.wind_speed;
	НоваяЗапись.Дата = Дата;
	НоваяЗапись.Город = Город;
	 
	Ощущается = Строка.parts.day_short.condition;
	Значения = Перечисления.Описание;
	Индекс = 0;
	Для Каждого Значение из Значения[0].Метаданные().ЗначенияПеречисления Цикл
	Если Значение.Имя = СтрЗаменить(Ощущается,"-","_") Тогда
	НоваяЗапись.Описание = Значения.Получить(Индекс);
	КонецЕсли;
	Индекс = Индекс + 1;
	КонецЦикла;
	КонецЕсли;
	КонецЦикла;
КонецЕсли;
 
Запись = Истина;
Выборка = РегистрыСведений.РегистрПогода.Выбрать();
Пока Выборка.Следующий() Цикл
Если Выборка.Дата = Дата И Выборка.Город = Город.Наименование Тогда
Сообщить("Такой прогноз уже существует");
Запись = Ложь;
КонецЕсли;
КонецЦикла;
 
Если Запись Тогда
НоваяЗапись.Записать();
КонецЕсли;
 
ЧтениеJSON.Закрыть();
КонецПроцедуры
 
&НаКлиенте
Процедура Получить(Команда)
	ЗагрузитьНаСервере();
КонецПроцедуры