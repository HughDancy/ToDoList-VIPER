
# ToDoList-VIPER
ToDoLost-VIPER это простое приложение для трекинга повседневных задач с интересным дизайном. Вход в приложение реализован через "логин-пароль". Также реализована возможность входа в приложение с помощью Google Sign-In. Добавленные задачи сохраняются как на локальное хранилище, так и выгружаются на сервер. Задачи можно изменять, удалять и завершать. Данные состояния каждой конкретной задачи транслируются и на сетевое хранилище. В случае удаления приложения или выхода из него, при следующем входе сохраненные на сервере задачи загружаются на устройство в background-потоке. Пользователю доступны изменения его аватара (с камеры или с галлереи), имени, а также смена пароля. 

## Стэк:
* Архитектура VIPER
* UIKit
* Firebase
* FirebaseAuth
* GoogleSignIn
* CoreData
* Kingfisher
* SnapKit
* SwiftLint
* Unit-test's
* UI-test's

## Основные модули приложения
### Модуль входа в приложение

<img src="https://github.com/HughDancy/ToDoList-VIPER/blob/main/ToDoList-VIPER/Resources/Assets.xcassets/Screens/LoginModule.png" width="380"> <img src="https://github.com/HughDancy/ToDoList-VIPER/blob/main/ToDoList-VIPER/Resources/Assets.xcassets/Screens/LoginModuleWithPass.png" width="380">  

---

### Модуль регистрации 
<img src="https://github.com/HughDancy/ToDoList-VIPER/blob/main/ToDoList-VIPER/Resources/Assets.xcassets/Screens/RegistrationModue.png" width="380">  

---

### Модуль сброса пароля
<img src="https://github.com/HughDancy/ToDoList-VIPER/blob/main/ToDoList-VIPER/Resources/Assets.xcassets/Screens/ForggotPassword.png" width="380">  

---

### Модуль главной страницы приложения 
<img src="https://github.com/HughDancy/ToDoList-VIPER/blob/main/ToDoList-VIPER/Resources/Assets.xcassets/Screens/MainScreen.png" width="380">  

---

### Модуль задач
<img src="https://github.com/HughDancy/ToDoList-VIPER/blob/main/ToDoList-VIPER/Resources/Assets.xcassets/Screens/ToDosUndone.png" width="380"> <img src="https://github.com/HughDancy/ToDoList-VIPER/blob/main/ToDoList-VIPER/Resources/Assets.xcassets/Screens/ToDosDone.png" width="380">  

---

### Модуль детальной информации о задаче
<img src="https://github.com/HughDancy/ToDoList-VIPER/blob/main/ToDoList-VIPER/Resources/Assets.xcassets/Screens/ToDoDetail.png" width="380">

---

### Модуль добавления новой задачи
<img src="https://github.com/HughDancy/ToDoList-VIPER/blob/main/ToDoList-VIPER/Resources/Assets.xcassets/Screens/AddNewToDo.png" width="380">

---

### Модуль Опций
<img src="https://github.com/HughDancy/ToDoList-VIPER/blob/main/ToDoList-VIPER/Resources/Assets.xcassets/Screens/Options.png" width="380">

---

### Модуль смены данных пользователя 
<img src="https://github.com/HughDancy/ToDoList-VIPER/blob/main/ToDoList-VIPER/Resources/Assets.xcassets/Screens/UserOptions.png" width="380">

---

### Примеры темной темы
<img src="https://github.com/HughDancy/ToDoList-VIPER/blob/main/ToDoList-VIPER/Resources/Assets.xcassets/Screens/MainDark.png" width="380"> <img src="https://github.com/HughDancy/ToDoList-VIPER/blob/main/ToDoList-VIPER/Resources/Assets.xcassets/Screens/OptionsDark.png" width="380">
<img src="https://github.com/HughDancy/ToDoList-VIPER/blob/main/ToDoList-VIPER/Resources/Assets.xcassets/Screens/ToDosDart.png" width="380">

