﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Позволяет задать общие настройки подсистемы.
//
// Параметры:
//   Настройки - Структура:
//     * КартинкаИндикатораПроблем    - Картинка - которая будет выводиться в качестве
//                                      индикатора ошибки в колонке динамического списка
//                                      форм списков и на специальной панели форм объектов.
//     * ПояснениеИндикатораПроблем   - Строка - поясняющая строка к ошибке.
//     * ГиперссылкаИндикатораПроблем - Строка - текст гиперссылки, при нажатии на которую,
//                                      будет сформирован и открыт отчет с ошибками.
//
// Пример:
//   Настройки = Новый Структура;
//   Настройки.Вставить("КартинкаИндикатораПроблем",    БиблиотекаКартинок.Предупреждение);
//   Настройки.Вставить("ПояснениеИндикатораПроблем",   Неопределено);
//   Настройки.Вставить("ГиперссылкаИндикатораПроблем", Неопределено);
//
Процедура ПриОпределенииНастроек(Настройки) Экспорт
	
КонецПроцедуры

// Предназначена для подключения собственных правил проверки ведения учета.
//
// Параметры:
//   ГруппыПроверок - ТаблицаЗначений - таблица, в которую добавляются группы проверок:
//      * Наименование                 - Строка - наименование группы проверок.
//      * ИдентификаторГруппы          - Строка - строковый идентификатор группы проверок, например: 
//                                       "СистемныеПроверки", "ЗакрытиеМесяца", "ПроверкиНДС" и т.п.
//                                       Обязателен для заполнения.
//      * Идентификатор                - Строка - строковый идентификатор группы проверок. Обязателен для заполнения.
//                                       Для уникальности формат идентификатора следует выбирать следующим:
//                                       "<Название программного продукта>.<Идентификатор проверки>". 
//                                       Например: "СтандартныеПодсистемы.СистемныеПроверки".
//      * КонтекстПроверокВеденияУчета - ОпределяемыйТип.КонтекстПроверокВеденияУчета - значение, дополнительно
//                                       уточняющее принадлежность группы проверок ведения учета к определенной
//                                       категории.
//      * Комментарий                  - Строка - комментарий к группе проверок.
//
//   Проверки - ТаблицаЗначений - таблица, в которую добавляются проверки:
//      * ИдентификаторГруппы          - Строка - строковый идентификатор группы проверок, например: 
//                                                "СистемныеПроверки", "ЗакрытиеМесяца", "ПроверкиНДС" и т.п.
//                                                 Обязателен для заполнения.
//      * Наименование                 - Строка - наименование проверки, выводимое пользователю.
//      * Причины                      - Строка - описание возможных причин, которые приводят к возникновению проблемы.
//      * Рекомендация                 - Строка - рекомендация по решению возникшей проблемы.
//      * Идентификатор                - Строка - строковый идентификатор элемента. Обязателен для заполнения.
//                                                Формат идентификатора должен быть следующим:
//                                                <Название программного продукта>.<Идентификатор проверки>. Например:
//                                                СтандартныеПодсистемы.СистемныеПроверки.
//      * ДатаНачалаПроверки           - Дата - пороговая дата, обозначающая границу проверяемых объектов
//                                              (только для объектов с датой, например, документов). Объекты, дата 
//                                              которых меньше указанной, не следует проверять. По умолчанию 
//                                              не заполнено (т.е. проверять все).
//      * ЛимитПроблем                 - Число - количество проверяемых объектов. По умолчанию 1000. 
//                                               Если указан 0, то следует проверять все объекты.
//      * ОбработчикПроверки           - Строка - имя экспортной процедуры-обработчика серверного общего модуля
//                                                в виде ИмяМодуля.ИмяПроцедуры.
//      * ОбработчикПереходаКИсправлению - Строка - имя экспортной процедуры-обработчика клиентского общего модуля
//                                                  для перехода к исправлению проблемы в виде "ИмяМодуля.ИмяПроцедуры"
//                                                  или полное имя формы, которую следует открыть для исправления проблемы.
//                                                  Процедура-обработчик принимает на вход два параметра: 
//                                                    ПараметрыИсправления - Структура - со свойствами:
//                                                      ИдентификаторПроверки - Строка - строковый идентификатор проверки;
//                                                      ВидПроверки - СправочникСсылка.ВидыПроверок - вид проверки,
//                                                               дополнительно уточняющий область исправления проблемы;
//                                                    ДополнительныеПараметры - Неопределено - параметр не используется.
//                                                 При открытии формы в нее передаются такие же параметры, как свойства 
//                                                 указанной выше структуры ПараметрыИсправления.
//      * БезОбработчикаПроверки       - Булево - признак служебной проверки, которая не имеет процедуры-обработчика.
//      * ЗапрещеноИзменениеВажности   - Булево - если Истина, то администратор не сможет перенастраивать 
//                                                важность данной проверки.
//      * КонтекстПроверокВеденияУчета - ОпределяемыйТип.КонтекстПроверокВеденияУчета - значение, дополнительно 
//                                                уточняющее принадлежность проверки ведения учета к определенной группе 
//                                                или категории.
//      * УточнениеКонтекстаПроверокВеденияУчета - ОпределяемыйТип.УточнениеКонтекстаПроверокВеденияУчета - второе значение, 
//                                                 дополнительно уточняющее принадлежность проверки ведения учета 
//                                                 к определенной группе или категории.
//      * ДополнительныеПараметры      - ХранилищеЗначения - произвольная дополнительная информация о проверке
//                                                 для программного использования.
//      * Комментарий                  - Строка - текстовый комментарий к проверке.
//      * Отключена                    - Булево - если Истина, то проверка не будет выполняться в фоне по расписанию.
//      * ПоддерживаетВыборочнуюПроверку - Булево - если Истина, то проверку можно вызвать для проверки конкретного объекта.
//
// Пример:
//   1) Добавление проверки
//      Проверка = Проверки.Добавить();
//      Проверка.ИдентификаторГруппы = "СистемныеПроверки";
//      Проверка.Наименование        = НСтр("ru='Демо: Проверка заполнения комментария в документах ""Демо: Поступление товаров""'");
//      Проверка.Причины             = НСтр("ru='Не введен комментарий в документе.'");
//      Проверка.Рекомендация        = НСтр("ru='Ввести комментарий в документе.'");
//      Проверка.Идентификатор       = "ПроверитьКомментарийВПоступленииТоваров";
//      Проверка.ОбработчикПроверки  = "_ДемоСтандартныеПодсистемы.ПроверитьКомментарийВПоступленииТоваров";
//      Проверка.ДатаНачалаПроверки  = Дата('20140101000000');
//      Проверка.ЛимитПроблем        = 3;
//   2) Добавление группы проверок
//      ГруппаПроверок = ГруппыПроверок.Добавить();
//      ГруппаПроверок.Наименование                 = НСтр("ru='Системные проверки'");
//      ГруппаПроверок.Идентификатор                = "СтандартныеПодсистемы.СистемныеПроверки";
//      ГруппаПроверок.КонтекстПроверокВеденияУчета = "СистемныеПроверки";
//
Процедура ПриОпределенииПроверок(ГруппыПроверок, Проверки) Экспорт
	// _Демо начало примера
	_ДемоСтандартныеПодсистемы.ПриОпределенииПроверок(ГруппыПроверок, Проверки);
	// _Демо конец примера
КонецПроцедуры

// Позволяет настроить положение индикатора о проблемах в формах объектов.
//
// Параметры:
//   ПараметрыГруппыИндикации - Структура - выходные параметры индикатора:
//     * ВыводитьСнизу     - Булево - если указать Истина, то группа индикатора будет выводиться самой последней 
//                           в форме или в конце указанной группе элементов ИмяРодителяГруппы.
//                           По умолчанию Ложь - группа выводится в начале указанной группе ИмяРодителяГруппы или 
//                           сразу под командной панелью формы объекта.
//     * ИмяРодителяГруппы - Строка - определяет имя группы элементов формы объекта, внутри которой должна 
//                           располагаться группа индикации.
//     * ДетальныйВид      - Булево - если Истина и у объекта найдена только одна проблема, то в карточке будет
//                           сразу выводиться ее описание вместо гиперссылки с переходом к списку проблем.
//                           Значение по умолчанию - Ложь.
//
//   ТипПроблемногоОбъекта - Тип - тип ссылки, для которой переопределяются параметры группы индикации.
//                     Например, Тип("ДокументСсылка.НачислениеЗарплаты").
//
Процедура ПриОпределенииПараметровГруппыИндикации(ПараметрыГруппыИндикации, Знач ТипПроблемногоОбъекта) Экспорт
	// _Демо начало примера
	_ДемоСтандартныеПодсистемы.ПриОпределенииПараметровГруппыИндикации(ПараметрыГруппыИндикации, ТипПроблемногоОбъекта);
	// _Демо конец примера
КонецПроцедуры

// Позволяет настроить внешний вид и положение колонки-индикатора о проблемах в формах списков
// (с динамическим списком).
//
// Параметры:
//   ПараметрыКолонкиИндикации - Структура - выходные параметры индикатора:
//     * ВыводитьПоследней  - Булево - если указать Истина, то колонка-индикатор будет выводиться в конце.
//                            По умолчанию Ложь - колонка выводится в начале.
//     * ПоложениеЗаголовка - ПоложениеЗаголовкаЭлементаФормы - задает положение заголовка колонки-индикатора.
//     * Ширина             - Число - ширина колонки-индикатора.
//
//   ПолноеИмя - Строка - полное имя объекта основной таблицы динамического списка.
//                        Например, Метаданные.Документы.НачислениеЗарплаты.ПолноеИмя().
//
Процедура ПриОпределенииПараметровКолонкиИндикации(ПараметрыКолонкиИндикации, ПолноеИмя) Экспорт
	// _Демо начало примера
	_ДемоСтандартныеПодсистемы.ПриОпределенииПараметровКолонкиИндикации(ПараметрыКолонкиИндикации, ПолноеИмя);
	// _Демо конец примера
КонецПроцедуры

// Позволяет дозаполнить информацию о проблеме перед ее регистрацией.
// В частности, можно заполнить дополнительные значения для ограничения доступа на уровне записей 
// к списку проблем ведения учета.
//
// Параметры:
//   Проблема - Структура - сформированная алгоритмом проверки информация о проблеме:
//     * ПроблемныйОбъект         - ЛюбаяСсылка - объект, по поводу которого записывается проблема.
//                                                Либо ссылка на элемент справочника ИдентификаторыОбъектовМетаданных
//     * ПравилоПроверки          - СправочникСсылка.ПравилаПроверкиУчета - ссылка на выполненную проверку.
//     * ВидПроверки              - СправочникСсылка.ВидыПроверок - ссылка на вид проверки, к которому 
//                                  относится выполненная проверка.
//     * КлючУникальности         - УникальныйИдентификатор - ключ уникальности проблемы.
//     * УточнениеПроблемы        - Строка - строка-уточнение найденной проблемы.
//     * ВажностьПроблемы         - ПеречислениеСсылка.ВажностьПроблемыУчета - важность проблемы учета
//                                  Информация, Предупреждение, Ошибка, ПолезныйСовет и ВажнаяИнформация.
//     * Ответственный            - СправочникСсылка.Пользователи - заполнен если есть возможность
//                                  идентифицировать ответственного в проблемном объекте.
//     * ИгнорироватьПроблему     - Булево - флаг игнорирования проблемы. Если имеет значение "Истина",
//                                  запись о проблеме игнорируется подсистемой.
//     * ДополнительнаяИнформация - ХранилищеЗначения - служебное свойство с дополнительными
//                                  сведениями, связанными с выявленной проблемой.
//     * Выявлено                 - Дата - серверное время идентификации проблемы.
//
//   СсылкаНаОбъект  - ЛюбаяСсылка - ссылка на объект-источник значения для добавляемых
//                     дополнительных измерений.
//   Реквизиты       - КоллекцияОбъектовМетаданных - коллекция, содержащая реквизиты объекта-
//                     источника проблем.
//
Процедура ПередЗаписьюПроблемы(Проблема, СсылкаНаОбъект, Реквизиты) Экспорт
	// _Демо начало примера
	_ДемоСтандартныеПодсистемы.ПередЗаписьюПроблемы(Проблема, СсылкаНаОбъект, Реквизиты);
	// _Демо конец примера
КонецПроцедуры

#Область УстаревшиеПроцедурыИФункции

// Устарела: Следует использовать функцию ПриОпределенииПроверок.
// Предназначена для подключения собственных правил проверки ведения учета.
//
// Параметры:
//   ГруппыПроверок - ТаблицаЗначений - таблица, в которую добавляются группы проверок:
//      * Наименование  - Строка - наименование группы проверок, например: "Системные проверки".
//      * Идентификатор - Строка - строковый идентификатор группы, например: "СистемныеПроверки".
//
//   Проверки - ТаблицаЗначений - таблица, в которую добавляются проверки:
//      * Наименование                   - Строка - наименование элемента проверки. Обязательно для заполнения.
//      * Причины                        - Строка - возможные причины, которые привели к возникновению проблемы.
//                                                  Выводятся в отчете о проблемах. Необязательно для заполнения.
//      * Рекомендация                   - Строка - рекомендация по решению возникшей проблемы.
//                                                  Выводятся в отчете о проблемах. Необязательно для заполнения.
//      * Идентификатор                  - Строка - строковый идентификатор проверки. Обязателен для заполнения.
//      * ИдентификаторРодителя          - Строка - строковый идентификатор группы проверок, например: "СистемныеПроверки".
//                                                  Обязательно для заполнения.
//      * ДатаНачалаПроверки             - Дата - пороговая дата, обозначающая границу проверяемых
//                                         объектов (только для объектов с датой). Объекты, дата которых меньше
//                                         указанной, не следует проверять. По умолчанию не заполнено (т.е. проверять все).
//      * ЛимитПроблем                   - Число - максимальное количество проверяемых объектов.
//                                         По умолчанию 0 - следует проверить все объекты.
//      * ОбработчикПроверки             - Строка - имя экспортной процедуры-обработчика проверки в серверном общем модуле.
//                                         Предназначен для поиска и регистрации проблем ведения учета.
//                                         Параметры обработчика проверки:
//                                           * Проверка - СправочникСсылка.ПравилаПроверкиУчета - исполняемая проверка.
//                                           * ПараметрыПроверки - Структура - параметры проверки, которую необходимо выполнить.
//                                                                             Подробнее см. в документации.
//      * ОбработчикПереходаКИсправлению - Строка - имя экспортной процедуры-обработчика исправления проблемы 
//                                         в клиентском общем модуле или полное имя формы, которая будет открыта для
//                                         исправления проблемы. Параметры обработчика исправления проблемы или формы:
//                                          * ИдентификаторПроверки - Строка - идентификатор проверки, 
//                                                                    которая выявила проблему.
//                                          * ВидПроверки - СправочникСсылка.ВидыПроверок - вид проверки 
//                                                          с дополнительной информацией о проблеме.
//      * ДополнительныеПараметры        - ХранилищеЗначения - дополнительная информация по проверке.
//
// Пример:
//   Проверка = Проверки.Добавить();
//   Проверка.ИдентификаторГруппы = "СистемныеПроверки";
//   Проверка.Наименование        = НСтр("ru='Демо: Проверка заполнения комментария в документах ""Демо: Поступление товаров""'");
//   Проверка.Причины             = НСтр("ru='Не введен комментарий в документе.'");
//   Проверка.Рекомендация        = НСтр("ru='Ввести комментарий в документе.'");
//   Проверка.Идентификатор       = "ПроверитьКомментарийВПоступленииТоваров";
//   Проверка.ОбработчикПроверки  = "_ДемоСтандартныеПодсистемы.ПроверитьКомментарийВПоступленииТоваров";
//   Проверка.ДатаНачалаПроверки  = Дата('20140101000000');
//   Проверка.ЛимитПроблем        = 3;
//
Процедура ПриОпределенииПрикладныхПроверок(ГруппыПроверок, Проверки) Экспорт
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти



