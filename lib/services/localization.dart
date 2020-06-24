import 'helper.dart';

String title;
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
String passcodeError = 'Incorrect pin code';
String success = 'Success';
String processing = 'Processing';
String _new = 'New';
String language = 'Language';
String settings = 'Settings';
String enterPhone = 'Enter phone';
String enterSmsCode = 'Enter SMS code';
String enterPassword = 'Enter password';
String replyPin = 'Repeat pin';
var languages = [
  {"title": "English", "code": "en"},
  {"title": "Russian", "code": "ru"},
  {"title": "Kazakh", "code": "kz"},
];

setLanguage(code) {
  SharedPreferencesHelper.setString('languageCode', '$code');
  switch (code) {
    case 'en':
      print('en');
      registration = 'Registration';
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
      passcodeError = 'Incorrect pin code';
      language = 'Language';
      settings = 'Settings';
      enterPhone = 'Enter phone';
      enterSmsCode = 'Enter SMS code';
      enterPassword = 'Enter password';
      replyPin = 'Repeat pin';
      languages = [
        {"title": "English", "code": "en"},
        {"title": "Russian", "code": "ru"},
        {"title": "Kazakh", "code": "kz"},
      ];
      break;
    case 'ru':
      registration = 'Регистрация';
      login = 'Вход';
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
      passcodeError = 'Неправильный PIN';
      language = 'Язык';
      settings = 'Настройки';
      enterPhone = 'Введите номер телефона';
      enterSmsCode = 'Введите SMS код';
      enterPassword = 'Введите пароль';
      replyPin = 'Повторите PIN';
      languages = [
        {"title": "Английский", "code": "en"},
        {"title": "Русский", "code": "ru"},
        {"title": "Казахский", "code": "kz"},
      ];
      print('ru');
      break;
    case 'kz':
      registration = 'Тіркелу';
      login = 'Енгізу';
      phoneNumber = 'Телефон нөмірі';
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
      passcodeError = 'Қате PIN код';
      language = 'Тіл';
      settings = 'Параметрлер';
      enterPhone = 'Телефон нөмірін енгізіңіз';
      enterSmsCode = 'SMS кодын енгізіңіз';
      enterPassword = 'Құпия сөзді енгізіңіз';
      replyPin = 'PIN қайталаңыз';
      languages = [
        {"title": "Ағылшын тілі", "code": "en"},
        {"title": "Орыс тілі", "code": "ru"},
        {"title": "Қазақша", "code": "kz"},
      ];
      print('kz');
      break;
    default:
  }
}
