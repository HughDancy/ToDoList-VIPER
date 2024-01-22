//
//  OnboardingItems.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 19.01.2024.
//

import UIKit

struct OnboardingItems {
    var title: String
    var description: String
    var buttonText: String
    var imageName: String
    var state: OnboardingStates
}

extension OnboardingItems {
    static let pagesData = [
        OnboardingItems(title: "Добро пожаловать ToDo List!",
                        description: "Для продолжения нажмите кнопку или свайпните вправо",
                        buttonText: "Начать",
                        imageName: "welcomeImage",
                        state: .welcome),
        OnboardingItems(title: "Удобное приложение для Ваших задач!",
                        description: "ToDo List позволяет привести Ваши задачи в порядок, отсортировать их по дате и установленному Вами приоритету",
                        buttonText: "Далее", 
                        imageName: "",
                        state: .aboutApp),
        OnboardingItems(title: "Добавить новую задачу просто!", 
                        description: "Просто нажмите на иконку плюса и заполните необходимые поля",
                        buttonText: "Далее",
                        imageName: "",
                        state: .addToDo),
        OnboardingItems(title: "Редактикруйте уже созданные задачи!",
                        description: """
                                      Изменяйте наименование задачи, ее описание, приоритет или дату при необходимости. Просто нажмите на уже созданную задачу,
                                      а после на иконку "Редактировать". Если задача уже не актуальна - просто удалите ее!
                                      """,
                        buttonText: "Далее",
                        imageName: "",
                        state: .featureToDo),
        OnboardingItems(title: "Завершить задачу в один клик!",
                        description: """
                        Завершить задачу очень просто - просто нажми на кружок в левой части и она перейдет в раздел "Выполнено".
                        Просроченные задачи можно посмотреть разделе "Просроченные"
                        """,
                        buttonText: "Далее",
                        imageName: "",
                        state: .doneAndOvedueToDo),
        OnboardingItems(title: "Настройте приложение!",
                        description: """
                        Измените аватар, смените ник, включите темную или светлую тему, настройте время получения уведоимлений о запланированных задачах
                        в разделе "Настройки"
                        """,
                        buttonText: "Начать",
                        imageName: "",
                        state: .option),
    
    ]
}
