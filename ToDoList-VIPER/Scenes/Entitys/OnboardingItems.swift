//
//  OnboardingItems.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 19.01.2024.
//

import UIKit

struct OnboardingItems {
    var title: String
    var buttonText: String?
    var imageName: String
    var state: OnboardingStates
}

extension OnboardingItems {
    static let pagesData = [
        OnboardingItems(title: "",
                        buttonText: nil,
                        imageName: "onboarding_1",
                        state: .welcome),
        OnboardingItems(title: "Удобное приложение для Ваших задач",
                        buttonText: nil,
                        imageName: "onboarding_2",
                        state: .aboutApp),
        OnboardingItems(title: "Добавить новую задачу просто",
                        buttonText: nil,
                        imageName: "onboarding_3",
                        state: .addToDo),
        OnboardingItems(title: "Редактикруй уже созданные задачи",
                        buttonText: nil,
                        imageName: "onboarding_4",
                        state: .featureToDo),
        OnboardingItems(title: "Заверши задачу в один клик",
                        buttonText: nil,
                        imageName: "onboarding_5",
                        state: .doneAndOvedueToDo),
        OnboardingItems(title: "Начнем?",
                        buttonText: "Начать",
                        imageName: "onboarding_6",
                        state: .option),
    
    ]
}
