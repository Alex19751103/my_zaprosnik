﻿
&НаКлиенте
Перем мРежимВыбораКолонок;

&НаКлиенте
Процедура УправлениеВидимостью()
	
	Если мРежимВыбораКолонок Тогда
		Элементы.ТаблицаЗначений.Видимость = Ложь;
		Элементы.СтруктураКолонок.Видимость = Истина;
	Иначе
		Элементы.ТаблицаЗначений.Видимость = Истина;
		Элементы.СтруктураКолонок.Видимость = Ложь;
	КонецЕсли;
	
КонецПроцедуры // УправлениеВидимостью()


&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	МассивРеквизитов = Новый Массив;
	Для Каждого ОписаниеКолонки Из Параметры.СтруктураКолонок Цикл
		НоваяСтрока = СтруктураКолонок.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока,ОписаниеКолонки.Значение);
		ИзменитьДобавитьКолонкуТаблицы(НоваяСтрока.ПолучитьИдентификатор());
	КонецЦикла;
	
	Для Каждого СодержимоеТаблицы Из Параметры.ВходящийСписок Цикл
		НоваяСтрока = ТаблицаЗначений.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока,СодержимоеТаблицы.Значение);
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура ИзменитьДобавитьКолонкуТаблицы(ОписаниеКолонкиИд)
	
	ОписаниеКолонки = СтруктураКолонок.НайтиПоИдентификатору(ОписаниеКолонкиИд);
	МассивРеквизитов = Новый Массив;
	ТекТип = ОписаниеКолонки.ТипЗначения;
	Если ЭлементыСинхронизированы(ОписаниеКолонкиИд) Тогда
		Возврат
	КонецЕсли;
	
	МассивРеквизитов.Добавить(Новый РеквизитФормы(ОписаниеКолонки.ИмяКолонки, ТекТип, "ТаблицаЗначений")); 
	ИзменитьРеквизиты(МассивРеквизитов);
	НовыйЭлемент = Элементы.Добавить("ТаблицаЗначений" + ОписаниеКолонки.ИмяКолонки, Тип("ПолеФормы"), Элементы.ТаблицаЗначений);
	НовыйЭлемент.Вид = ВидПоляФормы.ПолеВвода;
	НовыйЭлемент.ПутьКДанным = "ТаблицаЗначений." + ОписаниеКолонки.ИмяКолонки;
	
	
КонецПроцедуры // ДобавитьНовуюКолонкуТаблицы()

&НаКлиенте
Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
	ОписаниеТаблицыРодителя = ВладелецФормы.Элементы.ПараметрыЗапроса.ТекущиеДанные.ОписаниеТаблицыЗначений;
	ОписаниеТаблицыРодителя.Очистить();
	Для Каждого Колонка Из СтруктураКолонок Цикл
		НоваяСтруктура = Новый Структура;
		НоваяСтруктура.Вставить("ИмяКолонки",Колонка.ИмяКолонки);
		НоваяСтруктура.Вставить("ТипЗначения",Колонка.ТипЗначения);
		ОписаниеТаблицыРодителя.Добавить(НоваяСтруктура);
	КонецЦикла;
	
	ТаблицаЗначенийРодителя = ВладелецФормы.Элементы.ПараметрыЗапроса.ТекущиеДанные.ТаблицаЗначений;
	ТаблицаЗначенийРодителя.Очистить();
	Для Каждого СтрокаТЗ Из ТаблицаЗначений Цикл
		СтруктураЗагрузки = Новый Структура;
		Для Каждого Колонка Из СтруктураКолонок Цикл
			СтруктураЗагрузки.Вставить(Колонка.ИмяКолонки,СтрокаТЗ[Колонка.ИмяКолонки]);
		КонецЦикла;
		ТаблицаЗначенийРодителя.Добавить(СтруктураЗагрузки);
	КонецЦикла;
	ВладелецФормы.Элементы.ПараметрыЗапроса.ТекущиеДанные.ЗначениеПараметра = "ТаблицаЗначений : " + СокрЛП(ТаблицаЗначений.Количество()) + " стр.";
КонецПроцедуры


&НаКлиенте
Процедура ПриОткрытии(Отказ)
	УправлениеВидимостью();
КонецПроцедуры


&НаКлиенте
Процедура Отмена(Команда)
	ЭтаФорма.Закрыть();
КонецПроцедуры


&НаКлиенте
Процедура Колонки(Команда)
	мРежимВыбораКолонок = Истина;
	УправлениеВидимостью();
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытьНастройкуКолонок(Команда)
	мРежимВыбораКолонок = Ложь;
	УправлениеВидимостью();
КонецПроцедуры


&НаСервере
Процедура ОбработатьTXTНаСервере(ФайлВХранилище)
	
	ДвоичныеДанные = ПолучитьИзВременногоХранилища(ФайлВХранилище);
	ИмяТемпФайла = ПолучитьИмяВременногоФайла();
	ДвоичныеДанные.Записать(ИмяТемпФайла); 
	ТекстовыйФайл = Новый ТекстовыйДокумент;
	ТекстовыйФайл.Прочитать(ИмяТемпФайла);
	Т = ТекстовыйФайл.ПолучитьТекст();
	Если Найти(Т,"""#type"": ""jv8:ValueListType"",") > 0 ИЛИ Найти(Т,"""#type"": ""jv8:ValueTable"",") > 0 Тогда
		ОбъектОбработка = РеквизитФормыВЗначение("Объект");
		ТЗ = ОбъектОбработка.ДесерилизаторJSON(Т);
	Иначе
		ТЗ = ЗначениеИзФайла(ИмяТемпФайла);
	КонецЕсли;
	
	Если ТипЗнч(ТЗ) = Тип("СписокЗначений") Тогда
		М = ТЗ.ВыгрузитьЗначения();
		ТЗ = Новый ТаблицаЗначений;
		ТЗ.Колонки.Добавить("Значения");
		Для каждого стр Из М Цикл
			ТЗ.Добавить();
		КонецЦикла; 
		ТЗ.ЗагрузитьКолонку(М,"Значения");
	КонецЕсли;
	
	Колонки = ТЗ.Колонки;
	ИмяСл = Колонки.Найти("СлужебныйРек__");
	Если ИмяСл <> Неопределено  Тогда
		Колонки.Удалить("СлужебныйРек__");
	КонецЕсли;
	
	Файл = Новый Файл(ИмяТемпФайла);
	
	Если Файл.Существует() Тогда
		Попытка
			УдалитьФайлы(ИмяТемпФайла);
		Исключение
		КонецПопытки;
		
	КонецЕсли;
	
	ВывестиРезультат(ТЗ,Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьИзФайла(Команда)
	
	ДиалогВыбораФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	
	ДиалогВыбораФайла.Фильтр = "Файл данных (txt xls mxl)|*.txt;*.xls;*.xlsx;*.mxl";
	ДиалогВыбораФайла.Расширение = "txt";
	ДиалогВыбораФайла.ПредварительныйПросмотр = Ложь;
	ДиалогВыбораФайла.ИндексФильтра = 0;
	
	Если ДиалогВыбораФайла.Выбрать() Тогда
		
		Если Найти(ДиалогВыбораФайла.ПолноеИмяФайла,".txt") > 0 Тогда
			Файл = Новый ДвоичныеДанные(ДиалогВыбораФайла.ПолноеИмяФайла);
			Адрес = ПоместитьВоВременноеХранилище(Файл, ЭтаФорма.УникальныйИдентификатор);
			ОбработатьTXTНаСервере(Адрес);	
		ИначеЕсли Найти(ДиалогВыбораФайла.ПолноеИмяФайла,".mxl") > 0 Тогда
			Файл = Новый ДвоичныеДанные(ДиалогВыбораФайла.ПолноеИмяФайла);
			Адрес = ПоместитьВоВременноеХранилище(Файл, ЭтаФорма.УникальныйИдентификатор);
			ЗагрузитьИзФайлаMXLНаСервере(Адрес);
		Иначе
			
			Док = ПолучитьCOMОбъект(ДиалогВыбораФайла.ПолноеИмяФайла);
			
			ИмяКниги = ДиалогВыбораФайла.ПолноеИмяФайла;
			поз = Найти(ИмяКниги, "\");
			Пока поз > 0 Цикл
				ИмяКниги = Прав(ИмяКниги, СтрДлина(ИмяКниги) - поз );
				поз = Найти(ИмяКниги, "\");
			КонецЦикла;    
			
			ТекЛист = Док.Application.Workbooks(ИмяКниги).Worksheets(1);
			КолСтрок = ТекЛист.UsedRange.Rows.Count;
			КолСтолбцов = ТекЛист.UsedRange.Columns.Count;
			
			СомОбластьДанных = ТекЛист.Range(ТекЛист.Cells(1,1),ТекЛист.Cells(КолСтрок,КолСтолбцов));
			Данные = СомОбластьДанных.Value.Выгрузить();
			
			ЗагрузитьИзФайлаXLSНаСервере(Данные,КолСтрок,КолСтолбцов);
			
			Док = 0; 
		КонецЕсли;
		
		ПоказатьОповещениеПользователя("Данные загружены",,"Выполнена загрузка данных из файла "+ДиалогВыбораФайла.ПолноеИмяФайла);
	КонецЕсли;  
	
КонецПроцедуры

&НаСервере
Функция ПолучитьТЗНаСервере()
	
	ИмяТемпФайла = ПолучитьИмяВременногоФайла();
	ТЗ = ТаблицаЗначений.Выгрузить();
	
	Колонки = ТЗ.Колонки;
	ИмяСл = Колонки.Найти("СлужебныйРек__");
	Если ИмяСл <> Неопределено  Тогда
		Колонки.Удалить("СлужебныйРек__");
	КонецЕсли;
	
	//ЗначениеВФайл(ИмяТемпФайла,ТЗ);
	ОбъектОбработка = РеквизитФормыВЗначение("Объект");
	Т = ОбъектОбработка.СериализаторJSON(ТЗ);
	ТекстовыйФайл = Новый ТекстовыйДокумент;
	ТекстовыйФайл.УстановитьТекст(Т);
	ТекстовыйФайл.Записать(ИмяТемпФайла);

	ДвоичныеДанныеВложения = Новый ДвоичныеДанные(ИмяТемпФайла);
	Адрес = ПоместитьВоВременноеХранилище(ДвоичныеДанныеВложения);
	
	Файл = Новый Файл(ИмяТемпФайла);
	Если Файл.Существует() Тогда
		Попытка
			УдалитьФайлы(ИмяТемпФайла);
		Исключение
		КонецПопытки;
		
	КонецЕсли;
	
	Возврат Адрес;
	
КонецФункции

&НаКлиенте
Процедура СохранитьВФайл(Команда)
	
	ДиалогВыбораФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);
	ДиалогВыбораФайла.Фильтр = "Файл данных (*.txt)|*.txt";
	ДиалогВыбораФайла.Расширение = "txt";
	ДиалогВыбораФайла.ПредварительныйПросмотр = Ложь;
	ДиалогВыбораФайла.ИндексФильтра = 0;
	
	Если ДиалогВыбораФайла.Выбрать() Тогда
		ФайлВХранилище = ПолучитьТЗНаСервере();
		ДвоичныеДанные = ПолучитьИзВременногоХранилища(ФайлВХранилище);
		ДвоичныеДанные.Записать(ДиалогВыбораФайла.ПолноеИмяФайла); 
		ПоказатьОповещениеПользователя("Данные сохранены",,"Выполнено сохранение данных в файл "+ДиалогВыбораФайла.ПолноеИмяФайла);
	КонецЕсли;  
	
КонецПроцедуры

&НаСервере
Функция ИмяВФормате1С(Имя)
	
	НовоеИмя = "";
	Имя = СокрЛП(Имя);
	
	Цифры = "0123456789";
	Латиница = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	Кирилица = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя_";
	Все = Цифры + Латиница + Кирилица;
	
	Для сч = 1 По СтрДлина(Имя) Цикл
		Буква = Сред(Имя,сч,1);
		Если Найти(Все,Буква) > 0   Тогда
			НовоеИмя = НовоеИмя + Буква;
		Иначе
			НовоеИмя = НовоеИмя + КодСимвола(Буква);
		КонецЕсли;
	КонецЦикла;
	
	Если Найти(Цифры,Лев(НовоеИмя,1)) > 0   Тогда
		НовоеИмя = "_" + НовоеИмя;	
	КонецЕсли;
	
	НовоеИмя = СтрЗаменить(НовоеИмя,Символы.НПП,"");
	
	Возврат НовоеИмя;
	
КонецФункции // ()

&НаСервере
Процедура ЗагрузитьИзФайлаXLSНаСервере(Данные,КолСтрок,КолСтолбцов);
	
	ТЗ = Новый ТаблицаЗначений;
	
	Для Сч=0 По КолСтолбцов-1 Цикл
		ТЗ.Колонки.Добавить(ИмяВФормате1С(Данные[Сч][0]),Новый ОписаниеТипов("Строка"));
	КонецЦикла;
	
	Для Сч=1 По КолСтрок Цикл
		ТЗ.Добавить();
	КонецЦикла;
	
	Для Сч=0 По КолСтолбцов-1 Цикл
		ТЗ.ЗагрузитьКолонку(Данные[Сч], ИмяВФормате1С(Данные[Сч][0]));
	КонецЦикла;
	
	ТЗ.Удалить(ТЗ[0]);
	
	ВывестиРезультат(ТЗ);
	
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьИзФайлаMXLНаСервере(ФайлВХранилище)
	
	ДвоичныеДанные = ПолучитьИзВременногоХранилища(ФайлВХранилище);
	ИмяТемпФайла = ПолучитьИмяВременногоФайла();
	ДвоичныеДанные.Записать(ИмяТемпФайла); 
	
	ТабДок = Новый ТабличныйДокумент;
	ТабДок.Прочитать(ИмяТемпФайла);
	ПЗ = Новый ПостроительЗапроса;
	ПЗ.ИсточникДанных = Новый ОписаниеИсточникаДанных(ТабДок.Область());
	ПЗ.ДобавлениеПредставлений = ТипДобавленияПредставлений.НеДобавлять;
	ПЗ.ЗаполнитьНастройки();
	ПЗ.Выполнить();
	ТЗ =  ПЗ.Результат.Выгрузить();
	
	Файл = Новый Файл(ИмяТемпФайла);
	Если Файл.Существует() Тогда
		Попытка
			УдалитьФайлы(ИмяТемпФайла);
		Исключение
		КонецПопытки;
		
	КонецЕсли;
	
	ВывестиРезультат(ТЗ);
	
КонецПроцедуры

&НаСервере
Процедура ВывестиРезультат(ТЗРезультата, ПостОбработка = Истина)
	
	//Ал++
	КЧ = Новый КвалификаторыЧисла(15,3);
	КС = Новый КвалификаторыСтроки(250);
	КД = Новый КвалификаторыДаты(ЧастиДаты.ДатаВремя);
	
	МассивТипов = Новый Массив;
	МассивТипов.Добавить(Тип("Число"));
	ОписаниеТиповЧ = Новый ОписаниеТипов(МассивТипов, , ,КЧ,КС,КД);
	МассивТипов = Новый Массив;
	МассивТипов.Добавить(Тип("Строка"));
	ОписаниеТиповС = Новый ОписаниеТипов(МассивТипов, , ,КЧ,КС,КД);
	МассивТипов = Новый Массив;
	МассивТипов.Добавить(Тип("Дата"));
	ОписаниеТиповД = Новый ОписаниеТипов(МассивТипов, , ,КЧ,КС,КД);
	
	
	МассивКУдалению = Новый Массив;
	
	Если ТЗРезультата.Колонки.Количество() = 1 Тогда
		ТЗРезультата.Колонки.Добавить("Служ");
	КонецЕсли;	
	
	Если ПостОбработка Тогда
		
		Для счч = 0 По  ТЗРезультата.Колонки.Количество()-1 Цикл
			
			ИмяКолонки = ТЗРезультата.Колонки[счч].Имя;
			Массив = ТЗРезультата.ВыгрузитьКолонку(ИмяКолонки);
			
			Если НЕ МассивНеПустой(Массив) Тогда
				МассивКУдалению.Добавить(ИмяКолонки);
			ИначеЕсли НеТипизировать Тогда // Это строка
				Дл = МассивМаксДлинна(Массив);
				ТЗРезультата.Колонки.Удалить(ИмяКолонки);
				КС = Новый КвалификаторыСтроки(Дл);
				МассивТипов = Новый Массив;
				МассивТипов.Добавить(Тип("Строка"));
				ОписаниеТиповС = Новый ОписаниеТипов(МассивТипов, , ,,КС,);
				ТЗРезультата.Колонки.Вставить(счч,ИмяКолонки,ОписаниеТиповС);
				Для сч = 0 По Массив.Количество()-1 Цикл
					ТЗРезультата[сч][ИмяКолонки] = Массив[сч];
				КонецЦикла;
			ИначеЕсли МассивЭтоДата(Массив) Тогда
				ТЗРезультата.Колонки.Удалить(ИмяКолонки);
				ТЗРезультата.Колонки.Вставить(счч,ИмяКолонки,ОписаниеТиповД);
				Для сч = 0 По Массив.Количество()-1 Цикл
					ТЗРезультата[сч][ИмяКолонки] = ДатаИзСтроки(Массив[сч]);
				КонецЦикла;
			ИначеЕсли НЕ МассивЭтоСтрока(Массив) Тогда
				ТЗРезультата.Колонки.Удалить(ИмяКолонки);
				ТЗРезультата.Колонки.Вставить(счч,ИмяКолонки,ОписаниеТиповЧ);
				Для сч = 0 По Массив.Количество()-1 Цикл
					ТЗРезультата[сч][ИмяКолонки] = ЧислоИзСтроки(Массив[сч]);
				КонецЦикла;	
			Иначе // Это строка
				Дл = МассивМаксДлинна(Массив);
				ТЗРезультата.Колонки.Удалить(ИмяКолонки);
				КС = Новый КвалификаторыСтроки(Дл);
				МассивТипов = Новый Массив;
				МассивТипов.Добавить(Тип("Строка"));
				ОписаниеТиповС = Новый ОписаниеТипов(МассивТипов, , ,,КС,);
				ТЗРезультата.Колонки.Вставить(счч,ИмяКолонки,ОписаниеТиповС);
				Для сч = 0 По Массив.Количество()-1 Цикл
					ТЗРезультата[сч][ИмяКолонки] = Массив[сч];
				КонецЦикла;
			КонецЕсли;		
			
		КонецЦикла;
		
		Для сч = 0 По  МассивКУдалению.Количество()-1 Цикл
			ТЗРезультата.Колонки.Удалить(МассивКУдалению[сч]);
		КонецЦикла;
	КонецЕсли;
	
	//Ал--
	РекФормы = "ТаблицаЗначений";
	
	//Очистим колонки результата в форме
	ЭтаФорма[РекФормы].Очистить();
	
	КоллекцияКолонок = РеквизитФормыВЗначение(РекФормы).Колонки;
	МассивУдаляемыхКолонок = Новый Массив;
	Для Каждого Колонка Из КоллекцияКолонок Цикл
		Если Колонка.Имя = "СлужебныйРек__"  Тогда
			Продолжить;
		КонецЕсли;
		
		МассивУдаляемыхКолонок.Добавить(РекФормы+"."+Колонка.Имя);
		
		ЭлементФормы = Элементы.Найти(РекФормы+Колонка.Имя);
		Если ЭлементФормы<>Неопределено Тогда
			Элементы.Удалить(ЭлементФормы);
		КонецЕсли;
		
	КонецЦикла;
	ИзменитьРеквизиты(,МассивУдаляемыхКолонок);
	
	МассивРеквизитов = Новый Массив;
	УдаляемыеКолонкиТЗ = Новый Структура;
	ЧисловыеКолонки = Новый Массив;
	Если ТЗРезультата = Неопределено Тогда
		Возврат;
	КонецЕсли;
	Для Каждого КолонкаРез из ТЗРезультата.Колонки Цикл
		ТекТип = КолонкаРез.ТипЗначения;
		Если КолонкаРез.ТипЗначения.СодержитТип(Тип("РезультатЗапроса")) Тогда
			ТекТип = Новый ОписаниеТипов("Строка"); 
			УдаляемыеКолонкиТЗ.Вставить(КолонкаРез.Имя,"РезультатЗапроса");
		ИначеЕсли КолонкаРез.ТипЗначения.СодержитТип(Тип("ХранилищеЗначения")) Тогда
			ТекТип = Новый ОписаниеТипов("Строка"); 
			УдаляемыеКолонкиТЗ.Вставить(КолонкаРез.Имя,"ХранилищеЗначения");
		ИначеЕсли КолонкаРез.ТипЗначения.СодержитТип(Тип("ДвоичныеДанные")) Тогда
			ТекТип = Новый ОписаниеТипов("Строка"); 
			//УдаляемыеКолонкиТЗ.Вставить(КолонкаРез.Имя,"ХранилищеЗначения");
			
		ИначеЕсли КолонкаРез.ТипЗначения.СодержитТип(Тип("МоментВремени")) Тогда
			ТекТип = Новый ОписаниеТипов("Строка"); 
			УдаляемыеКолонкиТЗ.Вставить(КолонкаРез.Имя, "МоментВремени");
		ИначеЕсли КолонкаРез.ТипЗначения.СодержитТип(Тип("Число")) и РекФормы = "РезультатТаблица" и не Врег(КолонкаРез.Имя) = "УРОВЕНЬ" Тогда
			МассивРеквизитов.Добавить(Новый РеквизитФормы(РекФормы+"Итог"+КолонкаРез.Имя, Новый ОписаниеТипов("Число"), "")); 
			ЧисловыеКолонки.Добавить(КолонкаРез.Имя);
		КонецЕсли;
		МассивРеквизитов.Добавить(Новый РеквизитФормы(КолонкаРез.Имя, ТекТип, РекФормы)); 
	КонецЦикла;
	
	ИзменитьРеквизиты(МассивРеквизитов);
	
	СтруктураКолонок.Очистить();
	Для Каждого КолонкаРез из ТЗРезультата.Колонки Цикл
		
		НовыйЭлемент = Элементы.Добавить(РекФормы + КолонкаРез.Имя, Тип("ПолеФормы"), Элементы[РекФормы]);
		НовыйЭлемент.Вид = ВидПоляФормы.ПолеВвода;
		НовыйЭлемент.ПутьКДанным = РекФормы+"." + КолонкаРез.Имя;
		Если КолонкаРез.ТипЗначения.СодержитТип( Тип("Число")) и РекФормы = "РезультатТаблица" Тогда
			НовыйЭлемент.ОтображатьВПодвале = Истина;
			НовыйЭлемент.ПутьКДаннымПодвала = РекФормы+"Итог" + КолонкаРез.Имя;
		КонецЕсли;
		
		НоваяСтрока = СтруктураКолонок.Добавить();
		НоваяСтрока.ИмяКолонки  = КолонкаРез.Имя;
		НоваяСтрока.ТипЗначения = КолонкаРез.ТипЗначения;
		
	КонецЦикла;
	
	ТаблицаЗначений.Загрузить(ТЗРезультата);
	
	Для Каждого ПереоформляемаяКолонка Из УдаляемыеКолонкиТЗ Цикл
		ИмяКолонки = ПереоформляемаяКолонка.Ключ;
		ТЗРезультата.Колонки.Удалить(ТЗРезультата.Колонки.Найти(ПереоформляемаяКолонка.Ключ));
		ТЗРезультата.Колонки.Добавить(ИмяКолонки,Новый ОписаниеТипов("Строка"));
		ТЗРезультата.ЗаполнитьЗначения(ПереоформляемаяКолонка.Значение,ИмяКолонки);
	КонецЦикла;
	
КонецПроцедуры // ВывестиРезультат()


&НаСервере
Процедура ВставитьИзБуфераНаСервере(Текст)
	
	ТЗ = Новый ТаблицаЗначений;	
	МассивСтрок = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(Текст,Символы.ВК);
	
	Стр = МассивСтрок[0];		
	Если НЕ ЗначениеЗаполнено(Стр) Тогда
		Возврат;
	КонецЕсли;
	
	МассивСтолбцов = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(Стр,Символы.Таб);
	Для НомерСтроки = 0 По МассивСтолбцов.Количество()-1 Цикл
		ЗаголовокКолонки = МассивСтолбцов[НомерСтроки];
		
		ИмяКолонки = ИмяВФормате1С(ЗаголовокКолонки);
		Если ИмяКолонки = "_" Тогда
			ИмяКолонки = ТЗ.Колонки[ТЗ.Колонки.Количество()-1].Имя  + 1;
		КонецЕсли;
		
		ТЗ.Колонки.Добавить(ИмяКолонки, Новый ОписаниеТипов("Строка"),ЗаголовокКолонки);
	КонецЦикла;
	
	Для НомерСтроки = 1 По МассивСтрок.Количество()-1 Цикл
		
		Стр= МассивСтрок[НомерСтроки];
		Стр= СтрЗаменить(Стр,Символы.ПС,"");
		
		Если ЗначениеЗаполнено(Стр) Тогда
			
			НоваяСтрока = ТЗ.Добавить();
			МассивЗначенийСтолбцов = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(Стр,Символы.Таб);
			Для НомерКол = 0 По МассивЗначенийСтолбцов.Количество()-1 Цикл
				НоваяСтрока[НомерКол] = МассивЗначенийСтолбцов[НомерКол];
			КонецЦикла;
			
		КонецЕсли;
	КонецЦикла;
	
	ВывестиРезультат(ТЗ);
	
КонецПроцедуры

&НаКлиенте
Процедура ВставитьИзБуфера(Команда)
	
	Текст = "";
	ОбъектБуфер = Новый COMОбъект("htmlfile");
	Буфер = ОбъектБуфер.ParentWindow.ClipboardData.Getdata("Text");
	Текст = СокрЛП(Буфер);
	
	ВставитьИзБуфераНаСервере(Текст);
	
КонецПроцедуры

&НаКлиенте
Процедура СкопироватьВБуферСтруктуруКолонок(Команда)
	
	ТекстЗапроса = Новый ТекстовыйДокумент;
	ТекстЗапроса.ВставитьСтроку(1,"ВЫБРАТЬ");
	
	Для сч = 0 По СтруктураКолонок.Количество() - 1 Цикл
		Имя = СтруктураКолонок[сч].ИмяКолонки;
		ТекстЗапроса.ВставитьСтроку(сч + 2,"	ТЗ." + Имя + ",");
	КонецЦикла;
	ТекстЗапроса.ЗаменитьСтроку(сч + 1,"	ТЗ." + Имя);
	сч = сч + 1;
	ТекстЗапроса.ВставитьСтроку(сч + 1,"ПОМЕСТИТЬ ТЗ");
	ТекстЗапроса.ВставитьСтроку(сч + 2,"ИЗ");
	ТекстЗапроса.ВставитьСтроку(сч + 3,"	&ТЗ КАК ТЗ");
	ТекстЗапроса.ВставитьСтроку(сч + 4,";");
	ТекстЗапроса.ВставитьСтроку(сч + 5,"");
	ТекстЗапроса.ВставитьСтроку(сч + 6,"////////////////////////////////////////////////////////////////////////////////");
	
	ОбъектБуфер = Новый COMОбъект("htmlfile");
	ОбъектБуфер.ParentWindow.ClipboardData.SetData("Text", ТекстЗапроса.ПолучитьТекст());
	
КонецПроцедуры

&НаСервере
Функция МассивЭтоСтрока(Массив)
	
	Для счч = 0 По Массив.Количество() - 1 Цикл
		
		стр = СокрЛП(Массив[счч]);	
		стр = СтрЗаменить(стр," ","");
		стр = СтрЗаменить(стр," ","");
		стр = СтрЗаменить(стр,Символы.НПП,"");
		стр = СтрЗаменить(стр,",",".");
		стр = НРег(стр);
		
		Числа = "0123456789";
		Буквы = "ёйцукенгшщзхъфывапролджэячсмитьбю";
		БуквыЛ = "qwertyuiopasdfghjklzxcvbnm;";
		ВсеБуквы = Буквы + БуквыЛ;
		
		Для сч = 1 По СтрДлина(стр) Цикл
			й =  Сред(стр,сч,1);
			Если Найти(ВсеБуквы,й) > 0 Тогда
				Возврат Истина;
			КонецЕсли;
		КонецЦикла;
		
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции

&НаСервере
Функция МассивЭтоДата(Массив)
	
	Для счч = 0 По Массив.Количество() - 1 Цикл
		
		ДатаСтрокой = СокрЛП(Массив[счч]);
		Час = 0;
		Минута = 0;
		Секунда = 0;
		
		СтрДата = Лев(ДатаСтрокой, 10);
		День = ЧислоИзСтроки(Лев(СтрДата, 2));
		Месяц = ЧислоИзСтроки(Сред(СтрДата, 4, 2));
		Год = ЧислоИзСтроки(Прав(СтрДата, 4));
		
		Если СтрДлина(ДатаСтрокой) = 18 ИЛИ СтрДлина(ДатаСтрокой) = 19 Тогда
			Попытка
				СтрВремя = Прав(ДатаСтрокой, 8);
				СтрВремя = СтрЗаменить(СтрВремя,":",Символы.ПС);
				
				Час = Число(СтрПолучитьСтроку(СтрВремя, 1));
				Минута = Число(СтрПолучитьСтроку(СтрВремя, 2));
				Секунда = Число(СтрПолучитьСтроку(СтрВремя, 3));
				
			Исключение
			КонецПопытки;
			
		КонецЕсли;
		
		Попытка
			ДатаДатой = Дата(Год, Месяц, День, Час, Минута, Секунда);
		Исключение
			Возврат Ложь;
		КонецПопытки;
		
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции

&НаСервере
Функция МассивНеПустой(Массив)
	
	Для счч = 0 По Массив.Количество() - 1 Цикл
		стр = СокрЛП(Массив[счч]);
		Если ЗначениеЗаполнено(стр) Тогда
			Возврат Истина;
		КонецЕсли;
	КонецЦикла;	
	
	Возврат Ложь;
	
КонецФункции

&НаСервере
Функция МассивМаксДлинна(Массив)
	
	Дл = 1;
	Для счч = 0 По Массив.Количество() - 1 Цикл
		Дл = Макс(СтрДлина(СокрЛП(Массив[счч])),Дл);	
	КонецЦикла;
	
	Возврат Дл;
	
КонецФункции

&НаСервере
Функция ЧислоИзСтроки(стр)
	
	стр = СокрЛП(стр);	
	стр = СтрЗаменить(стр," ","");
	стр = СтрЗаменить(стр," ","");
	стр = СтрЗаменить(стр,Символы.НПП,"");
	стр = СтрЗаменить(стр,",",".");
	
	Числа = "0123456789.,";
	йй ="";
	Для сч = 1 По СтрДлина(стр) Цикл
		й =  Сред(стр,сч,1);
		Если Найти(Числа,й) > 0 Тогда
			йй = йй + й;
		Иначе
			йй ="";
		КонецЕсли;
		
	КонецЦикла;
	
	Попытка
		Возврат Число(йй);
	Исключение
		Возврат 0;
	КонецПопытки;
	
КонецФункции

&НаСервере
Функция ДатаИзСтроки(ДатаСтрокой)
	
	Час = 0;
	Минута = 0;
	Секунда = 0;
	
	СтрДата = Лев(ДатаСтрокой, 10);
	День = ЧислоИзСтроки(Лев(СтрДата, 2));
	Месяц = ЧислоИзСтроки(Сред(СтрДата, 4, 2));
	Год = ЧислоИзСтроки(Прав(СтрДата, 4));
	
	Если СтрДлина(ДатаСтрокой) = 18 ИЛИ СтрДлина(ДатаСтрокой) = 19 Тогда
		Попытка
			СтрВремя = Прав(ДатаСтрокой, 8);
			СтрВремя = СтрЗаменить(СтрВремя,":",Символы.ПС);
			
			Час = Число(СтрПолучитьСтроку(СтрВремя, 1));
			Минута = Число(СтрПолучитьСтроку(СтрВремя, 2));
			Секунда = Число(СтрПолучитьСтроку(СтрВремя, 3));
			
		Исключение
		КонецПопытки;
		
	КонецЕсли;
	
	Попытка
		Возврат Дата(Год, Месяц, День, Час, Минута, Секунда);
	Исключение
	КонецПопытки;
	
	Возврат ДатаСтрокой;
	
КонецФункции

&НаСервере
Функция НайтиПоКодуНаименованию(Стр,ТекТип)
	
	Мета = Метаданные.НайтиПоТипу(ТекТип.Типы().Получить(0));
	Если Мета = Неопределено Тогда
		Возврат СокрЛП(Стр);
	КонецЕсли;
	
	ИмяОбъекта = Метаданные.НайтиПоТипу(ТекТип.Типы().Получить(0)).Имя;
	ЭтоПредставление = СтрНайти(Стр,"(") > 0 И СтрНайти(Стр,") ") > 0;
	
	ЕстьНаименованиеПолное = Ложь;
	Попытка
		рек = Метаданные.Справочники[ИмяОбъекта].Реквизиты["НаименованиеПолное"];
		ЕстьНаименованиеПолное = Истина;
	Исключение	 
	КонецПопытки;
	
	ЕстьПолноеНаименование = Ложь;
	Попытка
		рек = Метаданные.Справочники[ИмяОбъекта].Реквизиты["ПолноеНаименование"];
		ЕстьПолноеНаименование = Истина;
	Исключение	 
	КонецПопытки;
	
	ЕстьИНН = Ложь;
	Если ИмяОбъекта = "Контрагенты" ИЛИ ИмяОбъекта = "ФизическиеЛица" Тогда
		Попытка
			рек = Метаданные.Справочники[ИмяОбъекта].Реквизиты["ИНН"];
			ЕстьИНН = Истина;
		Исключение	 
		КонецПопытки;
	КонецЕсли;
	
	ЕстьКод = Ложь;
	Попытка
		рек = Метаданные.Справочники[ИмяОбъекта].ДлинаКода > 0;
		ЕстьКод = Истина;
	Исключение	 
	КонецПопытки;
	
	ЕстьНаименование = Ложь;
	Попытка
		рек = Метаданные.Справочники[ИмяОбъекта].ДлинаНаименования > 0;
		ЕстьНаименование = Истина;
	Исключение	 
	КонецПопытки;
	
	Запрос = Новый Запрос;
	Если ИмяОбъекта = "Контрагенты" И ЭтоПредставление Тогда
		
		//Представление = "(" + Данные.ИНН + ") " + Данные.Наименование;  //Контрагенты
		
		ЗапросТекст = 
		"ВЫБРАТЬ
		|	Контрагенты.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.Контрагенты КАК Контрагенты
		|ГДЕ
		|	""("" + Контрагенты.ИНН + "") "" + Контрагенты.Наименование = &Наименование";
		
	ИначеЕсли ИмяОбъекта = "Контрагенты" И ЭтоПредставление Тогда
		
		//Представление = "(" + Данные.КПП + ") " + Данные.Наименование;  //ПодразделенияОрганизаций
		
		ЗапросТекст = 
		"ВЫБРАТЬ
		|	ПодразделенияОрганизаций.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.ПодразделенияОрганизаций КАК ПодразделенияОрганизаций
		|ГДЕ
		|	""("" + ПодразделенияОрганизаций.КПП + "") "" + ПодразделенияОрганизаций.Наименование = &Наименование";
		
	ИначеЕсли ЕстьНаименование И НЕ ЕстьКод Тогда
		
		ЗапросТекст = 
		"ВЫБРАТЬ
		|	Номенклатура.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.Номенклатура КАК Номенклатура
		|ГДЕ
		|	Номенклатура.Наименование = &Наименование";
		
	ИначеЕсли НЕ ЕстьНаименование И ЕстьКод Тогда
		
		ЗапросТекст = 
		"ВЫБРАТЬ
		|	Номенклатура.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.Номенклатура КАК Номенклатура
		|ГДЕ
		
		|	Номенклатура.Код = &Наименование";
		
	ИначеЕсли ЕстьНаименование И ЕстьКод Тогда
		
		ЗапросТекст = 
		"ВЫБРАТЬ
		|	Номенклатура.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.Номенклатура КАК Номенклатура
		|ГДЕ
		|	Номенклатура.Наименование В(&Наименование)
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	Номенклатура.Ссылка
		|ИЗ
		|	Справочник.Номенклатура КАК Номенклатура
		|ГДЕ
		|	Номенклатура.Код = &Наименование";
		
	КонецЕсли;
	
	Если ЕстьНаименованиеПолное И НЕ ЭтоПредставление Тогда
		
		ЗапросТекст = ЗапросТекст + "
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	Номенклатура.Ссылка
		|ИЗ
		|	Справочник.Номенклатура КАК Номенклатура
		|ГДЕ
		|	Номенклатура.НаименованиеПолное = &Наименование";
		
	КонецЕсли;
	
	Если ЕстьПолноеНаименование И НЕ ЭтоПредставление Тогда
		
		ЗапросТекст = ЗапросТекст + "
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	Номенклатура.Ссылка
		|ИЗ
		|	Справочник.Номенклатура КАК Номенклатура
		|ГДЕ
		|	Номенклатура.ПолноеНаименование = &Наименование";
		
	КонецЕсли;
	
	Если ЕстьИНН И НЕ ЭтоПредставление Тогда
		
		ЗапросТекст = ЗапросТекст + "
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	Номенклатура.Ссылка
		|ИЗ
		|	Справочник.Номенклатура КАК Номенклатура
		|ГДЕ
		|	Номенклатура.ИНН = &Наименование";
		
	КонецЕсли;
	
	ЗапросТекст = СтрЗаменить(ЗапросТекст,"Номенклатура",ИмяОбъекта);
	Запрос.Текст = ЗапросТекст;
	Запрос.УстановитьПараметр("Наименование", Стр);
	
	РезультатЗапроса = Запрос.Выполнить().Выгрузить();
	РезультатЗапроса.Свернуть("Ссылка");
	
	Попытка
		Возврат РезультатЗапроса[0].Ссылка;
	Исключение
		Возврат стр;
	КонецПопытки;
	
КонецФункции

&НаСервере
Функция ЭлементыСинхронизированы(ИдСтруктуры)
	
	ОписаниеКолонки = СтруктураКолонок.НайтиПоИдентификатору(ИдСтруктуры);
	ТЗ = РеквизитФормыВЗначение("ТаблицаЗначений");
	ТекКолонкаТЗ = ТЗ.Колонки.Найти(ОписаниеКолонки.ИмяКолонки); 
	Если ТекКолонкаТЗ = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;	
	Если ТекКолонкаТЗ.ТипЗначения <> ОписаниеКолонки.ТипЗначения Тогда
		Возврат Ложь
	Иначе
		Возврат Истина;
	КонецЕсли;
	
КонецФункции // ЭлементыСинхронизированы()

&НаСервере
Процедура УдалитьКолонкуИзТаблицы(ОписаниеКолонкиИд)
	
	МассивУдаляемыхРеквизитов = Новый Массив;
	
	Если ТипЗнч(ОписаниеКолонкиИд) = Тип("Массив") Тогда
		
		Для сч = 0 По ОписаниеКолонкиИд.Количество() - 1 Цикл
			ОписаниеКолонки = СтруктураКолонок.НайтиПоИдентификатору(ОписаниеКолонкиИд[сч]);
			Если НЕ Элементы.Найти("ТаблицаЗначений"+ОписаниеКолонки.ИмяКолонки) = Неопределено Тогда
				Элементы.Удалить(Элементы["ТаблицаЗначений"+ОписаниеКолонки.ИмяКолонки]);
				МассивУдаляемыхРеквизитов.Добавить("ТаблицаЗначений."+ОписаниеКолонки.ИмяКолонки);
			КонецЕсли;
		КонецЦикла;
		
	Иначе
		
		ОписаниеКолонки = СтруктураКолонок.НайтиПоИдентификатору(ОписаниеКолонкиИд);
		Если Элементы.Найти("ТаблицаЗначений"+ОписаниеКолонки.ИмяКолонки)=Неопределено Тогда
			Возврат;
		КонецЕсли;
		
		Элементы.Удалить(Элементы["ТаблицаЗначений"+ОписаниеКолонки.ИмяКолонки]);
		МассивУдаляемыхРеквизитов.Добавить("ТаблицаЗначений."+ОписаниеКолонки.ИмяКолонки);
		
	КонецЕсли;
	
	ИзменитьРеквизиты(,МассивУдаляемыхРеквизитов);
	
КонецПроцедуры // УдалитьКолонкуИзТаблицы()


&НаКлиенте
Процедура СтруктураКолонокПередУдалением(Элемент, Отказ)
	Массив = Элементы.СтруктураКолонок.ВыделенныеСтроки;
	УдалитьКолонкуИзТаблицы(Массив);
КонецПроцедуры


&НаКлиенте
Процедура СтруктураКолонокПриИзменении(Элемент) 
	
	ТекДанные = Элементы.СтруктураКолонок.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат
	КонецЕсли;
	Если ПустаяСтрока(ТекДанные.ИмяКолонки) ИЛИ ТекДанные.ТипЗначения = Новый ОписаниеТипов Тогда
		Возврат;
	КонецЕсли;
	
	ИзменитьКолонкуТаблицы(ТекДанные.ПолучитьИдентификатор());
	
КонецПроцедуры


&НаСервере
Процедура ИзменитьКолонкуТаблицы(ОписаниеКолонкиИд)
	
	ПереимКолонки = Ложь;
	ТЗ = ТаблицаЗначений.Выгрузить();	
	ОписаниеКолонки = СтруктураКолонок.НайтиПоИдентификатору(ОписаниеКолонкиИд);
	ТекТип = ОписаниеКолонки.ТипЗначения;
	Если ЭлементыСинхронизированы(ОписаниеКолонкиИд) Тогда
		Возврат;
	КонецЕсли;
	
	ТекКолонкаТЗ = ТЗ.Колонки.Найти(ОписаниеКолонки.ИмяКолонки); 
	Если ТекКолонкаТЗ = Неопределено Тогда
		ТекКолонкаТЗ = ТЗ.Колонки.Найти(СтарИмяКолонки);
		Если ТекКолонкаТЗ = Неопределено Тогда
			КС = Новый КвалификаторыСтроки(250);
			КД = Новый КвалификаторыДаты(ЧастиДаты.ДатаВремя);
			МассивТипов = Новый Массив;
			МассивТипов.Добавить(Тип("Строка"));
			ОписаниеТиповС = Новый ОписаниеТипов(МассивТипов, , ,,КС,);
			ТЗ.Колонки.Добавить(ОписаниеКолонки.ИмяКолонки,ОписаниеТиповС);
			ТекКолонкаТЗ = ТЗ.Колонки[ОписаниеКолонки.ИмяКолонки];
		КонецЕсли;
		ТекКолонкаТЗ.Имя = ОписаниеКолонки.ИмяКолонки;
		ПереимКолонки = Истина;
	КонецЕсли;
	
	Если НЕ ТекКолонкаТЗ = Неопределено Тогда
		
		Если ТекКолонкаТЗ.ТипЗначения <> ТекТип Тогда
			м = ТЗ.ВыгрузитьКолонку(ОписаниеКолонки.ИмяКолонки);
			УдалитьКолонкуИзТаблицы(ОписаниеКолонкиИд);
			МассивРеквизитов = Новый Массив;
			МассивРеквизитов.Добавить(Новый РеквизитФормы(ОписаниеКолонки.ИмяКолонки, ТекТип, "ТаблицаЗначений")); 
			ИзменитьРеквизиты(МассивРеквизитов);
			НовыйЭлемент = Элементы.Добавить("ТаблицаЗначений" + ОписаниеКолонки.ИмяКолонки, Тип("ПолеФормы"), Элементы.ТаблицаЗначений);
			НовыйЭлемент.Вид = ВидПоляФормы.ПолеВвода;
			НовыйЭлемент.ПутьКДанным = "ТаблицаЗначений." + ОписаниеКолонки.ИмяКолонки;
			
			Для сч = 0 По м.Количество() - 1 Цикл
				Если ТипЗнч(м[сч]) = Тип("Строка") Тогда
					
					Если ТекТип.Типы()[0] = Тип("Число") Тогда
						ТаблицаЗначений[сч][ОписаниеКолонки.ИмяКолонки] = ЧислоИзСтроки(м[сч]);
					ИначеЕсли ТекТип.Типы()[0] = Тип("Дата") Тогда
						ТаблицаЗначений[сч][ОписаниеКолонки.ИмяКолонки] = ДатаИзСтроки(м[сч]);
					ИначеЕсли СтрДлина(м[сч]) = 36 Тогда
						Попытка
							ТаблицаЗначений[сч][ОписаниеКолонки.ИмяКолонки] = Справочники[Метаданные.НайтиПоТипу(ТекТип.Типы().Получить(0)).Имя].ПолучитьСсылку(Новый УникальныйИдентификатор(м[сч]));
						Исключение
						КонецПопытки;
					ИначеЕсли Лев(м[сч],11) = "e1cib/data/" Тогда
						Попытка							
							ПерваяТочка = Найти(м[сч], "e1cib/data/");
							ВтораяТочка = Найти(м[сч], "?ref=");
							ПредставлениеТипа   = Сред(м[сч], ПерваяТочка + 11, ВтораяТочка - ПерваяТочка - 11);
							ШаблонЗначения = ЗначениеВСтрокуВнутр(ПредопределенноеЗначение(ПредставлениеТипа + ".ПустаяСсылка"));
							ЗначениеСсылки = СтрЗаменить(ШаблонЗначения, "00000000000000000000000000000000", Сред(м[сч], ВтораяТочка + 5));
							ТаблицаЗначений[сч][ОписаниеКолонки.ИмяКолонки] = ЗначениеИзСтрокиВнутр(ЗначениеСсылки);
						Исключение
						КонецПопытки;
					Иначе
						ТаблицаЗначений[сч][ОписаниеКолонки.ИмяКолонки] = НайтиПоКодуНаименованию(м[сч],ТекТип);
					КонецЕсли;
				Иначе
					ТаблицаЗначений[сч][ОписаниеКолонки.ИмяКолонки] = м[сч];
				КонецЕсли;
				
			КонецЦикла;
		КонецЕсли;		
	КонецЕсли;	
	
	Если ПереимКолонки Тогда
		ИмяСл = ТЗ.Колонки.Найти("СлужебныйРек__");
		Если ИмяСл <> Неопределено  Тогда
			ТЗ.Колонки.Удалить("СлужебныйРек__");
		КонецЕсли;
		ВывестиРезультат(ТЗ);
	КонецЕсли;
	
КонецПроцедуры // ИзменитьКолонкуТаблицы()

&НаКлиенте
Процедура ТаблицаЗначенийПриАктивизацииЯчейки(Элемент)
	
	Если Элементы.ТаблицаЗначений.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
                             
	ал_ИмяЭлемента = Элемент.ТекущийЭлемент.Имя;
	Если ал_ИмяЭлемента = "ТаблицаЗначенийСлужебныйРек__" Тогда
		Возврат;
	КонецЕсли;
	ал_ИмяЭлемента = Сред(ал_ИмяЭлемента,СтрДлина("ТаблицаЗначений")+1,СтрДлина(ал_ИмяЭлемента));	
	Элементы.НадписьКоличествоСтрок.Заголовок = "Всего "+ТаблицаЗначений.Количество()+" строк";
	
КонецПроцедуры


&НаСервере
Процедура РазбитьКолонкуНаСервере(ОписаниеКолонкиИд,Разделитель)
	
	ОписаниеКолонки = СтруктураКолонок.НайтиПоИдентификатору(ОписаниеКолонкиИд);
	ИмяКолонки = ОписаниеКолонки.ИмяКолонки;
	Если Элементы.Найти("ТаблицаЗначений"+ИмяКолонки)=Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ТЗ =  ТаблицаЗначений.Выгрузить();
	Колонки = ТЗ.Колонки;
	Массив = ТЗ.ВыгрузитьКолонку(ИмяКолонки);
	МассивЗначенийСтолбцов = Новый Массив ;
	
	Для счч = 0 По СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(Массив[0],Разделитель).Количество() - 1 Цикл
		ИмяНовойКолонки = ИмяКолонки + "_" + счч;
		Колонки.Вставить(ОписаниеКолонкиИд + счч, ИмяНовойКолонки, ОписаниеКолонки.ТипЗначения);
		МассивЗначенийСтолбцов.Добавить(ИмяНовойКолонки);
	КонецЦикла;
	
	Для счч = 0 По ТЗ.Количество() - 1 Цикл
		Значение = ТЗ[счч][ИмяКолонки];
		МассивЗначенийСтрок = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(Значение,Разделитель);
		Для сч = 0 По МассивЗначенийСтолбцов.Количество()-1  Цикл
			ТЗ[счч][МассивЗначенийСтолбцов[сч]] = МассивЗначенийСтрок[сч];
		КонецЦикла;
	КонецЦикла;
	
	ИмяСл = Колонки.Найти("СлужебныйРек__");
	Если ИмяСл <> Неопределено  Тогда
		Колонки.Удалить("СлужебныйРек__");
	КонецЕсли;
	
	ВывестиРезультат(ТЗ);
	
КонецПроцедуры

&НаКлиенте
Процедура РазбитьКолонку(Команда)
	Разделитель = "";
	ПоказатьВводЗначения(Новый ОписаниеОповещения("РазбитьКолонкуЗавершение", ЭтаФорма, Новый Структура("Разделитель", Разделитель)), Разделитель,"Введите разделитель столбцов");
КонецПроцедуры

&НаКлиенте
Процедура РазбитьКолонкуЗавершение(Значение, ДополнительныеПараметры) Экспорт
	
	Разделитель = ?(Значение = Неопределено, ДополнительныеПараметры.Разделитель, Значение);
	
	
	Если (Значение <> Неопределено) Тогда
		РазбитьКолонкуНаСервере(Элементы.СтруктураКолонок.ТекущиеДанные.ПолучитьИдентификатор(),Разделитель);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура СтруктураКолонокПередНачаломДобавленияНаСервере(ОписаниеКолонкиИд)
	
	ОписаниеКолонки = СтруктураКолонок.НайтиПоИдентификатору(ОписаниеКолонкиИд);
	ИмяКолонки = ОписаниеКолонки.ИмяКолонки;
	Если Элементы.Найти("ТаблицаЗначений"+ИмяКолонки)=Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ТЗ =  ТаблицаЗначений.Выгрузить();
	
	Колонки = ТЗ.Колонки;
	Массив = ТЗ.ВыгрузитьКолонку(ИмяКолонки);
	
	ИмяНовойКолонки = ИмяКолонки + "_0";
	Колонки.Вставить(ОписаниеКолонкиИд, ИмяНовойКолонки, ОписаниеКолонки.ТипЗначения);
	ТЗ.ЗагрузитьКолонку(Массив,ИмяНовойКолонки);
	
	ИмяСл = Колонки.Найти("СлужебныйРек__");
	Если ИмяСл <> Неопределено  Тогда
		Колонки.Удалить("СлужебныйРек__");
	КонецЕсли;
	
	ВывестиРезультат(ТЗ);
	
КонецПроцедуры

&НаКлиенте
Процедура СтруктураКолонокПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	ТекущиеДанные = Элементы.СтруктураКолонок.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СтарИмяКолонки = ТекущиеДанные.ИмяКолонки;
	
	Если Копирование Тогда
		СтруктураКолонокПередНачаломДобавленияНаСервере(Элементы.СтруктураКолонок.ТекущиеДанные.ПолучитьИдентификатор());
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НеТипизировать(Команда)
	НеТипизировать = НЕ НеТипизировать;
	Элементы.ТаблицаЗначенийНеТипизировать.Пометка = НеТипизировать;
	Элементы.СтруктураКолонокКонтекстноеМенюНеТипизировать.Пометка = НеТипизировать;
КонецПроцедуры

&НаСервере
Процедура УдалитьПустыеСтрокиНаСервере()
	
	текКолонка = ал_ИмяЭлемента;
	
	ТЗРезультата = РеквизитФормыВЗначение("ТаблицаЗначений");
	Колонки = ТЗРезультата.Колонки;
	
	ИмяСл = Колонки.Найти(текКолонка);
	Если ИмяСл = Неопределено  Тогда
		Возврат;
	КонецЕсли;
	М = Новый Массив;
	Для каждого стр Из  ТЗРезультата Цикл
		Если Не ЗначениеЗаполнено(стр[текКолонка]) Тогда
			М.Добавить(стр);
		КонецЕсли;
	КонецЦикла; 
	
	Для каждого стр Из  М Цикл
		ТЗРезультата.Удалить(стр);
	КонецЦикла;
	
	ЗначениеВРеквизитФормы(ТЗРезультата,"ТаблицаЗначений");
	
КонецПроцедуры

&НаКлиенте
Процедура УдалитьПустыеСтроки(Команда)
	УдалитьПустыеСтрокиНаСервере();
КонецПроцедуры


мРежимВыбораСтрок = Ложь;
мРежимВыбораКолонок = Ложь;