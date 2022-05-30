# Домашнее задание к занятию "7.5. Основы golang"

## Задача 1. Установите golang.
1. Воспользуйтесь инструкций с официального сайта: [https://golang.org/](https://golang.org/).
2. Так же для тестирования кода можно использовать песочницу: [https://play.golang.org/](https://play.golang.org/).

## Ответ:
Воспользовался песочницей, go ранее ставил.

## Задача 2. Знакомство с gotour.
У Golang есть обучающая интерактивная консоль [https://tour.golang.org/](https://tour.golang.org/). 
Рекомендуется изучить максимальное количество примеров. В консоли уже написан необходимый код, 
осталось только с ним ознакомиться и поэкспериментировать как написано в инструкции в левой части экрана.  

## Ответ:
Ознакомился.

## Задача 3. Написание кода. 
Цель этого задания закрепить знания о базовом синтаксисе языка. Можно использовать редактор кода 
на своем компьютере, либо использовать песочницу: [https://play.golang.org/](https://play.golang.org/).

1. Напишите программу для перевода метров в футы (1 фут = 0.3048 метр). Можно запросить исходные данные 
у пользователя, а можно статически задать в коде.
    Для взаимодействия с пользователем можно использовать функцию `Scanf`:
    ```
    package main
    
    import "fmt"
    
    func main() {
        fmt.Print("Enter a number: ")
        var input float64
        fmt.Scanf("%f", &input)
    
        output := input * 2
    
        fmt.Println(output)    
    }
    ```
 ## Ответ:
 ```GO
 package main

import "fmt"

func Convert (meters float64) float64{
	miles :=  meters * 0.3048
	return miles
}

func main() {
    fmt.Print("Enter a number: ")
    var input float64
    fmt.Scanf("%f", &input)

	output := Convert (input)

    fmt.Println(output)    
}
```
 
 
2. Напишите программу, которая найдет наименьший элемент в любом заданном списке, например:
    ```
    x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}
    ```
## Ответ:
```GO
package main
    
import "fmt"

func FindMin(array []int) int{
	min := array[0]
	for _, value := range array{
		if value < min{
			min = value
		}
	}
	return min
}

func main() {
    x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}
	output := FindMin(x)
	fmt.Println(output)    
}
```

3. Напишите программу, которая выводит числа от 1 до 100, которые делятся на 3. То есть `(3, 6, 9, …)`.

В виде решения ссылку на код или сам код. 

## Ответ:
```GO
package main

import "fmt"

func FindMultiple(number int) int{
	var i int
	var count int
	i = 1
	count = 0
	if number != 0{
		for i <= 100{
			if i % number == 0{
				count++
			}
			i++
		}
	}
	return count
}

func main() {
	x := 3
	output := FindMultiple(x)

    fmt.Println(output)    
}
```
