var NEED_TO_FILL = 'Небхідно заповнити';
var NEED_TO_SELECT = 'Небхідно обрати';
var PRIVACY_AGREEMENT = 'Згода на обробку персональних даних';

export default {
  errors: {
    before: "{{description}} повинно бути до {{before}}",
    wrongDateFormat: "{{description}} повинно бути у форматі {{format}}",
  },

  'header-toolbar.login': 'Увійти',

  'login.methodSelectionStep.label': 'Оберіть метод входу',
  'login.methodValueStep.label': 'Куди висилати код?',
  'login.methodValueStep.value.email': 'Вкажіть Вашу електронну пошту',
  'login.methodValueStep.value.phone': 'Вкажіть Ваш номер телефону',
  'login.methodValueStep.valueRequired': NEED_TO_FILL,
  'login.title': 'Вхід',
  'login.tokenStep.label': 'Верифікація коду',
  'login.tokenStep.token': 'Введіть код який Ви отримали',
  'login.tokenStep.tokenRequired': NEED_TO_FILL,
  'login.userNotFoundStep.createNew': 'Створити нового користувача',
  'login.userNotFoundStep.label': 'Немає користувача за таким контактом',
  'login.userNotFoundStep.pleaseChose': 'Оберіть що робити далі будь ласка',

  'main-sidenav.home': 'Домашня',
  'main-sidenav.logout': 'Вийти',
  'main-sidenav.privacyAgreement': PRIVACY_AGREEMENT,
  'main-sidenav.users': 'Люди',

  'privacy.privacyAgreement': PRIVACY_AGREEMENT,

  'register.back': 'Назад',
  'register.ducumentsUpload.identificationDocument': 'Документ що ідентифікує особу (фото першої сторінки паспорта або водійского посвідчення)',
  'register.ducumentsUpload.selectFile': 'Завантажити файл',
  'register.ducumentsUpload': 'Завантаження документів',
  'register.generalInfo.birthday.required': NEED_TO_SELECT,
  'register.generalInfo.birthday': 'День народження',
  'register.generalInfo.gender.female': 'Жіноча',
  'register.generalInfo.gender.male': 'Чоловіча',
  'register.generalInfo.gender.required': NEED_TO_SELECT,
  'register.generalInfo.gender': 'Стать',
  'register.generalInfo.displayName': "Ім'я для відображення",
  'register.generalInfo.displayNameReuired': NEED_TO_FILL,
  'register.generalInfo.pleaseFix': "Виправте помилки будь ласка",
  'register.generalInfo': 'Основна інформація',
  'register.iAgree': 'Я прочитав(ла) і згоден(на) з цією згодою на обробку персональних даних',
  'register.next': 'Далі',
  'register.privacyAgreement': PRIVACY_AGREEMENT,
  'register.title': 'Реєстрація',
};
