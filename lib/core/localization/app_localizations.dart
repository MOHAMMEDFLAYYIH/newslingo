import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  const AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  bool get isAr => locale.languageCode == 'ar';
  bool get isEs => locale.languageCode == 'es';
  bool get isFr => locale.languageCode == 'fr';
  bool get isPt => locale.languageCode == 'pt';
  bool get isRu => locale.languageCode == 'ru';
  bool get isHi => locale.languageCode == 'hi';
  bool get isZh => locale.languageCode == 'zh';

  // Splash
  String get splashTitle =>
      isAr ? 'نيوز لينجو' : isEs ? 'NewsLingo'
          : isFr
          ? 'Le jargon de l\'actualité'
          : isPt
          ? 'Jargão jornalístico'
          : isRu
          ? 'Жаргон новостей'
          : isHi
          ? 'समाचार की शब्दावली'

          : isZh
          ? '新闻术语'
: 'NewsLingo';
  String get splashSubtitle =>
      isAr ? 'تعلم الإنجليزية من الأخبار' : isEs ? 'Aprende inglés con las noticias'
          : isFr
          ? 'Apprendre l\'anglais grâce à l\'actualité'
          : isPt
          ? 'Aprenda inglês com as notícias'
          : isRu
          ? 'Изучайте английский по новостям'
          : isHi
          ? 'समाचारों से अंग्रेज़ी सीखें'

          : isZh
          ? '通过新闻学习英语'
: 'Learn English from the News';

  // App
  String get appName =>
      isAr ? 'نيوز لينجو' : isEs ? 'NewsLingo'
          : isFr
          ? 'Le jargon de l\'actualité'
          : isPt
          ? 'Jargão jornalístico'
          : isRu
          ? 'Жаргон новостей'
          : isHi
          ? 'समाचार की शब्दावली'

          : isZh
          ? '新闻术语'
: 'NewsLingo';

  // Bottom Nav
  String get navHome =>
      isAr ? 'الرئيسية' : isEs ? 'Inicio'
          : isFr
          ? 'Accueil'
          : isPt
          ? 'Página inicial'
          : isRu
          ? 'Главная'
          : isHi
          ? 'होम'

          : isZh
          ? '首页'
: 'Home';
  String get navVocabulary =>
      isAr ? 'مفرداتي' : isEs ? 'Vocabulario'
          : isFr
          ? 'Vocabulaire'
          : isPt
          ? 'Vocabulário'
          : isRu
          ? 'Словарный запас'
          : isHi
          ? 'शब्दावली'

          : isZh
          ? '词汇'
: 'Vocabulary';
  String get navProfile =>
      isAr ? 'حسابي' : isEs ? 'Perfil'
          : isFr
          ? 'Profil'
          : isPt
          ? 'Perfil'
          : isRu
          ? 'Профиль'
          : isHi
          ? 'प्रोफ़ाइल'

          : isZh
          ? '个人简介'
: 'Profile';

  // Onboarding
  String get obTitle1 =>
      isAr ? 'اقرأ أخبار حقيقية' : isEs ? 'Lee Noticias Reales'
          : isFr
          ? 'Lisez les vraies infos'
          : isPt
          ? 'Leia notícias verdadeiras'
          : isRu
          ? 'Читайте настоящие новости'
          : isHi
          ? 'वास्तविक समाचार पढ़ें'

          : isZh
          ? '阅读真实新闻'
: 'Read Real News';
  String get obSub1 => isAr
      ? 'نخبة من الأخبار اليومية\nمصممة خصيصاً لمستواك'
      : isEs ? 'Noticias diarias seleccionadas\ndiseñadas para tu nivel'

      : isFr
      ? 'Une sélection quotidienne d\'actualités\nadaptée à votre niveau'
      : isPt
      ? 'Notícias diárias selecionadas\nadaptadas ao seu nível'
      : isRu
      ? 'Подборка ежедневных новостей\nподборка, адаптированная к вашему уровню'
      : isHi
      ? 'रोज़ाना की चुनिंदा खबरें, आपके स्तर के अनुसार तैयार'

      : isZh
      ? '精选每日新闻\n专为您当前水平量身定制'
: 'Curated daily news\ndesigned for your level';
  String get obTitle2 =>
      isAr ? 'اضغط وتعلم' : isEs ? 'Toca y Aprende'
          : isFr
          ? 'Appuyez pour en savoir plus'
          : isPt
          ? 'Tocar e Aprender'
          : isRu
          ? '«Нажми и узнай»'
          : isHi
          ? 'टैप और सीखें'

          : isZh
          ? '点击学习'
: 'Tap & Learn';
  String get obSub2 => isAr
      ? 'أي كلمة تضغط عليها\nتشوف معناها وترجمتها ونطقها'
      : isEs ? 'Toca cualquier palabra para ver\nsu significado, traducción y pronunciación'

      : isFr
      ? 'Appuyez sur n\'importe quel mot pour voir sa\nsignification, sa traduction et sa prononciation'
      : isPt
      ? 'Toque em qualquer palavra para ver o seu\nsignificado, tradução e pronúncia'
      : isRu
      ? 'Нажмите на любое слово, чтобы увидеть его\nзначение, перевод и произношение'
      : isHi
      ? 'किसी भी शब्द पर टैप करें उसका अर्थ, अनुवाद और उच्चारण देखने के लिए'

      : isZh
      ? '点击任意单词，即可查看其\n释义、翻译和发音'
: 'Tap any word to see its\nmeaning, translation & pronunciation';
  String get obTitle3 =>
      isAr ? 'تتبع تقدمك' : isEs ? 'Sigue tu Progreso'
          : isFr
          ? 'Suivez vos progrès'
          : isPt
          ? 'Acompanhe o seu progresso'
          : isRu
          ? 'Отслеживайте свои успехи'
          : isHi
          ? 'अपनी प्रगति ट्रैक करें'

          : isZh
          ? '跟踪您的进度'
: 'Track Your Progress';
  String get obSub3 => isAr
      ? 'كلمات تحفظها، شارات تجمعها\nوتسلسل يومي يخليك مستمر'
      : isEs ? 'Guarda palabras, gana insignias\ny mantén tu racha diaria'

      : isFr
      ? 'Enregistrez des mots, gagnez des badges\net maintenez votre série'
      : isPt
      ? 'Guarda palavras, ganha emblemas\ne mantém a tua série de vitórias'
      : isRu
      ? 'Экономьте слова, зарабатывайте значки\nи не прерывайте свою серию'
      : isHi
      ? 'शब्दों की बचत करें, बैज अर्जित करें\nऔर अपनी स्ट्रीक जारी रखें'

      : isZh
      ? '节省单词，赚取徽章\n并保持连胜纪录'
: 'Save words, earn badges\nand keep your streak going';
  String get obSkip =>
      isAr ? 'تخطي' : isEs ? 'Saltar'
          : isFr
          ? 'Navire'
          : isPt
          ? 'Navio'
          : isRu
          ? 'Корабль'
          : isHi
          ? 'जहाज'

          : isZh
          ? '跳过'
: 'Skip';
  String get obNext =>
      isAr ? 'التالي' : isEs ? 'Siguiente'
          : isFr
          ? 'Suivant'
          : isPt
          ? 'Seguinte'
          : isRu
          ? 'Далее'
          : isHi
          ? 'अगला'

          : isZh
          ? '下一页'
: 'Next';
  String get obStart =>
      isAr ? 'خلنا نبدأ!' : isEs ? '¡Empecemos!' : "Let's Start!";

  // Auth
  String get loginTitle =>
      isAr ? 'مرحباً\nبعودتك!' : isEs ? '¡Bienvenido\nde nuevo!'
          : isFr
          ? 'Bienvenue\nDe retour !'
          : isPt
          ? 'Bem-vindo\nDe volta!'
          : isRu
          ? 'Добро пожаловать\nСнова!'
          : isHi
          ? 'स्वागत है\nफिर से वापस!'

          : isZh
          ? '欢迎\n回来！'
: 'Welcome\nBack!';
  String get loginSubtitle =>
      isAr ? 'سعداء برؤيتك مرة أخرى' : isEs ? 'Nos alegra verte de nuevo'
          : isFr
          ? 'Je suis content de te revoir'
          : isPt
          ? 'É um prazer voltar a ver-te'
          : isRu
          ? 'Рад снова вас видеть'
          : isHi
          ? 'आपको फिर से देखकर खुशी हुई'

          : isZh
          ? '很高兴再次见到你'
: 'Happy to see you again';
  String get emailLabel =>
      isAr ? 'البريد الإلكتروني' : isEs ? 'Correo electrónico'
          : isFr
          ? 'E-mail'
          : isPt
          ? 'E-mail'
          : isRu
          ? 'Электронная почта'
          : isHi
          ? 'ईमेल'

          : isZh
          ? '电子邮件'
: 'Email';
  String get emailHint =>
      isAr ? 'example@email.com' : isEs ? 'ejemplo@correo.com'
          : isFr
          ? 'example@email.com'
          : isPt
          ? 'example@email.com'
          : isRu
          ? 'example@email.com'
          : isHi
          ? 'example@email.com'

          : isZh
          ? 'example@email.com'
: 'example@email.com';
  String get emailRequired =>
      isAr ? 'يرجى إدخال البريد الإلكتروني'
          : isEs ? 'Por favor ingresa tu correo electrónico'

          : isFr
          ? 'Veuillez saisir votre adresse e-mail'
          : isPt
          ? 'Por favor, introduza o seu endereço de e-mail'
          : isRu
          ? 'Пожалуйста, введите свой адрес электронной почты'
          : isHi
          ? 'कृपया अपना ईमेल दर्ज करें'

          : isZh
          ? '请输入您的电子邮箱'
: 'Please enter your email';
  String get emailInvalid =>
      isAr ? 'البريد الإلكتروني غير صحيح'
          : isEs ? 'Correo electrónico no válido'

          : isFr
          ? 'Adresse e-mail non valide'
          : isPt
          ? 'Endereço de e-mail inválido'
          : isRu
          ? 'Неверный адрес электронной почты'
          : isHi
          ? 'अमान्य ईमेल पता'

          : isZh
          ? '电子邮件地址无效'
: 'Invalid email address';
  String get passwordLabel =>
      isAr ? 'كلمة المرور' : isEs ? 'Contraseña'
          : isFr
          ? 'Mot de passe'
          : isPt
          ? 'Palavra-passe'
          : isRu
          ? 'Пароль'
          : isHi
          ? 'पासवर्ड'

          : isZh
          ? '密码'
: 'Password';
  String get passwordHint =>
      isAr ? 'أدخل كلمة المرور' : isEs ? 'Ingresa tu contraseña'
          : isFr
          ? 'Entrez votre mot de passe'
          : isPt
          ? 'Introduza a sua palavra-passe'
          : isRu
          ? 'Введите пароль'
          : isHi
          ? 'अपना पासवर्ड दर्ज करें'

          : isZh
          ? '请输入密码'
: 'Enter your password';
  String get passwordRequired =>
      isAr ? 'يرجى إدخال كلمة المرور'
          : isEs ? 'Por favor ingresa tu contraseña'

          : isFr
          ? 'Veuillez saisir votre mot de passe'
          : isPt
          ? 'Introduza a sua palavra-passe'
          : isRu
          ? 'Введите, пожалуйста, свой пароль'
          : isHi
          ? 'कृपया अपना पासवर्ड दर्ज करें'

          : isZh
          ? '请输入密码'
: 'Please enter your password';
  String get forgotPassword =>
      isAr ? 'نسيت كلمة المرور؟' : isEs ? '¿Olvidaste tu contraseña?'
          : isFr
          ? 'Mot de passe oublié ?'
          : isPt
          ? 'Esqueceu-se da palavra-passe?'
          : isRu
          ? 'Забыли пароль?'
          : isHi
          ? 'पासवर्ड भूल गए?'

          : isZh
          ? '忘记密码了吗？'
: 'Forgot password?';
  String get login =>
      isAr ? 'تسجيل الدخول' : isEs ? 'Iniciar sesión'
          : isFr
          ? 'Se connecter'
          : isPt
          ? 'Iniciar sessão'
          : isRu
          ? 'Войти'
          : isHi
          ? 'लॉग इन'

          : isZh
          ? '登录'
: 'Log In';
  String get noAccount =>
      isAr ? 'ليس لديك حساب؟'
          : isEs ? '¿No tienes cuenta?'
          : "Don't have an account?";
  String get signUp =>
      isAr ? 'إنشاء حساب' : isEs ? 'Registrarse'
          : isFr
          ? 'S\'inscrire'
          : isPt
          ? 'Inscreva-se'
          : isRu
          ? 'Зарегистрироваться'
          : isHi
          ? 'साइन अप करें'

          : isZh
          ? '注册'
: 'Sign Up';
  String get errorRateLimit => isAr
      ? 'طلبات كثيرة جداً! انتظر دقيقة وحاول مرة أخرى ⏳'
      : isEs ? '¡Demasiadas solicitudes! Espera un minuto e inténtalo de nuevo ⏳'

      : isFr
      ? 'Trop de requêtes ! Veuillez patienter un instant, puis réessayez ⏳'
      : isPt
      ? 'Demasiadas solicitações! Aguarde um minuto e tente novamente ⏳'
      : isRu
      ? 'Слишком много запросов! Подождите минуту и попробуйте ещё раз ⏳'
      : isHi
      ? 'बहुत ज़्यादा अनुरोध! एक मिनट रुकें और फिर से कोशिश करें ⏳'

      : isZh
      ? '请求过多！请稍等片刻，然后重试 ⏳'
: 'Too many requests! Wait a minute and try again ⏳';
  String get errorEmailNotConfirmed => isAr
      ? 'البريد الإلكتروني غير مفعل. تحقق من بريدك الوارد'
      : isEs ? 'Correo no confirmado. Revisa tu bandeja de entrada'

      : isFr
      ? 'Votre adresse e-mail n\'a pas été validée. Vérifiez votre boîte de réception.'
      : isPt
      ? 'O e-mail não foi confirmado. Verifique a sua caixa de entrada'
      : isRu
      ? 'Электронная почта не подтверждена. Проверьте папку «Входящие»'
      : isHi
      ? 'ईमेल की पुष्टि नहीं हुई है। अपना इनबॉक्स जांचें।'

      : isZh
      ? '邮箱尚未确认。请检查您的收件箱'
: 'Email not confirmed. Check your inbox';
  String get errorInvalidCredentials => isAr
      ? 'البريد الإلكتروني أو كلمة المرور غير صحيحة'
      : isEs ? 'Correo o contraseña no válidos'

      : isFr
      ? 'Adresse e-mail ou mot de passe incorrect(e)'
      : isPt
      ? 'E-mail ou palavra-passe inválidos'
      : isRu
      ? 'Неверный адрес электронной почты или пароль'
      : isHi
      ? 'अमान्य ईमेल या पासवर्ड'

      : isZh
      ? '电子邮件地址或密码无效'
: 'Invalid email or password';
  String get errorGeneric => isAr
      ? 'خطأ: تأكد من اتصال الإنترنت وحاول مرة أخرى'
      : isEs ? 'Error: Verifica tu conexión a internet e inténtalo de nuevo'

      : isFr
      ? 'Erreur : vérifiez votre connexion Internet et réessayez'
      : isPt
      ? 'Erro: Verifique a sua ligação à Internet e tente novamente'
      : isRu
      ? 'Ошибка: Проверьте подключение к Интернету и попробуйте ещё раз'
      : isHi
      ? 'त्रुटि: अपना इंटरनेट जांचें और फिर से प्रयास करें'

      : isZh
      ? '错误：请检查网络连接，然后重试'
: 'Error: Check your internet and try again';

  String get signUpTitle =>
      isAr ? 'إنشاء حساب' : isEs ? 'Crear cuenta'
          : isFr
          ? 'Créer un compte'
          : isPt
          ? 'Criar conta'
          : isRu
          ? 'Создать аккаунт'
          : isHi
          ? 'खाता बनाएँ'

          : isZh
          ? '创建账户'
: 'Create Account';
  String get signUpSubtitle => isAr
      ? 'ابدأ رحلة تعلم الإنجليزية الآن'
      : isEs ? 'Comienza tu viaje de aprendizaje de inglés ahora'

      : isFr
      ? 'Commencez dès maintenant votre parcours d\'apprentissage de l\'anglais'
      : isPt
      ? 'Começa já a tua jornada de aprendizagem do inglês'
      : isRu
      ? 'Начните свое путешествие в мир английского языка прямо сейчас'
      : isHi
      ? 'अपनी अंग्रेज़ी सीखने की यात्रा अभी शुरू करें'

      : isZh
      ? '现在就开始你的英语学习之旅吧'
: 'Start your English learning journey now';
  String get getNameLabel =>
      isAr ? 'الاسم' : isEs ? 'Nombre'
          : isFr
          ? 'Nom'
          : isPt
          ? 'Nome'
          : isRu
          ? 'Имя'
          : isHi
          ? 'नाम'

          : isZh
          ? '姓名'
: 'Name';
  String get getNameHint =>
      isAr ? 'أدخل اسمك' : isEs ? 'Ingresa tu nombre'
          : isFr
          ? 'Entrez votre nom'
          : isPt
          ? 'Introduza o seu nome'
          : isRu
          ? 'Введите своё имя'
          : isHi
          ? 'अपना नाम दर्ज करें'

          : isZh
          ? '请输入您的姓名'
: 'Enter your name';
  String get getNameRequired =>
      isAr ? 'يرجى إدخال الاسم' : isEs ? 'Por favor ingresa tu nombre'
          : isFr
          ? 'Veuillez saisir votre nom'
          : isPt
          ? 'Por favor, introduza o seu nome'
          : isRu
          ? 'Пожалуйста, введите своё имя'
          : isHi
          ? 'कृपया अपना नाम दर्ज करें'

          : isZh
          ? '请输入您的姓名'
: 'Please enter your name';
  String get passwordMin =>
      isAr ? '6 أحرف على الأقل' : isEs ? 'Al menos 6 caracteres'
          : isFr
          ? 'Au moins 6 caractères'
          : isPt
          ? 'Pelo menos 6 caracteres'
          : isRu
          ? 'Не менее 6 символов'
          : isHi
          ? 'कम से कम 6 अक्षर'

          : isZh
          ? '至少6个字符'
: 'At least 6 characters';
  String get passwordLengthError => isAr
      ? 'كلمة المرور يجب أن تكون 6 أحرف على الأقل'
      : isEs ? 'La contraseña debe tener al menos 6 caracteres'

      : isFr
      ? 'Le mot de passe doit comporter au moins 6 caractères'
      : isPt
      ? 'A palavra-passe deve ter, pelo menos, 6 caracteres'
      : isRu
      ? 'Пароль должен состоять как минимум из 6 символов'
      : isHi
      ? 'पासवर्ड कम से कम 6 अक्षरों का होना चाहिए।'

      : isZh
      ? '密码必须至少包含 6 个字符'
: 'Password must be at least 6 characters';
  String get confirmPasswordLabel =>
      isAr ? 'تأكيد كلمة المرور' : isEs ? 'Confirmar contraseña'
          : isFr
          ? 'Confirmer le mot de passe'
          : isPt
          ? 'Confirmar palavra-passe'
          : isRu
          ? 'Подтвердите пароль'
          : isHi
          ? 'पासवर्ड की पुष्टि करें'

          : isZh
          ? '确认密码'
: 'Confirm Password';
  String get confirmPasswordHint =>
      isAr ? 'أعد إدخال كلمة المرور' : isEs ? 'Vuelve a ingresar la contraseña'
          : isFr
          ? 'Entrez à nouveau votre mot de passe'
          : isPt
          ? 'Introduza novamente a palavra-passe'
          : isRu
          ? 'Введите пароль ещё раз'
          : isHi
          ? 'पासवर्ड फिर से दर्ज करें'

          : isZh
          ? '请重新输入密码'
: 'Re-enter password';
  String get confirmPasswordRequired => isAr
      ? 'يرجى تأكيد كلمة المرور'
      : isEs ? 'Por favor confirma tu contraseña'

      : isFr
      ? 'Veuillez confirmer votre mot de passe'
      : isPt
      ? 'Por favor, confirme a sua palavra-passe'
      : isRu
      ? 'Пожалуйста, подтвердите свой пароль'
      : isHi
      ? 'कृपया अपना पासवर्ड पुष्टि करें'

      : isZh
      ? '请确认您的密码'
: 'Please confirm your password';
  String get passwordsMismatch => isAr
      ? 'كلمة المرور غير متطابقة'
      : isEs ? 'Las contraseñas no coinciden'

      : isFr
      ? 'Les mots de passe ne correspondent pas'
      : isPt
      ? 'As palavras-passe não coincidem'
      : isRu
      ? 'Пароли не совпадают'
      : isHi
      ? 'पासवर्ड मेल नहीं खाते'

      : isZh
      ? '密码不匹配'
: 'Passwords do not match';
  String get agreeTerms => isAr
      ? 'أوافق على الشروط والأحكام\nوسياسة الخصوصية'
      : isEs ? 'Acepto los Términos y Condiciones\ny la Política de Privacidad'

      : isFr
      ? 'J\'accepte les Conditions générales d\'utilisation\net la Politique de confidentialité'
      : isPt
      ? 'Concordo com os Termos de Serviço\n e com a Política de Privacidade'
      : isRu
      ? 'Я согласен с Условиями предоставления услуг\nи Политикой конфиденциальности'
      : isHi
      ? 'मैं सेवा की शर्तों और गोपनीयता नीति से सहमत हूँ।'

      : isZh
      ? '我同意《服务条款》\n和《隐私政策》'
: 'I agree to the Terms of Service\nand Privacy Policy';
  String get createAccount =>
      isAr ? 'إنشاء الحساب' : isEs ? 'Crear cuenta'
          : isFr
          ? 'Créer un compte'
          : isPt
          ? 'Criar conta'
          : isRu
          ? 'Создать аккаунт'
          : isHi
          ? 'खाता बनाएँ'

          : isZh
          ? '创建账户'
: 'Create Account';
  String get haveAccount =>
      isAr ? 'لديك حساب بالفعل؟' : isEs ? '¿Ya tienes una cuenta?'
          : isFr
          ? 'Vous avez déjà un compte ?'
          : isPt
          ? 'Já tem uma conta?'
          : isRu
          ? 'У вас уже есть аккаунт?'
          : isHi
          ? 'क्या आपका पहले से ही खाता है?'

          : isZh
          ? '已有账户？'
: 'Already have an account?';
  String get accountCreated =>
      isAr ? 'تم إنشاء الحساب!' : isEs ? '¡Cuenta creada!'
          : isFr
          ? 'Compte créé !'
          : isPt
          ? 'Conta criada!'
          : isRu
          ? 'Учётная запись создана!'
          : isHi
          ? 'खाता बना!'

          : isZh
          ? '账户已创建！'
: 'Account Created!';
  String get checkEmail => isAr
      ? 'تحقق من بريدك الإلكتروني لتفعيل الحساب'
      : isEs ? 'Revisa tu correo para activar tu cuenta'

      : isFr
      ? 'Consultez votre messagerie pour activer votre compte'
      : isPt
      ? 'Verifique o seu e-mail para ativar a sua conta'
      : isRu
      ? 'Проверьте свою электронную почту, чтобы активировать аккаунт'
      : isHi
      ? 'अपना खाता सक्रिय करने के लिए अपना ईमेल देखें।'

      : isZh
      ? '请查看您的电子邮件以激活您的账户'
: 'Check your email to activate your account';
  String get verificationSent => isAr
      ? 'تم إرسال رابط التفعيل إلى بريدك'
      : isEs ? 'Enlace de verificación enviado a tu correo'

      : isFr
      ? 'Un lien de vérification vous a été envoyé par e-mail'
      : isPt
      ? 'Enviámos um link de verificação para o seu e-mail'
      : isRu
      ? 'Ссылка для подтверждения отправлена на ваш адрес электронной почты'
      : isHi
      ? 'आपके ईमेल पर सत्यापन लिंक भेज दिया गया है।'

      : isZh
      ? '已将验证链接发送至您的电子邮箱'
: 'Verification link sent to your email';
  String get verificationDetail => isAr
      ? 'يرجى التحقق من بريدك الوارد والنقر على الرابط لتفعيل حسابك، ثم تسجيل الدخول'
      : isEs ? 'Por favor revisa tu bandeja de entrada y haz clic en el enlace para activar tu cuenta, luego inicia sesión'

      : isFr
      ? 'Veuillez consulter votre boîte de réception et cliquer sur le lien pour activer votre compte, puis vous connecter'
      : isPt
      ? 'Por favor, verifique a sua caixa de entrada e clique na ligação para ativar a sua conta; em seguida, inicie sessão'
      : isRu
      ? 'Пожалуйста, проверьте папку «Входящие» и перейдите по ссылке, чтобы активировать свою учетную запись, а затем войдите в систему'
      : isHi
      ? 'कृपया अपना इनबॉक्स जांचें और अपना खाता सक्रिय करने के लिए लिंक पर क्लिक करें, फिर लॉग इन करें।'

      : isZh
      ? '请检查您的收件箱，点击链接激活您的账户，然后登录'
: 'Please check your inbox and click the link to activate your account, then log in';
  String get errorAlreadyRegistered => isAr
      ? 'هذا البريد مسجل بالفعل. سجل دخول بدلاً من ذلك'
      : isEs ? 'Este correo ya está registrado. Inicia sesión en su lugar'

      : isFr
      ? 'Cette adresse e-mail est déjà enregistrée. Connectez-vous plutôt.'
      : isPt
      ? 'Este endereço de e-mail já está registado. Inicie sessão, em vez disso'
      : isRu
      ? 'Этот адрес электронной почты уже зарегистрирован. Войдите в систему'
      : isHi
      ? 'यह ईमेल पहले से पंजीकृत है। इसके बजाय लॉग इन करें।'

      : isZh
      ? '该邮箱已注册。请直接登录'
: 'This email is already registered. Log in instead';
  String get errorWeakPassword => isAr
      ? 'كلمة المرور ضعيفة جداً'
      : isEs ? 'La contraseña es demasiado débil'

      : isFr
      ? 'Le mot de passe n\'est pas assez sûr'
      : isPt
      ? 'A palavra-passe é demasiado fraca'
      : isRu
      ? 'Пароль слишком слабый'
      : isHi
      ? 'पासवर्ड बहुत कमजोर है'

      : isZh
      ? '密码强度不足'
: 'Password is too weak';

  // Forgot Password
  String get forgotTitle => isAr
      ? 'نسيت كلمة\nالمرور؟'
      : isEs ? '¿Olvidaste tu\ncontraseña?'

      : isFr
      ? 'Mot de passe oublié ?\n'
      : isPt
      ? 'Esqueceu-se da\npalavra-passe?'
      : isRu
      ? 'Забыли\nпароль?'
      : isHi
      ? 'पासवर्ड भूल गए?'

      : isZh
      ? '忘记\n密码了吗？'
: 'Forgot\nPassword?';
  String get forgotSubtitle => isAr
      ? 'لا تقلق! أدخل بريدك الإلكتروني\nوسنرسل لك رمز التأكيد'
      : isEs ? '¡No te preocupes! Ingresa tu correo\ny te enviaremos un código'
      : "Don't worry! Enter your email\nand we'll send you a code";
  String get sendCode =>
      isAr ? 'إرسال رمز التأكيد' : isEs ? 'Enviar código'
          : isFr
          ? 'Envoyer le code'
          : isPt
          ? 'Enviar código'
          : isRu
          ? 'Отправить код'
          : isHi
          ? 'कोड भेजें'

          : isZh
          ? '发送代码'
: 'Send Code';
  String get rememberedPassword => isAr
      ? 'تذكرت كلمة المرور؟'
      : isEs ? '¿Recordaste tu contraseña?'

      : isFr
      ? 'Vous avez oublié votre mot de passe ?'
      : isPt
      ? 'Já se lembrou da sua palavra-passe?'
      : isRu
      ? 'Вспомнили свой пароль?'
      : isHi
      ? 'क्या आप अपना पासवर्ड याद रखे हैं?'

      : isZh
      ? '忘记密码了吗？'
: 'Remembered your password?';
  String get codeSent => isAr
      ? 'تم إرسال الرمز إلى بريدك الإلكتروني'
      : isEs ? 'Código enviado a tu correo electrónico'

      : isFr
      ? 'Code envoyé à votre adresse e-mail'
      : isPt
      ? 'Código enviado para o seu e-mail'
      : isRu
      ? 'Код отправлен на ваш электронный адрес'
      : isHi
      ? 'कोड आपके ईमेल पर भेज दिया गया है।'

      : isZh
      ? '验证码已发送至您的电子邮箱'
: 'Code sent to your email';
  String get checkInbox => isAr
      ? 'تحقق من بريدك الوارد واتبع الرابط\nلتأكيد العملية'
      : isEs ? 'Revisa tu bandeja de entrada y sigue el enlace\npara confirmar'

      : isFr
      ? 'Consultez votre boîte de réception et cliquez sur le lien\npour confirmer'
      : isPt
      ? 'Verifique a sua caixa de entrada e clique na ligação\npara confirmar'
      : isRu
      ? 'Проверьте свой почтовый ящик и перейдите по ссылке\nдля подтверждения'
      : isHi
      ? 'अपना इनबॉक्स जांचें और पुष्टि करने के लिए लिंक पर जाएँ।'

      : isZh
      ? '请查看您的收件箱，并点击链接\n进行确认'
: 'Check your inbox and follow the link\nto confirm';
  String get enterCode =>
      isAr ? 'إدخال الرمز' : isEs ? 'Ingresar código'
          : isFr
          ? 'Saisir le code'
          : isPt
          ? 'Introduzir o código'
          : isRu
          ? 'Введите код'
          : isHi
          ? 'कोड दर्ज करें'

          : isZh
          ? '输入代码'
: 'Enter Code';

  // OTP
  String get otpTitle => isAr
      ? 'تأكيد\nالبريد الإلكتروني'
      : isEs ? 'Confirmar\ncorreo electrónico'

      : isFr
      ? 'Confirmer\nE-mail'
      : isPt
      ? 'Confirmar\nE-mail'
      : isRu
      ? 'Подтвердить\nЭлектронная почта'
      : isHi
      ? 'पुष्टि करें\nईमेल'

      : isZh
      ? '确认\n电子邮件'
: 'Confirm\nEmail';
  String get otpSubtitle => isAr
      ? 'أدخل رمز التأكيد المكون من 6 أرقام\nالذي أرسلناه إلى بريدك'
      : isEs ? 'Ingresa el código de 6 dígitos\nenviado a tu correo'

      : isFr
      ? 'Saisissez le code à 6 chiffres\nqui vous a été envoyé par e-mail'
      : isPt
      ? 'Introduza o código de 6 dígitos\nque lhe foi enviado por e-mail'
      : isRu
      ? 'Введите 6-значный код,\nотправленный на ваш электронный адрес'
      : isHi
      ? 'अपनी ईमेल पर भेजा गया 6-अंकीय कोड दर्ज करें।'

      : isZh
      ? '请输入发送到您邮箱的6位验证码\n'
: 'Enter the 6-digit code\nsent to your email';
  String get otpIncorrect => isAr
      ? 'رمز التأكيد غير صحيح. حاول مرة أخرى.'
      : isEs ? 'Código incorrecto. Inténtalo de nuevo.'

      : isFr
      ? 'Code incorrect. Veuillez réessayer.'
      : isPt
      ? 'Código incorreto. Tente novamente.'
      : isRu
      ? 'Неверный код. Попробуйте ещё раз.'
      : isHi
      ? 'गलत कोड। फिर से प्रयास करें।'

      : isZh
      ? '代码错误。请重试。'
: 'Incorrect code. Try again.';
  String get otpNotReceived => isAr
      ? 'لم يصلك الرمز؟'
      : isEs ? '¿No recibiste el código?'
      : "Didn't receive the code?";
  String get otpResend =>
      isAr ? 'إعادة إرسال الرمز' : isEs ? 'Reenviar código'
          : isFr
          ? 'Renvoyer le code'
          : isPt
          ? 'Reenviar código'
          : isRu
          ? 'Повторно отправить код'
          : isHi
          ? 'कोड फिर से भेजें'

          : isZh
          ? '重新发送验证码'
: 'Resend Code';
  String get otpConfirm =>
      isAr ? 'تأكيد' : isEs ? 'Confirmar'
          : isFr
          ? 'Confirmer'
          : isPt
          ? 'Confirmar'
          : isRu
          ? 'Подтвердить'
          : isHi
          ? 'पुष्टि करें'

          : isZh
          ? '确认'
: 'Confirm';
  String get otpSuccess =>
      isAr ? 'تم التحقق بنجاح!' : isEs ? '¡Verificado con éxito!'
          : isFr
          ? 'Vérification réussie !'
          : isPt
          ? 'Verificação concluída com sucesso!'
          : isRu
          ? 'Проверка прошла успешно!'
          : isHi
          ? 'सफलतापूर्वक सत्यापित!'

          : isZh
          ? '已成功验证！'
: 'Verified Successfully!';
  String get otpSuccessDetail => isAr
      ? 'يمكنك الآن تغيير كلمة المرور الخاصة بك'
      : isEs ? 'Ahora puedes cambiar tu contraseña'

      : isFr
      ? 'Vous pouvez désormais modifier votre mot de passe'
      : isPt
      ? 'Já pode alterar a sua palavra-passe'
      : isRu
      ? 'Теперь вы можете изменить свой пароль'
      : isHi
      ? 'अब आप अपना पासवर्ड बदल सकते हैं।'

      : isZh
      ? '现在您可以更改密码了'
: 'You can now change your password';
  String get backToLogin =>
      isAr ? 'العودة لتسجيل الدخول' : isEs ? 'Volver al inicio de sesión'
          : isFr
          ? 'Retour à la page de connexion'
          : isPt
          ? 'Voltar ao início de sessão'
          : isRu
          ? 'Вернуться к входу'
          : isHi
          ? 'लॉगिन पर वापस'

          : isZh
          ? '返回登录页面'
: 'Back to Login';
  String seconds(int s) =>
      isAr ? '$s ثانية' : isEs ? '$s s'
          : isFr
          ? '$s s'
          : isPt
          ? '$s s'
          : isRu
          ? '$s s'
          : isHi
          ? '$s s'

          : isZh
          ? '$s s'
: '$s s';

  // Language Level
  String get levelTitle => isAr
      ? 'ما هو مستواك\nفي الإنجليزية؟'
      : isEs ? '¿Cuál es tu\nnivel de inglés?'
      : "What's Your\nEnglish Level?";
  String get levelSubtitle => isAr
      ? 'حدد مستواك لنخصص لك الأخبار المناسبة\nونقدم لك المحتوى بمستوى يتناسب معك'
      : isEs ? 'Establece tu nivel para recibir noticias personalizadas\ny contenido que se adapte a ti'

      : isFr
      ? 'Définissez votre niveau pour recevoir des actualités\net des contenus personnalisés qui vous correspondent'
      : isPt
      ? 'Defina o seu nível para receber notícias\n e conteúdos personalizados à sua medida'
      : isRu
      ? 'Выберите уровень, чтобы получать персонализированные новости\nи контент, подходящие именно вам'
      : isHi
      ? 'Set your level for personalized news\nand content that fits you'

      : isZh
      ? '设置您的偏好级别，获取适合您的个性化新闻\n和内容simplified Chinese (Mainland)'
: 'Set your level for personalized news\nand content that fits you';
  String get levelContinue =>
      isAr ? 'استمر' : isEs ? 'Continuar'
          : isFr
          ? 'Continuer'
          : isPt
          ? 'Continuar'
          : isRu
          ? 'Продолжить'
          : isHi
          ? 'जारी रखें'

          : isZh
          ? '继续'
: 'Continue';
  String levelDescription(String level) {
    switch (level) {
      case 'A1':
        return isAr
            ? 'كلمات وجمل أساسية، أخبار مبسطة'
            : isEs ? 'Palabras y frases básicas, noticias simplificadas'
            : 'Basic words & sentences, simplified news';
      case 'A2':
        return isAr
            ? 'جمل بسيطة، مفردات يومية أساسية'
            : isEs ? 'Frases sencillas, vocabulario básico diario'
            : 'Simple sentences, basic daily vocabulary';
      case 'B1':
        return isAr
            ? 'فهم النصوص الرئيسية، محادثات'
            : isEs ? 'Comprensión de textos principales, conversaciones'
            : 'Understand main texts, conversations';
      case 'B2':
        return isAr
            ? 'نصوص معقدة، مواضيع متنوعة'
            : isEs ? 'Textos complejos, temas variados'
            : 'Complex texts, diverse topics';
      case 'C1':
        return isAr
            ? 'فهم كامل، مقالات متقدمة'
            : isEs ? 'Comprensión completa, artículos avanzados'
            : 'Full comprehension, advanced articles';
      default:
        return '';
    }
  }

  // Interests
  String get interestTitle => isAr
      ? 'ما هي المواضيع\nالتي تهمك؟'
      : isEs ? '¿Qué temas\nte interesan?'

      : isFr
      ? 'Quels sujets\nvous intéressent ?'
      : isPt
      ? 'Que temas\nte interessam?'
      : isRu
      ? 'Какие темы\nвас интересуют?'
      : isHi
      ? 'आपको कौन से विषय\nरुचिकर हैं?'

      : isZh
      ? '哪些话题\n让你感兴趣？'
: 'What Topics\nInterest You?';
  String get interestSubtitle => isAr
      ? 'اختر موضوعاً أو أكثر لنخصص لك\nالأخبار التي تناسب اهتماماتك'
      : isEs ? 'Elige uno o más temas para recibir\nnoticias que se ajusten a tus intereses'

      : isFr
      ? 'Choisissez un ou plusieurs sujets pour recevoir\ndes actualités correspondant à vos centres d\'intérêt'
      : isPt
      ? 'Escolha um ou mais temas para receber\nnotícias que correspondam aos seus interesses'
      : isRu
      ? 'Выберите одну или несколько тем, чтобы получать\nновости, соответствующие вашим интересам'
      : isHi
      ? 'अपनी रुचियों से मेल खाने वाली खबरें पाने के लिए एक या अधिक विषय चुनें'

      : isZh
      ? '选择一个或多个主题，以获取\n符合您兴趣的新闻'
: 'Pick one or more topics to get\nnews that matches your interests';
  String get interestSelected =>
      isAr ? 'تم الاختيار: {n}' : isEs ? 'Seleccionado: {n}'
          : isFr
          ? 'Sélectionné : {n}'
          : isPt
          ? 'Selecionado: {n}'
          : isRu
          ? 'Выбрано: {n}'
          : isHi
          ? 'चयनित: {n}'

          : isZh
          ? '已选中：{n}'
: 'Selected: {n}';
  String get interestMin =>
      isAr ? 'اختر موضوعاً على الأقل' : isEs ? 'Selecciona al menos un tema'
          : isFr
          ? 'Sélectionnez au moins un sujet'
          : isPt
          ? 'Selecione pelo menos um tópico'
          : isRu
          ? 'Выберите хотя бы одну тему'
          : isHi
          ? 'कम से कम एक विषय चुनें'

          : isZh
          ? '请至少选择一个主题'
: 'Select at least one topic';
  String get interestNext =>
      isAr ? 'التالي' : isEs ? 'Siguiente'
          : isFr
          ? 'Suivant'
          : isPt
          ? 'Seguinte'
          : isRu
          ? 'Далее'
          : isHi
          ? 'अगला'

          : isZh
          ? '下一页'
: 'Next';
  String get interestGeneral =>
      isAr ? 'عام' : isEs ? 'General'
          : isFr
          ? 'Généralités'
          : isPt
          ? 'Geral'
          : isRu
          ? 'Общие сведения'
          : isHi
          ? 'सामान्य'

          : isZh
          ? '概述'
: 'General';
  String get interestSports =>
      isAr ? 'رياضة' : isEs ? 'Deportes'
          : isFr
          ? 'Sports'
          : isPt
          ? 'Desporto'
          : isRu
          ? 'Спорт'
          : isHi
          ? 'खेल'

          : isZh
          ? '体育'
: 'Sports';
  String get interestTechnology =>
      isAr ? 'تكنولوجيا' : isEs ? 'Tecnología'
          : isFr
          ? 'Technologie'
          : isPt
          ? 'Tecnologia'
          : isRu
          ? 'Технологии'
          : isHi
          ? 'प्रौद्योगिकी'

          : isZh
          ? '技术'
: 'Technology';
  String get interestBusiness =>
      isAr ? 'اقتصاد' : isEs ? 'Negocios'
          : isFr
          ? 'Affaires'
          : isPt
          ? 'Negócios'
          : isRu
          ? 'Бизнес'
          : isHi
          ? 'व्यवसाय'

          : isZh
          ? '商业'
: 'Business';
  String get interestScience =>
      isAr ? 'علوم' : isEs ? 'Ciencia'
          : isFr
          ? 'Sciences'
          : isPt
          ? 'Ciência'
          : isRu
          ? 'Наука'
          : isHi
          ? 'विज्ञान'

          : isZh
          ? '科学'
: 'Science';
  String get interestEntertainment =>
      isAr ? 'ترفيه' : isEs ? 'Entretenimiento'
          : isFr
          ? 'Divertissement'
          : isPt
          ? 'Entretenimento'
          : isRu
          ? 'Развлечения'
          : isHi
          ? 'मनोरंजन'

          : isZh
          ? '娱乐'
: 'Entertainment';
  String get interestHealth =>
      isAr ? 'صحة' : isEs ? 'Salud'
          : isFr
          ? 'Santé'
          : isPt
          ? 'Saúde'
          : isRu
          ? 'Здоровье'
          : isHi
          ? 'स्वास्थ्य'

          : isZh
          ? '健康'
: 'Health';
  String get interestWorld =>
      isAr ? 'عالمية' : isEs ? 'Mundo'
          : isFr
          ? 'Monde'
          : isPt
          ? 'Mundo'
          : isRu
          ? 'Мир'
          : isHi
          ? 'विश्व'

          : isZh
          ? '世界'
: 'World';

  // Home
  String get homeTodayTitle =>
      isAr ? 'أخبار اليوم لمستواك 🎯' : isEs ? 'Noticias de hoy para tu nivel 🎯' : "Today's News for Your Level 🎯";
  String get homeError =>
      isAr ? 'عذراً، حدث خطأ' : isEs ? 'Lo sentimos, algo salió mal'
          : isFr
          ? 'Désolé, une erreur s\'est produite'
          : isPt
          ? 'Desculpe, ocorreu um erro'
          : isRu
          ? 'Извините, произошла ошибка'
          : isHi
          ? 'माफ़ कीजिए, कुछ गड़बड़ हो गई।'

          : isZh
          ? '抱歉，出现了一些问题'
: 'Sorry, something went wrong';
  String get homeErrorDetail =>
      isAr ? 'تحقق من اتصالك بالإنترنت' : isEs ? 'Verifica tu conexión a internet'
          : isFr
          ? 'Vérifiez votre connexion Internet'
          : isPt
          ? 'Verifique a sua ligação à Internet'
          : isRu
          ? 'Проверьте подключение к Интернету'
          : isHi
          ? 'अपना इंटरनेट कनेक्शन जांचें'

          : isZh
          ? '请检查您的网络连接'
: 'Check your internet connection';
  String get homeRetry =>
      isAr ? 'حاول مرة ثانية' : isEs ? 'Reintentar'
          : isFr
          ? 'Réessayer'
          : isPt
          ? 'Tentar novamente'
          : isRu
          ? 'Повторить попытку'
          : isHi
          ? 'दोबारा प्रयास करें'

          : isZh
          ? '重试'
: 'Retry';
  String get homeEmpty =>
      isAr ? 'ما في أخبار هلأ' : isEs ? 'No hay noticias ahora'
          : isFr
          ? 'Pas d\'actualités pour le moment'
          : isPt
          ? 'Não há notícias neste momento'
          : isRu
          ? 'На данный момент новостей нет'
          : isHi
          ? 'अभी कोई खबर नहीं'

          : isZh
          ? '目前没有新闻'
: 'No news right now';
  String get homeEmptyDetail =>
      isAr ? 'جرب تغير التصنيف أو ارجع بعدين'
          : isEs ? 'Prueba una categoría diferente o vuelve más tarde'

          : isFr
          ? 'Essayez une autre catégorie ou revenez plus tard'
          : isPt
          ? 'Experimenta uma categoria diferente ou volta mais tarde'
          : isRu
          ? 'Попробуйте выбрать другую категорию или зайдите позже'
          : isHi
          ? 'एक अलग श्रेणी आज़माएँ या बाद में वापस आएँ'

          : isZh
          ? '请尝试其他分类，或者稍后再试'
: 'Try a different category or come back later';
  String get searchHint =>
      isAr ? '🔍  ابحث عن كلمة...' : isEs ? '🔍  Busca una palabra...'
          : isFr
          ? '🔍  Rechercher un mot...'
          : isPt
          ? '🔍  Pesquisar uma palavra...'
          : isRu
          ? '🔍  Найти слово...'
          : isHi
          ? '🔍 किसी शब्द की खोज करें...'

          : isZh
          ? '🔍  搜索一个词……'
: '🔍  Search for a word...';
  String get searchArticlesHint =>
      isAr ? '🔍 بحث عن مقالات...' : isEs ? '🔍 Buscar artículos...'
          : isFr
          ? '🔍 Rechercher des articles...'
          : isPt
          ? '🔍 Pesquisar artigos...'
          : isRu
          ? '🔍 Поиск статей...'
          : isHi
          ? '🔍 लेख खोजें...'

          : isZh
          ? '🔍 搜索文章...'
: '🔍 Search articles...';
  String get searchEmptyTitle =>
      isAr ? 'ابحث عن مقالات' : isEs ? 'Buscar artículos'
          : isFr
          ? 'Rechercher des articles'
          : isPt
          ? 'Pesquisar artigos'
          : isRu
          ? 'Поиск статей'
          : isHi
          ? 'लेख खोजें'

          : isZh
          ? '搜索文章'
: 'Search Articles';
  String get searchEmptySub =>
      isAr ? 'ابدأ بالبحث لاكتشاف مقالات جديدة' : isEs ? 'Empieza a buscar para descubrir nuevos artículos'
          : isFr
          ? 'Lancez une recherche pour découvrir de nouveaux articles'
          : isPt
          ? 'Começa a pesquisar para descobrir novos artigos'
          : isRu
          ? 'Начните поиск, чтобы найти новые статьи'
          : isHi
          ? 'नए लेख खोजने के लिए खोज शुरू करें'

          : isZh
          ? '开始搜索，发现新文章'
: 'Start searching to discover new articles';
  String get searchRecent =>
      isAr ? 'عمليات البحث الأخيرة' : isEs ? 'Búsquedas recientes'
          : isFr
          ? 'Recherches récentes'
          : isPt
          ? 'Pesquisas recentes'
          : isRu
          ? 'Последние поисковые запросы'
          : isHi
          ? 'हाल की खोजें'

          : isZh
          ? '最近的搜索'
: 'Recent Searches';
  String searchResults(int n, String q) =>
      isAr ? '$n نتيجة لـ "$q"' : isEs ? '$n resultados para "$q"'
          : isFr
          ? '$n résultats pour « $q »'
          : isPt
          ? '$n resultados para "$q"'
          : isRu
          ? '$n результатов по запросу «$q»'
          : isHi
          ? '"$q" के लिए $n परिणाम'

          : isZh
          ? '搜索“$q”共获得 $n 条结果'
: '$n results for "$q"';
  String get searchNoResults =>
      isAr ? 'ما في نتائج' : isEs ? 'Sin resultados'
          : isFr
          ? 'Aucun résultat trouvé'
          : isPt
          ? 'Não foram encontrados resultados'
          : isRu
          ? 'Результаты не найдены'
          : isHi
          ? 'कोई परिणाम नहीं मिला'

          : isZh
          ? '未找到结果'
: 'No results found';
  String get searchNoResultsDetail =>
      isAr ? 'جرب كلمات بحث مختلفة' : isEs ? 'Prueba diferentes términos de búsqueda'
          : isFr
          ? 'Essayez différents termes de recherche'
          : isPt
          ? 'Experimente utilizar termos de pesquisa diferentes'
          : isRu
          ? 'Попробуйте ввести другие поисковые запросы'
          : isHi
          ? 'विभिन्न खोज शब्द आज़माएँ'

          : isZh
          ? '尝试不同的搜索词'
: 'Try different search terms';

  // Article
  String get articleListen =>
      isAr ? '🔊 استمع' : isEs ? '🔊 Escuchar'
          : isFr
          ? '🔊 Écouter'
          : isPt
          ? '🔊 Ouvir'
          : isRu
          ? '🔊 Прослушать'
          : isHi
          ? '🔊 सुनें'

          : isZh
          ? '🔊 收听'
: '🔊 Listen';
  String get articleLoading =>
      isAr ? 'جاري التحميل...' : isEs ? 'Cargando...'
          : isFr
          ? 'Chargement en cours...'
          : isPt
          ? 'A carregar...'
          : isRu
          ? 'Загрузка...'
          : isHi
          ? 'लोड हो रहा है...'

          : isZh
          ? '正在加载...'
: 'Loading...';
  String get articlePlaying =>
      isAr ? 'الاستماع الآن' : isEs ? 'Reproduciendo ahora'
          : isFr
          ? 'En cours de lecture'
          : isPt
          ? 'A tocar agora'
          : isRu
          ? 'Сейчас в эфире'
          : isHi
          ? 'अब चल रहा है'

          : isZh
          ? '正在播放'
: 'Now Playing';
  String get articleNoAudio =>
      isAr ? 'لا يوجد ملف صوتي لهذا المقال' : isEs ? 'No hay audio disponible para este artículo'
          : isFr
          ? 'Aucun fichier audio n\'est disponible pour cet article'
          : isPt
          ? 'Não há áudio disponível para este artigo'
          : isRu
          ? 'Аудиозапись для этой статьи отсутствует'
          : isHi
          ? 'इस लेख के लिए कोई ऑडियो उपलब्ध नहीं है।'

          : isZh
          ? '本文无音频'
: 'No audio available for this article';
  String get articleNotFound =>
      isAr ? 'المقال غير موجود' : isEs ? 'Artículo no encontrado'
          : isFr
          ? 'Article introuvable'
          : isPt
          ? 'Artigo não encontrado'
          : isRu
          ? 'Статья не найдена'
          : isHi
          ? 'लेख नहीं मिला'

          : isZh
          ? '未找到该文章'
: 'Article not found';
  String get articleError =>
      isAr ? 'فشل تحميل المقالات. تحقق من اتصالك بالإنترنت.'
          : isEs ? 'Error al cargar artículos. Verifica tu conexión.'

          : isFr
          ? 'Impossible de charger les articles. Vérifiez votre connexion.'
          : isPt
          ? 'Não foi possível carregar os artigos. Verifique a sua ligação.'
          : isRu
          ? 'Не удалось загрузить статьи. Проверьте подключение.'
          : isHi
          ? 'लेख लोड करने में विफल। अपना कनेक्शन जांचें।'

          : isZh
          ? '无法加载文章。请检查您的网络连接。'
: 'Failed to load articles. Check your connection.';
  String get articleQuizError =>
      isAr ? 'فشل تحميل الاختبار. تحقق من اتصالك بالإنترنت.'
          : isEs ? 'Error al cargar el cuestionario. Verifica tu conexión.'

          : isFr
          ? 'Impossible de charger le quiz. Vérifiez votre connexion.'
          : isPt
          ? 'Não foi possível carregar o questionário. Verifique a sua ligação.'
          : isRu
          ? 'Не удалось загрузить тест. Проверьте подключение.'
          : isHi
          ? 'क्विज़ लोड करने में असफल रहा। अपना कनेक्शन जांचें।'

          : isZh
          ? '无法加载测验。请检查您的网络连接。'
: 'Failed to load quiz. Check your connection.';
  String get articleNoQuiz =>
      isAr ? 'لا توجد أسئلة لهذا المقال'
          : isEs ? 'No hay preguntas para este artículo'

          : isFr
          ? 'Aucune question concernant cet article'
          : isPt
          ? 'Não há perguntas sobre este artigo'
          : isRu
          ? 'Вопросов к этой статье нет'
          : isHi
          ? 'इस लेख के लिए कोई प्रश्न नहीं हैं।'

          : isZh
          ? '本文没有相关问题'
: 'No questions for this article';
  String get vocabBookmarked =>
      isAr ? 'تم حفظ الكلمات 💾' : isEs ? 'Palabras guardadas 💾'
          : isFr
          ? 'Mots enregistrés 💾'
          : isPt
          ? 'Palavras guardadas 💾'
          : isRu
          ? 'Сохраненные слова 💾'
          : isHi
          ? 'शब्द सहेजे गए 💾'

          : isZh
          ? '保存的单词 💾'
: 'Words saved 💾';
  String get articleBookmarked =>
      isAr ? 'تمت الإضافة إلى المحفوظات 🔖' : isEs ? 'Añadido a marcadores 🔖'
          : isFr
          ? 'Ajouté aux favoris 🔖'
          : isPt
          ? 'Adicionado aos favoritos 🔖'
          : isRu
          ? 'Добавлено в закладки 🔖'
          : isHi
          ? 'Added to bookmarks 🔖'

          : isZh
          ? '已添加到书签 🔖'
: 'Added to bookmarks 🔖';
  String get articleUnbookmarked =>
      isAr ? 'تمت الإزالة من المحفوظات' : isEs ? 'Eliminado de marcadores'
          : isFr
          ? 'Supprimé des favoris'
          : isPt
          ? 'Removido dos favoritos'
          : isRu
          ? 'Удалено из закладок'
          : isHi
          ? 'बुकमार्क से हटाया गया'

          : isZh
          ? '已从书签中移除'
: 'Removed from bookmarks';

  // Category Labels
  String get categoryGeneral =>
      isAr ? 'عام' : isEs ? 'General'
          : isFr
          ? 'Généralités'
          : isPt
          ? 'Geral'
          : isRu
          ? 'Общие сведения'
          : isHi
          ? 'सामान्य'

          : isZh
          ? '概述'
: 'General';
  String get categorySports =>
      isAr ? 'رياضة' : isEs ? 'Deportes'
          : isFr
          ? 'Sports'
          : isPt
          ? 'Desporto'
          : isRu
          ? 'Спорт'
          : isHi
          ? 'खेल'

          : isZh
          ? '体育'
: 'Sports';
  String get categoryTechnology =>
      isAr ? 'تكنولوجيا' : isEs ? 'Tecnología'
          : isFr
          ? 'Technologie'
          : isPt
          ? 'Tecnologia'
          : isRu
          ? 'Технологии'
          : isHi
          ? 'प्रौद्योगिकी'

          : isZh
          ? '技术'
: 'Technology';
  String get categoryBusiness =>
      isAr ? 'أعمال' : isEs ? 'Negocios'
          : isFr
          ? 'Affaires'
          : isPt
          ? 'Negócios'
          : isRu
          ? 'Бизнес'
          : isHi
          ? 'व्यवसाय'

          : isZh
          ? '商业'
: 'Business';
  String get categoryScience =>
      isAr ? 'علوم' : isEs ? 'Ciencia'
          : isFr
          ? 'Sciences'
          : isPt
          ? 'Ciência'
          : isRu
          ? 'Наука'
          : isHi
          ? 'विज्ञान'

          : isZh
          ? '科学'
: 'Science';
  String get categoryEntertainment =>
      isAr ? 'ترفيه' : isEs ? 'Entretenimiento'
          : isFr
          ? 'Divertissement'
          : isPt
          ? 'Entretenimento'
          : isRu
          ? 'Развлечения'
          : isHi
          ? 'मनोरंजन'

          : isZh
          ? '娱乐'
: 'Entertainment';

  String categoryLabel(String key) {
    switch (key) {
      case 'general':
        return categoryGeneral;
      case 'sports':
        return categorySports;
      case 'technology':
        return categoryTechnology;
      case 'business':
        return categoryBusiness;
      case 'science':
        return categoryScience;
      case 'entertainment':
        return categoryEntertainment;
      default:
        return key;
    }
  }

  // Relative Time
  String relativeTimeMinutes(int n) =>
      isAr ? 'منذ $n دقيقة' : isEs ? 'hace $n minutos'
          : isFr
          ? 'Il y a $n minutes'
          : isPt
          ? 'Há $n minutos'
          : isRu
          ? '$n минут назад'
          : isHi
          ? '$n मिनट पहले'

          : isZh
          ? '$n 分钟前'
: '$n minutes ago';
  String relativeTimeHours(int n) =>
      isAr ? 'منذ $n ساعات' : isEs ? 'hace $n horas'
          : isFr
          ? 'Il y a $n heures'
          : isPt
          ? 'Há $n horas'
          : isRu
          ? '$n часов назад'
          : isHi
          ? '$n घंटे पहले'

          : isZh
          ? '$n 小时前'
: '$n hours ago';
  String relativeTimeDays(int n) =>
      isAr ? 'منذ $n أيام' : isEs ? 'hace $n días'
          : isFr
          ? 'Il y a $n jours'
          : isPt
          ? 'Há $n dias'
          : isRu
          ? '$n дней назад'
          : isHi
          ? '$n दिन पहले'

          : isZh
          ? '$n天前'
: '$n days ago';

  // Word Definition Sheet
  String get wordDefinition =>
      isAr ? '📖 التعريف' : isEs ? '📖 Definición'
          : isFr
          ? '📖 Définition'
          : isPt
          ? '📖 Definição'
          : isRu
          ? '📖 Определение'
          : isHi
          ? '📖 Definition'

          : isZh
          ? '📖 定义'
: '📖 Definition';
  String get wordExamples =>
      isAr ? '💬 أمثلة' : isEs ? '💬 Ejemplos'
          : isFr
          ? '💬 Exemples'
          : isPt
          ? '💬 Exemplos'
          : isRu
          ? '💬 Примеры'
          : isHi
          ? '💬 उदाहरण'

          : isZh
          ? '💬 示例'
: '💬 Examples';
  String get wordSynonyms =>
      isAr ? '🔗 مرادفات' : isEs ? '🔗 Sinónimos'
          : isFr
          ? '🔗 Synonymes'
          : isPt
          ? '🔗 Sinónimos'
          : isRu
          ? '🔗 Синонимы'
          : isHi
          ? '🔗 पर्यायवाची'

          : isZh
          ? '🔗 同义词'
: '🔗 Synonyms';
  String get wordSave =>
      isAr ? 'احفظ الكلمة' : isEs ? 'Guardar palabra'
          : isFr
          ? 'Enregistrer dans Word'
          : isPt
          ? 'Guardar no Word'
          : isRu
          ? 'Сохранить в формате Word'
          : isHi
          ? 'वर्ड सहेजें'

          : isZh
          ? '保存 Word'
: 'Save Word';
  String get wordListen =>
      isAr ? 'استمع للنطق' : isEs ? 'Escuchar pronunciación'
          : isFr
          ? 'Écouter la prononciation'
          : isPt
          ? 'Ouvir a pronúncia'
          : isRu
          ? 'Прослушать произношение'
          : isHi
          ? 'उच्चारण सुनें'

          : isZh
          ? '收听发音'
: 'Listen to Pronunciation';
  String get wordSaved =>
      isAr ? 'تم حفظ الكلمة ✅' : isEs ? 'Palabra guardada ✅'
          : isFr
          ? 'Mot enregistré ✅'
          : isPt
          ? 'Palavra guardada ✅'
          : isRu
          ? 'Слово сохранено ✅'
          : isHi
          ? 'शब्द सहेजा गया ✅'

          : isZh
          ? '单词已保存 ✅'
: 'Word Saved ✅';

  // Vocabulary Detail
  String get vocabDetailTitle =>
      isAr ? 'تفاصيل الكلمة' : isEs ? 'Detalles de la palabra'
          : isFr
          ? 'Détails du mot'
          : isPt
          ? 'Detalhes da palavra'
          : isRu
          ? 'Сведения о слове'
          : isHi
          ? 'शब्द विवरण'

          : isZh
          ? '词条详情'
: 'Word Details';
  String get vocabReview =>
      isAr ? 'مراجعة' : isEs ? 'Revisar'
          : isFr
          ? 'Critique'
          : isPt
          ? 'Crítica'
          : isRu
          ? 'Обзор'
          : isHi
          ? 'समीक्षा'

          : isZh
          ? '评论'
: 'Review';
  String get vocabShare =>
      isAr ? 'مشاركة' : isEs ? 'Compartir'
          : isFr
          ? 'Partager'
          : isPt
          ? 'Partilhar'
          : isRu
          ? 'Поделиться'
          : isHi
          ? 'साझा करें'

          : isZh
          ? '分享'
: 'Share';
  String get vocabListen =>
      isAr ? 'استمع للنطق' : isEs ? 'Escuchar pronunciación'
          : isFr
          ? 'Écouter la prononciation'
          : isPt
          ? 'Ouvir a pronúncia'
          : isRu
          ? 'Прослушать произношение'
          : isHi
          ? 'उच्चारण सुनें'

          : isZh
          ? '收听发音'
: 'Listen to Pronunciation';
  String get vocabExamples =>
      isAr ? '💬 أمثلة' : isEs ? '💬 Ejemplos'
          : isFr
          ? '💬 Exemples'
          : isPt
          ? '💬 Exemplos'
          : isRu
          ? '💬 Примеры'
          : isHi
          ? '💬 उदाहरण'

          : isZh
          ? '💬 示例'
: '💬 Examples';
  String get vocabSynonyms =>
      isAr ? '🔗 مرادفات' : isEs ? '🔗 Sinónimos'
          : isFr
          ? '🔗 Synonymes'
          : isPt
          ? '🔗 Sinónimos'
          : isRu
          ? '🔗 Синонимы'
          : isHi
          ? '🔗 पर्यायवाची'

          : isZh
          ? '🔗 同义词'
: '🔗 Synonyms';
  String get vocabSimilar =>
      isAr ? '📚 كلمات مشابهة' : isEs ? '📚 Palabras similares'
          : isFr
          ? '📚 Mots similaires'
          : isPt
          ? '📚 Palavras semelhantes'
          : isRu
          ? '📚 Похожие слова'
          : isHi
          ? '📚 समान शब्द'

          : isZh
          ? '📚 相似词'
: '📚 Similar Words';

  // Flashcards
  String get flashcardTitle =>
      isAr ? '📇 بطاقات' : isEs ? '📇 Tarjetas'
          : isFr
          ? '📇 Fiches de révision'
          : isPt
          ? '📇 Fichas de estudo'
          : isRu
          ? '📇 Карточки'
          : isHi
          ? '📇 फ्लैशकार्ड'

          : isZh
          ? '📇 单词卡'
: '📇 Flashcards';
  String flashcardRemaining(int n) =>
      isAr ? '$n متبقي' : isEs ? '$n restantes'
          : isFr
          ? 'Il reste $n'
          : isPt
          ? '$n restantes'
          : isRu
          ? 'Осталось $n'
          : isHi
          ? '$n शेष'

          : isZh
          ? '剩余 $n'
: '$n remaining';
  String get flashcardNeedReview =>
      isAr ? 'أحتاج مراجعة' : isEs ? 'Necesito repasar'
          : isFr
          ? 'À vérifier'
          : isPt
          ? 'Precisa de revisão'
          : isRu
          ? 'Требуется проверка'
          : isHi
          ? 'समीक्षा आवश्यक'

          : isZh
          ? '需要审核'
: 'Need Review';
  String get flashcardKnown =>
      isAr ? 'أعرفها' : isEs ? 'Lo sé'
          : isFr
          ? 'Je le sais'
          : isPt
          ? 'Eu sei disso'
          : isRu
          ? 'Я знаю это'
          : isHi
          ? 'मुझे पता है'

          : isZh
          ? '我知道'
: 'I Know It';
  String get flashcardTapToFlip =>
      isAr ? 'اضغط للقلب' : isEs ? 'Toca para girar'
          : isFr
          ? 'Appuyez pour retourner l\'image'
          : isPt
          ? 'Toque para virar'
          : isRu
          ? 'Нажмите, чтобы перевернуть'
          : isHi
          ? 'पलटने के लिए टैप करें'

          : isZh
          ? '轻点翻转'
: 'Tap to flip';
  String get flashcardError =>
      isAr ? 'فشل تحميل الكلمات المحفوظة.'
          : isEs ? 'Error al cargar las palabras guardadas.'

          : isFr
          ? 'Impossible de charger les mots enregistrés.'
          : isPt
          ? 'Não foi possível carregar as palavras guardadas.'
          : isRu
          ? 'Не удалось загрузить сохраненные слова.'
          : isHi
          ? 'सहेजे गए शब्द लोड करने में विफल।'

          : isZh
          ? '无法加载已保存的单词。'
: 'Failed to load saved words.';
  String get flashcardEmpty =>
      isAr ? 'لا توجد كلمات محفوظة.\nاحفظ كلمات من المقالات أولاً.'
          : isEs ? 'No hay palabras guardadas.\nGuarda palabras de los artículos primero.'

          : isFr
          ? 'Aucun mot enregistré.\nEnregistrez d\'abord les mots tirés des articles.'
          : isPt
          ? 'Não há palavras guardadas.\nGuarde primeiro as palavras dos artigos.'
          : isRu
          ? 'Слова не сохранены.\nСначала сохраните слова из статей.'
          : isHi
          ? 'कोई सहेजे गए शब्द नहीं।\nलेखों से पहले शब्द सहेजें।'

          : isZh
          ? '没有保存的词条。\n请先从文章中保存词条。'
: 'No saved words.\nSave words from articles first.';
  String get flashcardBrowse =>
      isAr ? 'استعرض المقالات' : isEs ? 'Explorar artículos'
          : isFr
          ? 'Parcourir les articles'
          : isPt
          ? 'Explorar artigos'
          : isRu
          ? 'Просмотреть статьи'
          : isHi
          ? 'लेख ब्राउज़ करें'

          : isZh
          ? '浏览文章'
: 'Browse Articles';
  String get flashcardWellDone =>
      isAr ? 'أحسنت! 🎊' : isEs ? '¡Bien hecho! 🎊'
          : isFr
          ? 'Bravo ! 🎊'
          : isPt
          ? 'Muito bem! 🎊'
          : isRu
          ? 'Отлично! 🎊'
          : isHi
          ? 'बहुत बढ़िया! 🎊'

          : isZh
          ? '干得漂亮！🎊'
: 'Well Done! 🎊';
  String get flashcardComplete =>
      isAr ? 'لقد أكملت جميع البطاقات'
          : isEs ? 'Completaste todas las tarjetas'

          : isFr
          ? 'Vous avez terminé toutes les cartes'
          : isPt
          ? 'Já completaste todas as cartas'
          : isRu
          ? 'Вы прошли все карты'
          : isHi
          ? 'आपने सभी कार्ड पूरे कर लिए हैं।'

          : isZh
          ? '您已集齐所有卡片'
: 'You completed all cards';
  String get flashcardBackHome =>
      isAr ? 'العودة للرئيسية' : isEs ? 'Volver al inicio'
          : isFr
          ? 'Retour à la page d\'accueil'
          : isPt
          ? 'Voltar à página inicial'
          : isRu
          ? 'Вернуться на главную страницу'
          : isHi
          ? 'होम पर वापस'

          : isZh
          ? '返回首页'
: 'Back to Home';
  String get flashcardRestart =>
      isAr ? 'أعد الكرة' : isEs ? 'Reiniciar'
          : isFr
          ? 'Redémarrer'
          : isPt
          ? 'Reiniciar'
          : isRu
          ? 'Перезапуск'
          : isHi
          ? 'पुनः आरंभ करें'

          : isZh
          ? '重新启动'
: 'Restart';
  String get flashcardForReview =>
      isAr ? 'للمراجعة' : isEs ? 'Para repasar'
          : isFr
          ? 'À relire'
          : isPt
          ? 'Para revisão'
          : isRu
          ? 'Для рассмотрения'
          : isHi
          ? 'समीक्षा के लिए'

          : isZh
          ? '供审阅'
: 'For Review';

  // Quiz
  String quizProgress(int current, int total) =>
      isAr ? 'سؤال $current من $total' : isEs ? 'Pregunta $current de $total'
          : isFr
          ? 'Question $current sur $total'
          : isPt
          ? 'Pergunta $current de $total'
          : isRu
          ? 'Вопрос № $current из $total'
          : isHi
          ? 'कुल का वर्तमान प्रश्न'

          : isZh
          ? '第 $current 题，共 $total 题'
: 'Question $current of $total';
  String get quizShowResults =>
      isAr ? 'عرض النتائج 🎉' : isEs ? 'Mostrar resultados 🎉'
          : isFr
          ? 'Afficher les résultats 🎉'
          : isPt
          ? 'Mostrar resultados 🎉'
          : isRu
          ? 'Показать результаты 🎉'
          : isHi
          ? 'परिणाम दिखाएँ 🎉'

          : isZh
          ? '显示结果 🎉'
: 'Show Results 🎉';
  String get quizNext =>
      isAr ? 'السؤال التالي ⬅️' : isEs ? 'Siguiente pregunta ⬅️'
          : isFr
          ? 'Question suivante ⬅️'
          : isPt
          ? 'Próxima pergunta ⬅️'
          : isRu
          ? 'Следующий вопрос ⬅️'
          : isHi
          ? 'अगला प्रश्न ⬅️'

          : isZh
          ? '下一题 ⬅️'
: 'Next Question ⬅️';
  String get quizTryAgain =>
      isAr ? 'حاول مرة ثانية' : isEs ? 'Intentar de nuevo'
          : isFr
          ? 'Réessayer'
          : isPt
          ? 'Tentar novamente'
          : isRu
          ? 'Попробуй ещё раз'
          : isHi
          ? 'Try Again'

          : isZh
          ? '重试'
: 'Try Again';
  String resultsTimeFormat(int minutes, int seconds) {
    if (minutes > 0) {
      return isAr ? '$minutesد $secondsث' : isEs ? '$minutes min $seconds s' : '$minutes min $seconds s';
    }
    return isAr ? '$secondsث' : isEs ? '$seconds s' : '$seconds s';
  }

  // Quiz Results
  String get resultsTitle =>
      isAr ? 'النتائج' : isEs ? 'Resultados'
          : isFr
          ? 'Résultats'
          : isPt
          ? 'Resultados'
          : isRu
          ? 'Результаты'
          : isHi
          ? 'परिणाम'

          : isZh
          ? '结果'
: 'Results';
  String get resultsExcellent =>
      isAr ? 'ممتاز! 🎉' : isEs ? '¡Excelente! 🎉'
          : isFr
          ? 'Excellent! 🎉'
          : isPt
          ? 'Excelente! 🎉'
          : isRu
          ? 'Отлично! 🎉'
          : isHi
          ? 'शानदार! 🎉'

          : isZh
          ? '太棒了！🎉'
: 'Excellent! 🎉';
  String get resultsGood =>
      isAr ? 'جيد 👍' : isEs ? 'Bien 👍'
          : isFr
          ? 'Bien 👍'
          : isPt
          ? 'Ótimo 👍'
          : isRu
          ? 'Хорошо 👍'
          : isHi
          ? 'अच्छा 👍'

          : isZh
          ? '不错 👍'
: 'Good 👍';
  String get resultsTryAgain =>
      isAr ? 'حاول مرة 💪' : isEs ? 'Inténtalo de nuevo 💪'
          : isFr
          ? 'Réessaie 💪'
          : isPt
          ? 'Tenta de novo 💪'
          : isRu
          ? 'Попробуй ещё раз 💪'
          : isHi
          ? 'फिर से कोशिश करें 💪'

          : isZh
          ? '再试一次 💪'
: 'Try Again 💪';
  String get resultsNewAchievement =>
      isAr ? 'إنجاز جديد!' : isEs ? '¡Nuevo logro!'
          : isFr
          ? 'Nouveau succès !'
          : isPt
          ? 'Nova conquista!'
          : isRu
          ? 'Новое достижение!'
          : isHi
          ? 'नई उपलब्धि!'

          : isZh
          ? '新成就！'
: 'New Achievement!';
  String get resultsAchievementDesc =>
      isAr ? 'حصلت على 80% أو أكثر في هذا الاختبار 🎊'
          : isEs ? 'Obtuviste un 80% o más en este cuestionario 🎊'

          : isFr
          ? 'Tu as obtenu un score de 80 % ou plus à ce quiz 🎊'
          : isPt
          ? 'Obteve uma pontuação de 80% ou mais neste questionário 🎊'
          : isRu
          ? 'Вы набрали 80 % или более в этом тесте 🎊'
          : isHi
          ? 'आपने इस क्विज़ में 80% या उससे अधिक अंक प्राप्त किए 🎊'

          : isZh
          ? '你在本次测验中得了80%或以上的分数 🎊'
: 'You scored 80% or more on this quiz 🎊';
  String get resultsCorrect =>
      isAr ? 'صحيح' : isEs ? 'Correcto'
          : isFr
          ? 'Correct'
          : isPt
          ? 'Correto'
          : isRu
          ? 'Правильно'
          : isHi
          ? 'सही'

          : isZh
          ? '正确'
: 'Correct';
  String get resultsWrong =>
      isAr ? 'خطأ' : isEs ? 'Incorrecto'
          : isFr
          ? 'Faux'
          : isPt
          ? 'Errado'
          : isRu
          ? 'Неверно'
          : isHi
          ? 'गलत'

          : isZh
          ? '错误'
: 'Wrong';
  String get resultsTime =>
      isAr ? 'الوقت' : isEs ? 'Tiempo'
          : isFr
          ? 'Heure'
          : isPt
          ? 'Hora'
          : isRu
          ? 'Время'
          : isHi
          ? 'समय'

          : isZh
          ? '时间'
: 'Time';
  String get resultsDetails =>
      isAr ? '📋 تفاصيل الأسئلة' : isEs ? '📋 Detalles de preguntas'
          : isFr
          ? '📋 Détails de la question'
          : isPt
          ? '📋 Detalhes da pergunta'
          : isRu
          ? '📋 Подробности вопроса'
          : isHi
          ? '📋 प्रश्न विवरण'

          : isZh
          ? '📋 问题详情'
: '📋 Question Details';
  String resultsQuestionNum(int n) =>
      isAr ? 'سؤال $n' : isEs ? 'Pregunta $n'
          : isFr
          ? 'Question $n'
          : isPt
          ? 'Questão $n'
          : isRu
          ? 'Вопрос № $n'
          : isHi
          ? 'प्रश्न $n'

          : isZh
          ? '第$n题'
: 'Question $n';
  String resultsAnswer(String answer) =>
      isAr ? 'الإجابة: $answer' : isEs ? 'Respuesta: $answer'
          : isFr
          ? 'Réponse : $answer'
          : isPt
          ? 'Resposta: $answer'
          : isRu
          ? 'Ответ: $answer'
          : isHi
          ? 'उत्तर: $answer'

          : isZh
          ? '答案：$answer'
: 'Answer: $answer';
  String get resultsBackToArticle =>
      isAr ? 'العودة للخبر' : isEs ? 'Volver al artículo'
          : isFr
          ? 'Retour à l\'article'
          : isPt
          ? 'Voltar ao artigo'
          : isRu
          ? 'Вернуться к статье'
          : isHi
          ? 'लेख पर वापस'

          : isZh
          ? '返回文章'
: 'Back to Article';
  String get resultsReviewWords =>
      isAr ? 'مراجعة الكلمات' : isEs ? 'Repasar palabras'
          : isFr
          ? 'Mots-clés de l\'évaluation'
          : isPt
          ? 'Palavras de revisão'
          : isRu
          ? 'Слова для повторения'
          : isHi
          ? 'समीक्षा शब्द'

          : isZh
          ? '复习词汇'
: 'Review Words';
  String get resultsShare =>
      isAr ? 'مشاركة النتيجة' : isEs ? 'Compartir resultado'
          : isFr
          ? 'Partager le résultat'
          : isPt
          ? 'Partilhar resultado'
          : isRu
          ? 'Поделиться результатом'
          : isHi
          ? 'परिणाम साझा करें'

          : isZh
          ? '分享结果'
: 'Share Result';

  // Pronunciation
  String get pronunciationTitle =>
      isAr ? 'تدرب على النطق' : isEs ? 'Práctica de pronunciación'
          : isFr
          ? 'Exercices de prononciation'
          : isPt
          ? 'Prática de pronúncia'
          : isRu
          ? 'Практика произношения'
          : isHi
          ? 'उच्चारण अभ्यास'

          : isZh
          ? '发音练习'
: 'Pronunciation Practice';
  String get pronunciationHint =>
      isAr ? 'قل الكلمة بصوت عالٍ 🗣️' : isEs ? 'Di la palabra en voz alta 🗣️'
          : isFr
          ? 'Dis ce mot à voix haute 🗣️'
          : isPt
          ? 'Diz a palavra em voz alta 🗣️'
          : isRu
          ? 'Произнесите это слово вслух 🗣️'
          : isHi
          ? 'शब्द को ज़ोर से बोलें 🗣️'

          : isZh
          ? '把这个词大声读出来 🗣️'
: 'Say the word aloud 🗣️';
  String get pronunciationStop =>
      isAr ? 'اضغط للإيقاف' : isEs ? 'Toca para detener'
          : isFr
          ? 'Appuyez pour arrêter'
          : isPt
          ? 'Toque para parar'
          : isRu
          ? 'Нажмите, чтобы остановиться'
          : isHi
          ? 'रोकने के लिए टैप करें'

          : isZh
          ? '轻点停止'
: 'Tap to Stop';
  String get pronunciationRecord =>
      isAr ? 'اضغط للتسجيل' : isEs ? 'Toca para grabar'
          : isFr
          ? 'Appuyez pour enregistrer'
          : isPt
          ? 'Toque para gravar'
          : isRu
          ? 'Нажмите, чтобы начать запись'
          : isHi
          ? 'रिकॉर्ड करने के लिए टैप करें'

          : isZh
          ? '点击录制'
: 'Tap to Record';
  String get pronunciationTryAgain =>
      isAr ? 'حاول مرة' : isEs ? 'Intentar de nuevo'
          : isFr
          ? 'Réessayer'
          : isPt
          ? 'Tentar novamente'
          : isRu
          ? 'Попробуй ещё раз'
          : isHi
          ? 'Try Again'

          : isZh
          ? '重试'
: 'Try Again';
  String get pronunciationNext =>
      isAr ? 'كلمة تالية' : isEs ? 'Siguiente palabra'
          : isFr
          ? 'Mot suivant'
          : isPt
          ? 'Próxima palavra'
          : isRu
          ? 'Следующее слово'
          : isHi
          ? 'अगला शब्द'

          : isZh
          ? '下一个单词'
: 'Next Word';
  String get pronunciationExcellent =>
      isAr ? 'نطق رائع! حافظ على هذا المستوى 💪'
          : isEs ? '¡Excelente pronunciación! Sigue así 💪'

          : isFr
          ? 'Super prononciation ! Continue comme ça 💪'
          : isPt
          ? 'Excelente pronúncia! Continua assim 💪'
          : isRu
          ? 'Отличное произношение! Так держать 💪'
          : isHi
          ? 'बहुत बढ़िया उच्चारण! ऐसे ही जारी रखो 💪'

          : isZh
          ? '发音真棒！继续保持 💪'
: 'Great pronunciation! Keep it up 💪';
  String get pronunciationGood =>
      isAr ? 'انتبه للمقطع المشدد في الكلمة'
          : isEs ? 'Presta atención a la sílaba tónica'

          : isFr
          ? 'Faites attention à la syllabe accentuée'
          : isPt
          ? 'Presta atenção à sílaba tônica'
          : isRu
          ? 'Обратите внимание на ударный слог'
          : isHi
          ? 'उच्चारण पर जोर वाले अक्षर पर ध्यान दें।'

          : isZh
          ? '注意重读音节'
: 'Pay attention to the stressed syllable';
  String get pronunciationKeepTrying =>
      isAr ? 'حاول تقليد النطق ببطء، مقطع مقطع'
          : isEs ? 'Intenta imitar lentamente, sílaba por sílaba'

          : isFr
          ? 'Essaie d\'imiter lentement, syllabe par syllabe'
          : isPt
          ? 'Tenta imitar devagar, sílaba a sílaba'
          : isRu
          ? 'Попробуйте повторять медленно, по слогам'
          : isHi
          ? 'धीरे-धीरे, अक्षर-अक्षर करके नकल करने की कोशिश करें।'

          : isZh
          ? '试着慢慢模仿，一个音节一个音节地来'
: 'Try imitating slowly, syllable by syllable';
  String get pronunciationAnalyzing =>
      isAr ? 'يتم التحليل...' : isEs ? 'Analizando...'
          : isFr
          ? 'Analyse en cours...'
          : isPt
          ? 'A analisar...'
          : isRu
          ? 'Анализ...'
          : isHi
          ? 'विश्लेषण...'

          : isZh
          ? '正在分析...'
: 'Analyzing...';

  // Vocabulary Page
  String get vocabTodayTab =>
      isAr ? '🌟 كلمات اليوم' : isEs ? '🌟 Palabras de hoy' : "🌟 Today's Words";
  String get vocabMyWordsTab =>
      isAr ? '📚 كلماتي' : isEs ? '📚 Mis palabras'
          : isFr
          ? '📚 Mes mots'
          : isPt
          ? '📚 As minhas palavras'
          : isRu
          ? '📚 «Мои слова»'
          : isHi
          ? '📚 मेरे शब्द'

          : isZh
          ? '📚 我的话'
: '📚 My Words';
  String get vocabTitle =>
      isAr ? 'مفرداتي' : isEs ? 'Mi vocabulario'
          : isFr
          ? 'Mon vocabulaire'
          : isPt
          ? 'O meu vocabulário'
          : isRu
          ? 'Мой словарный запас'
          : isHi
          ? 'मेरी शब्दावली'

          : isZh
          ? '我的词汇'
: 'My Vocabulary';
  String get vocabError =>
      isAr ? 'حدث خطأ في تحميل الكلمات'
          : isEs ? 'Error al cargar las palabras'

          : isFr
          ? 'Erreur lors du chargement des mots'
          : isPt
          ? 'Erro ao carregar as palavras'
          : isRu
          ? 'Ошибка при загрузке слов'
          : isHi
          ? 'शब्द लोड करने में त्रुटि'

          : isZh
          ? '加载单词时出错'
: 'Error loading words';
  String get vocabRetry =>
      isAr ? 'إعادة المحاولة' : isEs ? 'Reintentar'
          : isFr
          ? 'Réessayer'
          : isPt
          ? 'Tentar novamente'
          : isRu
          ? 'Повторить попытку'
          : isHi
          ? 'दोबारा प्रयास करें'

          : isZh
          ? '重试'
: 'Retry';
  String get vocabEmpty =>
      isAr ? 'ما في كلمات محفوظة' : isEs ? 'No hay palabras guardadas'
          : isFr
          ? 'Aucun mot enregistré'
          : isPt
          ? 'Sem palavras guardadas'
          : isRu
          ? 'Нет сохраненных слов'
          : isHi
          ? 'कोई सहेजे हुए शब्द नहीं'

          : isZh
          ? '没有保存的词条'
: 'No saved words';
  String get vocabNoResults =>
      isAr ? 'ما في نتائج للبحث' : isEs ? 'Sin resultados de búsqueda'
          : isFr
          ? 'Aucun résultat de recherche'
          : isPt
          ? 'Não foram encontrados resultados'
          : isRu
          ? 'Результаты поиска отсутствуют'
          : isHi
          ? 'कोई खोज परिणाम नहीं'

          : isZh
          ? '没有搜索结果'
: 'No search results';

  // Dashboard
  String get dashboardTitle =>
      isAr ? '📊 تقدمك' : isEs ? '📊 Tu progreso'
          : isFr
          ? '📊 Vos progrès'
          : isPt
          ? '📊 O teu progresso'
          : isRu
          ? '📊 Ваш прогресс'
          : isHi
          ? '📊 आपकी प्रगति'

          : isZh
          ? '📊 您的进度'
: '📊 Your Progress';
  String get dashboardStats =>
      isAr ? '📈 إحصائيات سريعة' : isEs ? '📈 Estadísticas rápidas'
          : isFr
          ? '📈 Chiffres clés'
          : isPt
          ? '📈 Estatísticas rápidas'
          : isRu
          ? '📈 Краткая статистика'
          : isHi
          ? '📈 त्वरित आँकड़े'

          : isZh
          ? '📈 快速数据'
: '📈 Quick Stats';
  String get dashboardWeekly =>
      isAr ? '📅 النشاط الأسبوعي' : isEs ? '📅 Actividad semanal'
          : isFr
          ? '📅 Activité hebdomadaire'
          : isPt
          ? '📅 Atividade semanal'
          : isRu
          ? '📅 Еженедельные мероприятия'
          : isHi
          ? '📅 साप्ताहिक गतिविधि'

          : isZh
          ? '📅 本周活动'
: '📅 Weekly Activity';
  String get dashboardToday =>
      isAr ? '✅ نشاط اليوم' : isEs ? '✅ Actividad de hoy' : "✅ Today's Activity";
  String get dashboardComparison =>
      isAr ? '📊 مقارنة الأسبوع' : isEs ? '📊 Comparación semanal'
          : isFr
          ? '📊 Comparaison hebdomadaire'
          : isPt
          ? '📊 Comparação semanal'
          : isRu
          ? '📊 Сравнение по неделям'
          : isHi
          ? '📊 साप्ताहिक तुलना'

          : isZh
          ? '📊 周对比'
: '📊 Week Comparison';
  String get dashboardLevelProgress =>
      isAr ? '⭐ التقدم للمستوى التالي' : isEs ? '⭐ Progreso al siguiente nivel'
          : isFr
          ? '⭐ Des progrès d\'un niveau supérieur'
          : isPt
          ? '⭐ Progresso de nível superior'
          : isRu
          ? '⭐ Прогресс на новый уровень'
          : isHi
          ? '⭐ अगली कड़ी प्रगति'

          : isZh
          ? '⭐ 更上一层楼'
: '⭐ Next Level Progress';
  String get dashboardLearningTime =>
      isAr ? '⏱ وقت التعلم' : isEs ? '⏱ Tiempo de aprendizaje'
          : isFr
          ? '⏱ Durée de l\'apprentissage'
          : isPt
          ? '⏱ Tempo de aprendizagem'
          : isRu
          ? '⏱ Время обучения'
          : isHi
          ? '⏱ सीखने का समय'

          : isZh
          ? '⏱ 学习时间'
: '⏱ Learning Time';
  String points(int n) =>
      isAr ? '$n نقطة' : isEs ? '$n pts'
          : isFr
          ? '$n points'
          : isPt
          ? '$n pontos'
          : isRu
          ? '$n точек'
          : isHi
          ? '$n अंक'

          : isZh
          ? '$n 个点'
: '$n pts';
  List<String> get weekDaysAbbr => isAr
      ? ['س', 'ن', 'ث', 'ر', 'خ', 'ج', 'س']
      : isEs ? ['D', 'L', 'M', 'M', 'J', 'V', 'S']
      : ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  String get streakDays =>
      isAr ? 'أيام متتالية' : isEs ? 'Días consecutivos'
          : isFr
          ? 'Série de jours'
          : isPt
          ? 'Série de dias'
          : isRu
          ? 'Количество дней подряд'
          : isHi
          ? 'दिनों का सिलसिला'

          : isZh
          ? '连续天数'
: 'Days Streak';
  String get articlesRead =>
      isAr ? 'مقالات مقروءة' : isEs ? 'Artículos leídos'
          : isFr
          ? 'Articles lus'
          : isPt
          ? 'Artigos lidos'
          : isRu
          ? 'Прочитанные статьи'
          : isHi
          ? 'पढ़े गए लेख'

          : isZh
          ? '已阅读的文章'
: 'Articles Read';
  String get wordsSaved =>
      isAr ? 'كلمات محفوظة' : isEs ? 'Palabras guardadas'
          : isFr
          ? 'Mots enregistrés'
          : isPt
          ? 'Palavras guardadas'
          : isRu
          ? 'Сохраненные слова'
          : isHi
          ? 'बचाए गए शब्द'

          : isZh
          ? '已保存的单词'
: 'Words Saved';
  String get quizzesPassed =>
      isAr ? 'اختبارات ناجحة' : isEs ? 'Cuestionarios aprobados'
          : isFr
          ? 'Tests réussis'
          : isPt
          ? 'Testes concluídos com sucesso'
          : isRu
          ? 'Пройденные тесты'
          : isHi
          ? 'क्विज़ उत्तीर्ण'

          : isZh
          ? '已通过的测验'
: 'Quizzes Passed';
  String get thisWeek =>
      isAr ? 'هذا الأسبوع' : isEs ? 'Esta semana'
          : isFr
          ? 'Cette semaine'
          : isPt
          ? 'Esta semana'
          : isRu
          ? 'На этой неделе'
          : isHi
          ? 'इस सप्ताह'

          : isZh
          ? '本周'
: 'This Week';
  String get lastWeek =>
      isAr ? 'الأسبوع الماضي' : isEs ? 'La semana pasada'
          : isFr
          ? 'La semaine dernière'
          : isPt
          ? 'Na semana passada'
          : isRu
          ? 'На прошлой неделе'
          : isHi
          ? 'पिछला सप्ताह'

          : isZh
          ? '上周'
: 'Last Week';
  String get thisMonth =>
      isAr ? 'هذا الشهر' : isEs ? 'Este mes'
          : isFr
          ? 'Ce mois-ci'
          : isPt
          ? 'Este mês'
          : isRu
          ? 'В этом месяце'
          : isHi
          ? 'इस महीने'

          : isZh
          ? '本月'
: 'This Month';
  String get total =>
      isAr ? 'الإجمالي' : isEs ? 'Total'
          : isFr
          ? 'Total'
          : isPt
          ? 'Total'
          : isRu
          ? 'Итого'
          : isHi
          ? 'कुल'

          : isZh
          ? '总计'
: 'Total';
  String get hour =>
      isAr ? 'ساعة' : isEs ? 'h'
          : isFr
          ? 'M.'
          : isPt
          ? 'Sr.'
          : isRu
          ? 'г-н'
          : isHi
          ? 'श्री'

          : isZh
          ? 'hr'
: 'hr';
  String get hourLabel =>
      isAr ? 'ساعات التعلم' : isEs ? 'Horas de aprendizaje'
          : isFr
          ? 'Heures d\'apprentissage'
          : isPt
          ? 'Horas de aprendizagem'
          : isRu
          ? 'Учебные часы'
          : isHi
          ? 'सीखने के घंटे'

          : isZh
          ? '学习时长'
: 'Learning Hours';
  String remainingPoints(int n) =>
      isAr ? '$n نقطة متبقية للترقية'
          : isEs ? '$n pts restantes para el siguiente nivel'

          : isFr
          ? 'Il reste $n points pour passer au niveau suivant'
          : isPt
          ? 'Faltam $n pontos para o próximo nível'
          : isRu
          ? 'Осталось $n очков до следующего уровня'
          : isHi
          ? 'अगले स्तर के लिए $n अंक शेष हैं'

          : isZh
          ? '距离下一关还差 $n 分'
: '$n pts remaining for next level';
  String levelLabel(String level) =>
      isAr ? 'مستوى $level' : isEs ? 'Nivel $level'
          : isFr
          ? 'Niveau $level'
          : isPt
          ? 'Nível $level'
          : isRu
          ? 'Уровень $level'
          : isHi
          ? 'स्तर $level'

          : isZh
          ? '级别 $level'
: 'Level $level';
  String levelName(String level) {
    const ar = ['مبتدئ', 'أساسي', 'متوسط', 'فوق المتوسط', 'متقدم', 'خبير'];
    const es = ['Principiante', 'Elemental', 'Intermedio', 'Intermedio alto', 'Avanzado', 'Experto'];
    const en = ['Beginner', 'Elementary', 'Intermediate', 'Upper Intermediate', 'Advanced', 'Proficient'];
    final levels = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];
    final i = levels.indexOf(level);
    return i >= 0 ? (isAr ? ar[i] : isEs ? es[i] : en[i]) : level;
  }
  String get activityReadArticle =>
      isAr ? 'قراءة مقال' : isEs ? 'Leer artículo'
          : isFr
          ? 'Lire l\'article'
          : isPt
          ? 'Ler artigo'
          : isRu
          ? 'Прочитать статью'
          : isHi
          ? 'लेख पढ़ें'

          : isZh
          ? '阅读文章'
: 'Read Article';
  String get activityReadDetail =>
      isAr ? 'تابع القراءة لتحسين مستواك'
          : isEs ? 'Sigue leyendo para mejorar'

          : isFr
          ? 'Continuez à lire pour vous améliorer'
          : isPt
          ? 'Continua a ler para melhorares'
          : isRu
          ? 'Продолжайте читать, чтобы совершенствоваться'
          : isHi
          ? 'सुधारने के लिए पढ़ते रहें।'

          : isZh
          ? '继续阅读，不断进步'
: 'Keep reading to improve';
  String get activityQuiz =>
      isAr ? 'اختبار مفردات' : isEs ? 'Cuestionario de vocabulario'
          : isFr
          ? 'Quiz de vocabulaire'
          : isPt
          ? 'Teste de vocabulário'
          : isRu
          ? 'Тест по лексике'
          : isHi
          ? 'शब्दावली प्रश्नोत्तरी'

          : isZh
          ? '词汇测验'
: 'Vocabulary Quiz';
  String get activityQuizDetail =>
      isAr ? 'اختبر معرفتك' : isEs ? 'Pon a prueba tu conocimiento'
          : isFr
          ? 'Testez vos connaissances'
          : isPt
          ? 'Testa os teus conhecimentos'
          : isRu
          ? 'Проверьте свои знания'
          : isHi
          ? 'अपने ज्ञान का परीक्षण करें'

          : isZh
          ? '测试你的知识'
: 'Test your knowledge';
  String get activityFlashcards =>
      isAr ? 'مراجعة بطاقات' : isEs ? 'Repaso con tarjetas'
          : isFr
          ? 'Révision à l\'aide de fiches'
          : isPt
          ? 'Revisão com fichas de estudo'
          : isRu
          ? 'Повторение с помощью карточек'
          : isHi
          ? 'फ़्लैशकार्ड समीक्षा'

          : isZh
          ? '单词卡复习'
: 'Flashcard Review';
  String get activityFlashcardDetail =>
      isAr ? 'راجع الكلمات المحفوظة' : isEs ? 'Repasa las palabras guardadas'
          : isFr
          ? 'Réviser les mots enregistrés'
          : isPt
          ? 'Revisar palavras guardadas'
          : isRu
          ? 'Просмотреть сохраненные слова'
          : isHi
          ? 'Review saved words'

          : isZh
          ? '复习已保存的单词'
: 'Review saved words';
  String get activityPronunciation =>
      isAr ? 'تدريب نطق' : isEs ? 'Práctica de pronunciación'
          : isFr
          ? 'Exercices de prononciation'
          : isPt
          ? 'Prática de pronúncia'
          : isRu
          ? 'Практика произношения'
          : isHi
          ? 'उच्चारण अभ्यास'

          : isZh
          ? '发音练习'
: 'Pronunciation Practice';
  String get activityPronunciationDetail =>
      isAr ? 'حسن نطقك للكلمات' : isEs ? 'Mejora tu pronunciación'
          : isFr
          ? 'Améliorez votre prononciation'
          : isPt
          ? 'Melhora a tua pronúncia'
          : isRu
          ? 'Улучшите своё произношение'
          : isHi
          ? 'अपने उच्चारण में सुधार करें'

          : isZh
          ? '提高你的发音'
: 'Improve your pronunciation';

  // Streak
  String get streakTitle =>
      isAr ? '🔥 التسلسل' : isEs ? '🔥 Racha'
          : isFr
          ? '🔥 Série'
          : isPt
          ? '🔥 Streak'
          : isRu
          ? '🔥 Серия'
          : isHi
          ? '🔥 लय'

          : isZh
          ? '🔥 连胜'
: '🔥 Streak';
  String get streakStart =>
      isAr ? 'ابدأ رحلتك اليوم!' : isEs ? '¡Comienza tu viaje hoy!'
          : isFr
          ? 'Commencez votre aventure dès aujourd’hui !'
          : isPt
          ? 'Começa a tua jornada hoje mesmo!'
          : isRu
          ? 'Начните своё путешествие уже сегодня!'
          : isHi
          ? 'अपनी यात्रा आज ही शुरू करें!'

          : isZh
          ? '今天就开启您的旅程吧！'
: 'Start Your Journey Today!';
  String get streakPrompt =>
      isAr ? 'اقرأ أول خبر وابدأ تسلسلك 🔥' : isEs ? 'Lee tu primera noticia y comienza tu racha 🔥'
          : isFr
          ? 'Lis ton premier article et lance ta série 🔥'
          : isPt
          ? 'Lê a tua primeira notícia e começa a tua série 🔥'
          : isRu
          ? 'Прочитайте первую новость и начните свою серию 🔥'
          : isHi
          ? 'अपनी पहली खबर पढ़ें और अपनी स्ट्रीक शुरू करें 🔥'

          : isZh
          ? '阅读第一条新闻，开启你的连读记录 🔥'
: 'Read your first news and start your streak 🔥';
  String get streakReadNow =>
      isAr ? 'اقرأ خبر الآن' : isEs ? 'Leer una noticia ahora'
          : isFr
          ? 'Lire un article d\'actualité maintenant'
          : isPt
          ? 'Ler uma notícia agora'
          : isRu
          ? 'Прочитать новость прямо сейчас'
          : isHi
          ? 'अब एक समाचार पढ़ें'

          : isZh
          ? '立即阅读新闻'
: 'Read a News Now';
  String streakMessage(int days) {
    if (days >= 100) {
      return isAr
          ? 'أنت أسطورة حقيقية! 💎'
          : isEs ? '¡Eres una leyenda! 💎'
          : 'You\'re a true legend! 💎';
    }
    if (days >= 60) {
      return isAr
          ? 'التزامك مميز جداً! أنت قدوة 👑'
          : isEs ? '¡Compromiso increíble! Eres un modelo a seguir 👑'
          : 'Amazing commitment! You\'re a role model 👑';
    }
    if (days >= 30) {
      return isAr
          ? 'شهر كامل من التعلم! أنت رائع 🏆'
          : isEs ? '¡Un mes completo de aprendizaje! Eres increíble 🏆'
          : 'A full month of learning! You\'re awesome 🏆';
    }
    if (days >= 14) {
      return isAr
          ? 'أسبوعين مذهلين! استمر 🔥'
          : isEs ? '¡Dos semanas increíbles! Sigue así 🔥'
          : 'Amazing two weeks! Keep going 🔥';
    }
    if (days >= 7) {
      return isAr
          ? 'أسبوع كامل! بداية قوية 🎯'
          : isEs ? '¡Una semana completa! Buen comienzo 🎯'
          : 'A full week! Strong start 🎯';
    }
    return isAr
        ? 'كل يوم تتعلم شيء جديد! استمر 💪'
        : isEs ? '¡Cada día aprendes algo nuevo! Sigue así 💪'
        : 'Every day you learn something new! Keep it up 💪';
  }

  String get streakBest =>
      isAr ? '🏆 الأفضل: ' : isEs ? '🏆 Mejor: '
          : isFr
          ? '🏆 Le meilleur : '
          : isPt
          ? '🏆 O melhor: '
          : isRu
          ? '🏆 Лучшее: '
          : isHi
          ? '🏆 सर्वश्रेष्ठ: '

          : isZh
          ? '🏆 最佳：'
: '🏆 Best: ';
  String streakDaysCount(int n) =>
      isAr ? '$n يوم' : isEs ? '$n días'
          : isFr
          ? '$n jours'
          : isPt
          ? '$n dias'
          : isRu
          ? '$n дней'
          : isHi
          ? '$n दिन'

          : isZh
          ? '$n 天'
: '$n days';
  String streakNextMilestone(String label) =>
      isAr ? 'الهدف التالي: $label' : isEs ? 'Siguiente meta: $label'
          : isFr
          ? 'Prochain objectif : $label'
          : isPt
          ? 'Próximo objetivo: $label'
          : isRu
          ? 'Следующая цель: $label'
          : isHi
          ? 'अगला लक्ष्य: $label'

          : isZh
          ? '下一个目标：$label'
: 'Next Goal: $label';
  String get streakLast30 =>
      isAr ? '📅 آخر 30 يوم' : isEs ? '📅 Últimos 30 días'
          : isFr
          ? '📅 30 derniers jours'
          : isPt
          ? '📅 Últimos 30 dias'
          : isRu
          ? '📅 Последние 30 дней'
          : isHi
          ? '📅 पिछले 30 दिन'

          : isZh
          ? '📅 过去30天'
: '📅 Last 30 Days';
  String get streakUpcoming =>
      isAr ? '🏅 الإنجازات القادمة' : isEs ? '🏅 Próximos logros'
          : isFr
          ? '🏅 Prochains succès'
          : isPt
          ? '🏅 Próximas conquistas'
          : isRu
          ? '🏅 Предстоящие достижения'
          : isHi
          ? '🏅 आगामी उपलब्धियाँ'

          : isZh
          ? '🏅 即将解锁的成就'
: '🏅 Upcoming Achievements';
  String streakMilestone(int n) =>
      isAr ? '$n يوم' : isEs ? '$n días'
          : isFr
          ? '$n jours'
          : isPt
          ? '$n dias'
          : isRu
          ? '$n дней'
          : isHi
          ? '$n दिन'

          : isZh
          ? '$n 天'
: '$n Days';
  String consecutiveDays(int n) =>
      isAr ? '$n يوم متتالي' : isEs ? '$n días consecutivos'
          : isFr
          ? '$n jours consécutifs'
          : isPt
          ? '$n dias consecutivos'
          : isRu
          ? '$n дней подряд'
          : isHi
          ? 'लगातार n दिन'

          : isZh
          ? '$n 个连续的日子'
: '$n consecutive days';
  String get consecutiveDaysLabel =>
      isAr ? 'يوم متتالي' : isEs ? 'Días consecutivos'
          : isFr
          ? 'Jours consécutifs'
          : isPt
          ? 'Dias consecutivos'
          : isRu
          ? 'Подряд'
          : isHi
          ? 'लगातार दिन'

          : isZh
          ? '连续天数'
: 'Consecutive Days';

  // Leaderboard
  String get leaderboardTitle =>
      isAr ? '🏆 لوحة المتصدرين' : isEs ? '🏆 Tabla de clasificación'
          : isFr
          ? '🏆 Classement'
          : isPt
          ? '🏆 Tabela de classificação'
          : isRu
          ? '🏆 Таблица лидеров'
          : isHi
          ? '🏆 लीडरबोर्ड'

          : isZh
          ? '🏆 排行榜'
: '🏆 Leaderboard';
  String get leaderboardWeek =>
      isAr ? 'هذا الأسبوع' : isEs ? 'Esta semana'
          : isFr
          ? 'Cette semaine'
          : isPt
          ? 'Esta semana'
          : isRu
          ? 'На этой неделе'
          : isHi
          ? 'इस सप्ताह'

          : isZh
          ? '本周'
: 'This Week';
  String get leaderboardMonth =>
      isAr ? 'هذا الشهر' : isEs ? 'Este mes'
          : isFr
          ? 'Ce mois-ci'
          : isPt
          ? 'Este mês'
          : isRu
          ? 'В этом месяце'
          : isHi
          ? 'इस महीने'

          : isZh
          ? '本月'
: 'This Month';
  String get leaderboardAll =>
      isAr ? 'كل الوقت' : isEs ? 'Todo el tiempo'
          : isFr
          ? 'De tous les temps'
          : isPt
          ? 'De sempre'
          : isRu
          ? 'За всю историю'
          : isHi
          ? 'सर्वकालिक'

          : isZh
          ? '历史总计'
: 'All Time';
  String get leaderboardError =>
      isAr ? 'فشل تحميل لوحة المتصدرين'
          : isEs ? 'Error al cargar la tabla de clasificación'

          : isFr
          ? 'Échec du chargement du classement'
          : isPt
          ? 'Não foi possível carregar a tabela de classificação'
          : isRu
          ? 'Не удалось загрузить таблицу лидеров'
          : isHi
          ? 'लीडरबोर्ड लोड करने में असफल'

          : isZh
          ? '无法加载排行榜'
: 'Failed to load leaderboard';
  String get leaderboardRetry =>
      isAr ? 'حاول مرة ثانية' : isEs ? 'Reintentar'
          : isFr
          ? 'Réessayer'
          : isPt
          ? 'Tentar novamente'
          : isRu
          ? 'Повторить попытку'
          : isHi
          ? 'दोबारा प्रयास करें'

          : isZh
          ? '重试'
: 'Retry';
  String get leaderboardDefaultName =>
      isAr ? 'مستخدم' : isEs ? 'Usuario'
          : isFr
          ? 'Utilisateur'
          : isPt
          ? 'Utilizador'
          : isRu
          ? 'Пользователь'
          : isHi
          ? 'उपयोगकर्ता'

          : isZh
          ? '用户'
: 'User';
  String leaderboardLevel(String l) =>
      isAr ? 'مستوى $l' : isEs ? 'Nivel $l'
          : isFr
          ? 'Niveau $l'
          : isPt
          ? 'Nível $l'
          : isRu
          ? 'Уровень $l'
          : isHi
          ? 'स्तर $l'

          : isZh
          ? '级别 $l'
: 'Level $l';

  // Achievements
  String get achievementsTitle =>
      isAr ? '🏆 الإنجازات' : isEs ? '🏆 Logros'
          : isFr
          ? '🏆 Réalisations'
          : isPt
          ? '🏆 Conquistas'
          : isRu
          ? '🏆 Достижения'
          : isHi
          ? '🏆 उपलब्धियाँ'

          : isZh
          ? '🏆 成就'
: '🏆 Achievements';
  String get achievementsUnlockedLabel =>
      isAr ? 'مفتوح' : isEs ? 'Desbloqueado'
          : isFr
          ? 'Débloqué'
          : isPt
          ? 'Desbloqueado'
          : isRu
          ? 'Разблокировано'
          : isHi
          ? 'अनलॉक्ड'

          : isZh
          ? '已解锁'
: 'Unlocked';
  String achievementTitle(int i) {
    final ar = [
      'أول خبر مقروء', 'تسلسل 7 أيام', '50 كلمة', '10 اختبارات',
      '100 كلمة', 'تسلسل 30 يوم', 'كل المستويات', '50 مقال',
      'الهدف الأول', 'نجم الأسبوع', 'متخرج', 'التسلسل السريع',
      'متنوع', 'المراجعة', 'ممارسة', 'مكتبتي', 'المثابرة',
      'الاحتفال', 'مشاركة', 'المحارب',
    ];
    final es = [
      'Primer artículo', 'Racha de 7 días', '50 palabras', '10 cuestionarios',
      '100 palabras', 'Racha de 30 días', 'Todos los niveles', '50 artículos',
      'Primera meta', 'Estrella de la semana', 'Graduado', 'Racha rápida',
      'Variedad', 'Repaso', 'Práctica', 'Mi biblioteca', 'Perseverancia',
      'Celebración', 'Compartir', 'Guerrero',
    ];
    final en = [
      'First Article', '7-Day Streak', '50 Words', '10 Quizzes',
      '100 Words', '30-Day Streak', 'All Levels', '50 Articles',
      'First Goal', 'Star of the Week', 'Graduate', 'Quick Streak',
      'Variety', 'Review', 'Practice', 'My Library', 'Perseverance',
      'Celebration', 'Sharing', 'Warrior',
    ];
    return isAr ? ar[i] : isEs ? es[i] : en[i];
  }

  String achievementDesc(int i) {
    final ar = [
      'اقرأ أول خبر في التطبيق',
      '7 أيام متتالية من التعلم',
      'تعلم 50 كلمة جديدة',
      'اجتز 10 اختبارات',
      'تعلم 100 كلمة جديدة',
      '30 يوم متتالية من التعلم',
      'وصل لكل المستويات',
      'اقرأ 50 مقال',
      'حقق أول هدف يومي',
      'أكثر متعلم نشاطاً في الأسبوع',
      'أكمل المستوى الأول',
      '5 أيام متتالية في أول أسبوع',
      'اقرأ من كل التصنيفات',
      'راجع 20 كلمة في يوم واحد',
      'استخدم وضع النطق 10 مرات',
      'احفظ 5 كلمات',
      'تعلم ل 30 يوماً',
      'احتفل بإنجاز 500 كلمة',
      'شارك تطبيق مع صديق',
      'أكمل 100 اختبار',
    ];
    final es = [
      'Lee tu primer artículo en la app',
      '7 días consecutivos de aprendizaje',
      'Aprende 50 palabras nuevas',
      'Aprueba 10 cuestionarios',
      'Aprende 100 palabras nuevas',
      '30 días consecutivos de aprendizaje',
      'Alcanza todos los niveles',
      'Lee 50 artículos',
      'Completa tu primera meta diaria',
      'Estudiante más activo de la semana',
      'Completa el primer nivel',
      '5 días consecutivos en tu primera semana',
      'Lee de todas las categorías',
      'Repasa 20 palabras en un día',
      'Usa el modo de pronunciación 10 veces',
      'Guarda 5 palabras',
      'Aprende durante 30 días',
      'Celebra el logro de 500 palabras',
      'Comparte la app con un amigo',
      'Completa 100 cuestionarios',
    ];
    final en = [
      'Read your first article in the app',
      '7 consecutive days of learning',
      'Learn 50 new words',
      'Pass 10 quizzes',
      'Learn 100 new words',
      '30 consecutive days of learning',
      'Reach all levels',
      'Read 50 articles',
      'Complete your first daily goal',
      'Most active learner of the week',
      'Complete the first level',
      '5 consecutive days in your first week',
      'Read from all categories',
      'Review 20 words in one day',
      'Use pronunciation mode 10 times',
      'Save 5 words',
      'Learn for 30 days',
      'Celebrate 500 words achievement',
      'Share the app with a friend',
      'Complete 100 quizzes',
    ];
    return isAr ? ar[i] : isEs ? es[i] : en[i];
  }

  // Settings
  String get settingsTitle =>
      isAr ? '⚙️ الإعدادات' : isEs ? '⚙️ Ajustes'
          : isFr
          ? '⚙️ Paramètres'
          : isPt
          ? '⚙️ Definições'
          : isRu
          ? '⚙️ Настройки'
          : isHi
          ? '⚙️ सेटिंग्स'

          : isZh
          ? '⚙️ 设置'
: '⚙️ Settings';
  String get settingsApp =>
      isAr ? '🎨 التطبيق' : isEs ? '🎨 App'
          : isFr
          ? '🎨 Application'
          : isPt
          ? '🎨 Aplicação'
          : isRu
          ? '🎨 Приложение'
          : isHi
          ? '🎨 ऐप'

          : isZh
          ? '🎨 应用程序'
: '🎨 App';
  String get settingsLanguage =>
      isAr ? 'لغة التطبيق' : isEs ? 'Idioma de la app'
          : isFr
          ? 'Langue de l\'application'
          : isPt
          ? 'Idioma da aplicação'
          : isRu
          ? 'Язык приложения'
          : isHi
          ? 'ऐप भाषा'

          : isZh
          ? '应用语言'
: 'App Language';
  String get settingsArabic =>
      isAr ? 'العربية' : isEs ? 'Árabe'
          : isFr
          ? 'Arabe'
          : isPt
          ? 'Árabe'
          : isRu
          ? 'арабский'
          : isHi
          ? 'अरबी'

          : isZh
          ? '阿拉伯语'
: 'Arabic';
  String get settingsNotifications =>
      isAr ? '🔔 الإشعارات' : isEs ? '🔔 Notificaciones'
          : isFr
          ? '🔔 Notifications'
          : isPt
          ? '🔔 Notificações'
          : isRu
          ? '🔔 Уведомления'
          : isHi
          ? '🔔 सूचनाएँ'

          : isZh
          ? '🔔 通知'
: '🔔 Notifications';
  String get settingsNotifTitle =>
      isAr ? 'الإشعارات' : isEs ? 'Notificaciones'
          : isFr
          ? 'Notifications'
          : isPt
          ? 'Notificações'
          : isRu
          ? 'Уведомления'
          : isHi
          ? 'सूचनाएँ'

          : isZh
          ? '通知'
: 'Notifications';
  String get settingsNotifSub =>
      isAr ? 'إشعارات عامة' : isEs ? 'Notificaciones generales'
          : isFr
          ? 'Notifications générales'
          : isPt
          ? 'Notificações gerais'
          : isRu
          ? 'Общие уведомления'
          : isHi
          ? 'सामान्य सूचनाएं'

          : isZh
          ? '一般通知'
: 'General notifications';
  String get settingsDailyNewsTitle =>
      isAr ? 'خبر اليوم' : isEs ? 'Noticia diaria'
          : isFr
          ? 'Actualités quotidiennes'
          : isPt
          ? 'Notícias do Dia'
          : isRu
          ? 'Ежедневные новости'
          : isHi
          ? 'दैनिक समाचार'

          : isZh
          ? '《每日新闻》'
: 'Daily News';
  String get settingsDailyNewsSub =>
      isAr ? 'إشعار يومي بأهم خبر' : isEs ? 'Notificación diaria con la noticia principal'
          : isFr
          ? 'Notification quotidienne avec les principales actualités'
          : isPt
          ? 'Notificação diária com as notícias mais importantes'
          : isRu
          ? 'Ежедневные уведомления с главными новостями'
          : isHi
          ? 'शीर्ष समाचारों के साथ दैनिक सूचना'

          : isZh
          ? '每日推送精选新闻'
: 'Daily notification with top news';
  String get settingsVocabRemindTitle =>
      isAr ? 'تذكير المفردات' : isEs ? 'Recordatorio de vocabulario'
          : isFr
          ? 'Rappel de vocabulaire'
          : isPt
          ? 'Resumo do vocabulário'
          : isRu
          ? 'Повторение лексики'
          : isHi
          ? 'शब्दावली अनुस्मारक'

          : isZh
          ? '词汇复习'
: 'Vocabulary Reminder';
  String get settingsVocabRemindSub =>
      isAr ? 'ذكرني أراجع الكلمات' : isEs ? 'Recuérdame repasar palabras'
          : isFr
          ? 'Rappelle-moi de réviser mon vocabulaire'
          : isPt
          ? 'Lembra-me de rever as palavras'
          : isRu
          ? 'Напомни мне, чтобы я повторил слова'
          : isHi
          ? 'मुझे शब्दों की समीक्षा करने के लिए याद दिलाएं'

          : isZh
          ? '提醒我复习单词'
: 'Remind me to review words';
  String get settingsRemindTime =>
      isAr ? 'وقت التذكير' : isEs ? 'Hora del recordatorio'
          : isFr
          ? 'Heure de rappel'
          : isPt
          ? 'Hora do lembrete'
          : isRu
          ? 'Время напоминания'
          : isHi
          ? 'स्मरण समय'

          : isZh
          ? '提醒时间'
: 'Reminder Time';
  String get settingsAccount =>
      isAr ? '⭐ الحساب' : isEs ? '⭐ Cuenta'
          : isFr
          ? '⭐ Compte'
          : isPt
          ? '⭐ Conta'
          : isRu
          ? '⭐ Учётная запись'
          : isHi
          ? '⭐ खाता'

          : isZh
          ? '⭐ 账户'
: '⭐ Account';
  String get settingsProfileTitle =>
      isAr ? 'الملف الشخصي' : isEs ? 'Perfil'
          : isFr
          ? 'Profil'
          : isPt
          ? 'Perfil'
          : isRu
          ? 'Профиль'
          : isHi
          ? 'प्रोफ़ाइल'

          : isZh
          ? '个人简介'
: 'Profile';
  String get settingsProfileSub =>
      isAr ? 'تعديل الاسم والصورة' : isEs ? 'Editar nombre y foto'
          : isFr
          ? 'Modifier le nom et la photo'
          : isPt
          ? 'Editar nome e foto'
          : isRu
          ? 'Изменить имя и фотографию'
          : isHi
          ? 'नाम और फोटो संपादित करें'

          : isZh
          ? '编辑姓名和照片'
: 'Edit name & photo';
  String get settingsSubscription =>
      isAr ? 'الاشتراك المميز' : isEs ? 'Suscripción premium'
          : isFr
          ? 'Abonnement Premium'
          : isPt
          ? 'Assinatura Premium'
          : isRu
          ? 'Премиум-подписка'
          : isHi
          ? 'प्रिमियम सदस्यता'

          : isZh
          ? '高级订阅'
: 'Premium Subscription';
  String get settingsSubscriptionSub =>
      isAr ? 'فتح كل الميزات الحصرية' : isEs ? 'Desbloquea todas las funciones exclusivas'
          : isFr
          ? 'Débloquez toutes les fonctionnalités exclusives'
          : isPt
          ? 'Desbloqueia todas as funcionalidades exclusivas'
          : isRu
          ? 'Разблокируйте все эксклюзивные функции'
          : isHi
          ? 'सभी विशेष सुविधाओं को अनलॉक करें'

          : isZh
          ? '解锁所有独家功能'
: 'Unlock all exclusive features';
  String get settingsSupport =>
      isAr ? '❓ الدعم' : isEs ? '❓ Soporte'
          : isFr
          ? '❓ Assistance'
          : isPt
          ? '❓ Apoio'
          : isRu
          ? '❓ Поддержка'
          : isHi
          ? '❓ सहायता'

          : isZh
          ? '❓ 支持'
: '❓ Support';
  String get settingsHelp =>
      isAr ? 'المساعدة والدعم' : isEs ? 'Ayuda y soporte'
          : isFr
          ? 'Aide et assistance'
          : isPt
          ? 'Ajuda e Apoio'
          : isRu
          ? 'Справка и поддержка'
          : isHi
          ? 'सहायता और समर्थन'

          : isZh
          ? '帮助与支持'
: 'Help & Support';
  String get settingsAbout =>
      isAr ? 'حول التطبيق' : isEs ? 'Acerca de'
          : isFr
          ? 'À propos'
          : isPt
          ? 'Sobre'
          : isRu
          ? 'О нас'
          : isHi
          ? 'बारे में'

          : isZh
          ? '关于'
: 'About';
  String get settingsPrivacy =>
      isAr ? 'سياسة الخصوصية' : isEs ? 'Política de privacidad'
          : isFr
          ? 'Politique de confidentialité'
          : isPt
          ? 'Política de Privacidade'
          : isRu
          ? 'Политика конфиденциальности'
          : isHi
          ? 'गोपनीयता नीति'

          : isZh
          ? '隐私政策'
: 'Privacy Policy';
  String get settingsTerms =>
      isAr ? 'شروط الاستخدام' : isEs ? 'Términos de uso'
          : isFr
          ? 'Conditions d\'utilisation'
          : isPt
          ? 'Termos de Utilização'
          : isRu
          ? 'Условия использования'
          : isHi
          ? 'उपयोग की शर्तें'

          : isZh
          ? '使用条款'
: 'Terms of Use';
  String get settingsLogout =>
      isAr ? 'تسجيل الخروج' : isEs ? 'Cerrar sesión'
          : isFr
          ? 'Se déconnecter'
          : isPt
          ? 'Sair'
          : isRu
          ? 'Выйти'
          : isHi
          ? 'लॉग आउट'

          : isZh
          ? '退出登录'
: 'Log Out';
  String get settingsLogoutConfirm =>
      isAr ? 'هل أنت متأكد من تسجيل الخروج؟'
          : isEs ? '¿Estás seguro de que quieres cerrar sesión?'

          : isFr
          ? 'Êtes-vous sûr de vouloir vous déconnecter ?'
          : isPt
          ? 'Tem a certeza de que quer terminar a sessão?'
          : isRu
          ? 'Вы действительно хотите выйти из системы?'
          : isHi
          ? 'क्या आप वास्तव में लॉग आउट करना चाहते हैं?'

          : isZh
          ? '您确定要注销吗？'
: 'Are you sure you want to log out?';
  String get settingsDeleteAccount =>
      isAr ? 'حذف الحساب' : isEs ? 'Eliminar cuenta'
          : isFr
          ? 'Supprimer le compte'
          : isPt
          ? 'Eliminar conta'
          : isRu
          ? 'Удалить аккаунт'
          : isHi
          ? 'खाता हटाएँ'

          : isZh
          ? '删除账户'
: 'Delete Account';
  String get settingsDeleteConfirm => isAr
      ? 'هل أنت متأكد؟ هذا الإجراء لا يمكن التراجع عنه.\nسيتم حذف جميع بياناتك نهائياً.'
      : isEs ? '¿Estás seguro? Esta acción no se puede deshacer.\nTodos tus datos serán eliminados permanentemente.'

      : isFr
      ? 'Êtes-vous sûr ? Cette action est irréversible.\nToutes vos données seront définitivement supprimées.'
      : isPt
      ? 'Tem a certeza? Esta ação não pode ser revertida.\nTodos os seus dados serão eliminados de forma definitiva.'
      : isRu
      ? 'Вы уверены? Это действие нельзя отменить.\nВсе ваши данные будут безвозвратно удалены.'
      : isHi
      ? 'क्या आप निश्चित हैं? इसे वापस नहीं किया जा सकता। आपके सभी डेटा स्थायी रूप से हटा दिए जाएंगे।'

      : isZh
      ? '您确定吗？此操作无法撤销。\n您的所有数据都将被永久删除。'
: 'Are you sure? This cannot be undone.\nAll your data will be permanently deleted.';
  String get settingsDeleteError => isAr
      ? 'حدث خطأ أثناء حذف الحساب'
      : isEs ? 'Ocurrió un error al eliminar la cuenta'

      : isFr
      ? 'Une erreur s\'est produite lors de la suppression de votre compte'
      : isPt
      ? 'Ocorreu um erro ao eliminar a sua conta'
      : isRu
      ? 'При удалении вашей учетной записи произошла ошибка'
      : isHi
      ? 'आपका खाता हटाते समय एक त्रुटि हुई।'

      : isZh
      ? '删除您的账户时发生错误'
: 'An error occurred while deleting your account';
  String get cancel =>
      isAr ? 'إلغاء' : isEs ? 'Cancelar'
          : isFr
          ? 'Annuler'
          : isPt
          ? 'Cancelar'
          : isRu
          ? 'Отменить'
          : isHi
          ? 'रद्द करें'

          : isZh
          ? '取消'
: 'Cancel';
  String get settingsNotifManage =>
      isAr ? 'إدارة إشعارات التطبيق' : isEs ? 'Gestionar notificaciones de la app'
          : isFr
          ? 'Gérer les notifications des applications'
          : isPt
          ? 'Gerir notificações de aplicações'
          : isRu
          ? 'Управление уведомлениями приложений'
          : isHi
          ? 'ऐप सूचनाएँ प्रबंधित करें'

          : isZh
          ? '管理应用通知'
: 'Manage App Notifications';
  String get settingsNotifAchieveTitle =>
      isAr ? 'إنجازات جديدة' : isEs ? 'Nuevos logros'
          : isFr
          ? 'Nouveaux succès'
          : isPt
          ? 'Novas conquistas'
          : isRu
          ? 'Новые достижения'
          : isHi
          ? 'नई उपलब्धियाँ'

          : isZh
          ? '新成就'
: 'New Achievements';
  String get settingsNotifAchieveSub =>
      isAr ? 'إشعار عند تحقيق إنجاز جديد'
          : isEs ? 'Notificación cuando obtengas un nuevo logro'

          : isFr
          ? 'Notification lorsque vous débloquez un nouveau succès'
          : isPt
          ? 'Notificação quando conquistares uma nova conquista'
          : isRu
          ? 'Уведомление о получении нового достижения'
          : isHi
          ? 'नई उपलब्धि हासिल करने पर सूचना'

          : isZh
          ? '获得新成就时的通知'
: 'Notification when you earn a new achievement';
  String get settingsNotifWeeklyTitle =>
      isAr ? 'تقرير أسبوعي' : isEs ? 'Informe semanal'
          : isFr
          ? 'Rapport hebdomadaire'
          : isPt
          ? 'Relatório semanal'
          : isRu
          ? 'Еженедельный отчет'
          : isHi
          ? 'साप्ताहिक रिपोर्ट'

          : isZh
          ? '每周报告'
: 'Weekly Report';
  String get settingsNotifWeeklySub =>
      isAr ? 'ملخص تقدمك الأسبوعي كل يوم أحد'
          : isEs ? 'Resumen semanal de tu progreso cada domingo'

          : isFr
          ? 'Votre bilan hebdomadaire de vos progrès, chaque dimanche'
          : isPt
          ? 'O teu resumo semanal do progresso, todos os domingos'
          : isRu
          ? 'Еженедельный отчет о ваших успехах — каждое воскресенье'
          : isHi
          ? 'हर रविवार आपकी साप्ताहिक प्रगति का सारांश'

          : isZh
          ? '每周日为您奉上的进度总结'
: 'Your weekly progress summary every Sunday';
  String get settingsNotifTipsTitle =>
      isAr ? 'نصائح تعلم' : isEs ? 'Consejos de aprendizaje'
          : isFr
          ? 'Conseils d\'apprentissage'
          : isPt
          ? 'Dicas de aprendizagem'
          : isRu
          ? 'Советы по обучению'
          : isHi
          ? 'सीखने के सुझाव'

          : isZh
          ? '学习技巧'
: 'Learning Tips';
  String get settingsNotifTipsSub =>
      isAr ? 'نصائح وحيل لتحسين تعلمك للغة'
          : isEs ? 'Consejos y trucos para mejorar tu aprendizaje del idioma'

          : isFr
          ? 'Conseils et astuces pour améliorer votre apprentissage des langues'
          : isPt
          ? 'Dicas e truques para melhorar a tua aprendizagem de línguas'
          : isRu
          ? 'Советы и рекомендации по повышению эффективности изучения языка'
          : isHi
          ? 'अपनी भाषा सीखने में सुधार के लिए टिप्स और ट्रिक्स'

          : isZh
          ? '提高语言学习效果的技巧与诀窍'
: 'Tips and tricks to improve your language learning';

  // Language Settings
  String get langSettingsTitle =>
      isAr ? '🌐 لغة التطبيق' : isEs ? '🌐 Idioma de la app'
          : isFr
          ? '🌐 Langue de l\'application'
          : isPt
          ? '🌐 Idioma da aplicação'
          : isRu
          ? '🌐 Язык приложения'
          : isHi
          ? '🌐 ऐप भाषा'

          : isZh
          ? '🌐 应用语言'
: '🌐 App Language';
  String get langSettingsChoose =>
      isAr ? 'اختر لغة التطبيق' : isEs ? 'Elige el idioma de la app'
          : isFr
          ? 'Choisissez la langue de l\'application'
          : isPt
          ? 'Escolher o idioma da aplicação'
          : isRu
          ? 'Выберите язык приложения'
          : isHi
          ? 'ऐप भाषा चुनें'

          : isZh
          ? '选择应用语言'
: 'Choose App Language';
  String get langSettingsApply =>
      isAr ? 'تطبيق' : isEs ? 'Aplicar'
          : isFr
          ? 'Postuler'
          : isPt
          ? 'Candidatar-se'
          : isRu
          ? 'Подать заявку'
          : isHi
          ? 'लागू करें'

          : isZh
          ? '申请'
: 'Apply';

  // Profile
  String get profileDefaultName =>
      isAr ? 'مستخدم' : isEs ? 'Usuario'
          : isFr
          ? 'Utilisateur'
          : isPt
          ? 'Utilizador'
          : isRu
          ? 'Пользователь'
          : isHi
          ? 'उपयोगकर्ता'

          : isZh
          ? '用户'
: 'User';
  String get profileDefaultLevel =>
      isAr ? 'B1 - متوسط' : isEs ? 'B1 - Intermedio'
          : isFr
          ? 'B1 - Intermédiaire'
          : isPt
          ? 'B1 - Intermédio'
          : isRu
          ? 'B1 — средний уровень'
          : isHi
          ? 'बी1 - मध्यवर्ती'

          : isZh
          ? 'B1 - 中级'
: 'B1 - Intermediate';
  String get profileStatStreak =>
      isAr ? 'تسلسل' : isEs ? 'Racha'
          : isFr
          ? 'Série'
          : isPt
          ? 'Série de vitórias'
          : isRu
          ? 'Серия'
          : isHi
          ? 'धारा'

          : isZh
          ? '连胜'
: 'Streak';
  String get profileStatArticles =>
      isAr ? 'مقالات' : isEs ? 'Artículos'
          : isFr
          ? 'Articles'
          : isPt
          ? 'Artigos'
          : isRu
          ? 'Статьи'
          : isHi
          ? 'लेख'

          : isZh
          ? '文章'
: 'Articles';
  String get profileStatWords =>
      isAr ? 'كلمات' : isEs ? 'Palabras'
          : isFr
          ? 'Mots'
          : isPt
          ? 'Palavras'
          : isRu
          ? 'Слова'
          : isHi
          ? 'शब्द'

          : isZh
          ? '词语'
: 'Words';
  String get profileStatQuizzes =>
      isAr ? 'اختبارات' : isEs ? 'Cuestionarios'
          : isFr
          ? 'Jeux-questionnaires'
          : isPt
          ? 'Questionários'
          : isRu
          ? 'Викторины'
          : isHi
          ? 'क्विज़'

          : isZh
          ? '测验'
: 'Quizzes';
  String get profileSavedArticles =>
      isAr ? 'المقالات المحفوظة' : isEs ? 'Artículos guardados'
          : isFr
          ? 'Articles enregistrés'
          : isPt
          ? 'Artigos guardados'
          : isRu
          ? 'Сохраненные статьи'
          : isHi
          ? 'सहेजे गए लेख'

          : isZh
          ? '已保存的文章'
: 'Saved Articles';
  String get profileAchievements =>
      isAr ? 'الإنجازات' : isEs ? 'Logros'
          : isFr
          ? 'Réalisations'
          : isPt
          ? 'Conquistas'
          : isRu
          ? 'Достижения'
          : isHi
          ? 'उपलब्धियाँ'

          : isZh
          ? '成就'
: 'Achievements';
  String get profileDashboard =>
      isAr ? 'لوحة التقدم' : isEs ? 'Panel de progreso'
          : isFr
          ? 'Tableau de bord des progrès'
          : isPt
          ? 'Painel de Progresso'
          : isRu
          ? 'Панель мониторинга прогресса'
          : isHi
          ? 'प्रगति डैशबोर्ड'

          : isZh
          ? '进度仪表盘'
: 'Progress Dashboard';
  String get profileSettings =>
      isAr ? 'الإعدادات' : isEs ? 'Ajustes'
          : isFr
          ? 'Paramètres'
          : isPt
          ? 'Definições'
          : isRu
          ? 'Настройки'
          : isHi
          ? 'सेटिंग्स'

          : isZh
          ? '设置'
: 'Settings';
  String get profileSubscription =>
      isAr ? 'الاشتراك المميز' : isEs ? 'Suscripción premium'
          : isFr
          ? 'Abonnement Premium'
          : isPt
          ? 'Assinatura Premium'
          : isRu
          ? 'Премиум-подписка'
          : isHi
          ? 'प्रिमियम सदस्यता'

          : isZh
          ? '高级订阅'
: 'Premium Subscription';
  String get profileHelp =>
      isAr ? 'المساعدة والدعم' : isEs ? 'Ayuda y soporte'
          : isFr
          ? 'Aide et assistance'
          : isPt
          ? 'Ajuda e Apoio'
          : isRu
          ? 'Справка и поддержка'
          : isHi
          ? 'सहायता और समर्थन'

          : isZh
          ? '帮助与支持'
: 'Help & Support';
  String get profileAbout =>
      isAr ? 'حول التطبيق' : isEs ? 'Acerca de'
          : isFr
          ? 'À propos'
          : isPt
          ? 'Sobre'
          : isRu
          ? 'О нас'
          : isHi
          ? 'बारे में'

          : isZh
          ? '关于'
: 'About';

  // Edit Profile
  String get editProfileTitle =>
      isAr ? '✏️ تعديل الملف' : isEs ? '✏️ Editar perfil'
          : isFr
          ? '✏️ Modifier le profil'
          : isPt
          ? '✏️ Editar perfil'
          : isRu
          ? '✏️ Редактировать профиль'
          : isHi
          ? '✏️ प्रोफ़ाइल संपादित करें'

          : isZh
          ? '✏️ 编辑个人资料'
: '✏️ Edit Profile';
  String get editProfileBio =>
      isAr ? 'نبذة عني' : isEs ? 'Sobre mí'
          : isFr
          ? 'À propos de moi'
          : isPt
          ? 'Sobre mim'
          : isRu
          ? 'О себе'
          : isHi
          ? 'मेरे बारे में'

          : isZh
          ? '关于我'
: 'About Me';
  String get editProfileBioHint =>
      isAr ? 'اكتب نبذة عن نفسك...' : isEs ? 'Escribe algo sobre ti...'
          : isFr
          ? 'Parle-nous un peu de toi...'
          : isPt
          ? 'Escreve algo sobre ti...'
          : isRu
          ? 'Напиши что-нибудь о себе...'
          : isHi
          ? 'अपने बारे में कुछ लिखें...'

          : isZh
          ? '写点关于你自己的内容……'
: 'Write something about yourself...';
  String get editProfileSave =>
      isAr ? 'حفظ التغييرات' : isEs ? 'Guardar cambios'
          : isFr
          ? 'Enregistrer les modifications'
          : isPt
          ? 'Guardar alterações'
          : isRu
          ? 'Сохранить изменения'
          : isHi
          ? 'बदलाव सहेजें'

          : isZh
          ? '保存更改'
: 'Save Changes';
  String get editProfileCancel =>
      isAr ? 'إلغاء' : isEs ? 'Cancelar'
          : isFr
          ? 'Annuler'
          : isPt
          ? 'Cancelar'
          : isRu
          ? 'Отменить'
          : isHi
          ? 'रद्द करें'

          : isZh
          ? '取消'
: 'Cancel';
  String get editProfileLevel =>
      isAr ? 'المستوى' : isEs ? 'Nivel'
          : isFr
          ? 'Niveau'
          : isPt
          ? 'Nível'
          : isRu
          ? 'Уровень'
          : isHi
          ? 'स्तर'

          : isZh
          ? '级别'
: 'Level';
  String get editProfileInterests =>
      isAr ? 'الاهتمامات' : isEs ? 'Intereses'
          : isFr
          ? 'Centres d\'intérêt'
          : isPt
          ? 'Interesses'
          : isRu
          ? 'Интересы'
          : isHi
          ? 'रुचियाँ'

          : isZh
          ? '兴趣'
: 'Interests';
  String get editProfileLevelA1 =>
      isAr ? 'A1 - مبتدئ' : isEs ? 'A1 - Principiante'
          : isFr
          ? 'A1 - Débutant'
          : isPt
          ? 'A1 - Principiante'
          : isRu
          ? 'A1 — Начинающий уровень'
          : isHi
          ? 'A1 – शुरुआती'

          : isZh
          ? 'A1 - 初级'
: 'A1 - Beginner';
  String get editProfileLevelA2 =>
      isAr ? 'A2 - مبتدئ متقدم' : isEs ? 'A2 - Principiante avanzado'
          : isFr
          ? 'A2 - Débutant avancé'
          : isPt
          ? 'A2 - Nível iniciante avançado'
          : isRu
          ? 'A2 — уровень «продвинутый начинающий»'
          : isHi
          ? 'ए2 - उन्नत शुरुआती'

          : isZh
          ? 'A2 - 初级进阶'
: 'A2 - Advanced Beginner';
  String get editProfileLevelB1 =>
      isAr ? 'B1 - متوسط' : isEs ? 'B1 - Intermedio'
          : isFr
          ? 'B1 - Intermédiaire'
          : isPt
          ? 'B1 - Intermédio'
          : isRu
          ? 'B1 — средний уровень'
          : isHi
          ? 'बी1 - मध्यवर्ती'

          : isZh
          ? 'B1 - 中级'
: 'B1 - Intermediate';
  String get editProfileLevelB2 =>
      isAr ? 'B2 - فوق المتوسط' : isEs ? 'B2 - Intermedio alto'
          : isFr
          ? 'B2 - Niveau intermédiaire supérieur'
          : isPt
          ? 'B2 - Nível intermédio-avançado'
          : isRu
          ? 'B2 — выше среднего уровня'
          : isHi
          ? 'बी2 - ऊपरी मध्यवर्ती'

          : isZh
          ? 'B2 - 中高级'
: 'B2 - Upper Intermediate';
  String get editProfileLevelC1 =>
      isAr ? 'C1 - متقدم' : isEs ? 'C1 - Avanzado'
          : isFr
          ? 'C1 - Avancé'
          : isPt
          ? 'C1 - Avançado'
          : isRu
          ? 'C1 — Продвинутый уровень'
          : isHi
          ? 'C1 - उन्नत'

          : isZh
          ? 'C1 - 高级'
: 'C1 - Advanced';
  String get editProfileLevelC2 =>
      isAr ? 'C2 - محترف' : isEs ? 'C2 - Competente'
          : isFr
          ? 'C2 - Maîtrise'
          : isPt
          ? 'C2 - Proficiente'
          : isRu
          ? 'C2 — Высокий уровень владения языком'
          : isHi
          ? 'सी2 - प्रवीण'

          : isZh
          ? 'C2 - 熟练'
: 'C2 - Proficient';
  String get editProfileInterestNews =>
      isAr ? 'أخبار' : isEs ? 'Noticias'
          : isFr
          ? 'Actualités'
          : isPt
          ? 'Notícias'
          : isRu
          ? 'Новости'
          : isHi
          ? 'समाचार'

          : isZh
          ? '新闻'
: 'News';
  String get editProfileInterestTech =>
      isAr ? 'تكنولوجيا' : isEs ? 'Tecnología'
          : isFr
          ? 'Technologie'
          : isPt
          ? 'Tecnologia'
          : isRu
          ? 'Технологии'
          : isHi
          ? 'प्रौद्योगिकी'

          : isZh
          ? '技术'
: 'Technology';
  String get editProfileInterestSports =>
      isAr ? 'رياضة' : isEs ? 'Deportes'
          : isFr
          ? 'Sports'
          : isPt
          ? 'Desporto'
          : isRu
          ? 'Спорт'
          : isHi
          ? 'खेल'

          : isZh
          ? '体育'
: 'Sports';
  String get editProfileInterestScience =>
      isAr ? 'علوم' : isEs ? 'Ciencia'
          : isFr
          ? 'Sciences'
          : isPt
          ? 'Ciência'
          : isRu
          ? 'Наука'
          : isHi
          ? 'विज्ञान'

          : isZh
          ? '科学'
: 'Science';
  String get editProfileInterestBusiness =>
      isAr ? 'اقتصاد' : isEs ? 'Negocios'
          : isFr
          ? 'Affaires'
          : isPt
          ? 'Negócios'
          : isRu
          ? 'Бизнес'
          : isHi
          ? 'व्यवसाय'

          : isZh
          ? '商业'
: 'Business';
  String get editProfileInterestEntertainment =>
      isAr ? 'ترفيه' : isEs ? 'Entretenimiento'
          : isFr
          ? 'Divertissement'
          : isPt
          ? 'Entretenimento'
          : isRu
          ? 'Развлечения'
          : isHi
          ? 'मनोरंजन'

          : isZh
          ? '娱乐'
: 'Entertainment';
  String get editProfileInterestHealth =>
      isAr ? 'صحة' : isEs ? 'Salud'
          : isFr
          ? 'Santé'
          : isPt
          ? 'Saúde'
          : isRu
          ? 'Здоровье'
          : isHi
          ? 'स्वास्थ्य'

          : isZh
          ? '健康'
: 'Health';
  String get editProfileInterestWorld =>
      isAr ? 'عالم' : isEs ? 'Mundo'
          : isFr
          ? 'Monde'
          : isPt
          ? 'Mundo'
          : isRu
          ? 'Мир'
          : isHi
          ? 'विश्व'

          : isZh
          ? '世界'
: 'World';
  String get editProfileSaveError =>
      isAr ? 'خطأ في حفظ التغييرات:' : isEs ? 'Error al guardar cambios:'
          : isFr
          ? 'Erreur lors de l\'enregistrement des modifications :'
          : isPt
          ? 'Erro ao guardar as alterações:'
          : isRu
          ? 'Ошибка при сохранении изменений:'
          : isHi
          ? 'बदलाव सहेजते समय त्रुटि:'

          : isZh
          ? '保存更改时出错：'
: 'Error saving changes:';

  // Subscription
  String get subscriptionTitle =>
      isAr ? '⭐ الاشتراك المميز' : isEs ? '⭐ Suscripción premium'
          : isFr
          ? '⭐ Abonnement Premium'
          : isPt
          ? '⭐ Subscrição Premium'
          : isRu
          ? '⭐ Премиум-подписка'
          : isHi
          ? '⭐ प्रीमियम सदस्यता'

          : isZh
          ? '⭐ 高级订阅'
: '⭐ Premium Subscription';
  String get subscriptionChoose =>
      isAr ? 'اختر خطتك' : isEs ? 'Elige tu plan'
          : isFr
          ? 'Choisissez votre forfait'
          : isPt
          ? 'Escolha o seu plano'
          : isRu
          ? 'Выберите тарифный план'
          : isHi
          ? 'अपना प्लान चुनें'

          : isZh
          ? '选择您的套餐'
: 'Choose Your Plan';
  String get subscriptionAutoRenew =>
      isAr ? 'سيتم تجديد الاشتراك تلقائياً. يمكنك الإلغاء في أي وقت.'
          : isEs ? 'Se renovará automáticamente. Puedes cancelar en cualquier momento.'

          : isFr
          ? 'Renouvellement automatique. Vous pouvez résilier à tout moment.'
          : isPt
          ? 'Renovação automática. Pode cancelar a qualquer momento.'
          : isRu
          ? 'Автоматическое продление. Можно отменить в любой момент.'
          : isHi
          ? 'स्वचालित नवीनीकरण। कभी भी रद्द करें।'

          : isZh
          ? '自动续订。可随时取消。'
: 'Auto-renews. Cancel anytime.';
  String get subscriptionNoAds =>
      isAr ? 'بدون إعلانات' : isEs ? 'Sin anuncios'
          : isFr
          ? 'Sans publicité'
          : isPt
          ? 'Sem anúncios'
          : isRu
          ? 'Без рекламы'
          : isHi
          ? 'कोई विज्ञापन नहीं'

          : isZh
          ? '无广告'
: 'No Ads';
  String get subscriptionNoAdsDesc =>
      isAr ? 'تصفح بدون أي إعلانات مزعجة'
          : isEs ? 'Navega sin anuncios molestos'

          : isFr
          ? 'Naviguez sans publicités gênantes'
          : isPt
          ? 'Navegue sem anúncios irritantes'
          : isRu
          ? 'Просматривайте страницы без назойливой рекламы'
          : isHi
          ? 'बिना परेशान करने वाले विज्ञापनों के ब्राउज़ करें'

          : isZh
          ? '无烦人广告，畅享浏览'
: 'Browse without annoying ads';
  String get subscriptionAllLessons =>
      isAr ? 'جميع الدروس' : isEs ? 'Todas las lecciones'
          : isFr
          ? 'Toutes les leçons'
          : isPt
          ? 'Todas as aulas'
          : isRu
          ? 'Все уроки'
          : isHi
          ? 'सभी पाठ'

          : isZh
          ? '所有课程'
: 'All Lessons';
  String get subscriptionAllLessonsDesc =>
      isAr ? 'وصول كامل لجميع الدروس والمقالات'
          : isEs ? 'Acceso completo a todas las lecciones y artículos'

          : isFr
          ? 'Accès complet à toutes les leçons et à tous les articles'
          : isPt
          ? 'Acesso total a todas as aulas e artigos'
          : isRu
          ? 'Полный доступ ко всем урокам и статьям'
          : isHi
          ? 'सभी पाठों और लेखों तक पूर्ण पहुँच'

          : isZh
          ? '全面访问所有课程和文章'
: 'Full access to all lessons & articles';
  String get subscriptionAdvancedAudio =>
      isAr ? 'نطق صوتي متقدم' : isEs ? 'Audio avanzado'
          : isFr
          ? 'Audio avancé'
          : isPt
          ? 'Áudio Avançado'
          : isRu
          ? 'Расширенные аудиофункции'
          : isHi
          ? 'उन्नत ऑडियो'

          : isZh
          ? '高级音频'
: 'Advanced Audio';
  String get subscriptionAdvancedAudioDesc =>
      isAr ? 'استمع للنطق الصحيح للكلمات'
          : isEs ? 'Escucha la pronunciación correcta de las palabras'

          : isFr
          ? 'Écoutez la prononciation correcte'
          : isPt
          ? 'Ouve a pronúncia correta'
          : isRu
          ? 'Прослушайте правильное произношение'
          : isHi
          ? 'सही उच्चारण सुनें'

          : isZh
          ? '收听正确发音'
: 'Listen to correct pronunciation';
  String get subscriptionDownload =>
      isAr ? 'تحميل المقالات' : isEs ? 'Descargar artículos'
          : isFr
          ? 'Télécharger les articles'
          : isPt
          ? 'Descarregar artigos'
          : isRu
          ? 'Скачать статьи'
          : isHi
          ? 'लेख डाउनलोड करें'

          : isZh
          ? '下载文章'
: 'Download Articles';
  String get subscriptionDownloadDesc =>
      isAr ? 'احفظ المقالات للقراءة بدون إنترنت'
          : isEs ? 'Guarda artículos para leer sin conexión'

          : isFr
          ? 'Enregistrer des articles pour les lire hors ligne'
          : isPt
          ? 'Guardar artigos para ler sem ligação à Internet'
          : isRu
          ? 'Сохранять статьи для чтения в автономном режиме'
          : isHi
          ? 'ऑफ़लाइन पढ़ने के लिए लेख सहेजें'

          : isZh
          ? '将文章保存下来以便离线阅读'
: 'Save articles for offline reading';
  String get subscriptionChallenges =>
      isAr ? 'تحديات حصرية' : isEs ? 'Desafíos exclusivos'
          : isFr
          ? 'Défis exclusifs'
          : isPt
          ? 'Desafios exclusivos'
          : isRu
          ? 'Эксклюзивные испытания'
          : isHi
          ? 'विशेष चुनौतियाँ'

          : isZh
          ? '独家挑战'
: 'Exclusive Challenges';
  String get subscriptionChallengesDesc =>
      isAr ? 'شارك في تحديات أسبوعية للمتفوقين'
          : isEs ? 'Participa en desafíos semanales para los mejores'

          : isFr
          ? 'Participez aux défis hebdomadaires réservés aux meilleurs élèves'
          : isPt
          ? 'Participa nos desafios semanais para os melhores alunos'
          : isRu
          ? 'Присоединяйтесь к еженедельным заданиям для лучших учащихся'
          : isHi
          ? 'शीर्ष शिक्षार्थियों के लिए साप्ताहिक चुनौतियों में शामिल हों'

          : isZh
          ? '加入面向顶尖学习者的每周挑战'
: 'Join weekly challenges for top learners';
  String get subscriptionFeatures =>
      isAr ? 'مميزات الاشتراك' : isEs ? 'Funciones de la suscripción'
          : isFr
          ? 'Fonctionnalités de l\'abonnement'
          : isPt
          ? 'Funcionalidades da subscrição'
          : isRu
          ? 'Возможности подписки'
          : isHi
          ? 'सदस्यता सुविधाएँ'

          : isZh
          ? '订阅功能'
: 'Subscription Features';
  String get subscriptionMonthly =>
      isAr ? 'شهري' : isEs ? 'Mensual'
          : isFr
          ? 'Mensuel'
          : isPt
          ? 'Mensal'
          : isRu
          ? 'Ежемесячно'
          : isHi
          ? 'मासिक'

          : isZh
          ? '每月'
: 'Monthly';
  String get subscriptionYearly =>
      isAr ? 'سنوي' : isEs ? 'Anual'
          : isFr
          ? 'Annuelle'
          : isPt
          ? 'Anual'
          : isRu
          ? 'Ежегодно'
          : isHi
          ? 'वार्षिक'

          : isZh
          ? '每年'
: 'Yearly';
  String get subscriptionLifetime =>
      isAr ? 'مدى الحياة' : isEs ? 'De por vida'
          : isFr
          ? 'Durée de vie'
          : isPt
          ? 'Vida útil'
          : isRu
          ? 'Срок службы'
          : isHi
          ? 'आजीवन'

          : isZh
          ? '终身'
: 'Lifetime';
  String get subscriptionBestValue =>
      isAr ? 'الأفضل' : isEs ? 'Mejor valor'
          : isFr
          ? 'Meilleur rapport qualité-prix'
          : isPt
          ? 'Melhor relação qualidade/preço'
          : isRu
          ? 'Лучшее соотношение цены и качества'
          : isHi
          ? 'सर्वोत्तम मूल्य'

          : isZh
          ? '最超值'
: 'Best Value';
  String get subscriptionCurrent =>
      isAr ? 'حالي' : isEs ? 'Actual'
          : isFr
          ? 'Actuel'
          : isPt
          ? 'Atual'
          : isRu
          ? 'Текущий'
          : isHi
          ? 'वर्तमान'

          : isZh
          ? '当前'
: 'Current';
  String get subscriptionSubscribe =>
      isAr ? 'اشترك الآن' : isEs ? 'Suscribirse ahora'
          : isFr
          ? 'Abonnez-vous dès maintenant'
          : isPt
          ? 'Subscreva agora'
          : isRu
          ? 'Подписаться сейчас'
          : isHi
          ? 'अभी सदस्यता लें'

          : isZh
          ? '立即订阅'
: 'Subscribe Now';
  String get subscriptionMonthlyCurrency =>
      isAr ? '\$/شهر' : isEs ? '\$/mes'
          : isFr
          ? '\$/mois'
          : isPt
          ? '\$/mês'
          : isRu
          ? '\$/месяц'
          : isHi
          ? '\$/माह'

          : isZh
          ? '\$/月'
: '\$/month';
  String get subscriptionYearlyCurrency =>
      isAr ? '\$/سنة' : isEs ? '\$/año'
          : isFr
          ? '\$/an'
          : isPt
          ? '\$/ano'
          : isRu
          ? '\$/год'
          : isHi
          ? 'प्रति वर्ष \$/'

          : isZh
          ? '\$/年'
: '\$/year';
  String get subscriptionLifetimeCurrency =>
      isAr ? '\$ لمرة واحدة' : isEs ? '\$ único'
          : isFr
          ? '\$ ponctuel'
          : isPt
          ? '\$ único'
          : isRu
          ? '\$ одноразовый'
          : isHi
          ? '\$ one-time'

          : isZh
          ? '\$ 一次性'
: '\$ one-time';
  String get subscriptionMonthlyPrice =>
      isAr ? '٩٫٩٩' : isEs ? '9.99'
          : isFr
          ? '9,99'
          : isPt
          ? '9,99'
          : isRu
          ? '9,99'
          : isHi
          ? '9.99'

          : isZh
          ? '9.99'
: '9.99';
  String get subscriptionYearlyPrice =>
      isAr ? '٧٩٫٩٩' : isEs ? '79.99'
          : isFr
          ? '79,99'
          : isPt
          ? '79,99'
          : isRu
          ? '79,99'
          : isHi
          ? 'सत्तावन दशमलव नब्बे नौ'

          : isZh
          ? '79.99'
: '79.99';
  String get subscriptionLifetimePrice =>
      isAr ? '١٤٩٫٩٩' : isEs ? '149.99'
          : isFr
          ? '149,99'
          : isPt
          ? '149,99'
          : isRu
          ? '149,99'
          : isHi
          ? 'एक सौ उनचालीस डॉलर नब्बे नौ सेंट'

          : isZh
          ? '149.99'
: '149.99';

  // Payment
  String get paymentTitle =>
      isAr ? '💳 الدفع' : isEs ? '💳 Pago'
          : isFr
          ? '💳 Paiement'
          : isPt
          ? '💳 Pagamento'
          : isRu
          ? '💳 Оплата'
          : isHi
          ? '💳 भुगतान'

          : isZh
          ? '💳 支付'
: '💳 Payment';
  String get paymentMethod =>
      isAr ? 'طريقة الدفع' : isEs ? 'Método de pago'
          : isFr
          ? 'Mode de paiement'
          : isPt
          ? 'Forma de pagamento'
          : isRu
          ? 'Способ оплаты'
          : isHi
          ? 'भुगतान विधि'

          : isZh
          ? '付款方式'
: 'Payment Method';
  String get paymentCreditCard =>
      isAr ? 'بطاقة ائتمان' : isEs ? 'Tarjeta de crédito'
          : isFr
          ? 'Carte de crédit'
          : isPt
          ? 'Cartão de crédito'
          : isRu
          ? 'Кредитная карта'
          : isHi
          ? 'क्रेडिट कार्ड'

          : isZh
          ? '信用卡'
: 'Credit Card';
  String get paymentCardHolder =>
      isAr ? 'اسم حامل البطاقة' : isEs ? 'Nombre del titular'
          : isFr
          ? 'Nom du titulaire de la carte'
          : isPt
          ? 'Nome do titular do cartão'
          : isRu
          ? 'Имя владельца карты'
          : isHi
          ? 'कार्डधारक का नाम'

          : isZh
          ? '持卡人姓名'
: 'Cardholder Name';
  String get paymentCardHolderHint =>
      isAr ? 'الاسم على البطاقة' : isEs ? 'Nombre en la tarjeta'
          : isFr
          ? 'Nom figurant sur la carte'
          : isPt
          ? 'Nome no cartão'
          : isRu
          ? 'Имя на визитке'
          : isHi
          ? 'कार्ड पर नाम'

          : isZh
          ? '卡片上的姓名'
: 'Name on card';
  String get paymentCardNumber =>
      isAr ? 'رقم البطاقة' : isEs ? 'Número de tarjeta'
          : isFr
          ? 'Numéro de carte'
          : isPt
          ? 'Número do cartão'
          : isRu
          ? 'Номер карты'
          : isHi
          ? 'कार्ड नंबर'

          : isZh
          ? '卡号'
: 'Card Number';
  String get paymentExpiry =>
      isAr ? 'تاريخ الانتهاء' : isEs ? 'Fecha de vencimiento'
          : isFr
          ? 'Date d\'expiration'
          : isPt
          ? 'Data de validade'
          : isRu
          ? 'Срок годности'
          : isHi
          ? 'समाप्ति तिथि'

          : isZh
          ? '有效期'
: 'Expiry Date';
  String get paymentDiscount =>
      isAr ? 'كود الخصم' : isEs ? 'Código de descuento'
          : isFr
          ? 'Code de réduction'
          : isPt
          ? 'Código de desconto'
          : isRu
          ? 'Код скидки'
          : isHi
          ? 'छूट कोड'

          : isZh
          ? '优惠码'
: 'Discount Code';
  String get paymentDiscountHint =>
      isAr ? 'أدخل كود الخصم' : isEs ? 'Ingresa el código de descuento'
          : isFr
          ? 'Saisir le code de réduction'
          : isPt
          ? 'Introduza o código de desconto'
          : isRu
          ? 'Введите код скидки'
          : isHi
          ? 'छूट कोड दर्ज करें'

          : isZh
          ? '输入优惠码'
: 'Enter discount code';
  String get paymentApply =>
      isAr ? 'تطبيق' : isEs ? 'Aplicar'
          : isFr
          ? 'Postuler'
          : isPt
          ? 'Candidatar-se'
          : isRu
          ? 'Подать заявку'
          : isHi
          ? 'लागू करें'

          : isZh
          ? '申请'
: 'Apply';
  String get paymentApplied =>
      isAr ? 'تم تطبيق الخصم بنجاح!' : isEs ? '¡Descuento aplicado con éxito!'
          : isFr
          ? 'La réduction a bien été appliquée !'
          : isPt
          ? 'O desconto foi aplicado com sucesso!'
          : isRu
          ? 'Скидка применена успешно!'
          : isHi
          ? 'छूट सफलतापूर्वक लागू हो गई!'

          : isZh
          ? '折扣已成功应用！'
: 'Discount applied successfully!';
  String get paymentSubtotal =>
      isAr ? 'المجموع الفرعي' : isEs ? 'Subtotal'
          : isFr
          ? 'Sous-total'
          : isPt
          ? 'Subtotal'
          : isRu
          ? 'Промежуточный итог'
          : isHi
          ? 'उप-योग'

          : isZh
          ? '小计'
: 'Subtotal';
  String get paymentDiscountLabel =>
      isAr ? 'الخصم' : isEs ? 'Descuento'
          : isFr
          ? 'Réduction'
          : isPt
          ? 'Desconto'
          : isRu
          ? 'Скидка'
          : isHi
          ? 'छूट'

          : isZh
          ? '折扣'
: 'Discount';
  String get paymentTotal =>
      isAr ? 'المجموع' : isEs ? 'Total'
          : isFr
          ? 'Total'
          : isPt
          ? 'Total'
          : isRu
          ? 'Итого'
          : isHi
          ? 'कुल'

          : isZh
          ? '总计'
: 'Total';
  String paymentPay(double amount) =>
      isAr ? 'ادفع \$$amount' : isEs ? 'Pagar \$$amount'
          : isFr
          ? 'Payer \$$amount'
          : isPt
          ? 'Pagar \$$amount'
          : isRu
          ? 'Оплатить \$$amount'
          : isHi
          ? 'भुगतान \$$amount'

          : isZh
          ? '支付 \$$amount'
: 'Pay \$$amount';
  String get paymentPlanAnnual =>
      isAr ? 'الخطة السنوية' : isEs ? 'Plan anual'
          : isFr
          ? 'Plan annuel'
          : isPt
          ? 'Plano Anual'
          : isRu
          ? 'Годовой план'
          : isHi
          ? 'वार्षिक योजना'

          : isZh
          ? '年度计划'
: 'Annual Plan';
  String get paymentCardInfo =>
      isAr ? 'معلومات البطاقة' : isEs ? 'Información de la tarjeta'
          : isFr
          ? 'Informations sur la carte'
          : isPt
          ? 'Informações sobre o cartão'
          : isRu
          ? 'Информация о карте'
          : isHi
          ? 'कार्ड की जानकारी'

          : isZh
          ? '卡片信息'
: 'Card Information';
  String get paymentCardHolderShort =>
      isAr ? 'حامل البطاقة' : isEs ? 'Titular'
          : isFr
          ? 'Titulaire de la carte'
          : isPt
          ? 'Titular do cartão'
          : isRu
          ? 'Держатель карты'
          : isHi
          ? 'कार्डधारक'

          : isZh
          ? '持卡人'
: 'Cardholder';
  String get paymentSuccess =>
      isAr ? '✅ تمت عملية الدفع بنجاح!' : isEs ? '✅ ¡Pago exitoso!'
          : isFr
          ? '✅ Paiement effectué avec succès !'
          : isPt
          ? '✅ Pagamento efetuado com sucesso!'
          : isRu
          ? '✅ Оплата прошла успешно!'
          : isHi
          ? '✅ भुगतान सफल!'

          : isZh
          ? '✅ 支付成功！'
: '✅ Payment successful!';
  String get privacyTitle =>
      isAr ? '🔒 سياسة الخصوصية' : isEs ? '🔒 Política de privacidad'
          : isFr
          ? '🔒 Politique de confidentialité'
          : isPt
          ? '🔒 Política de Privacidade'
          : isRu
          ? '🔒 Политика конфиденциальности'
          : isHi
          ? '🔒 गोपनीयता नीति'

          : isZh
          ? '🔒 隐私政策'
: '🔒 Privacy Policy';
  String get privacyLastUpdated =>
      isAr ? 'آخر تحديث: يونيو 2025' : isEs ? 'Última actualización: junio 2025'
          : isFr
          ? 'Dernière mise à jour : juin 2025'
          : isPt
          ? 'Última atualização: junho de 2025'
          : isRu
          ? 'Последнее обновление: июнь 2025 года'
          : isHi
          ? 'अंतिम अपडेट: जून 2025'

          : isZh
          ? '最后更新：2025年6月'
: 'Last updated: June 2025';
  String get privacySection1Title =>
      isAr ? 'المعلومات التي نجمعها' : isEs ? 'Información que recopilamos'
          : isFr
          ? 'Informations que nous collectons'
          : isPt
          ? 'Informações que recolhemos'
          : isRu
          ? 'Информация, которую мы собираем'
          : isHi
          ? 'हम जो जानकारी एकत्र करते हैं'

          : isZh
          ? '我们收集的信息'
: 'Information We Collect';
  String get privacySection1Body => isAr ? 'نقوم بجمع المعلومات التالية لتحسين تجربتك التعليمية:\n\n• معلومات الحساب: الاسم، البريد الإلكتروني، كلمة المرور المشفرة\n• بيانات التعلم: الكلمات المحفوظة، المقالات المقروءة، نتائج الاختبارات\n• معلومات الجهاز: نوع الجهاز، نظام التشغيل، إصدار التطبيق\n• بيانات الاستخدام: مدة الجلسات، الصفحات التي تزورها، تفضيلاتك\n\nلا نقوم بجمع أي معلومات حساسة دون موافقتك الصريحة.' : isEs ? 'Recopilamos la siguiente información para mejorar tu experiencia de aprendizaje:\n\n• Información de la cuenta: nombre, correo electrónico, contraseña encriptada\n• Datos de aprendizaje: palabras guardadas, artículos leídos, resultados de cuestionarios\n• Información del dispositivo: tipo de dispositivo, sistema operativo, versión de la app\n• Datos de uso: duración de sesiones, páginas visitadas, preferencias\n\nNo recopilamos información sensible sin tu consentimiento explícito.' : isFr ? 'Nous collectons les informations suivantes afin d\'améliorer votre expérience d\'apprentissage :\n\n• Informations de compte : nom, e-mail, mot de passe crypté\n• Données d\'apprentissage : mots enregistrés, articles lus, résultats aux quiz\n• Informations sur l\'appareil : type d\'appareil, système d\'exploitation, version de l\'application\n• Données d\'utilisation : durée de la session, pages consultées, préférences\n\nNous ne collectons aucune information sensible sans votre consentement explicite.' : isPt ? 'Recolhemos as seguintes informações para melhorar a sua experiência de aprendizagem:\n\n• Informações da conta: nome, e-mail, palavra-passe encriptada\n• Dados de aprendizagem: palavras guardadas, artigos lidos, resultados dos questionários\n• Informações do dispositivo: tipo de dispositivo, sistema operativo, versão da aplicação\n• Dados de utilização: duração da sessão, páginas visitadas, preferências\n\nNão recolhemos quaisquer informações sensíveis sem o seu consentimento explícito.' : isRu ? 'Мы собираем следующую информацию, чтобы улучшить ваш опыт обучения:\n\n• Данные учетной записи: имя, адрес электронной почты, зашифрованный пароль\n• Данные об обучении: сохраненные слова, прочитанные статьи, результаты тестов\n• Данные об устройстве: тип устройства, ОС, версия приложения\n• Данные об использовании: продолжительность сеанса, посещённые страницы, настройки\n\nМы не собираем никакой конфиденциальной информации без вашего явного согласия.'
          : isHi
          ? 'हम आपके सीखने के अनुभव को बेहतर बनाने के लिए निम्नलिखित जानकारी एकत्र करते हैं:\n\n• खाता जानकारी: नाम, ईमेल, एन्क्रिप्टेड पासवर्ड\n• सीखने का डेटा: सहेदे गए शब्द, पढ़े गए लेख, क्विज़ परिणाम\n• डिवाइस जानकारी: डिवाइस का प्रकार, ओएस, ऐप संस्करण\n• उपयोग डेटा: सत्र की अवधि, देखे गए पृष्ठ, प्राथमिकताएँ\n\nहम आपकी स्पष्ट सहमति के बिना कोई भी संवेदनशील जानकारी एकत्र नहीं करते हैं।'
          : isZh
          ? '为了提升您的学习体验，我们会收集以下信息：\n\n• 账户信息：姓名、电子邮箱、加密密码\n• 学习数据：已保存的单词、已阅读的文章、测验结果\n• 设备信息：设备类型、操作系统、应用版本\n• 使用数据：会话时长、访问过的页面、偏好设置\n\n未经您的明确同意，我们不会收集任何敏感信息。'
  : 'We collect the following information to improve your learning experience:\n\n• Account info: name, email, encrypted password\n• Learning data: saved words, read articles, quiz results\n• Device info: device type, OS, app version\n• Usage data: session duration, pages visited, preferences\n\nWe do not collect any sensitive information without your explicit consent.';
  String get privacySection2Title =>
      isAr ? 'كيفية استخدام المعلومات' : isEs ? 'Cómo usamos la información'
          : isFr
          ? 'Comment nous utilisons les informations'
          : isPt
          ? 'Como Utilizamos as Informações'
          : isRu
          ? 'Как мы используем информацию'
          : isHi
          ? 'हम जानकारी का उपयोग कैसे करते हैं'

          : isZh
          ? '我们如何使用信息'
: 'How We Use Information';
  String get privacySection2Body => isAr ? 'نستخدم معلوماتك للأغراض التالية:\n\n• تقديم محتوى تعليمي مخصص حسب مستواك واهتماماتك\n• تحسين وتطوير ميزات التطبيق بناءً على سلوك المستخدمين\n• إرسال إشعارات تذكيرية وتقارير أسبوعية (حسب إعداداتك)\n• التواصل معك بخصوص تحديثات التطبيق والدعم الفني\n\nلن نستخدم بياناتك لأغراض إعلانية دون موافقتك.' : isEs ? 'Usamos tu información para los siguientes fines:\n\n• Proporcionar contenido educativo personalizado según tu nivel e intereses\n• Mejorar y desarrollar funciones de la app basadas en el comportamiento de los usuarios\n• Enviar notificaciones de recordatorio e informes semanales (según tu configuración)\n• Comunicarnos contigo sobre actualizaciones de la app y soporte técnico\n\nNo usaremos tus datos para fines publicitarios sin tu consentimiento.' : isFr ? 'Nous utilisons vos informations aux fins suivantes :\n\n• Fournir un contenu pédagogique personnalisé en fonction de votre niveau et de vos centres d\'intérêt\n• Améliorer et développer les fonctionnalités de l\'application en fonction du comportement des utilisateurs\n• Envoyer des notifications de rappel et des rapports hebdomadaires (selon vos paramètres)\n• Communiquer avec vous concernant les mises à jour de l\'application et l\'assistance technique\n\nNous n\'utiliserons pas vos données à des fins publicitaires sans votre consentement.' : isPt ? 'Utilizamos as suas informações para os seguintes fins:\n\n• Fornecer conteúdos educativos personalizados com base no seu nível e nos seus interesses\n• Melhorar e desenvolver funcionalidades da aplicação com base no comportamento dos utilizadores\n• Enviar notificações de lembrete e relatórios semanais (de acordo com as suas definições)\n• Comunicar consigo relativamente a atualizações da aplicação e assistência técnica\n\nNão utilizaremos os seus dados para fins publicitários sem o seu consentimento.' : isRu ? 'Мы используем вашу информацию в следующих целях:\n\n• Предоставление персонализированного образовательного контента с учетом вашего уровня и интересов\n• Улучшение и развитие функций приложения с учётом поведения пользователей\n• Отправка напоминаний и еженедельных отчётов (в соответствии с вашими настройками)\n• Связь с вами по поводу обновлений приложения и технической поддержки\n\nМы не будем использовать ваши данные в рекламных целях без вашего согласия.'
          : isHi
          ? 'हम आपकी जानकारी का उपयोग निम्नलिखित उद्देश्यों के लिए करते हैं:\n\n• आपके स्तर और रुचियों के आधार पर व्यक्तिगत शैक्षिक सामग्री प्रदान करना\n• उपयोगकर्ता के व्यवहार के आधार पर ऐप की सुविधाओं में सुधार और विकास करना\n• (आपकी सेटिंग्स के अनुसार) रिमाइंडर सूचनाएं और साप्ताहिक रिपोर्ट भेजना\n• ऐप अपडेट और तकनीकी सहायता के संबंध में आपसे संवाद करना\n\nहम आपकी सहमति के बिना विज्ञापन उद्देश्यों के लिए आपके डेटा का उपयोग नहीं करेंगे।'
          : isZh
          ? '我们使用您的信息用于以下目的：\n\n• 根据您的水平和兴趣提供个性化的教育内容\n• 根据用户行为改进和开发应用功能\n• 发送提醒通知和每周报告（根据您的设置）\n• 就应用更新和技术支持事宜与您沟通\n\n未经您的同意，我们不会将您的数据用于广告目的。'
  : 'We use your information for the following purposes:\n\n• Providing personalized educational content based on your level and interests\n• Improving and developing app features based on user behavior\n• Sending reminder notifications and weekly reports (per your settings)\n• Communicating with you regarding app updates and technical support\n\nWe will not use your data for advertising purposes without your consent.';
  String get privacySection3Title =>
      isAr ? 'حماية المعلومات' : isEs ? 'Protección de la información'
          : isFr
          ? 'Protection des informations'
          : isPt
          ? 'Proteção da informação'
          : isRu
          ? 'Защита информации'
          : isHi
          ? 'सूचना सुरक्षा'

          : isZh
          ? '信息保护'
: 'Information Protection';
  String get privacySection3Body => isAr ? 'نحن نأخذ أمن بياناتك على محمل الجد:\n\n• جميع البيانات مشفرة أثناء النقل (SSL/TLS)\n• كلمات المرور مشفرة باستخدام أحدث معايير التشفير\n• خوادمنا محمية بأحدث بروتوكولات الأمان\n• لا نشارك بياناتك مع أطراف ثالثة دون موافقتك\n• نراجع إجراءاتنا الأمنية بشكل دوري' : isEs ? 'Tomamos la seguridad de tus datos muy en serio:\n\n• Todos los datos están encriptados en tránsito (SSL/TLS)\n• Las contraseñas están encriptadas con los últimos estándares\n• Nuestros servidores están protegidos con los protocolos de seguridad más recientes\n• No compartimos tus datos con terceros sin tu consentimiento\n• Revisamos nuestros procedimientos de seguridad periódicamente' : isFr ? 'Nous prenons très au sérieux la sécurité de vos données :\n\n• Toutes les données sont chiffrées lors de leur transfert (SSL/TLS)\n• Les mots de passe sont chiffrés selon les normes de chiffrement les plus récentes\n• Nos serveurs sont protégés par les protocoles de sécurité les plus récents\n• Nous ne partageons pas vos données avec des tiers sans votre consentement\n• Nous réévaluons régulièrement nos procédures de sécurité' : isPt ? 'Levamos a segurança dos seus dados muito a sério:\n\n• Todos os dados são encriptados durante a transmissão (SSL/TLS)\n• As palavras-passe são encriptadas utilizando os mais recentes padrões de encriptação\n• Os nossos servidores estão protegidos pelos mais recentes protocolos de segurança\n• Não partilhamos os seus dados com terceiros sem o seu consentimento\n• Revemos periodicamente os nossos procedimentos de segurança' : isRu ? 'Мы серьезно относимся к безопасности ваших данных:\n\n• Все данные шифруются при передаче (SSL/TLS)\n• Пароли шифруются с использованием новейших стандартов шифрования\n• Наши серверы защищены новейшими протоколами безопасности\n• Мы не передаем ваши данные третьим лицам без вашего согласия\n• Мы периодически пересматриваем наши процедуры безопасности'
          : isHi
          ? 'हम आपके डेटा की सुरक्षा को गंभीरता से लेते हैं: • सभी डेटा ट्रांज़िट के दौरान एन्क्रिप्ट किया जाता है (SSL/TLS) • पासवर्ड नवीनतम एन्क्रिप्शन मानकों का उपयोग करके एन्क्रिप्ट किए जाते हैं • हमारे सर्वर नवीनतम सुरक्षा प्रोटोकॉल द्वारा संरक्षित हैं • हम आपकी सहमति के बिना आपके डेटा को तीसरे पक्षों के साथ साझा नहीं करते हैं • हम अपनी सुरक्षा प्रक्रियाओं की समय-समय पर समीक्षा करते हैं'
          : isZh
          ? '我们高度重视您的数据安全：\n\n• 所有数据在传输过程中均经过加密（SSL/TLS）\n• 密码采用最新的加密标准进行加密\n• 我们的服务器受最新安全协议保护\n• 未经您的同意，我们不会将您的数据分享给第三方\n• 我们会定期审查我们的安全流程'
  : 'We take your data security seriously:\n\n• All data is encrypted in transit (SSL/TLS)\n• Passwords are encrypted using the latest encryption standards\n• Our servers are protected by the latest security protocols\n• We do not share your data with third parties without your consent\n• We review our security procedures periodically';
  String get privacySection4Title =>
      isAr ? 'حقوقك' : isEs ? 'Tus derechos'
          : isFr
          ? 'Vos droits'
          : isPt
          ? 'Os seus direitos'
          : isRu
          ? 'Ваши права'
          : isHi
          ? 'आपके अधिकार'

          : isZh
          ? '您的权利'
: 'Your Rights';
  String get privacySection4Body => isAr ? 'لديك الحقوق التالية فيما يخص بياناتك:\n\n• الوصول إلى جميع بياناتك الشخصية في أي وقت\n• طلب تصحيح أو تحديث بياناتك\n• طلب حذف حسابك وجميع بياناتك المرتبطة به\n• سحب الموافقة على معالجة البيانات في أي وقت\n• تصدير بياناتك بصيغة قابلة للقراءة\n\nيمكنك ممارسة هذه الحقوق من خلال الإعدادات أو التواصل معنا.' : isEs ? 'Tienes los siguientes derechos con respecto a tus datos:\n\n• Acceder a todos tus datos personales en cualquier momento\n• Solicitar la corrección o actualización de tus datos\n• Solicitar la eliminación de tu cuenta y todos los datos asociados\n• Retirar el consentimiento para el procesamiento de datos en cualquier momento\n• Exportar tus datos en un formato legible\n\nPuedes ejercer estos derechos a través de Ajustes o contactándonos.' : isFr ? 'Vous disposez des droits suivants concernant vos données :\n\n• Accéder à toutes vos données personnelles à tout moment\n• Demander la rectification ou la mise à jour de vos données\n• Demander la suppression de votre compte et de toutes les données associées\n• Retirer votre consentement au traitement des données à tout moment\n• Exporter vos données dans un format lisible\n\nVous pouvez exercer ces droits via les Paramètres ou en nous contactant.' : isPt ? 'Tem os seguintes direitos relativamente aos seus dados:\n\n• Aceder a todos os seus dados pessoais a qualquer momento\n• Solicitar a correção ou atualização dos seus dados\n• Solicitar a eliminação da sua conta e de todos os dados associados\n• Retirar o consentimento para o tratamento de dados a qualquer momento\n• Exportar os seus dados num formato legível\n\nPode exercer estes direitos através das Definições ou contactando-nos.' : isRu ? 'У вас есть следующие права в отношении ваших данных:\n\n• Получать доступ ко всем своим персональным данным в любое время\n• Запрашивать исправление или обновление своих данных\n• Запрашивать удаление своей учетной записи и всех связанных с ней данных\n• Отзывать согласие на обработку данных в любое время\n• Экспортировать свои данные в читаемом формате\n\nВы можете воспользоваться этими правами в разделе «Настройки» или связавшись с нами.'
          : isHi
          ? 'आपके डेटा के संबंध में आपके निम्नलिखित अधिकार हैं:\n\n• किसी भी समय अपने सभी व्यक्तिगत डेटा तक पहुँच\n• अपने डेटा में सुधार या अपडेट का अनुरोध करें\n• अपने खाते और सभी संबंधित डेटा को हटाने का अनुरोध करें\n• किसी भी समय डेटा प्रसंस्करण के लिए सहमति वापस लें\n• अपने डेटा को पठनीय प्रारूप में निर्यात करें\n\nआप इन अधिकारों का प्रयोग सेटिंग्स के माध्यम से या हमसे संपर्क करके कर सकते हैं।'
          : isZh
          ? '您对您的数据享有以下权利：\n\n• 随时访问您的所有个人数据\n• 要求更正或更新您的数据\n• 要求删除您的账户及所有相关数据\n• 随时撤回对数据处理的同意\n• 以可读格式导出您的数据\n\n您可以通过“设置”或联系我们来行使这些权利。'
  : 'You have the following rights regarding your data:\n\n• Access all your personal data at any time\n• Request correction or update of your data\n• Request deletion of your account and all associated data\n• Withdraw consent for data processing at any time\n• Export your data in a readable format\n\nYou can exercise these rights through Settings or by contacting us.';
  String get privacySection5Title =>
      isAr ? 'اتصل بنا' : isEs ? 'Contáctanos'
          : isFr
          ? 'Nous contacter'
          : isPt
          ? 'Contacte-nos'
          : isRu
          ? 'Свяжитесь с нами'
          : isHi
          ? 'हमसे संपर्क करें'

          : isZh
          ? '联系我们'
: 'Contact Us';
  String get privacySection5Body => isAr ? 'إذا كان لديك أي استفسار حول سياسة الخصوصية أو كيفية معالجة بياناتك، لا تتردد في التواصل معنا:\n\n📧 البريد الإلكتروني: privacy@newslingo.app\n🌐 الموقع الرسمي: www.newslingo.app' : isEs ? 'Si tienes alguna pregunta sobre la política de privacidad o cómo procesamos tus datos, no dudes en contactarnos:\n\n📧 Correo electrónico: privacy@newslingo.app\n🌐 Sitio web: www.newslingo.app' : isFr ? 'Si vous avez des questions concernant la politique de confidentialité ou le traitement de vos données, n\'hésitez pas à nous contacter :\n\n📧 E-mail : privacy@newslingo.app\n🌐 Site web : www.newslingo.app' : isPt ? 'Se tiver alguma dúvida sobre a política de privacidade ou sobre a forma como os seus dados são tratados, contacte-nos:\n\n📧 E-mail: privacy@newslingo.app\n🌐 Site: www.newslingo.app' : isRu ? 'Если у вас возникнут вопросы по поводу политики конфиденциальности или порядка обработки ваших данных, пожалуйста, свяжитесь с нами:\n\n📧 Электронная почта: privacy@newslingo.app\n🌐 Веб-сайт: www.newslingo.app'
          : isHi
          ? 'यदि आपके पास गोपनीयता नीति या आपके डेटा की प्रक्रिया के बारे में कोई प्रश्न हैं, तो कृपया हमसे संपर्क करें:\n\n📧 ईमेल: privacy@newslingo.app\n🌐 वेबसाइट: www.newslingo.app'
          : isZh
          ? '如果您对隐私政策或您的数据处理方式有任何疑问，请联系我们：\n\n📧 电子邮件：privacy@newslingo.app\n🌐 网站：www.newslingo.app'
  : 'If you have any questions about the privacy policy or how your data is processed, please contact us:\n\n📧 Email: privacy@newslingo.app\n🌐 Website: www.newslingo.app';
  String get termsTitle =>
      isAr ? '📄 شروط الاستخدام' : isEs ? '📄 Términos de uso'
          : isFr
          ? '📄 Conditions d\'utilisation'
          : isPt
          ? '📄 Termos de Utilização'
          : isRu
          ? '📄 Условия использования'
          : isHi
          ? '📄 उपयोग की शर्तें'

          : isZh
          ? '📄 使用条款'
: '📄 Terms of Use';
  String get termsLastUpdated =>
      isAr ? 'آخر تحديث: يونيو 2025' : isEs ? 'Última actualización: junio 2025'
          : isFr
          ? 'Dernière mise à jour : juin 2025'
          : isPt
          ? 'Última atualização: junho de 2025'
          : isRu
          ? 'Последнее обновление: июнь 2025 года'
          : isHi
          ? 'अंतिम अपडेट: जून 2025'

          : isZh
          ? '最后更新：2025年6月'
: 'Last updated: June 2025';
  String get termsSection1Title =>
      isAr ? 'قبول الشروط' : isEs ? 'Aceptación de los términos'
          : isFr
          ? 'Acceptation des conditions générales'
          : isPt
          ? 'Aceitação dos Termos'
          : isRu
          ? 'Согласие с условиями'
          : isHi
          ? 'शर्तों की स्वीकृति'

          : isZh
          ? '接受条款'
: 'Acceptance of Terms';
  String get termsSection1Body => isAr ? 'باستخدامك لتطبيق NewsLingo، فإنك توافق على هذه الشروط والأحكام. إذا كنت لا توافق على أي جزء من هذه الشروط، يجب عليك التوقف عن استخدام التطبيق فوراً.\n\nنحتفظ بالحق في تعديل هذه الشروط في أي وقت. سيتم إعلامك بأي تغييرات جوهرية عبر البريد الإلكتروني أو من خلال التطبيق.' : isEs ? 'Al usar NewsLingo, aceptas estos términos y condiciones. Si no estás de acuerdo con alguna parte de estos términos, debes dejar de usar la aplicación inmediatamente.\n\nNos reservamos el derecho de modificar estos términos en cualquier momento. Te notificaremos cualquier cambio importante por correo electrónico o a través de la aplicación.' : isFr ? 'En utilisant NewsLingo, vous acceptez les présentes conditions générales. Si vous n\'acceptez pas l\'une des dispositions de ces conditions, vous devez cesser immédiatement d\'utiliser l\'application.\n\nNous nous réservons le droit de modifier ces conditions à tout moment. Vous serez informé de toute modification importante par e-mail ou via l\'application.' : isPt ? 'Ao utilizar o NewsLingo, concorda com estes termos e condições. Se não concordar com qualquer parte destes termos, deve deixar de utilizar a aplicação imediatamente.\n\nReservamo-nos o direito de alterar estes termos a qualquer momento. Será notificado de quaisquer alterações substanciais por e-mail ou através da aplicação.' : isRu ? 'Используя NewsLingo, вы соглашаетесь с настоящими условиями. Если вы не согласны с какой-либо частью этих условий, вам необходимо немедленно прекратить использование приложения.\n\nМы оставляем за собой право вносить изменения в настоящие условия в любое время. О любых существенных изменениях вам будет сообщено по электронной почте или через приложение.'
          : isHi
          ? 'NewsLingo का उपयोग करके, आप इन नियमों और शर्तों से सहमत होते हैं। यदि आप इन नियमों के किसी भी भाग से सहमत नहीं हैं, तो आपको तुरंत ऐप का उपयोग बंद कर देना चाहिए।  हम किसी भी समय इन नियमों में संशोधन करने का अधिकार सुरक्षित रखते हैं। आपको किसी भी महत्वपूर्ण बदलाव की सूचना ईमेल या ऐप के माध्यम से दी जाएगी।'
          : isZh
          ? '使用 NewsLingo 即表示您同意这些条款和条件。如果您不同意这些条款的任何部分，必须立即停止使用该应用程序。\n\n我们保留随时修改这些条款的权利。如有任何重大变更，我们将通过电子邮件或应用程序通知您。'
  : 'By using NewsLingo, you agree to these terms and conditions. If you do not agree to any part of these terms, you must stop using the app immediately.\n\nWe reserve the right to modify these terms at any time. You will be notified of any material changes via email or through the app.';
  String get termsSection2Title =>
      isAr ? 'الحساب والتسجيل' : isEs ? 'Cuenta y registro'
          : isFr
          ? 'Compte et inscription'
          : isPt
          ? 'Conta e registo'
          : isRu
          ? 'Учетная запись и регистрация'
          : isHi
          ? 'खाता और पंजीकरण'

          : isZh
          ? '账户与注册'
: 'Account & Registration';
  String get termsSection2Body => isAr ? 'للاستفادة من جميع ميزات التطبيق، يجب عليك إنشاء حساب:\n\n• يجب أن تكون المعلومات التي تقدمها صحيحة وكاملة\n• أنت المسؤول الوحيد عن الحفاظ على سرية كلمة المرور\n• يجب ألا يقل عمرك عن 13 عاماً لاستخدام التطبيق\n• يحق لنا تعليق أو إلغاء حسابات المخالفين للشروط\n\nحساب واحد لكل مستخدم. لا يسمح بإنشاء حسابات متعددة.' : isEs ? 'Para beneficiarte de todas las funciones de la aplicación, debes crear una cuenta:\n\n• La información que proporciones debe ser precisa y completa\n• Eres el único responsable de mantener la confidencialidad de tu contraseña\n• Debes tener al menos 13 años para usar la aplicación\n• Nos reservamos el derecho de suspender o cancelar cuentas que violen los términos\n\nUna cuenta por usuario. No se permiten cuentas múltiples.' : isFr ? 'Pour profiter de toutes les fonctionnalités de l\'application, vous devez créer un compte :\n\n• Les informations que vous fournissez doivent être exactes et complètes\n• Vous êtes seul responsable de la confidentialité de votre mot de passe\n• Vous devez être âgé d\'au moins 13 ans pour utiliser l\'application\n• Nous nous réservons le droit de suspendre ou de résilier les comptes qui enfreignent les conditions d\'utilisation\n\nUn seul compte par utilisateur. La création de comptes multiples n\'est pas autorisée.' : isPt ? 'Para usufruir de todas as funcionalidades da aplicação, deve criar uma conta:\n\n• As informações que fornecer devem ser precisas e completas\n• É o único responsável por manter a confidencialidade da palavra-passe\n• Tem de ter pelo menos 13 anos para utilizar a aplicação\n• Reservamo-nos o direito de suspender ou cancelar contas que violem os termos\n\nUma conta por utilizador. Não são permitidas contas múltiplas.' : isRu ? 'Чтобы воспользоваться всеми функциями приложения, необходимо создать учетную запись:\n\n• Предоставляемая вами информация должна быть точной и полной\n• Вы несете полную ответственность за сохранение конфиденциальности пароля\n• Для использования приложения вам должно быть не менее 13 лет\n• Мы оставляем за собой право приостановить действие или аннулировать учетные записи, нарушающие условия\n\nОдна учетная запись на одного пользователя. Создание нескольких учетных записей запрещено.'
          : isHi
          ? 'सभी ऐप सुविधाओं का लाभ उठाने के लिए, आपको एक खाता बनाना होगा:\n\n• आपके द्वारा प्रदान की गई जानकारी सटीक और पूर्ण होनी चाहिए\n• पासवर्ड की गोपनीयता बनाए रखने के लिए आप पूरी तरह से जिम्मेदार हैं\n• ऐप का उपयोग करने के लिए आपकी आयु कम से कम 13 वर्ष होनी चाहिए\n• हम उन खातों को निलंबित या रद्द करने का अधिकार सुरक्षित रखते हैं जो नियमों का उल्लंघन करते हैं\n\nप्रति उपयोगकर्ता एक खाता। कई खाते की अनुमति नहीं है।'
          : isZh
          ? '要使用本应用的所有功能，您必须创建一个账户：\n\n• 您提供的信息必须准确、完整\n• 您应全权负责确保密码的保密性\n• 您必须年满 13 周岁方可使用本应用\n• 我们保留暂停或注销违反条款的账户的权利\n\n每位用户仅限一个账户。不允许注册多个账户。'
  : 'To benefit from all app features, you must create an account:\n\n• The information you provide must be accurate and complete\n• You are solely responsible for maintaining password confidentiality\n• You must be at least 13 years old to use the app\n• We reserve the right to suspend or cancel accounts that violate the terms\n\nOne account per user. Multiple accounts are not allowed.';
  String get termsSection3Title =>
      isAr ? 'المحتوى التعليمي' : isEs ? 'Contenido educativo'
          : isFr
          ? 'Contenu pédagogique'
          : isPt
          ? 'Conteúdo educativo'
          : isRu
          ? 'Образовательные материалы'
          : isHi
          ? 'शैक्षिक सामग्री'

          : isZh
          ? '教育内容'
: 'Educational Content';
  String get termsSection3Body => isAr ? 'المحتوى المتاح على NewsLingo:\n\n• المقالات الإخبارية مستمدة من مصادر موثوقة مع إعادة صياغتها للأغراض التعليمية\n• المحتوى مخصص للأغراض التعليمية فقط ولا يعتبر نصيحة مهنية\n• جميع الحقوق الفكرية للمحتوى محفوظة لـ NewsLingo\n• قد تتم إزالة أو تحديث المحتوى في أي وقت دون إشعار مسبق\n\nنحن نبذل قصارى جهدنا لضمان دقة المحتوى، لكننا لا نضمن خلوه من الأخطاء.' : isEs ? 'Contenido disponible en NewsLingo:\n\n• Los artículos de noticias provienen de fuentes confiables y se reescriben con fines educativos\n• El contenido es solo para fines educativos y no constituye asesoramiento profesional\n• Todos los derechos de propiedad intelectual del contenido pertenecen a NewsLingo\n• El contenido puede ser eliminado o actualizado en cualquier momento sin previo aviso\n\nHacemos nuestro mejor esfuerzo para garantizar la precisión del contenido, pero no garantizamos que esté libre de errores.' : isFr ? 'Contenu disponible sur NewsLingo :\n\n• Les articles d\'actualité proviennent de sources fiables et sont réécrits à des fins pédagogiques\n• Ce contenu est destiné exclusivement à des fins pédagogiques et ne constitue en aucun cas un avis professionnel\n• Tous les droits de propriété intellectuelle relatifs au contenu appartiennent à NewsLingo\n• Le contenu peut être supprimé ou mis à jour à tout moment sans préavis\n\nNous faisons de notre mieux pour garantir l\'exactitude du contenu, mais nous ne garantissons pas qu\'il soit exempt d\'erreurs.' : isPt ? 'Conteúdo disponível no NewsLingo:\n\n• As notícias provêm de fontes fiáveis e são reescritas para fins educativos\n• O conteúdo destina-se exclusivamente a fins educativos e não constitui aconselhamento profissional\n• Todos os direitos de propriedade intelectual sobre o conteúdo pertencem ao NewsLingo\n• O conteúdo pode ser removido ou atualizado a qualquer momento sem aviso prévio\n\nFazemos o nosso melhor para garantir a exatidão do conteúdo, mas não garantimos que este esteja isento de erros.' : isRu ? 'Материалы, доступные на NewsLingo:\n\n• Новостные статьи берутся из надежных источников и перерабатываются в образовательных целях\n• Материалы предназначены исключительно для образовательных целей и не являются профессиональной консультацией\n• Все права интеллектуальной собственности на контент принадлежат NewsLingo\n• Контент может быть удален или обновлен в любое время без предварительного уведомления\n\nМы делаем все возможное для обеспечения точности контента, но не гарантируем его безошибочность.'
          : isHi
          ? 'NewsLingo पर उपलब्ध सामग्री:\n\n• समाचार लेख विश्वसनीय स्रोतों से लिए जाते हैं और शैक्षिक उद्देश्यों के लिए पुनर्लिखित किए जाते हैं\n• सामग्री केवल शैक्षिक उद्देश्यों के लिए है और यह पेशेवर सलाह नहीं है\n• सामग्री के सभी बौद्धिक संपदा अधिकार NewsLingo के पास हैं। • सामग्री को किसी भी समय पूर्व सूचना के बिना हटाया या अपडेट किया जा सकता है। हम सामग्री की सटीकता सुनिश्चित करने का सर्वोत्तम प्रयास करते हैं, लेकिन हम इसकी त्रुटिरहित होने की गारंटी नहीं देते।'
          : isZh
          ? 'NewsLingo 提供的内容：\n\n• 新闻文章均来自可靠媒体，并为教育目的进行了改写\n• 内容仅供教育用途，不构成专业建议\n• 内容的所有知识产权均归 NewsLingo 所有\n• 内容可能随时被删除或更新，恕不另行通知\n\n我们尽最大努力确保内容的准确性，但不保证内容完全无误。'
  : 'Content available on NewsLingo:\n\n• News articles are sourced from reliable outlets and rewritten for educational purposes\n• Content is for educational purposes only and does not constitute professional advice\n• All intellectual property rights to the content belong to NewsLingo\n• Content may be removed or updated at any time without prior notice\n\nWe do our best to ensure content accuracy, but we do not guarantee it is error-free.';
  String get termsSection4Title =>
      isAr ? 'الاستخدام المسموح' : isEs ? 'Uso permitido'
          : isFr
          ? 'Utilisation autorisée'
          : isPt
          ? 'Utilização permitida'
          : isRu
          ? 'Допустимое использование'
          : isHi
          ? 'अनुमत उपयोग'

          : isZh
          ? '允许用途'
: 'Permitted Use';
  String get termsSection4Body => isAr ? 'عند استخدام NewsLingo، أنت توافق على:\n\n• استخدام التطبيق للأغراض الشخصية والتعليمية فقط\n• عدم نسخ أو إعادة توزيع المحتوى لأغراض تجارية\n• عدم محاولة اختراق أمن التطبيق أو خوادمه\n• عدم استخدام التطبيق لنشر محتوى ضار أو مسيء\n• احترام حقوق الملكية الفكرية لـ NewsLingo والغير\n\nأي استخدام غير مصرح به يؤدي إلى إنهاء حسابك فوراً.' : isEs ? 'Al usar NewsLingo, aceptas:\n\n• Usar la aplicación solo para fines personales y educativos\n• No copiar ni redistribuir el contenido con fines comerciales\n• No intentar hackear la aplicación o sus servidores\n• No usar la aplicación para distribuir contenido dañino u ofensivo\n• Respetar los derechos de propiedad intelectual de NewsLingo y terceros\n\nCualquier uso no autorizado resultará en la terminación inmediata de tu cuenta.' : isFr ? 'En utilisant NewsLingo, vous vous engagez à :\n\n• Utiliser l\'application uniquement à des fins personnelles et éducatives\n• Ne pas copier ni redistribuer de contenu à des fins commerciales\n• Ne pas tenter de pirater l’application ou ses serveurs\n• Ne pas utiliser l’application pour diffuser du contenu nuisible ou offensant\n• Respecter les droits de propriété intellectuelle de NewsLingo et de tiers\n\nToute utilisation non autorisée entraînera la résiliation immédiate de votre compte.' : isPt ? 'Ao utilizar o NewsLingo, concorda em:\n\n• Utilizar a aplicação apenas para fins pessoais e educativos\n• Não copiar nem redistribuir conteúdos para fins comerciais\n• Não tentar piratear a aplicação ou os seus servidores\n• Não utilizar a aplicação para distribuir conteúdos prejudiciais ou ofensivos\n• Respeitar os direitos de propriedade intelectual da NewsLingo e de terceiros\n\nQualquer utilização não autorizada resultará no encerramento imediato da sua conta.' : isRu ? 'Используя NewsLingo, вы соглашаетесь на следующее:\n\n• Использовать приложение исключительно в личных и образовательных целях\n• не копировать и не распространять контент в коммерческих целях\n• не предпринимать попыток взлома приложения или его серверов\n• не использовать приложение для распространения вредоносного или оскорбительного контента\n• уважать права интеллектуальной собственности NewsLingo и других лиц\n\nЛюбое несанкционированное использование приведет к немедленному закрытию вашей учетной записи.'
          : isHi
          ? 'NewsLingo का उपयोग करते समय, आप सहमत हैं:\n\n• ऐप का उपयोग केवल व्यक्तिगत और शैक्षिक उद्देश्यों के लिए करें\n• व्यावसायिक उद्देश्यों के लिए सामग्री की नकल या पुनर्वितरण न करें\n• ऐप या उसके सर्वर को हैक करने का प्रयास न करें\n• हानिकारक या आपत्तिजनक सामग्री वितरित करने के लिए ऐप का उपयोग न करें\n• NewsLingo और अन्य की बौद्धिक संपदा अधिकारों का सम्मान करें\n\nकिसी भी अनधिकृत उपयोग से आपके खाते को तुरंत समाप्त कर दिया जाएगा।'
          : isZh
          ? '使用 NewsLingo 时，您同意：\n\n• 仅将本应用用于个人和教育目的\n• 不得出于商业目的复制或再分发内容\n• 不得试图破解本应用或其服务器\n• 不得利用本应用传播有害或冒犯性内容\n• 尊重 NewsLingo 及其他方的知识产权\n\n任何未经授权的使用都将导致您的账户被立即终止。'
  : 'When using NewsLingo, you agree to:\n\n• Use the app for personal and educational purposes only\n• Not copy or redistribute content for commercial purposes\n• Not attempt to hack the app or its servers\n• Not use the app to distribute harmful or offensive content\n• Respect the intellectual property rights of NewsLingo and others\n\nAny unauthorized use will result in immediate termination of your account.';

  // Saved Articles
  String get savedArticlesTitle =>
      isAr ? '🔖 المحفوظات' : isEs ? '🔖 Artículos guardados'
          : isFr
          ? '🔖 Articles enregistrés'
          : isPt
          ? '🔖 Artigos guardados'
          : isRu
          ? '🔖 Сохраненные статьи'
          : isHi
          ? '🔖 सहेजे गए लेख'

          : isZh
          ? '🔖 收藏的文章'
: '🔖 Saved Articles';
  String get savedArticlesError =>
      isAr ? 'فشل تحميل المقالات المحفوظة'
          : isEs ? 'Error al cargar los artículos guardados'

          : isFr
          ? 'Impossible de charger les articles enregistrés'
          : isPt
          ? 'Não foi possível carregar os artigos guardados'
          : isRu
          ? 'Не удалось загрузить сохраненные статьи'
          : isHi
          ? 'सहेजे गए लेख लोड करने में विफल'

          : isZh
          ? '无法加载已保存的文章'
: 'Failed to load saved articles';
  String get savedArticlesEmpty =>
      isAr ? 'ما في مقالات محفوظة' : isEs ? 'No hay artículos guardados'
          : isFr
          ? 'Aucun article enregistré'
          : isPt
          ? 'Não há artigos guardados'
          : isRu
          ? 'Статей в списке сохраненных нет'
          : isHi
          ? 'No saved articles'

          : isZh
          ? '没有保存的文章'
: 'No saved articles';
  String get savedArticlesEmptyDetail =>
      isAr ? 'احفظ المقالات اللي تعجبك عشان ترجع تقرأها لاحقاً'
          : isEs ? 'Guarda los artículos que te gusten para leerlos más tarde'

          : isFr
          ? 'Enregistrez les articles qui vous plaisent pour les lire plus tard'
          : isPt
          ? 'Guarda os artigos de que gostas para os leres mais tarde'
          : isRu
          ? 'Сохраняйте понравившиеся статьи, чтобы прочитать их позже'
          : isHi
          ? 'पसंदीदा लेख सहेजें, बाद में पढ़ें'

          : isZh
          ? '将喜欢的文章保存起来，以便稍后阅读'
: 'Save articles you like to read them later';

  // Info Pages
  String get aboutTitle =>
      isAr ? 'ℹ️ حول التطبيق' : isEs ? 'ℹ️ Acerca de'
          : isFr
          ? 'ℹ️ À propos'
          : isPt
          ? 'ℹ️ Sobre'
          : isRu
          ? 'ℹ️ О нас'
          : isHi
          ? 'ℹ️ बारे में'

          : isZh
          ? 'ℹ️ 关于'
: 'ℹ️ About';
  String get aboutDescription => isAr
      ? 'نيوز لينجو هو تطبيق تعليمي مبتكر يهدف لمساعدتك على تحسين مهاراتك في اللغة الإنجليزية من خلال قراءة الأخبار اليومية. نقدم لك أخباراً من مصادر موثوقة مقسمة حسب مستواك اللغوي مع ترجمة فورية للكلمات الصعبة وتمارين تفاعلية.'
      : isEs ? 'NewsLingo es una aplicación educativa innovadora que te ayuda a mejorar tus habilidades de inglés a través de la lectura de noticias diarias. Te traemos noticias de fuentes confiables organizadas por tu nivel con traducciones instantáneas y ejercicios interactivos.'

      : isFr
      ? 'NewsLingo est une application éducative innovante qui vous aide à améliorer votre niveau d\'anglais grâce à la lecture quotidienne d\'actualités. Nous vous proposons des sources d\'information fiables, classées par niveau, accompagnées de traductions instantanées et d\'exercices interactifs.'
      : isPt
      ? 'O NewsLingo é uma aplicação educativa inovadora que o ajuda a melhorar as suas competências em inglês através da leitura diária de notícias. Oferecemos-lhe fontes de notícias fiáveis, organizadas de acordo com o seu nível, com traduções instantâneas e exercícios interativos.'
      : isRu
      ? 'NewsLingo — это инновационное образовательное приложение, которое поможет вам улучшить свои навыки владения английским языком благодаря ежедневному чтению новостей. Мы предлагаем вам надежные источники новостей, отсортированные по вашему уровню, с мгновенным переводом и интерактивными упражнениями.'
      : isHi
      ? 'NewsLingo एक अभिनव शैक्षिक ऐप है जो आपको दैनिक समाचार पढ़कर अपनी अंग्रेजी क्षमताएँ सुधारने में मदद करता है। हम आपके स्तर के अनुसार व्यवस्थित विश्वसनीय समाचार स्रोत, तत्काल अनुवाद और इंटरैक्टिव अभ्यास प्रदान करते हैं।'

      : isZh
      ? 'NewsLingo 是一款创新的教育类应用，可帮助您通过每日阅读新闻来提高英语水平。我们为您提供按您的英语水平分类的可靠新闻来源，并配有即时翻译和互动练习。'
: 'NewsLingo is an innovative educational app that helps you improve your English skills through daily news reading. We bring you trusted news sources organized by your level with instant translations and interactive exercises.';
  String get aboutLinks =>
      isAr ? '🔗 روابط التواصل' : isEs ? '🔗 Enlaces sociales'
          : isFr
          ? '🔗 Liens vers les réseaux sociaux'
          : isPt
          ? '🔗 Links para redes sociais'
          : isRu
          ? '🔗 Ссылки на социальные сети'
          : isHi
          ? '🔗 सामाजिक लिंक'

          : isZh
          ? '🔗 社交媒体链接'
: '🔗 Social Links';
  String get aboutWebsite =>
      isAr ? 'الموقع الرسمي' : isEs ? 'Sitio web'
          : isFr
          ? 'Site web'
          : isPt
          ? 'Site'
          : isRu
          ? 'Веб-сайт'
          : isHi
          ? 'वेबसाइट'

          : isZh
          ? '网站'
: 'Website';
  String get aboutTeam =>
      isAr ? '👨‍💻 الفريق' : isEs ? '👨‍💻 Equipo'
          : isFr
          ? '👨‍💻 L\'équipe'
          : isPt
          ? '👨‍💻 Equipa'
          : isRu
          ? '👨‍💻 Команда'
          : isHi
          ? '👨‍💻 टीम'

          : isZh
          ? '👨‍💻 团队'
: '👨‍💻 Team';
  String get aboutTeamDesc => isAr
      ? 'تم تطوير هذا التطبيق من قبل فريق نيوز لينجو\nبهدف نشر التعليم المجاني للجميع.'
      : isEs ? 'Esta aplicación fue desarrollada por el equipo de NewsLingo\ncon el objetivo de difundir educación gratuita para todos.'

      : isFr
      ? 'Cette application a été développée par l\'équipe de NewsLingo\ndans le but de promouvoir l\'accès à l\'éducation gratuite pour tous.'
      : isPt
      ? 'Esta aplicação foi desenvolvida pela equipa da NewsLingo\ncom o objetivo de promover a educação gratuita para todos.'
      : isRu
      ? 'Это приложение было разработано командой NewsLingo\nс целью обеспечения бесплатного образования для всех.'
      : isHi
      ? 'यह ऐप न्यूज़लिंगो टीम द्वारा सभी के लिए मुफ्त शिक्षा फैलाने के लक्ष्य के साथ विकसित किया गया था।'

      : isZh
      ? '该应用由 NewsLingo 团队开发，\n旨在为所有人提供免费教育。'
: 'This app was developed by the NewsLingo team\nwith the goal of spreading free education for all.';
  String get aboutRate =>
      isAr ? 'قيم التطبيق' : isEs ? 'Califica la app'
          : isFr
          ? 'Évaluez l\'application'
          : isPt
          ? 'Avalie a aplicação'
          : isRu
          ? 'Оцените приложение'
          : isHi
          ? 'ऐप को रेट करें'

          : isZh
          ? '为应用评分'
: 'Rate the App';
  String get aboutVersion =>
      isAr ? 'الإصدار 1.0.0' : isEs ? 'Versión 1.0.0'
          : isFr
          ? 'Version 1.0.0'
          : isPt
          ? 'Versão 1.0.0'
          : isRu
          ? 'Версия 1.0.0'
          : isHi
          ? 'संस्करण 1.0.0'

          : isZh
          ? '版本 1.0.0'
: 'Version 1.0.0';
  String get aboutTwitter =>
      isAr ? 'تويتر' : isEs ? 'Twitter'
          : isFr
          ? 'Twitter'
          : isPt
          ? 'Twitter'
          : isRu
          ? 'Twitter'
          : isHi
          ? 'ट्विटर'

          : isZh
          ? 'Twitter'
: 'Twitter';
  String get aboutFacebook =>
      isAr ? 'فيسبوك' : isEs ? 'Facebook'
          : isFr
          ? 'Facebook'
          : isPt
          ? 'Facebook'
          : isRu
          ? 'Facebook'
          : isHi
          ? 'फेसबुक'

          : isZh
          ? 'Facebook'
: 'Facebook';
  String get aboutInstagram =>
      isAr ? 'إنستغرام' : isEs ? 'Instagram'
          : isFr
          ? 'Instagram'
          : isPt
          ? 'Instagram'
          : isRu
          ? 'Instagram'
          : isHi
          ? 'इंस्टाग्राम'

          : isZh
          ? 'Instagram'
: 'Instagram';

  String get helpTitle =>
      isAr ? '🎧 المساعدة' : isEs ? '🎧 Ayuda'
          : isFr
          ? '🎧 Aide'
          : isPt
          ? '🎧 Ajuda'
          : isRu
          ? '🎧 Справка'
          : isHi
          ? '🎧 सहायता'

          : isZh
          ? '🎧 帮助'
: '🎧 Help';
  String get helpFAQ =>
      isAr ? 'الأسئلة الشائعة' : isEs ? 'Preguntas frecuentes'
          : isFr
          ? 'Foire aux questions'
          : isPt
          ? 'Perguntas frequentes'
          : isRu
          ? 'Часто задаваемые вопросы'
          : isHi
          ? 'अक्सर पूछे जाने वाले प्रश्न'

          : isZh
          ? '常见问题解答'
: 'FAQ';
  String get helpFaq1Q =>
      isAr ? 'كيف أحدد مستواي؟' : isEs ? '¿Cómo determino mi nivel?'
          : isFr
          ? 'Comment puis-je déterminer mon niveau ?'
          : isPt
          ? 'Como posso determinar o meu nível?'
          : isRu
          ? 'Как определить свой уровень?'
          : isHi
          ? 'मैं अपना स्तर कैसे निर्धारित करूँ?'

          : isZh
          ? '如何确定我的水平？'
: 'How do I determine my level?';
  String get helpFaq1A => isAr ? 'يمكنك تحديد مستواك من خلال اختبار تحديد المستوى أثناء التسجيل. سنعرض عليك أسئلة قصيرة ونحدد مستواك بين A1 و C1 بناءً على إجاباتك. يمكنك تغيير مستواك لاحقاً من صفحة الإعدادات.' : isEs ? 'Puedes determinar tu nivel a través de la prueba de nivel durante el registro. Te mostraremos preguntas cortas y determinaremos tu nivel entre A1 y C1 según tus respuestas. Puedes cambiar tu nivel más tarde desde la página de Ajustes.' : isFr ? 'Vous pouvez définir votre niveau grâce au test de niveau proposé lors de votre inscription. Nous vous poserons quelques questions courtes et déterminerons votre niveau, compris entre A1 et C1, en fonction de vos réponses. Vous pourrez modifier votre niveau ultérieurement depuis la rubrique « Paramètres ».' : isPt ? 'Podes definir o teu nível através do teste de nivelamento durante a inscrição. Apresentaremos algumas perguntas curtas e determinaremos o teu nível entre A1 e C1 com base nas tuas respostas. Podes alterar o teu nível mais tarde, na secção «Definições».' : isRu ? 'Вы можете определить свой уровень с помощью вступительного теста при регистрации. Мы предложим вам ответить на несколько коротких вопросов и на основе ваших ответов определим ваш уровень в диапазоне от A1 до C1. Позже вы сможете изменить свой уровень в разделе «Настройки».'
          : isHi
          ? 'आप साइन-अप के दौरान प्लेसमेंट टेस्ट के माध्यम से अपना स्तर निर्धारित कर सकते हैं। हम आपको संक्षिप्त प्रश्न दिखाएंगे और आपके उत्तरों के आधार पर A1 से C1 के बीच आपका स्तर निर्धारित करेंगे। आप बाद में सेटिंग्स से अपना स्तर बदल सकते हैं।'
          : isZh
          ? '您可以在注册时通过分级测试来确定自己的水平。我们会向您展示一些简短的问题，并根据您的回答将您的水平评定为A1至C1之间的某个等级。您稍后可以通过“设置”更改您的水平。'
  : 'You can set your level through the placement test during sign-up. We will show you short questions and determine your level between A1 and C1 based on your answers. You can change your level later from Settings.';
  String get helpFaq2Q =>
      isAr ? 'كيف أحفظ الكلمات؟' : isEs ? '¿Cómo guardo palabras?'
          : isFr
          ? 'Comment enregistrer des mots ?'
          : isPt
          ? 'Como é que guardo palavras?'
          : isRu
          ? 'Как сохранить слова?'
          : isHi
          ? 'How do I save words?'

          : isZh
          ? '如何保存单词？'
: 'How do I save words?';
  String get helpFaq2A => isAr ? 'أثناء قراءة المقالات، يمكنك الضغط على أي كلمة غير مفهومة لحفظها في قائمة المفردات. ستظهر لك الترجمة والمعنى في السياق. يمكنك مراجعة الكلمات المحفوظة في قسم "مفرداتي".' : isEs ? 'Mientras lees artículos, puedes tocar cualquier palabra desconocida para guardarla en tu lista de vocabulario. La traducción y el significado aparecerán en contexto. Puedes revisar las palabras guardadas en la sección "Mi vocabulario".' : isFr ? 'Lorsque vous lisez des articles, vous pouvez appuyer sur n\'importe quel mot que vous ne connaissez pas pour l\'ajouter à votre liste de vocabulaire. La traduction et la définition s\'afficheront dans leur contexte. Vous pouvez revoir les mots enregistrés dans la section « Mon vocabulaire ».' : isPt ? 'Enquanto lê artigos, pode tocar em qualquer palavra que não conheça para a guardar na sua lista de vocabulário. A tradução e o significado aparecerão no contexto. Pode rever as palavras guardadas na secção «O meu vocabulário».' : isRu ? 'Во время чтения статей вы можете нажать на любое незнакомое слово, чтобы добавить его в свой словарный список. Перевод и значение слова отобразятся в контексте. Просмотреть сохраненные слова можно в разделе «Мой словарный запас».'
          : isHi
          ? 'लेख पढ़ते समय, आप किसी भी अपरिचित शब्द पर टैप करके उसे अपनी शब्दावली सूची में जोड़ सकते हैं। अनुवाद और अर्थ संदर्भ में दिखाई देंगे। आप "मेरी शब्दावली" अनुभाग में सहेजे गए शब्दों की समीक्षा कर सकते हैं।'
          : isZh
          ? '阅读文章时，您可以点击任何不熟悉的单词，将其保存到词汇表中。该单词的翻译和释义会随上下文显示。您可以在“我的词汇表”部分复习已保存的单词。'
  : 'While reading articles, you can tap any unfamiliar word to save it to your vocabulary list. The translation and meaning will appear in context. You can review saved words in the "My Vocabulary" section.';
  String get helpFaq3Q =>
      isAr ? 'كم مرة أراجع الكلمات؟' : isEs ? '¿Con qué frecuencia debo repasar las palabras?'
          : isFr
          ? 'À quelle fréquence dois-je réviser mon vocabulaire ?'
          : isPt
          ? 'Com que frequência devo rever as palavras?'
          : isRu
          ? 'Как часто мне следует повторять слова?'
          : isHi
          ? 'मुझे शब्दों की समीक्षा कितनी बार करनी चाहिए?'

          : isZh
          ? '我应该多久复习一次单词？'
: 'How often should I review words?';
  String get helpFaq3A => isAr ? 'نظام المراجعة الذكي يذكرك بمراجعة الكلمات بناءً على خوارزمية التكرار المتباعد. سترى الكلمات الجديدة كل يوم، ثم كل 3 أيام، ثم كل أسبوع، ثم كل شهر - لضمان تثبيتها في الذاكرة طويلة المدى.' : isEs ? 'El sistema de revisión inteligente te recuerda repasar palabras basado en un algoritmo de repetición espaciada. Verás palabras nuevas cada día, luego cada 3 días, luego cada semana, luego cada mes - para asegurar que se fijen en la memoria a largo plazo.' : isFr ? 'Le système de révision intelligent vous rappelle de réviser les mots selon un algorithme de répétition espacée. Vous verrez apparaître de nouveaux mots chaque jour, puis tous les trois jours, puis chaque semaine, puis chaque mois, afin de vous assurer qu\'ils s\'ancrent dans votre mémoire à long terme.' : isPt ? 'O sistema de revisão inteligente lembra-te de rever as palavras com base num algoritmo de repetição espaçada. Verás palavras novas todos os dias, depois a cada 3 dias, depois todas as semanas e, por fim, todos os meses — para garantir que ficam gravadas na memória de longo prazo.' : isRu ? 'Интеллектуальная система повторения напоминает вам о необходимости повторять слова по алгоритму интервального повторения. Вы будете видеть новые слова сначала каждый день, затем каждые 3 дня, потом каждую неделю, а затем каждый месяц — чтобы они прочно закрепились в долговременной памяти.'
          : isHi
          ? 'स्मार्ट समीक्षा प्रणाली आपको स्पेस्ड रिपीटिशन एल्गोरिदम के आधार पर शब्दों की समीक्षा करने की याद दिलाती है। आप हर दिन नए शब्द देखेंगे, फिर हर 3 दिन में, फिर हर सप्ताह में, फिर हर महीने में – ताकि वे दीर्घकालिक स्मृति में टिके रहें।'
          : isZh
          ? '智能复习系统会根据间隔重复算法提醒您复习单词。您每天都会看到新单词，随后是每3天、每周、每月一次——以确保这些单词能牢记在长期记忆中。'
  : 'The smart review system reminds you to review words based on a spaced repetition algorithm. You will see new words every day, then every 3 days, then every week, then every month - to ensure they stick in long-term memory.';
  String get helpFaq4Q =>
      isAr ? 'ماذا يعني التسلسل اليومي؟' : isEs ? '¿Qué significa la racha diaria?'
          : isFr
          ? 'Que signifie « série quotidienne » ?'
          : isPt
          ? 'O que significa «série diária»?'
          : isRu
          ? 'Что означает «ежедневная серия»?'
          : isHi
          ? 'डेली स्ट्रीक का क्या मतलब है?'

          : isZh
          ? '“每日连击”是什么意思？'
: 'What does daily streak mean?';
  String get helpFaq4A => isAr ? 'التسلسل اليومي (Streak) هو عدد الأيام المتتالية التي تتعلم فيها في التطبيق. كل يوم تفتح التطبيق وتتعلم كلمة واحدة على الأقل، يزيد تسلسلك. الحفاظ على تسلسل طويل يمنحك مكافآت وإنجازات خاصة!' : isEs ? 'La racha diaria (Streak) es el número de días consecutivos que aprendes en la aplicación. Cada día que abres la aplicación y aprendes al menos una palabra, tu racha aumenta. ¡Mantener una racha larga te da recompensas y logros especiales!' : isFr ? 'La série quotidienne correspond au nombre de jours consécutifs pendant lesquels vous apprenez dans l\'application. Chaque jour où vous ouvrez l\'application et apprenez au moins un mot, votre série s\'allonge. En maintenant une longue série, vous obtenez des récompenses et des succès spéciaux !' : isPt ? 'A sequência diária é o número de dias consecutivos em que estudas na aplicação. Todos os dias em que abrires a aplicação e aprenderes pelo menos uma palavra, a tua sequência aumenta. Manter uma sequência longa dá-te recompensas e conquistas especiais!' : isRu ? '«Ежедневная серия» — это количество дней подряд, в течение которых вы занимаетесь в приложении. Каждый день, когда вы открываете приложение и выучиваете хотя бы одно слово, ваша серия увеличивается. Сохраняя длинную серию, вы получаете награды и специальные достижения!'
          : isHi
          ? 'डेली स्ट्रीक वह लगातार दिनों की संख्या है जिनमें आप ऐप में सीखते हैं। हर दिन जब आप ऐप खोलकर कम से कम एक शब्द सीखते हैं, तो आपकी स्ट्रीक बढ़ जाती है। लंबी स्ट्रीक बनाए रखने पर आपको पुरस्कार और विशेष उपलब्धियाँ मिलती हैं!'
          : isZh
          ? '“每日连学天数”是指你在应用中连续学习的天数。每天只要打开应用并至少学习一个单词，你的连学天数就会增加。保持较长的连学天数，你将获得奖励和特别成就！'
  : 'The daily streak is the number of consecutive days you learn in the app. Every day you open the app and learn at least one word, your streak increases. Maintaining a long streak gives you rewards and special achievements!';
  String get helpFaq5Q =>
      isAr ? 'كيف أستخدم البطاقات التعليمية؟' : isEs ? '¿Cómo uso las tarjetas didácticas?'
          : isFr
          ? 'Comment utiliser les fiches de révision ?'
          : isPt
          ? 'Como é que se utilizam os cartões de estudo?'
          : isRu
          ? 'Как пользоваться карточками?'
          : isHi
          ? 'मैं फ्लैशकार्ड का उपयोग कैसे करूँ?'

          : isZh
          ? '如何使用单词卡？'
: 'How do I use flashcards?';
  String get helpFaq5A => isAr ? 'البطاقات التعليمية (Flashcards) تساعدك على مراجعة الكلمات بطريقة تفاعلية. اذهب إلى قسم "مفرداتي" واختر "البطاقات التعليمية". اقلب البطاقة لترى الترجمة، واضغط ✅ إذا عرفت الكلمة أو ❌ إذا تحتاج لمراجعتها مرة أخرى.' : isEs ? 'Las tarjetas didácticas (Flashcards) te ayudan a repasar palabras de forma interactiva. Ve a la sección "Mi vocabulario" y selecciona "Tarjetas". Voltea la tarjeta para ver la traducción, y presiona ✅ si sabes la palabra o ❌ si necesitas repasarla de nuevo.' : isFr ? 'Les fiches de révision vous aident à réviser votre vocabulaire de manière interactive. Rendez-vous dans « Mon vocabulaire » et sélectionnez « Fiches de révision ». Retournez la fiche pour voir la traduction, puis appuyez sur ✅ si vous connaissez le mot ou sur ❌ si vous devez le réviser à nouveau.' : isPt ? 'Os cartões de memória ajudam-te a rever palavras de forma interativa. Vai a «O meu vocabulário» e seleciona «Cartões de memória». Vira o cartão para veres a tradução e clica em ✅ se souberes a palavra ou em ❌ se precisares de a rever novamente.' : isRu ? 'Карточки помогут вам интерактивно повторять слова. Перейдите в раздел «Мой словарный запас» и выберите «Карточки». Переверните карточку, чтобы увидеть перевод, и нажмите ✅, если знаете слово, или ❌, если вам нужно повторить его ещё раз.'
          : isHi
          ? 'फ़्लैशकार्ड आपको शब्दों की इंटरैक्टिव रूप से समीक्षा करने में मदद करते हैं। "मेरी शब्दावली" पर जाएँ और "फ़्लैशकार्ड" चुनें। अनुवाद देखने के लिए कार्ड पलटें, और यदि आप शब्द जानते हैं तो ✅ दबाएँ, या यदि आपको इसे फिर से समीक्षा करने की आवश्यकता है तो ❌ दबाएँ।'
          : isZh
          ? '单词卡能帮助你以互动的方式复习单词。进入“我的词汇”，选择“单词卡”。翻开卡片查看翻译，如果知道这个单词，请点击✅；如果需要再次复习，请点击❌。'
  : 'Flashcards help you review words interactively. Go to "My Vocabulary" and select "Flashcards". Flip the card to see the translation, and press ✅ if you know the word or ❌ if you need to review it again.';
  String get helpFaq6Q =>
      isAr ? 'هل التطبيق مجاني؟' : isEs ? '¿La aplicación es gratuita?'
          : isFr
          ? 'L\'application est-elle gratuite ?'
          : isPt
          ? 'A aplicação é gratuita?'
          : isRu
          ? 'Приложение бесплатное?'
          : isHi
          ? 'क्या यह ऐप मुफ्त है?'

          : isZh
          ? '这款应用是免费的吗？'
: 'Is the app free?';
  String get helpFaq6A => isAr ? 'نعم، التطبيق مجاني بالكامل مع ميزات أساسية ممتازة. يوجد اشتراك مميز (Premium) يفتح ميزات حصرية مثل تحليل النصوص المتقدم وإحصائيات مفصلة وبدون إعلانات.' : isEs ? 'Sí, la aplicación es completamente gratuita con excelentes funciones básicas. Hay una suscripción Premium que desbloquea funciones exclusivas como análisis de texto avanzado, estadísticas detalladas y sin anuncios.' : isFr ? 'Oui, l\'application est entièrement gratuite et propose d\'excellentes fonctionnalités de base. Il existe un abonnement Premium qui donne accès à des fonctionnalités exclusives telles que l\'analyse avancée de texte, des statistiques détaillées et l\'absence de publicités.' : isPt ? 'Sim, a aplicação é totalmente gratuita e oferece excelentes funcionalidades básicas. Existe uma subscrição Premium que dá acesso a funcionalidades exclusivas, como análise avançada de texto, estatísticas detalhadas e ausência de anúncios.' : isRu ? 'Да, приложение полностью бесплатное и предлагает отличные базовые функции. Существует подписка «Премиум», которая открывает доступ к эксклюзивным функциям, таким как расширенный анализ текста, подробная статистика и отсутствие рекламы.'
          : isHi
          ? 'हाँ, ऐप बेहतरीन बुनियादी सुविधाओं के साथ पूरी तरह से मुफ्त है। एक प्रीमियम सदस्यता भी है जो उन्नत टेक्स्ट विश्लेषण, विस्तृत आँकड़े और बिना विज्ञापनों जैसी विशेष सुविधाएँ अनलॉक करती है।'
          : isZh
          ? '是的，这款应用完全免费，且具备出色的基础功能。此外，还有一项高级订阅服务，可解锁诸如高级文本分析、详细统计数据以及无广告等专属功能。'
  : 'Yes, the app is completely free with excellent basic features. There is a Premium subscription that unlocks exclusive features like advanced text analysis, detailed statistics, and no ads.';
  String get helpContact =>
      isAr ? 'تواصل معنا' : isEs ? 'Contáctanos'
          : isFr
          ? 'Nous contacter'
          : isPt
          ? 'Contacte-nos'
          : isRu
          ? 'Свяжитесь с нами'
          : isHi
          ? 'हमसे संपर्क करें'

          : isZh
          ? '联系我们'
: 'Contact Us';

  // Level Up
  String get levelUpCongrats =>
      isAr ? 'أحسنت! 🎉' : isEs ? '¡Bien hecho! 🎉'
          : isFr
          ? 'Bravo ! 🎉'
          : isPt
          ? 'Muito bem! 🎉'
          : isRu
          ? 'Отлично! 🎉'
          : isHi
          ? 'बहुत बढ़िया! 🎉'

          : isZh
          ? '干得漂亮！🎉'
: 'Well Done! 🎉';
  String levelUpMessage(String level) =>
      isAr ? 'لقد انتقلت إلى المستوى $level' : isEs ? 'Has alcanzado el nivel $level'
          : isFr
          ? 'Vous avez atteint le niveau $level'
          : isPt
          ? 'Alcançaste o nível $level'
          : isRu
          ? 'Вы достигли уровня $level'
          : isHi
          ? 'आप स्तर $level पर पहुँच गए हैं।'

          : isZh
          ? '您已达到 $level 级'
: 'You reached level $level';
  String get levelUpContinue =>
      isAr ? 'متابعة' : isEs ? 'Continuar'
          : isFr
          ? 'Continuer'
          : isPt
          ? 'Continuar'
          : isRu
          ? 'Продолжить'
          : isHi
          ? 'जारी रखें'

          : isZh
          ? '继续'
: 'Continue';
  String get levelUpFeatures =>
      isAr ? 'ميزات جديدة متاحة' : isEs ? 'Nuevas funciones disponibles'
          : isFr
          ? 'Nouvelles fonctionnalités disponibles'
          : isPt
          ? 'Novas funcionalidades disponíveis'
          : isRu
          ? 'Доступны новые функции'
          : isHi
          ? 'नई सुविधाएँ उपलब्ध'

          : isZh
          ? '新功能已上线'
: 'New Features Available';
  String get levelUpFeature1Title =>
      isAr ? 'مقالات متقدمة' : isEs ? 'Artículos avanzados'
          : isFr
          ? 'Articles avancés'
          : isPt
          ? 'Artigos avançados'
          : isRu
          ? 'Статьи для продвинутых пользователей'
          : isHi
          ? 'उन्नत लेख'

          : isZh
          ? '进阶文章'
: 'Advanced Articles';
  String get levelUpFeature1Sub =>
      isAr ? 'مقالات أطول بمفردات أكثر تعقيداً'
          : isEs ? 'Artículos más largos con vocabulario más complejo'

          : isFr
          ? 'Des articles plus longs, avec un vocabulaire plus complexe'
          : isPt
          ? 'Artigos mais longos com vocabulário mais complexo'
          : isRu
          ? 'Более длинные статьи с более сложным словарным запасом'
          : isHi
          ? 'अधिक जटिल शब्दावली वाले लंबे लेख'

          : isZh
          ? '篇幅较长且词汇更复杂的文章'
: 'Longer articles with more complex vocabulary';
  String get levelUpFeature2Title =>
      isAr ? 'كتابة مقالات' : isEs ? 'Escribir artículos'
          : isFr
          ? 'Rédiger des articles'
          : isPt
          ? 'Escrever artigos'
          : isRu
          ? 'Написать статьи'
          : isHi
          ? 'लेख लिखें'

          : isZh
          ? '撰写文章'
: 'Write Articles';
  String get levelUpFeature2Sub =>
      isAr ? 'اكتب مقالاتك الخاصة باللغة الإنجليزية'
          : isEs ? 'Escribe tus propios artículos en inglés'

          : isFr
          ? 'Rédigez vos propres articles en anglais'
          : isPt
          ? 'Escreve os teus próprios artigos em inglês'
          : isRu
          ? 'Пишите свои статьи на английском языке'
          : isHi
          ? 'अंग्रेज़ी में अपने स्वयं के लेख लिखें'

          : isZh
          ? '用英语撰写自己的文章'
: 'Write your own articles in English';
  String get levelUpFeature3Title =>
      isAr ? 'اختبارات أصعب' : isEs ? 'Cuestionarios más difíciles'
          : isFr
          ? 'Des quiz plus difficiles'
          : isPt
          ? 'Questionários mais difíceis'
          : isRu
          ? 'Более сложные викторины'
          : isHi
          ? 'कठिन प्रश्नोत्तरी'

          : isZh
          ? '难度更大的测验'
: 'Harder Quizzes';
  String get levelUpFeature3Sub =>
      isAr ? 'أسئلة أكثر تحدياً لمستواك الجديد'
          : isEs ? 'Preguntas más desafiantes para tu nuevo nivel'

          : isFr
          ? 'Des questions plus difficiles adaptées à votre nouveau niveau'
          : isPt
          ? 'Questões mais desafiantes para o teu novo nível'
          : isRu
          ? 'Более сложные вопросы для вашего нового уровня'
          : isHi
          ? 'आपके नए स्तर के लिए और अधिक चुनौतीपूर्ण प्रश्न'

          : isZh
          ? '适合你新等级的更具挑战性的问题'
: 'More challenging questions for your new level';
  String get levelUpFeature4Title =>
      isAr ? 'مناقشات' : isEs ? 'Discusiones'
          : isFr
          ? 'Discussions'
          : isPt
          ? 'Discussões'
          : isRu
          ? 'Обсуждения'
          : isHi
          ? 'चर्चाएँ'

          : isZh
          ? '讨论'
: 'Discussions';
  String get levelUpFeature4Sub =>
      isAr ? 'انضم لنقاشات مع متعلمين في مستواك'
          : isEs ? 'Únete a discusiones con estudiantes de tu nivel'

          : isFr
          ? 'Participez à des discussions avec des apprenants de votre niveau'
          : isPt
          ? 'Participe em discussões com alunos do seu nível'
          : isRu
          ? 'Присоединяйтесь к обсуждениям с учащимися вашего уровня'
          : isHi
          ? 'अपने स्तर के शिक्षार्थियों के साथ चर्चाओं में शामिल हों'

          : isZh
          ? '加入与同水平学习者的讨论'
: 'Join discussions with learners at your level';
  String get levelUpWordLearned =>
      isAr ? 'كلمة متعلمة' : isEs ? 'Palabras aprendidas'
          : isFr
          ? 'Mots appris'
          : isPt
          ? 'Palavras aprendidas'
          : isRu
          ? 'Выученные слова'
          : isHi
          ? 'सीखे हुए शब्द'

          : isZh
          ? '学到的单词'
: 'Words Learned';
  String get levelUpArticleRead =>
      isAr ? 'مقال مقروء' : isEs ? 'Artículos leídos'
          : isFr
          ? 'Articles lus'
          : isPt
          ? 'Artigos lidos'
          : isRu
          ? 'Прочитанные статьи'
          : isHi
          ? 'पढ़े गए लेख'

          : isZh
          ? '已阅读的文章'
: 'Articles Read';
  String get levelUpQuizPassed =>
      isAr ? 'اختبار ناجح' : isEs ? 'Cuestionarios aprobados'
          : isFr
          ? 'Tests réussis'
          : isPt
          ? 'Testes concluídos com sucesso'
          : isRu
          ? 'Пройденные тесты'
          : isHi
          ? 'क्विज़ उत्तीर्ण'

          : isZh
          ? '已通过的测验'
: 'Quizzes Passed';
  String get levelUpStreakDays =>
      isAr ? 'يوم تسلسل' : isEs ? 'Días de racha'
          : isFr
          ? 'Jours de série'
          : isPt
          ? 'Dias de sequência'
          : isRu
          ? 'Дни серии'
          : isHi
          ? 'स्ट्रिक्ट डेज़'

          : isZh
          ? '连胜天数'
: 'Streak Days';

  // Widgets
  String get errorTitle =>
      isAr ? 'عذراً، حدث خطأ' : isEs ? 'Lo sentimos, ocurrió un error'
          : isFr
          ? 'Désolé, une erreur s\'est produite'
          : isPt
          ? 'Desculpe, ocorreu um erro'
          : isRu
          ? 'Извините, произошла ошибка'
          : isHi
          ? 'क्षमा करें, एक त्रुटि हुई।'

          : isZh
          ? '抱歉，发生了一个错误'
: 'Sorry, an error occurred';
  String get noInternetTitle =>
      isAr ? 'لا يوجد اتصال بالإنترنت' : isEs ? 'Sin conexión a internet'
          : isFr
          ? 'Pas de connexion Internet'
          : isPt
          ? 'Sem ligação à Internet'
          : isRu
          ? 'Нет подключения к Интернету'
          : isHi
          ? 'कोई इंटरनेट कनेक्शन नहीं'

          : isZh
          ? '没有互联网连接'
: 'No internet connection';
  String get noInternetDescription =>
      isAr ? 'تحقق من اتصالك بالشبكة وحاول مرة أخرى'
          : isEs ? 'Verifica tu conexión de red e inténtalo de nuevo'

          : isFr
          ? 'Vérifiez votre connexion réseau et réessayez'
          : isPt
          ? 'Verifique a sua ligação à rede e tente novamente'
          : isRu
          ? 'Проверьте подключение к сети и попробуйте ещё раз'
          : isHi
          ? 'अपने नेटवर्क कनेक्शन की जाँच करें और फिर से प्रयास करें।'

          : isZh
          ? '请检查您的网络连接，然后重试'
: 'Check your network connection and try again';
  String get cardListen =>
      isAr ? 'استمع' : isEs ? 'Escuchar'
          : isFr
          ? 'Écoutez'
          : isPt
          ? 'Ouve'
          : isRu
          ? 'Слушайте'
          : isHi
          ? 'सुनो'

          : isZh
          ? '收听'
: 'Listen';
  String get cardTranslate =>
      isAr ? 'ترجمة' : isEs ? 'Traducir'
          : isFr
          ? 'Traduire'
          : isPt
          ? 'Traduzir'
          : isRu
          ? 'Перевести'
          : isHi
          ? 'अनुवाद करें'

          : isZh
          ? '翻译'
: 'Translate';
  String get grammarRule =>
      isAr ? '📖 القاعدة' : isEs ? '📖 La regla'
          : isFr
          ? '📖 La règle'
          : isPt
          ? '📖 A Regra'
          : isRu
          ? '📖 Правило'
          : isHi
          ? '📖 नियम'

          : isZh
          ? '📖 《规则》'
: '📖 The Rule';
  String get grammarExamples =>
      isAr ? '💬 أمثلة' : isEs ? '💬 Ejemplos'
          : isFr
          ? '💬 Exemples'
          : isPt
          ? '💬 Exemplos'
          : isRu
          ? '💬 Примеры'
          : isHi
          ? '💬 उदाहरण'

          : isZh
          ? '💬 示例'
: '💬 Examples';
  String get grammarGotIt =>
      isAr ? 'فهمت ✅' : isEs ? 'Entendido ✅'
          : isFr
          ? 'C\'est noté ✅'
          : isPt
          ? 'Entendi ✅'
          : isRu
          ? 'Понял ✅'
          : isHi
          ? 'समझ गया ✅'

          : isZh
          ? '明白了 ✅'
: 'Got it ✅';
  String get grammarCategoryWriting =>
      isAr ? '✍️ كتابة' : isEs ? '✍️ Escritura'
          : isFr
          ? '✍️ Écriture'
          : isPt
          ? '✍️ Escrita'
          : isRu
          ? '✍️ Письмо'
          : isHi
          ? '✍️ लेखन'

          : isZh
          ? '✍️ 写作'
: '✍️ Writing';
  String get grammarCategorySpeaking =>
      isAr ? '🗣️ محادثة' : isEs ? '🗣️ Conversación'
          : isFr
          ? '🗣️ Prise de parole'
          : isPt
          ? '🗣️ A falar'
          : isRu
          ? '🗣️ Выступление'
          : isHi
          ? '🗣️ बोलना'

          : isZh
          ? '🗣️ 口语'
: '🗣️ Speaking';
  String get grammarCategoryGrammar =>
      isAr ? '📚 قواعد' : isEs ? '📚 Gramática'
          : isFr
          ? '📚 Grammaire'
          : isPt
          ? '📚 Gramática'
          : isRu
          ? '📚 Грамматика'
          : isHi
          ? '📚 Grammar'

          : isZh
          ? '📚 语法'
: '📚 Grammar';
  String get articleQuizButton =>
      isAr ? 'اختبار' : isEs ? 'Cuestionario'
          : isFr
          ? 'Quiz'
          : isPt
          ? 'Quiz'
          : isRu
          ? 'Викторина'
          : isHi
          ? 'Quiz'

          : isZh
          ? '测验'
: 'Quiz';
  String get articleSaveWords =>
      isAr ? 'حفظ الكلمات' : isEs ? 'Guardar palabras'
          : isFr
          ? 'Enregistrer des mots'
          : isPt
          ? 'Guardar palavras'
          : isRu
          ? 'Сохранить слова'
          : isHi
          ? 'शब्द बचाएँ'

          : isZh
          ? '保存词汇'
: 'Save Words';
  String get articleShowMore =>
      isAr ? 'عرض المزيد' : isEs ? 'Mostrar más'
          : isFr
          ? 'Afficher plus'
          : isPt
          ? 'Mostrar mais'
          : isRu
          ? 'Показать больше'
          : isHi
          ? 'और दिखाएँ'

          : isZh
          ? '显示更多'
: 'Show more';
  String get articleShowAll =>
      isAr ? 'عرض الكل' : isEs ? 'Mostrar todo'
          : isFr
          ? 'Afficher tout'
          : isPt
          ? 'Mostrar tudo'
          : isRu
          ? 'Показать всё'
          : isHi
          ? 'सभी दिखाएँ'

          : isZh
          ? '显示全部'
: 'Show all';
  String get aboutBuiltWith =>
      isAr ? '🏗️ بني باستخدام Flutter' : isEs ? '🏗️ Construido con Flutter'
          : isFr
          ? '🏗️ Développé avec Flutter'
          : isPt
          ? '🏗️ Desenvolvido com Flutter'
          : isRu
          ? '🏗️ Создано с помощью Flutter'
          : isHi
          ? '🏗️ फ्लटर से निर्मित'

          : isZh
          ? '🏗️ 基于 Flutter 构建'
: '🏗️ Built with Flutter';
  String get pronunciationNoSpeech =>
      isAr ? 'لا أسمع أي شيء. يرجى التحقق من الميكروفون.' : isEs ? 'No se oye nada. Comprueba tu micrófono.' : isFr ? 'Je n\'entends rien. Vérifie ton micro.' : isPt ? 'Não consigo ouvir nada. Verifica o teu microfone.' : isRu ? 'Ничего не слышно. Проверьте микрофон.'
          : isHi
          ? 'कुछ भी सुनाई नहीं दे रहा है। अपना माइक्रोफ़ोन जांचें।'
          : isZh
          ? '听不到声音。请检查您的麦克风。'
      : 'Can\'t hear anything. Check your microphone.';

  String get vocabSubtitle =>
      isAr ? 'الكلمات التي قمت بحفظها' : isEs ? 'Tus palabras guardadas' : isFr ? 'Tes mots enregistrés' : isPt ? 'As tuas palavras guardadas' : isRu ? 'Ваши сохраненные слова'
          : isHi
          ? 'आपके सहेजे शब्द'
          : isZh
          ? '您保存的词条'
      : 'Your saved words';

  String get vocabEmptyDetail =>
      isAr ? 'لا توجد كلمات حتى الآن. ابدأ في حفظ الكلمات من المقالات!' : isEs ? 'Aún no hay palabras. ¡Empieza a guardar palabras de los artículos!' : isFr ? 'Pas encore de mots. Commencez à enregistrer des mots tirés d\'articles !' : isPt ? 'Ainda não há palavras. Começa a guardar palavras dos artigos!' : isRu ? 'Пока нет слов. Начните сохранять слова из статей!'
          : isHi
          ? 'अभी तक कोई शब्द नहीं। लेखों से शब्द सहेजना शुरू करें!'
          : isZh
          ? '目前还没有词条。开始从文章中收集词条吧！'
      : 'No words yet. Start saving words from articles!';

  String get vocabDeleted =>
      isAr ? 'تم حذف الكلمة بنجاح' : isEs ? 'La palabra se ha eliminado correctamente' : isFr ? 'Le mot a été supprimé avec succès' : isPt ? 'A palavra foi eliminada com sucesso' : isRu ? 'Слово удалено успешно'
          : isHi
          ? 'शब्द सफलतापूर्वक हटा दिया गया'
          : isZh
          ? '单词已成功删除'
      : 'Word deleted successfully';

  String get undo =>
      isAr ? 'تراجع' : isEs ? 'Deshacer' : isFr ? 'Annuler' : isPt ? 'Desfazer' : isRu ? 'Отменить'
          : isHi
          ? 'रद्द करें'
          : isZh
          ? '撤销'
      : 'Undo';

  String get vocabStreak =>
      isAr ? 'سلسلة الأيام المتتالية' : isEs ? 'Racha de días' : isFr ? 'Série de jours consécutifs' : isPt ? 'Série de dias' : isRu ? 'Серия дней'
          : isHi
          ? 'दिवसीय सिलसिला'
          : isZh
          ? '连续天数'
      : 'Day Streak';

  String get vocabTodayCount =>
      isAr ? 'الكلمات التي تعلمتها اليوم' : isEs ? 'Palabras aprendidas hoy' : isFr ? 'Mots appris aujourd\'hui' : isPt ? 'Palavras aprendidas hoje' : isRu ? 'Слова, выученные сегодня'
          : isHi
          ? 'आज सीखे गए शब्द'
          : isZh
          ? '今天学到的单词'
      : 'Words learned today';

  String get vocabTotal =>
      isAr ? 'إجمالي عدد الكلمات' : isEs ? 'Número total de palabras' : isFr ? 'Nombre total de mots' : isPt ? 'Número total de palavras' : isRu ? 'Общее количество слов'
          : isHi
          ? 'कुल शब्द'
          : isZh
          ? '总字数'
      : 'Total words';

  String get vocabDetail =>
      isAr ? 'تفاصيل الكلمة' : isEs ? 'Detalles de la palabra' : isFr ? 'Détails du mot' : isPt ? 'Detalhes da palavra' : isRu ? 'Сведения о слове'
          : isHi
          ? 'शब्द विवरण'
          : isZh
          ? '词条详情'
      : 'Word Details';

  String get vocabReviewed =>
      isAr ? 'الكلمات التي تمت مراجعتها اليوم' : isEs ? 'Palabras repasadas hoy' : isFr ? 'Mots révisés aujourd\'hui' : isPt ? 'Palavras revistas hoje' : isRu ? 'Слова, прошедшие сегодня проверку'
          : isHi
          ? 'आज समीक्षा किए गए शब्द'
          : isZh
          ? '今天复习的单词'
      : 'Words reviewed today';

  String get vocabReviewedCount =>
      isAr ? 'الكلمات التي تمت مراجعتها' : isEs ? 'Palabras revisadas' : isFr ? 'Mots révisés' : isPt ? 'Palavras revistas' : isRu ? 'Проверенные слова'
          : isHi
          ? 'समीक्षित शब्द'
          : isZh
          ? '已复习的单词'
      : 'Words reviewed';
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['ar', 'en', 'es', 'fr', 'pt', 'ru', 'hi', 'zh']
          .contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
