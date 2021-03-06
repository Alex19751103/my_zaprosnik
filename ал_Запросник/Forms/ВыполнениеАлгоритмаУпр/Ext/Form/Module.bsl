&НаКлиенте
Перем ИмяФайла,ИмяПути;
//Ал++
&НаКлиенте
Перем мПутьКОбработке Экспорт;
//Ал--
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	//Ал++
	мПутьКОбработке = ВладелецФормы.мПутьКОбработке;
	//Ал--
	Элементы.НадписьСлева.Заголовок = "Кол. строк в результате: "+ВладелецФормы.РезультатТаблица.Количество();
	СтрокаДереваЗапросов = ВладелецФормы.ДеревоЗапросов.НайтиПоИдентификатору(ВладелецФормы.Элементы.ДеревоЗапросов.Текущаястрока);
	Если СтрокаДереваЗапросов.ТекстАлгоритма<>"" Тогда
		
		//ТекстАлгоритма.УстановитьФорматированнуюСтроку(Новый ФорматированнаяСтрока(СтрокаДереваЗапросов.ТекстАлгоритма));
				//обеспечим совместимость со старыми значениями
		СтрокаДереваЗапросов.ТекстАлгоритма = СтрЗаменить(СтрокаДереваЗапросов.ТекстАлгоритма,"Параметры.ТаблицаРезультата","РезультатТаблица");

		ТекстАлгоритма.УстановитьТекст(СтрокаДереваЗапросов.ТекстАлгоритма);
		
		Если СтрокаДереваЗапросов.ПараметрыАлгоритма<>Неопределено Тогда
			ПараметрыАлгоритма = СтрокаДереваЗапросов.ПараметрыАлгоритма;
		КонецЕсли;//  
	Иначе 
		
		УстановитьНачальныйТекстАлгоритма();
		
	КонецЕсли; 

	Если ЭтаФорма.ВладелецФормы.мДоступнаРаскраска И ЭтаФорма.ВладелецФормы.Объект.РаскрашиватьКод Тогда
		Режим=0;
	Иначе
		Режим=2;
	КонецЕсли;
	
	#Если ВебКлиент Тогда
		Элементы.КнРежимКода.Видимость=Ложь;
		Режим=2;
	#КонецЕсли
	ОбработатьРежимВводаКода();
КонецПроцедуры


&НаКлиенте
Процедура УстановитьНачальныйТекстАлгоритма()

		//устанавливаем дефолтный текст
		
		ТекстАлгоритмаСтр = "//данный код сформирован автоматически, но скорее всего он Вам пригодится";
		ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + Символы.ПС;
		ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + Символы.ПС;
		ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + "Для Каждого СтрокаРезультата Из РезультатТаблица Цикл";
		ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + Символы.ПС;
		ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + Символы.ПС;
		ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + "   //алгоритм обработки строки результата - начало ------>";
		
		Если СтруктураРезультатаЗапроса.НайтиСтроки(Новый Структура("Поле","Ссылка")).Количество()>0 Тогда
			//если в списке колонок есть колонка с именем Ссылка, то можно предположить, 
			//что алгоритм будет по изменению объекта по этой ссылке
			//дадим заготовку
			
			ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + Символы.ПС;
			ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + Символы.ПС;
			ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + Символы.Таб + "Объект1с = СтрокаРезультата.Ссылка.ПолучитьОбъект();";
			ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + Символы.ПС;
			ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + Символы.ПС;
			ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + Символы.ПС;
			ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + Символы.Таб + "//примеры кода:";
			ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + Символы.ПС;
			ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + Символы.Таб + "//Объект1с.Комментарий = ПараметрыАлгоритма[0].Значение;";
			ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + Символы.ПС;
			ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + Символы.Таб + "//Объект1с.ПометкаУдаления = Истина;";
			ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + Символы.ПС;
			ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + Символы.Таб + "//Объект1с.ОбменДанными.Загрузка = Истина;";
			ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + Символы.ПС;
			ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + Символы.ПС;
			ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + Символы.ПС;
			ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + Символы.Таб + "Объект1с.Записать();";
			
		КонецЕсли; 
		
		ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + Символы.ПС;
		ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + Символы.ПС;
		ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + "   //алгоритм обработки строки результата - конец <------";
		ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + Символы.ПС;
		ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + Символы.ПС;
		ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + "КонецЦикла;";
		ТекстАлгоритмаСтр = ТекстАлгоритмаСтр + Символы.ПС;
		
		//ТекстАлгоритма.УстановитьФорматированнуюСтроку(Новый ФорматированнаяСтрока(ТекстАлгоритмаСтр));
		ТекстАлгоритма.УстановитьТекст(ТекстАлгоритмаСтр);

КонецПроцедуры //УстановитьНачальныйТекстАлгоритма
 

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	МассивДобавляемыхРеквизитов = Новый Массив;
	Для Каждого КолонкаРезультата Из Параметры.СтруктураРезультата Цикл
		НоваяСтрока = СтруктураРезультатаЗапроса.Добавить();
		НоваяСтрока.Поле = КолонкаРезультата.Ключ;
		НоваяСтрока.ПримерЗначения = КолонкаРезультата.Значение;
	КонецЦикла;
	
	ОБ_Объект=РеквизитФормыВЗначение("ОбъектОбработка");
	ТекстАлгоритмаHTML=ОБ_Объект.ПолучитьМакет("gHTML_webKit").ПолучитьТекст();

КонецПроцедуры

&НаКлиенте
Процедура СтруктураРезультатаЗапросаПриАктивизацииСтроки(Элемент)
	ТекДанные = Элементы.СтруктураРезультатаЗапроса.ТекущиеДанные;
	
	Если ТекДанные = Неопределено Тогда Возврат	КонецЕсли; 
	
	ПолеРезультатаТекстДляМодуля = "СтрокаРезультата." + СокрЛП(ТекДанные.Поле) + ";";
	
КонецПроцедуры

&НаКлиенте
Процедура ПараметрыАлгоритмаПриАктивизацииСтроки(Элемент)
	ТекДанные = Элементы.ПараметрыАлгоритма.ТекущиеДанные;
	
	Если ТекДанные = Неопределено Тогда Возврат	КонецЕсли; 
	
	ПараметрАлгоритмаТекстДляМодуля = "ПараметрыАлгоритма.НайтиПоИдентификатору("+СокрЛП(Элементы.ПараметрыАлгоритма.ТекущаяСтрока)+").Значение;";

КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьАлгоритм(Команда)
	
	ТекстАлгоритма.УстановитьТекст(ПолучитьВыражение());
	ТекстАлгоритмаTEMP = ТекстАлгоритма.ПолучитьТекст();

	ВыполнениеНачало = ТекущаяДата();
	Элементы.НадписьПрерватьВыполнение.Заголовок = "Ctrl + Break - прервать выполнение";
	
	Элементы.НадписьПрерватьВыполнение.Заголовок = "алгоритм выполнен";
	Если АлгоритмВыполняетсяНаСервере() Тогда
		Индикатор = 0;
		ВладелецФормы.ВыполнитьНаСервереПолностью(ТекстАлгоритма.ПолучитьТекст(),ПараметрыАлгоритма,ВыполнятьВТранзакции);
		Индикатор = Элементы.Индикатор.МаксимальноеЗначение;
	Иначе
		Элементы.Индикатор.Видимость = Истина;
		ТекстВыполнения = Новый ТекстовыйДокумент;
		Отказ = Ложь;
		Для Сч = 1 по ТекстАлгоритма.КоличествоСтрок() Цикл
			
			Если НЕ Сч = ОткрытиеЦикла и НЕ Сч = ЗакрытиеЦикла Тогда
				ТекстВыполнения.ДобавитьСтроку(ТекстАлгоритма.ПолучитьСтроку(Сч));
			КонецЕсли;
		КонецЦикла;
		Индикатор = 0;
		Элементы.Индикатор.МаксимальноеЗначение = ВладелецФормы.РезультатТаблица.Количество();
		СтруктураСтрокиВызова = Новый Структура;
		Для Каждого КолонкаРеза Из СтруктураРезультатаЗапроса Цикл 
			СтруктураСтрокиВызова.Вставить(КолонкаРеза.Поле,"");
		КонецЦикла;
		Для Каждого СтрокаРезультата Из ВладелецФормы.РезультатТаблица Цикл
			Индикатор = Индикатор+1;
			ЗаполнитьЗначенияСвойств(СтруктураСтрокиВызова,СтрокаРезультата);
			ВыполнитьАлгоритмНаСервере(ТекстВыполнения.ПолучитьТекст(),СтруктураСтрокиВызова,ПараметрыАлгоритма);
			Если Отказ Тогда
				Прервать;
			КонецЕсли;
			ОбработкаПрерыванияПользователя();
			ОбновитьОтображениеДанных();
		КонецЦикла;
	КонецЕсли;
	
	ВыполнениеКонец = ТекущаяДата();
	ВремяВыполненияВСекундах = ВыполнениеКонец - ВыполнениеНачало;
	Элементы.НадписьВремяВыполнения.Заголовок = "(" + СокрЛП(ВремяВыполненияВСекундах) + " сек.)";

КонецПроцедуры

&НаСервереБезКонтекста
Процедура ВыполнитьАлгоритмНаСервере(Знач ТекстАлгоритмаВып,Знач СтруктураСтрокиВызова,Знач ПараметрыАлгоритма)
	СтрокаРезультата = СтруктураСтрокиВызова;
	Выполнить(ТекстАлгоритмаВып);

КонецПроцедуры // ВыполнитьАлгоритмНаСервере()

&НаСервере
Процедура ВыполнитьНаСервереПолностью()
	Если ВыполнятьВТранзакции Тогда
		НачатьТранзакцию();
	КонецЕсли;
	Выполнить(ТекстАлгоритма.ПолучитьТекст());
	Если ВыполнятьВТранзакции Тогда
		ЗафиксироватьТранзакцию();
	КонецЕсли;
КонецПроцедуры // ВыполнитьНаСервереПолностью()

&НаКлиенте
Функция АлгоритмВыполняетсяНаСервере()
	Если ВыполнятьВТранзакции Тогда
		Возврат Истина;
	КонецЕсли;
	СтрокВсего = ТекстАлгоритма.КоличествоСтрок();
	ОткрытиеЦикла = Ложь;
	ЗакрытиеЦикла = Ложь;
	ВыполнениеНаКлиенте = Истина;
	Для Сч = 1 по СтрокВсего Цикл
		ТекСтрока = СокрЛП(ТекстАлгоритма.ПолучитьСтроку(Сч));
		Если ТекСтрока = "" или Лев(ТекСтрока,2)="//" Тогда
			Продолжить;
		КонецЕсли;
		Если ТекСтрока = "Для Каждого СтрокаРезультата Из РезультатТаблица Цикл" Тогда
			ОткрытиеЦикла = Сч;
			Прервать;
		Иначе
			ВыполнениеНаКлиенте = Ложь;
		КонецЕсли;
	КонецЦикла;
	Для Сч = -СтрокВсего по -1 Цикл
		ТекСтрока = СокрЛП(ТекстАлгоритма.ПолучитьСтроку(-Сч));
		Если ТекСтрока = "" или Лев(ТекСтрока,2)="//" Тогда
			Продолжить;
		КонецЕсли;
		Если ТекСтрока = "КонецЦикла;" Тогда
			ЗакрытиеЦикла = -Сч;
			Прервать;
		Иначе
			ВыполнениеНаКлиенте = Ложь;
		КонецЕсли;
	КонецЦикла;
	Возврат НЕ ВыполнениеНаКлиенте;
	
КонецФункции // АлгоритмВыполняетсяНаСервере()

&НаКлиенте
Процедура СохранитьАлгоритмВФайл(НовыйФайл = Ложь)
	
	ТекстАлгоритма.УстановитьТекст(ПолучитьВыражение());
	
	Если Не ЗначениеЗаполнено(ИмяФайла) Тогда
		НовыйФайл = Истина;
	КонецЕсли; 
	
	Если НовыйФайл Тогда
		
		Длг = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);
		
		Длг.ПолноеИмяФайла = ИмяФайла;
		Длг.Каталог = ИмяПути;
		Длг.Заголовок = "Укажите файл";
		Длг.Фильтр = "Файлы запросов (*.alg)|*.alg|Все файлы (*.*)|*.*";
		Длг.Расширение = "alg";
		
		Если Длг.Выбрать() Тогда
			ИмяФайла = Длг.ПолноеИмяФайла;
			ИмяПути = Длг.Каталог;
		Иначе
			Возврат;
		КонецЕсли;
		
	КонецЕсли; 
	
	Попытка
		
		СтруктураСохранения = Новый Структура("ТекстАлгоритма,ПараметрыАлгоритма");
		СтруктураСохранения.ТекстАлгоритма = ТекстАлгоритма.ПолучитьТекст();
		СтруктураСохранения.ПараметрыАлгоритма = ПараметрыАлгоритма;
		СтруктураТекст = ЗначениеВСтроку(СтруктураСохранения);
		ТекстовыйДок = Новый ТекстовыйДокумент;
		ТекстовыйДок.УстановитьТекст(СтруктураТекст);
		ТекстовыйДок.Записать(ИмяФайла);
		

	Исключение
		
		Сообщить(ОписаниеОшибки());
		Возврат;
		
	КонецПопытки;
	
	Модифицированность = Ложь;
	
	Заголовок = ИмяФайла;
	
КонецПроцедуры //СохранитьАлгоритмВФайл

&НаСервере
Функция ЗначениеВСтроку(Значение)
	Возврат ЗначениеВСтрокуВнутр(Значение);
КонецФункции // ЗначениеВСтроку()


&НаКлиенте
Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
	ТекстАлгоритма.УстановитьТекст(ПолучитьВыражение());
	//сохраняем текст алгоритма в строке дерева запросов
	СтрокаДереваЗапросов = ВладелецФормы.ДеревоЗапросов.НайтиПоИдентификатору(ВладелецФормы.Элементы.ДеревоЗапросов.Текущаястрока);
	СтрокаДереваЗапросов.ТекстАлгоритма = ТекстАлгоритма.ПолучитьТекст();
	СтрокаДереваЗапросов.ПараметрыАлгоритма = ПараметрыАлгоритма;
	//если алгоритм модифицирован - установим модифицированность и в основной форме
	ВладелецФормы.Модифицированность = Модифицированность;
	

КонецПроцедуры

&НаКлиенте
Процедура СохранитьАлгоритм(Команда)
	
	ТекстАлгоритмаTEMP = ТекстАлгоритма.ПолучитьТекст();
	СохранитьАлгоритмВФайл(ИмяФайла=Неопределено);
	
КонецПроцедуры


&НаКлиенте
Процедура ОткрытьАлгоритм(Команда)
	Длг = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	Длг.ПолноеИмяФайла = ИмяФайла;
	Длг.Каталог = ИмяПути;
	Длг.Заголовок = "Выберите файл со списком запросов";
	Длг.Фильтр = "Файлы запросов (*.alg)|*.alg|Все файлы (*.*)|*.*";
	Длг.Расширение = "alg";
	
	Если Длг.Выбрать() Тогда
		ИмяФайла = Длг.ПолноеИмяФайла;
		ИмяПути = Длг.Каталог;
		ТекстовыйДокумент = Новый ТекстовыйДокумент;
		ТекстовыйДокумент.Прочитать(ИмяФайла);
		СтруктураСохранения = ПрочитатьЗначение(ТекстовыйДокумент.ПолучитьТекст());
		ПараметрыАлгоритма = СтруктураСохранения.ПараметрыАлгоритма;
		ТекстАлгоритма.УстановитьТекст(СтруктураСохранения.ТекстАлгоритма);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ПрочитатьЗначение(Текст)
	Возврат ЗначениеИзСтрокиВнутр(Текст);
	

КонецФункции // ПрочитатьЗначение()


&НаКлиенте                                          
Процедура СохранитьКак(Команда)
	ТекстАлгоритмаTEMP = ТекстАлгоритма.ПолучитьТекст();
	СохранитьАлгоритмВФайл(Истина);
КонецПроцедуры


&НаКлиенте                                        
Процедура СтруктураРезультатаЗапросаНачалоПеретаскивания(Элемент, ПараметрыПеретаскивания, Выполнение)
	// Вставить содержимое обработчика.
	ПараметрыПеретаскивания.Значение = ПолеРезультатаТекстДляМодуля;
КонецПроцедуры                                      

&НаКлиенте
Процедура ПараметрыАлгоритмаНачалоПеретаскивания(Элемент, ПараметрыПеретаскивания, Выполнение)
	ПараметрыПеретаскивания.Значение = ПараметрАлгоритмаТекстДляМодуля;
КонецПроцедуры

#Область Коструктор_Запроса
	
&НаКлиенте
Процедура кнКонструкторЗапроса(Команда)
	КонструкторЗапроса = Новый КонструкторЗапроса;
	Если Режим=2 Тогда
		ТекстЗапроса=Элементы.ТекстАлгоритма.ВыделенныйТекст;
	Иначе
		ТекстЗапроса=ПолучитьВыделениеHTML();
	КонецЕсли;
	
	ТекстЗапроса=СтрЗаменить(СтрЗаменить(ТекстЗапроса,"|",""),"""""","""");
	
	Попытка
		Если Не ПустаяСтрока(ТекстЗапроса) Тогда
			КонструкторЗапроса.Текст = ТекстЗапроса;
		КонецЕсли;
	Исключение
		Стр_Ошибка=ОписаниеОшибки();
		ПоказатьОповещениеПользователя("Ошибки",,Стр_Ошибка,БиблиотекаКартинок.Остановить);
		Возврат;
	КонецПопытки;
	
	ОБ_ДопПарам=Новый Структура;
	КонструкторЗапроса.Показать(Новый ОписаниеОповещения("кнКонструкторЗапросаЗавершение", ЭтаФорма, ОБ_ДопПарам));
КонецПроцедуры

&НаКлиенте
Процедура кнКонструкторЗапросаЗавершение(ВыбранныйЭлемент, ДополнительныеПараметры) Экспорт
	Если Не ВыбранныйЭлемент=Неопределено Тогда
		
		Стр_Код=СтрЗаменить(СтрЗаменить(ВыбранныйЭлемент,Символы.ПС,Символы.ПС+"			|"),"""","""""");
		Если Режим=2 Тогда
			Ч_КолСтрок=СтрЧислоСтрок(Стр_Код);
			
			Ч_НачалоСтроки=0;
			Ч_НачалоКолонки=0;
			Ч_КонецСтроки=0;
			Ч_КонецКолонки=0;
			
			Элементы.ТекстАлгоритма.ПолучитьГраницыВыделения(Ч_НачалоСтроки,Ч_НачалоКолонки,Ч_КонецСтроки,Ч_КонецКолонки);
			
			Ч_КонецСтроки=Ч_НачалоСтроки+(Ч_КолСтрок-1);
			
			Если Ч_КолСтрок>1 Тогда
				Стр_Последняя=СтрПолучитьСтроку(Стр_Код,Ч_КолСтрок);
				Ч_КонецКолонки=СтрДлина(Стр_Последняя)+1;
			Иначе
				Ч_КонецКолонки=Ч_НачалоКолонки+СтрДлина(Стр_Код);
			КонецЕсли;
			
			Элементы.ТекстАлгоритма.ВыделенныйТекст=Стр_Код;
			Элементы.ТекстАлгоритма.УстановитьГраницыВыделения(Ч_НачалоСтроки,Ч_НачалоКолонки,Ч_КонецСтроки,Ч_КонецКолонки);
		Иначе
			ВставитьКод_в_HTML(Стр_Код);
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти 


#Область РАСКРАСКА_МОДУЛЯ

&НаКлиенте
Процедура ОбработатьРежимВводаКода()
	Б_НТМЛ=НЕ (Режим=2);
	
	Элементы.ТекстАлгоритма.Видимость=НЕ Б_НТМЛ;
	Элементы.ТекстАлгоритмаHTML.Видимость=Б_НТМЛ;
	Элементы.КнОбновить.Видимость=Б_НТМЛ;
	
	Элементы.КнРежимКода.Пометка=Б_НТМЛ;
	Если Б_НТМЛ Тогда
	     ТекущийЭлемент=Элементы.ТекстАлгоритмаHTML;
	Иначе	
	     ТекущийЭлемент=Элементы.ТекстАлгоритма;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Функция ПолучитьВыражение()
	Если Режим=2 Тогда
		Стр_Выражение = ТекстАлгоритма.ПолучитьТекст();
	Иначе
		Стр_Выражение = "";
		Попытка
			Стр_Выражение = Элементы.ТекстАлгоритмаHTML.Document.editor.getValue();
		Исключение
		КонецПопытки;
	КонецЕсли;
	Возврат Стр_Выражение;
КонецФункции

&НаКлиенте
Функция ПолучитьВыделениеHTML()
	Код = "";
	Попытка
		Код = Элементы.ТекстАлгоритмаHTML.Document.editor.getSelection();
	Исключение
	КонецПопытки;
	Возврат Код;
КонецФункции

&НаКлиенте
Процедура ВставитьКод_в_HTML(Стр_Код)
	Элементы.ТекстАлгоритмаHTML.Document.editor.replaceSelection(Стр_Код,"around");
КонецПроцедуры

&НаКлиенте
Процедура УстановитьКод_в_HTML()
	Элементы.ТекстАлгоритмаHTML.Document.editor.setValue(ТекстАлгоритма.ПолучитьТекст());
КонецПроцедуры	

&НаКлиенте
Процедура КнОбновить(Команда)
	Элементы.ТекстАлгоритмаHTML.Document.editor.refresh();	
КонецПроцедуры

&НаКлиенте
Процедура КнРежимКода(Команда)
	ТекстАлгоритма.УстановитьТекст(ПолучитьВыражение());
	Элементы.КнРежимКода.Пометка=Не Элементы.КнРежимКода.Пометка;
	Если Элементы.КнРежимКода.Пометка Тогда
		Режим=0;
	Иначе	
	    Режим=2;
	КонецЕсли;
	ЭтаФорма.ВладелецФормы.Объект.РаскрашиватьКод=Элементы.КнРежимКода.Пометка;
	ОбработатьРежимВводаКода();
КонецПроцедуры

&НаКлиенте
Процедура ТекстАлгоритмаHTMLДокументСформирован(Элемент)
	УстановитьКод_в_HTML();
КонецПроцедуры


#КонецОбласти


#Область Алгоритм
//Ал++
&НаСервере
Функция ПолучитьАлгоритмНаСервере(Алгоритм)
	Об = РеквизитФормыВЗначение("ОбъектОбработка");
	Возврат Об.ПолучитьАлгоритмИзМакета(Алгоритм);
КонецФункции

&НаКлиенте
Процедура АлгоритмНачальный(Команда)
	ТекстАлгоритмаTEMP = ТекстАлгоритма.ПолучитьТекст();
	ТекстАлгоритма.УстановитьТекст(ПолучитьАлгоритмНаСервере("Начальный"));
КонецПроцедуры

&НаКлиенте
Процедура ПараметрыАлгоритмаЗначениеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Элементы.ПараметрыАлгоритмаЗначение.ВыбиратьТип = Элементы.ПараметрыАлгоритма.ТекущиеДанные.Значение = Неопределено;
	Если Элементы.ПараметрыАлгоритмаЗначение.ВыбиратьТип Тогда
		ПараметрыИсходящие = Новый Структура("ВыбираемыеТипы",ТипЗначенияПараметра);
		СтандартнаяОбработка = Ложь;
		ОткрытьФормуСовместимость82(мПутьКОбработке+".ВыборТипаУпр",ПараметрыИсходящие,"НачалоВыбораЗавершение");
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура НачалоВыбораЗавершение(Результат,ДополнительныеПараметры) Экспорт
	Если Результат <> Неопределено Тогда
		ТекДанные = ПараметрыАлгоритма.НайтиПоИдентификатору(Элементы.ПараметрыАлгоритма.ТекущаяСтрока);
		ТекДанные.Значение = Результат;
	КонецЕсли;
КонецПроцедуры // НачалоВыбораЗавершение()


&НаКлиенте
Процедура ОткрытьФормуСовместимость82(ИмяОткрываемойФормы,СтруктураПараметров = Неопределено,МодульРезультата = "") Экспорт
	
	Если ВладелецФормы.Это82() Тогда
		Результат = ОткрытьФормуМодально(ИмяОткрываемойФормы,СтруктураПараметров,ЭтаФорма);
		Если МодульРезультата <> "" Тогда
			Выполнить(МодульРезультата+"(Результат,Неопределено)");
		КонецЕсли;
	Иначе
		Если МодульРезультата <> "" Тогда
			ОписаниеОповещения = Неопределено;
			Выполнить("ОписаниеОповещения = Новый ОписаниеОповещения(МодульРезультата,ЭтаФорма)");
			Выполнить("ОткрытьФорму(ИмяОткрываемойФормы,СтруктураПараметров,ЭтаФорма,,,,ОписаниеОповещения,РежимОткрытияОкнаФормы.БлокироватьОкноВладельца)");
		Иначе
			Выполнить("ОткрытьФорму(ИмяОткрываемойФормы,СтруктураПараметров,ЭтаФорма,,,,,РежимОткрытияОкнаФормы.БлокироватьОкноВладельца)");
		КонецЕсли;
	КонецЕсли;
	

КонецПроцедуры // ОткрытьФормуСовместимость82()

&НаКлиенте
Процедура ал_ДобавитьВПараметрыАлгоритма(Команда)
	
	ТекДанные = Элементы.СтруктураРезультатаЗапроса.ТекущиеДанные;
	
	Если ТекДанные = Неопределено Тогда Возврат	КонецЕсли; 
	
	Если ПараметрыАлгоритма.НайтиПоЗначению(ТекДанные.ПримерЗначения) = Неопределено Тогда
		ПараметрыАлгоритма.Добавить(ТекДанные.ПримерЗначения);
	КонецЕсли;		
	
КонецПроцедуры

&НаКлиенте
Процедура ал_ОбратитьВыделение(Команда)
	
	Если Режим=2 Тогда
		ВыделенныйТекст=Элементы.ТекстАлгоритма.ВыделенныйТекст;
	Иначе
		ВыделенныйТекст=ПолучитьВыделениеHTML();
	КонецЕсли;
	
	ТекстАлгоритма.УстановитьТекст(ВыделенныйТекст);
КонецПроцедуры

&НаКлиенте
Процедура ал_Закоментарить(Команда)
	
	Перем СтрНач,СтрКон,КолНач,КолКон;
	Если Режим=2 Тогда
		Элементы.ТекстАлгоритма.ПолучитьГраницыВыделения(СтрНач,КолНач,СтрКон,КолКон);
		Элементы.ТекстАлгоритма.УстановитьГраницыВыделения(СтрНач,КолНач,СтрКон,КолКон);
		
		Для сч = СтрНач по СтрКон Цикл
			НовСтрока = "//" + ТекстАлгоритма.ПолучитьСтроку(сч);
			ТекстАлгоритма.ЗаменитьСтроку(сч, НовСтрока);
		КонецЦикла;  
		
		Элементы.ТекстАлгоритма.УстановитьГраницыВыделения(СтрНач,КолНач,СтрКон,КолКон);
	Иначе
		Стр_Код=ПолучитьВыделениеHTML();
		СтрКон=СтрЧислоСтрок(Стр_Код);
		
		Стр_НовКод="";
		Для сч = 1 по СтрКон Цикл
			НовСтрока = "//" + СтрПолучитьСтроку(Стр_Код,сч);
			Стр_НовКод=Стр_НовКод+НовСтрока+"
			|";
		КонецЦикла;
		ВставитьКод_в_HTML(Стр_НовКод);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ал_Раскоментарить(Команда)
	Перем СтрНач,СтрКон,КолНач,КолКон;
	
	Если Режим=2 Тогда
		Элементы.ТекстАлгоритма.ПолучитьГраницыВыделения(СтрНач,КолНач,СтрКон,КолКон);
		
		Для сч = СтрНач по СтрКон Цикл
			СтарСтрока = ТекстАлгоритма.ПолучитьСтроку(сч);
			Если Не Лев(СтарСтрока,2) = "//" Тогда Продолжить КонецЕсли; 
			
			НовСтрока = Сред(СтарСтрока,3,СтрДлина(СтарСтрока));
			ТекстАлгоритма.ЗаменитьСтроку(сч, НовСтрока);
		КонецЦикла;  
		
		Элементы.ТекстАлгоритма.УстановитьГраницыВыделения(СтрНач,КолНач,СтрКон,КолКон);
	Иначе
		Стр_Код=ПолучитьВыделениеHTML();
		СтрКон=СтрЧислоСтрок(Стр_Код);
		
		Стр_НовКод="";
		Для сч = 1 по СтрКон Цикл
			СтарСтрока = СтрПолучитьСтроку(Стр_Код,сч);
			Если Лев(СтарСтрока,2) = "//" Тогда
				НовСтрока = Сред(СтарСтрока,3,СтрДлина(СтарСтрока));
			Иначе
			    НовСтрока = СтарСтрока;
			КонецЕсли; 
			
			Стр_НовКод=Стр_НовКод+НовСтрока+"
			|";
		КонецЦикла;
		ВставитьКод_в_HTML(Стр_НовКод);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ал_ОбновитьНумерациюОбъектов(Команда)
	
	// составной тип из строки и ссылки на справочник Номенклатуры.

	МассивТипов = Новый Массив;
	//МассивТипов.Добавить(Тип("СправочникСсылка.Номенклатура"));
	МассивТипов.Добавить(Тип("Строка"));
	ПараметрыСтроки = Новый КвалификаторыСтроки(150);
	
	ДопустимыеТипы = Новый ОписаниеТипов(МассивТипов, , ПараметрыСтроки);
	
	Значение = "ОбновитьНумерациюОбъектов(Метаданные.Документы.РеализацияТоваровУслуг);";
	ДополнительныеПараметры = Новый Структура;
	Оповещение = Новый ОписаниеОповещения("ал_ОбновитьНумерациюОбъектовЗавершение", ЭтаФорма, ДополнительныеПараметры);
	ПоказатьВводЗначения(Оповещение, Значение, "Введите значение", ДопустимыеТипы);
	
КонецПроцедуры

&НаКлиенте
Процедура ал_ОбновитьНумерациюОбъектовЗавершение(Значение, ДополнительныеПараметры) Экспорт
	
	Если Значение <> Неопределено Тогда
		СтруктураСтрокиВызова = Новый Структура;
		ВыполнитьАлгоритмНаСервере(Значение,СтруктураСтрокиВызова,ПараметрыАлгоритма);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПолеРезультатаТекстДляМодуляСкопировать(Команда)
	ОбъектБуфер = Новый COMОбъект("htmlfile");
	ОбъектБуфер.ParentWindow.ClipboardData.SetData("Text", ПолеРезультатаТекстДляМодуля);
	
КонецПроцедуры

&НаКлиенте
Процедура КнопкаПараметрАлгоритмаТекстДляМодуляСкопировать(Команда)
	ОбъектБуфер = Новый COMОбъект("htmlfile");
	ОбъектБуфер.ParentWindow.ClipboardData.SetData("Text", ПараметрАлгоритмаТекстДляМодуля);
КонецПроцедуры

&НаКлиенте
Процедура ал_Назад(Команда)
	ТекстАлгоритма.УстановитьТекст(ТекстАлгоритмаTEMP);
КонецПроцедуры

//Ал--
#КонецОбласти
