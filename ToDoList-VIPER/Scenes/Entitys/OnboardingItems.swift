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
                        imageName: "onboardingMock",
                        state: .aboutApp),
        OnboardingItems(title: "Добавить новую задачу просто!", 
                        description: "Просто нажмите на иконку плюса и заполните необходимые поля",
                        buttonText: "Далее",
                        imageName: "onboardingMock",
                        state: .addToDo),
        OnboardingItems(title: "Редактикруйте уже созданные задачи!",
                        description: """
                                      Изменяйте наименование задачи, ее описание, приоритет или дату.
                                      Если задача уже не актуальна - просто удалите ее!
                                      """,
                        buttonText: "Далее",
                        imageName: "onboardingMock",
                        state: .featureToDo),
        OnboardingItems(title: "Завершить задачу в один клик!",
                        description: """
                        Завершить задачу очень просто - просто нажми на кружок в левой части и она перейдет в раздел "Выполнено".
                        """,
                        buttonText: "Далее",
                        imageName: "onboardingMock",
                        state: .doneAndOvedueToDo),
        OnboardingItems(title: "Настройте приложение!",
                        description: """
                        Измените аватар, смените ник, включите темную или светлую тему в разделе "Настройки"
                        """,
                        buttonText: "Начать",
                        imageName: "onboardingMock",
                        state: .option),
    
    ]
}
