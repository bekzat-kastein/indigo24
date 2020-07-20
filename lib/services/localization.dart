import 'helper.dart';

String title = 'Title';
String registration = 'Registration';
String login = 'Login';
String phoneNumber = 'Phone number';
String password = 'Password';
String forgotPassword = 'Forgot password?';
String next = 'Next';
String currentLanguage = 'English';
String email = 'Email';
String exit = 'Exit';
String support = 'SUPPORT SERVICE';
String chats = 'Chats';
String chat = 'Chat';
String profile = 'Profile';
String tape = 'Tapes';
String wallet = 'Wallet';
String comments = 'Comments';
String withdraw = 'Withdraw';
String refill = 'Refill';
String payments = 'Payments';
String transfers = 'Transfers';
String balanceInBlock = 'Balance in processing';
String balance = 'Balance';
String account = 'Account';
String walletBalance = 'Wallet balance';
String amount = 'Amount';
String pay = 'Pay';
String minAmount = 'Minimum amount';
String minCommission = 'Minimum commission';
String maxAmount = 'Maximum amount';
String commission = 'Commission';
String toIndigo24Client = 'To Indigo24 Client';
String transfer = 'Transfer';
String enterMessage = 'Enter your message';
String members = 'Members';
String creator = 'Creator';
String member = 'Member';
String contacts = 'Contacts';
String search = 'Search';
String createGroup = 'Create group';
String chatName = 'Chat name';
String newTape = 'New tape';
String enterPin = 'Enter passcode';
String createPin = 'Set passcode';
String incorrectPin = 'Incorrect PIN';
String error = 'Error';
String chatNotifications = 'Chat notifications';
String notifications = 'Notifications';
String showNotifications = 'Show notifications';
String messagePreview = 'Message preview';
String sound = 'Sound';
String success = 'Success';
String processing = 'Processing';
String wordNew = 'New';
String language = 'Language';
String settings = 'Settings';
String enterPhone = 'Enter phone';
String enterSmsCode = 'Enter SMS code';
String enterPassword = 'Enter password';
String repeatPin = 'Repeat pin';
String attention = 'Alert';
String admin = 'Admin';
String lastSeen = 'Last seen';
String video = 'Video';
String selectOption = 'Select option';
String gallery = 'Gallery';
String wantToExit = 'Are you sure want to logout';
String uploaded = 'Uploaded';
String somethingWentWrong = 'Somethin went wrong';
String save = 'Save';
String share = 'Share';
String photo = 'Photo';
String sessionIsOver = 'Session is over';
String cancel = 'Cancel';
String allowContacts = 'Allow contacts';
String openSettings = 'Open settings';
String document = 'Document';
String textMessage = 'Text message';
String voiceMessage = 'Voice message';
String location = 'Location';
String reply = 'Reply';
String money = 'Money';
String link = 'Link';
String forwardedMessage = 'Forwarded message';
String message = 'Message';
String systemMessage = 'System message';
String back = 'Back';
String camera = 'Camera';
String watch = 'Watch';
String no = 'No';
String yes = 'Yes';
String fillAllFields = 'Fill all fields';
String description = 'Description';
String goToChat = 'Go to chat';
String userNotInSystem = 'This user is not in the system';
String file = 'File';
String addToGroup = 'Add to group';
String clickToStart = 'Tap to start chat';
String setAdmin = 'Set admin rights';
String makeMember = 'Make member';
String exitGroup = 'Exit group';
String sureExitGroup = 'Are sure exit group';
String delete = 'Delete';
String noChatName = 'No chat name';
String minMembersCount = 'Minimum count of members 3';
String files = 'Files';
String edit = 'Edit';
String editedMessage = 'Edited';
String surname = 'Surname';
String passwordNotMatch = 'Passwords must be identical';
String weSentToEmail =
    'We have sent an SMS key to your number, which will arrive within 10 seconds';
String keyFromSms = 'SMS code';
String country = 'Country';
String status = 'Status';
String selectFile = 'Select file';
String userNotFound = 'User not found';
String history = 'History';
String youSended = 'You have sended';
String youReceived = 'You have received';
String online = 'online';
String enterValidAccount = 'Enter the correct account number';
String enterBelowMax = 'Enter the amount below the maximum mark';
String enterAboveMin = 'Enter the amount above the minimum mark';
String appVersion = 'App version';
String httpError = 'Error while loading data';
String historyBalance = 'Balance history';
String emptyContacts = 'Contacts is empty';
String empty = 'Empty';
String noChats = 'No chats';
String report = "To complain";
String terms = "Terms of use";
var languages = [
  {"title": "English", "code": "en"},
  {"title": "Русский", "code": "ru"},
  {"title": "Қазақша", "code": "kz"},
  {'title': 'Ўзбекча', 'code': 'uz'},
  {'title': 'O\'zbekcha', 'code': 'uzb'}
];

setLanguage(code) {
  SharedPreferencesHelper.setString('languageCode', '$code');
  switch (code) {
    case 'en':
      print('en');
      registration = 'Registration';
      title = 'Title';
      login = 'Login';
      phoneNumber = 'Phone number';
      password = 'Password';
      forgotPassword = 'Forgot password?';
      next = 'Next';
      currentLanguage = 'English';
      email = 'Email';
      exit = 'Exit';
      chats = 'Chats';
      chat = 'Chat';
      profile = 'Profile';
      tape = 'Tapes';
      wallet = 'Wallet';
      comments = 'Comments';
      withdraw = 'Withdraw';
      refill = 'Refill';
      support = 'SUPPORT SERVICE';
      payments = 'Payments';
      transfers = 'Transfers';
      balanceInBlock = 'Balance in processing';
      balance = 'Balance';
      account = 'Account';
      walletBalance = 'Wallet balance';
      amount = 'Amount';
      minAmount = 'Minimum amount';
      minCommission = 'Minimum commission';
      maxAmount = 'Maximum amount';
      commission = 'Commission';
      toIndigo24Client = 'To Indigo24 Client';
      transfer = 'Transfer';
      pay = 'Pay';
      enterMessage = 'Enter your message';
      members = 'Members';
      creator = 'Creator';
      member = 'Member';
      contacts = 'Contacts';
      search = 'Search';
      createGroup = 'Create group';
      chatName = 'Chat name';
      newTape = 'New tape';
      enterPin = 'Enter passcode';
      createPin = 'Set passcode';
      incorrectPin = 'Incorrect PIN';
      chatNotifications = 'Chat notifications';
      error = 'Error';
      notifications = 'Notifications';
      showNotifications = 'Show notifications';
      messagePreview = 'Message preview';
      sound = 'Sound';
      language = 'Language';
      settings = 'Settings';
      enterPhone = 'Enter phone';
      enterSmsCode = 'Enter SMS code';
      enterPassword = 'Enter password';
      repeatPin = 'Repeat pin';
      attention = 'Alert';
      admin = 'Admin';
      lastSeen = 'Last seen';
      video = 'Video';
      selectOption = 'Select option';
      gallery = 'Gallery';
      wantToExit = 'Are you sure want to logout';
      uploaded = 'Uploaded';
      somethingWentWrong = 'Somethin went wrong';
      save = 'Save';
      share = 'Share';
      photo = 'Photo';
      sessionIsOver = 'Session done';
      cancel = 'Cancel';
      allowContacts = 'Allow contacts';
      openSettings = 'Open settings';
      document = 'Document';
      textMessage = 'Text message';
      voiceMessage = 'Voice message';
      location = 'Location';
      reply = 'Reply';
      money = 'Money';
      link = 'Link';
      forwardedMessage = 'Forwarded message';
      message = 'Message';
      systemMessage = 'System message';
      back = 'Back';
      camera = 'Camera';
      watch = 'Watch';
      no = 'No';
      yes = 'Yes';
      fillAllFields = 'Fill all fields';
      description = 'Description';
      goToChat = 'Go to chat';
      userNotInSystem = 'This user is not in the system';
      file = 'File';
      addToGroup = 'Add to group';
      clickToStart = 'Tap to start chat';
      setAdmin = 'Set admin rights';
      makeMember = 'Make member';
      exitGroup = 'Exit group';
      sureExitGroup = 'Are sure exit group';
      delete = 'Delete';
      noChatName = 'No chat name';
      minMembersCount = 'Minimum count of members 3';
      files = 'Files';
      edit = 'Edit';
      editedMessage = 'Edited';
      surname = 'Surname';
      passwordNotMatch = 'Passwords must be identical';
      weSentToEmail =
          'We have sent an SMS key to your number, which will arrive within 10 seconds';
      keyFromSms = 'SMS code';
      country = 'Country';
      status = 'Status';
      selectFile = 'Select file';
      userNotFound = 'User not found';
      history = 'History';
      youSended = 'You have sended';
      youReceived = 'You have received';
      online = 'online';
      enterValidAccount = 'Enter the correct account number';
      enterBelowMax = 'Enter the amount below the maximum mark';
      enterAboveMin = 'Enter the amount above the minimum mark';
      appVersion = 'App version';
      httpError = 'Error while loading data';
      historyBalance = 'Balance history';
      emptyContacts = 'Contacts is empty';
      empty = 'Empty';
      noChats = 'No chats';
      terms = "Terms of use";
      break;
    case 'ru':
      registration = 'Регистрация';
      login = 'Вход';
      title = 'Название';
      phoneNumber = 'Номер телефона';
      password = 'Пароль';
      forgotPassword = 'Забыли пароль?';
      next = 'Далее';
      currentLanguage = 'Русский';
      email = 'Почта';
      exit = 'Выйти';
      support = 'СЛУЖБА ПОДДЕРЖКИ';
      chats = 'Чаты';
      chat = 'Чат';
      profile = 'Профиль';
      tape = 'Лента';
      wallet = 'Кошелек';
      comments = 'Комментарии';
      withdraw = 'Вывести';
      refill = 'Пополнить';
      payments = 'Платежи';
      transfers = 'Переводы';
      balanceInBlock = 'Баланс в обработке';
      balance = 'Баланс';
      account = 'Аккаунт';
      walletBalance = 'Баланс кошелька';
      amount = 'Сумма';
      pay = 'Оплатить';
      minAmount = 'Минимальная сумма';
      minCommission = 'Минимальная комиссия';
      maxAmount = 'Максимальная сумма';
      commission = 'Комиссия';
      toIndigo24Client = 'Клиенту Indigo24';
      transfer = 'Перевести';
      enterMessage = 'Введите ваше сообщение';
      members = 'Участников';
      creator = 'Создатель';
      member = 'Участник';
      contacts = 'Контакты';
      search = 'Поиск';
      createGroup = 'Создать группу';
      chatName = 'Название чата';
      newTape = 'Новая запись';
      enterPin = 'Введите PIN';
      createPin = 'Установите PIN';
      incorrectPin = 'Неправильный PIN';
      chatNotifications = 'Уведомления от чатов';
      notifications = 'Уведомления';
      showNotifications = 'Показывать уведомления';
      error = 'Ошибка';
      messagePreview = 'Показывать текст';
      sound = 'Звук';
      language = 'Язык';
      settings = 'Настройки';
      enterPhone = 'Введите номер телефона';
      enterSmsCode = 'Введите SMS код';
      enterPassword = 'Введите пароль';
      repeatPin = 'Повторите PIN';
      attention = 'Внимание';
      admin = 'Администратор';
      lastSeen = 'Был в сети';
      video = 'Видео';
      selectOption = 'Выберите опцию';
      gallery = 'Галерея';
      wantToExit = 'Уверены, что хотите выйти?';
      uploaded = 'Загружено';
      somethingWentWrong = 'Что-то пошло не так';
      save = 'Сохранить';
      share = 'Поделиться';
      photo = 'Фото';
      sessionIsOver = 'Сессия окончена';
      cancel = 'Cancel';
      allowContacts = 'Разрешить контакты';
      openSettings = 'Открыть настройки';
      document = 'Документ';
      textMessage = 'Текстовое сообщение';
      voiceMessage = 'Голосовое сообщение';
      location = 'Местоположение';
      reply = 'Ответить';
      money = 'Деньги';
      link = 'Ссылка';
      forwardedMessage = 'Переотправленное сообщение';
      message = 'Сообщение';
      systemMessage = 'Системное сообщение';
      back = 'Назад';
      camera = 'Камера';
      watch = 'Посмотреть';
      no = 'Нет';
      yes = 'Да';
      fillAllFields = 'Заполните все поля';
      description = 'Описание';
      goToChat = 'Перейти в чат';
      userNotInSystem = 'This user is not in the system';
      file = 'Файл';
      addToGroup = 'Добавить в группу';
      clickToStart = 'Нажмите, чтобы начать чат';
      setAdmin = 'Назначить администратором';
      makeMember = 'Сделать участником';
      exitGroup = 'Выйти из группы';
      sureExitGroup = 'Уверены, что хотите выйти из группы?';
      delete = 'Удалить';
      noChatName = 'Нет названия чата';
      minMembersCount = 'Минимальное количество участников: 3';
      files = 'Файлы';
      edit = 'Редактировать';
      editedMessage = 'Ред';
      surname = 'Фамилия';
      passwordNotMatch = 'Пароли не совпадают';
      weSentToEmail =
          'Мы отправили на ваш номер SMS ключ, который поступит в течение 10 секунд';
      keyFromSms = 'SMS код';
      country = 'Страна';
      status = 'Статус';
      selectFile = 'Выберите файл';
      userNotFound = 'Пользователь не найден';
      history = 'История';
      youSended = 'Вы отправили';
      youReceived = 'Вы получили';
      online = 'онлайн';
      enterValidAccount = 'Введите корректный номер аккаунта';
      enterBelowMax = 'Введите сумму ниже максимальной отметки';
      enterAboveMin = 'Введите сумму выше минимальной отметки';
      appVersion = 'Версия приложения';
      httpError = 'Ошибка при загрузке данных';
      historyBalance = 'История баланса';
      emptyContacts = 'Контакты пусты';
      empty = 'Пусто';
      noChats = 'Нет чатов';
      terms = "Пользовательское соглашение";
      print('ru');
      break;
    case 'kz':
      registration = 'Тіркелу';
      login = 'Енгізу';
      phoneNumber = 'Телефон нөмірі';
      title = 'Атауы';
      password = 'Құпия сөз';
      forgotPassword = 'Құпия сөзіңізді ұмыттыңыз ба?';
      next = 'Әрі қарай';
      currentLanguage = 'Қазақша';
      email = 'Пошта';
      exit = 'Шығу';
      support = 'ҚОЛДАУ ҚЫЗМЕТІ';
      chats = 'Чаттар';
      chat = 'Чат';
      profile = 'Профиль';
      tape = 'Таспа';
      wallet = 'Әмиян';
      comments = 'Пікірлер';
      withdraw = 'Шығару';
      refill = 'Толтыру';
      payments = 'Төлемдер';
      transfers = 'Аударымдар';
      balanceInBlock = 'Өңдеудегі баланс';
      balance = 'Баланс';
      account = 'Аккаунт';
      walletBalance = 'Әмиян балансы';
      amount = 'Сома';
      pay = 'Төлем жасау';
      minAmount = 'Минималды сома';
      minCommission = 'Минималды комиссия';
      maxAmount = 'Максималды сома';
      commission = 'Комиссия';
      toIndigo24Client = 'Indigo24 клиентіне';
      transfer = 'Аудару';
      enterMessage = 'Хабарламаны енгізіңіз';
      members = 'Қатысушылар';
      creator = 'Құрушы';
      member = 'Қатысушы';
      contacts = 'Байланыстар';
      search = 'Іздеу';
      createGroup = 'Топ құру';
      chatName = 'Чат атауы';
      newTape = 'Жаңа жазба';
      enterPin = 'PIN код енгізіңіз';
      createPin = 'Құпия код орнатыңыз';
      incorrectPin = 'Қате PIN код';
      chatNotifications = 'Чат хабарландырулары';
      error = 'Қате';
      notifications = 'Хабарламалар';
      showNotifications = 'Хабарландыруларды көрсету';
      messagePreview = 'Мәтінді көрсету';
      sound = 'Дыбыс';
      language = 'Тіл';
      settings = 'Параметрлер';
      enterPhone = 'Телефон нөмірін енгізіңіз';
      enterSmsCode = 'SMS кодын енгізіңіз';
      enterPassword = 'Құпия сөзді енгізіңіз';
      repeatPin = 'PIN қайталаңыз';
      attention = 'Назар аударыңыз';
      admin = 'Администратор';
      lastSeen = 'Желіде болды';
      video = 'Видео';
      selectOption = 'Опцияны таңдаңыз';
      gallery = 'Галерея';
      wantToExit = 'Шыққыңыз келе ме?';
      uploaded = 'Жүктелді';
      somethingWentWrong = 'Бір нәрсе дұрыс емес болды';
      save = 'Сақтау';
      share = 'Бөлісу';
      photo = 'Фото';
      sessionIsOver = 'Сессия аяқталды';
      cancel = 'Болдырмау';
      allowContacts = 'Контактілерге рұқсат беріңіз';
      openSettings = 'Параметрлерді ашу';
      document = 'Құжат';
      textMessage = 'Мәтіндік хабар';
      voiceMessage = 'Дауыстық хабарлама';
      location = 'Орналасуы';
      reply = 'Жауап беру';
      money = 'Ақша';
      link = 'Сілтеме';
      forwardedMessage = 'Қайта жіберілген хабарлама';
      message = 'Хабар';
      systemMessage = 'Жүйелік хабарлама';
      back = 'Артқа';
      camera = 'Камера';
      watch = 'Көру';
      no = 'Жоқ';
      yes = 'Иә';
      fillAllFields = 'Барлық ұяшықтарды толтырыңыз';
      description = 'Сипаттамасы';
      goToChat = 'Чатқа бару';
      userNotInSystem = 'Бұл қолданушы жүйеде жоқ';
      file = 'Файл';
      addToGroup = 'Топқа қосу';
      clickToStart = 'Сөйлесуді бастау үшін түртіңіз';
      setAdmin = 'Администратор ретінде тағайындау';
      makeMember = 'Мүше қылдыру';
      exitGroup = 'Топтан шығу';
      sureExitGroup = 'Топтан шыққыңыз келе ме?';
      delete = 'Жою';
      noChatName = 'Чат аты жоқ';
      minMembersCount = 'Мүшелердің ең аз саны: 3';
      files = 'Файлдар';
      edit = 'Өңдеу';
      editedMessage = 'Өңд.';
      surname = 'Тегі';
      passwordNotMatch = 'Парольдер сәйкес келмейді';
      weSentToEmail =
          'Біз сіздің нөміріңізге 10 секунд ішінде келетін SMS кілт жібердік';
      keyFromSms = 'SMS кілт';
      country = 'Ел';
      status = 'Күй';
      selectFile = 'Файлды таңдаңыз';
      userNotFound = 'Пайдаланушы табылмады';
      history = 'Төлемдер тарихы';
      youSended = 'Сіз жібердіңіз';
      youReceived = 'Сіз алдыңыз';
      online = 'онлайн';
      enterValidAccount = 'Дұрыс тіркелгі нөмірін енгізіңіз';
      enterBelowMax = 'Ең жоғарғы белгіден төмен соманы енгізіңіз';
      enterAboveMin = 'Ең төменгі белгіден жоғары соманы енгізіңіз';
      appVersion = 'Мобильді қосымшаның нұсқасы';
      httpError = 'Деректерді жүктеу кезіндегі қате';
      historyBalance = 'Баланс тарихы';
      emptyContacts = 'Контактілер жоқ';
      empty = 'Бос';
      noChats = 'Чат жоқ';
      terms = "Қолдану ережелері";
      print('kz');
      break;
    case 'uz':
      registration = 'Рўйхатдан ўтиш';
      login = 'Кириш';
      title = 'Номи';
      phoneNumber = 'Телефон рақами';
      password = 'Махфий сўз';
      forgotPassword = 'Махфий сўзни унутдингизми?';
      next = 'Сўнгра';
      currentLanguage = 'O\'zbekcha';
      email = 'Электрон почта';
      exit = 'Чиқиш';
      support = 'ҚЎЛЛАБ-ҚУВВАТЛАШ ХИЗМАТИ';
      chats = 'Чатлар';
      chat = 'Чат';
      profile = 'Профиль';
      tape = 'Тасма';
      wallet = 'Ҳамён';
      comments = 'Фикрлар';
      withdraw = 'Чиқариш';
      refill = 'Тўлдириш';
      payments = 'Бошқа тўловлар';
      transfers = 'Ўтказишлар';
      balanceInBlock = 'Қайта ишлашдаги баланс';
      balance = 'Баланс';
      account = 'Аккаунт';
      walletBalance = 'Ҳамён баланси';
      amount = 'Сумма';
      pay = 'Тўлов қилиш';
      minAmount = 'Минимал сумма';
      minCommission = 'Минимал комиссия';
      maxAmount = 'Максимал сумма';
      commission = 'Комиссия';
      toIndigo24Client = 'Indigo24 мижозига';
      transfer = 'Ўтказиш';
      enterMessage = 'Хабарномангизни киритинг';
      members = 'Иштирокчиларнинг минимал сони: 3';
      creator = 'Яратувчи';
      member = 'Иштирокчи';
      contacts = 'Алоқалар';
      search = 'Излаш';
      createGroup = 'Гуруҳ яратиш';
      chatName = 'Чат номи';
      newTape = 'Янги йозув';
      enterPin = 'PIN-кодни киритинг';
      createPin = 'PIN-кодни ўрнатинг';
      incorrectPin = 'PIN-код нотўғри';
      chatNotifications = 'Чат хабарномалари';
      notifications = 'Хабарномалар';
      showNotifications = 'Хабарномаларни кўрсатищ';
      error = 'Xaтo';
      messagePreview = 'Матнни кўрсатиш';
      sound = 'Овоз';
      language = 'Тил';
      settings = 'Созламалар';
      enterPhone = 'Телефон рақамини киритинг';
      enterSmsCode = 'SMS кодини киритинг';
      enterPassword = 'Махфий сўзни киритинг';
      repeatPin = 'Pin-кодни такрорланг';
      attention = 'Диққат';
      admin = 'Администратор';
      lastSeen = 'Бўлди хозир';
      video = 'Видео';
      selectOption = 'Бирор вариантни танланг';
      gallery = 'Галерея';
      wantToExit = 'Ҳақиқатан ҳам чиқмоқчимисиз?';
      uploaded = 'Юкланилган';
      somethingWentWrong = 'Бир нарса нотўғри кетди';
      save = 'Ҳозирги тил';
      share = 'Насиб қилса';
      photo = 'Сурат';
      sessionIsOver = 'Сессия тугади';
      cancel = 'Бекор қилиш';
      allowContacts = 'Контактларга рухсат бериш';
      openSettings = 'Очиқ Созламалар';
      document = 'Ҳужжат. гов. ве';
      textMessage = 'Матнли хабар';
      voiceMessage = 'Овозли х���бар ъ';
      location = 'Узбекона. ве';
      reply = 'Жавоб бериш';
      money = 'Пул-Саисият';
      link = 'Линк';
      forwardedMessage = 'Жўнатилган хабар';
      message = 'Хабар';
      systemMessage = 'Тизим хабари';
      back = 'Орқага';
      camera = 'Камера';
      watch = 'Қаранглар';
      no = 'Йўқ';
      yes = 'Ҳа';
      fillAllFields = 'Барча майдонларни тўлдиринг';
      description = 'Тавсифи';
      goToChat = 'Чатга ўтиш';
      userNotInSystem = 'Бу фойдаланувчи тизимда йўқ';
      file = 'Фай хақида"';
      addToGroup = 'Гуруҳга қўшиш учун';
      clickToStart = 'Чатни бошлаш учун босинг';
      setAdmin = 'Администратор сифатида тайинлаш';
      makeMember = 'Аъзо бўлинг';
      exitGroup = 'Гуруҳдан чиқиш учун';
      sureExitGroup = 'Гуруҳдан чиқмоқчи еканлигингизга ишончингиз комилми?';
      delete = 'Ўчириш';
      noChatName = 'Чат номи йўқ';
      minMembersCount = 'Иштирокчиларнинг минимал сони: 3';
      files = 'Файллар';
      edit = 'Таҳрирлаш';
      editedMessage = 'Таҳр.';
      surname = 'Фамилия';
      passwordNotMatch = 'Махфий сўз мос келмаяпти';
      weSentToEmail =
          'Електрон почтангизга 10 сония ичида қабул қилинадиган СМС-калит юбордик';
      keyFromSms = 'SMS коди';
      country = 'Мамлакат';
      status = 'Статуслари';
      selectFile = 'Танланган файл';
      userNotFound = 'Фойдаланувчи топилмади';
      history = 'Тарих. уз';
      youSended = 'Сиз юборган';
      youReceived = 'Сиз олган';
      online = 'onlayn';
      enterValidAccount = 'Тўғри ҳисоб рақамини киритинг';
      enterBelowMax = 'Максимал белгидан паст миқдорни киритинг';
      enterAboveMin = 'Minimal белгидан юқори миқдорни киритинг';
      appVersion = 'Mobil дастур версияси';
      httpError = 'Маълумотларни юклашда хатолик';
      historyBalance = 'Мувозанат тарихи';
      emptyContacts = 'Алоқалар йўқ';
      empty = 'Та бўш';
      noChats = 'Чатлар йўқ';

      print('uz');
      break;
    case 'uzb':
      registration = 'Ro\'yxatdan o\'tish';
      login = 'Kirish';
      phoneNumber = 'Телефон рақами';
      title = 'Nomi';
      password = 'Maxfiy so\'z';
      forgotPassword = 'Maxfiy so\'zni unutdingizmi?';
      next = 'So\'ngra';
      currentLanguage = 'Ўзбекча';
      email = 'Elektron pochta';
      exit = 'Chiqish';
      support = 'QO\'LLAB-QUVVATLASH XIZMATI';
      chats = 'Chatlar';
      chat = 'Chat';
      profile = 'Profil';
      tape = 'Tasma';
      wallet = 'Hamyon';
      comments = 'Fikrlar';
      withdraw = 'Chiqarish';
      refill = 'To\'ldirish';
      payments = 'To\'lovlar';
      transfers = 'O\'tkazishlar';
      balanceInBlock = 'Qayta ishlashdagi balans';
      balance = 'Balans';
      account = 'Akkaunt';
      walletBalance = 'Hamyon balansi';
      amount = 'Maksimal summa';
      pay = 'To\'lov qilish';
      minAmount = 'Minimal summa';
      minCommission = 'Minimal komissiya';
      maxAmount = 'Maksimal summa';
      commission = 'Komissiya';
      toIndigo24Client = 'Indigo24 mijoziga';
      transfer = 'O\'tkazish';
      enterMessage = 'Xabarnomangizni kiriting';
      members = 'Ishtirokchilar';
      creator = 'Yaratuvchi';
      member = 'Ishtirokchi';
      contacts = 'Aloqalar';
      search = 'Izlash';
      createGroup = 'Guruh yaratish';
      chatName = 'Chat nomi y\'q';
      newTape = 'Yangi yozuv';
      enterPin = 'PIN-kodni kiriting';
      createPin = 'PIN-kodni o\'rnating';
      incorrectPin = 'PIN-kod noto‘g‘ri';
      chatNotifications = 'Chat xabarnomalari';
      notifications = 'Xabarnomalar';
      showNotifications = 'Xabarnomalarni ko\'rsatish';
      error = 'Xato';
      messagePreview = 'Matnni ko\'rsatish';
      sound = 'Ovoz';
      language = 'Til';
      settings = 'Sozlamalar';
      enterPhone = 'Telefon raqamini kiriting';
      enterSmsCode = 'SMS kodini kiriting';
      enterPassword = 'Maxfiy so\'zni kiriting';
      repeatPin = 'PIN-kodni takrorlang';
      attention = 'Diqqat';
      admin = 'Administrator';
      lastSeen = 'Tarmoqda edi';
      video = 'Video';
      selectOption = 'Biror variantni tanlang';
      gallery = 'Galereya';
      wantToExit = 'Haqiqatan ham chiqmoqchimisiz?';
      uploaded = 'Yuklab olingan';
      somethingWentWrong = 'Biror narsa noto\'g\'ri ketdi';
      save = 'Saqlash';
      share = 'Share';
      photo = 'Surat';
      sessionIsOver = 'Sessiya tugadi';
      cancel = 'Cancel';
      allowContacts = 'Kontaktlar ruxsat berish';
      openSettings = 'Ochiq Sozlamalar';
      document = 'Hujjat';
      textMessage = 'Matnli xabar';
      voiceMessage = 'Ovozli xabar"';
      location = 'Manzil';
      reply = 'Javob';
      money = 'Pul';
      link = 'Aloqa';
      forwardedMessage = 'Qayta yo\'naltirilgan xabar';
      message = 'Xabar';
      systemMessage = 'Tizim xabarlari';
      back = 'Orqaga';
      camera = 'Kamera';
      watch = 'Qarang';
      no = 'Yo\'q';
      yes = 'Ha';
      fillAllFields = 'Barcha maydonlarni to\'ldiring';
      description = 'Tavsifi';
      goToChat = 'Suhbatga o\'tish';
      userNotInSystem = 'Bu foydalanuvchi tizimda yo\'q';
      file = 'Fayl';
      addToGroup = 'Guruhga qo\'shing';
      clickToStart = 'Bosing suhbatni boshlash uchun';
      setAdmin = 'Administrator sifatida tayinlash';
      makeMember = 'A\'zo bo\'ling';
      exitGroup = 'Guruhdan chiqish';
      sureExitGroup = 'Guruhdan chiqib ketmoqchimisiz?';
      delete = 'O\'chirish';
      noChatName = 'Chat nomi yo\'q';
      minMembersCount = 'Ishtirokchilarning minimal soni: 3';
      files = 'Fayllar';
      edit = 'Tahrirlash';
      editedMessage = 'Tahr.';
      surname = 'Familiya';
      passwordNotMatch = 'Maxfiy so\'z mos kelmayapti';
      weSentToEmail =
          '10 soniya ichida keladigan pochta xabaringizga SMS-kalitni yubordik';
      keyFromSms = 'SMS kodi';
      country = 'Mamlakat';
      status = 'Status';
      selectFile = 'Faylni tanlang';
      userNotFound = 'Foydalanuvchi topilmadi';
      history = 'Tarix';
      youSended = 'Siz yuborgan';
      youReceived = 'Siz bor';
      online = 'onlayn';
      enterValidAccount = 'To\'g\'ri hisob raqamini kiriting';
      enterBelowMax = 'Maksimal belgidan past miqdorni kiriting';
      enterAboveMin = 'Eng kam belgidan yuqori miqdorni kiriting';
      appVersion = 'Mobil ilova versiyasi';
      httpError = 'Ma\'lumotlarni yuklashda xatolik';
      historyBalance = 'Balans tarixi';
      emptyContacts = 'Hech qanday aloqa yo\'q';
      empty = 'Bo\'sh';
      noChats = 'Hech qanday suhbat yo\'q';
      terms = "Foydalanish shartlari";
      print('uzb');
      break;
    default:
  }
}
