# language: ru

@IgnoreOnCIMainBuild
@tree


Функциональность: ДляПроверкаПередачиПараметровСтруктурыСценарияВПодсценарий

 

Структура сценария: ДляПроверкаПередачиПараметровСтруктурыСценарияВПодсценарий
	И вызов экспортного сценария для структуры сценария проверка передачи параметров "111"
	И внутренний шаг <ПараметрСтруктурыСценария>
	И вызов экспортного сценария для структуры сценария проверка передачи параметров <ПараметрСтруктурыСценария>
	И вызов экспортного сценария для структуры сценария проверка передачи параметров "333"

	Примеры:
		| ПараметрСтруктурыСценария  |
		| 'Значение1'              |
		| 'Значение2'              |
