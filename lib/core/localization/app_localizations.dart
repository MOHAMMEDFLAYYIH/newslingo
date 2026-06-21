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

  // Splash
  String get splashTitle =>
      isAr ? 'نيوز لينجو' : isEs ? 'NewsLingo' : 'NewsLingo';
  String get splashSubtitle =>
      isAr ? 'تعلم الإنجليزية من الأخبار' : isEs ? 'Aprende inglés con las noticias' : 'Learn English from the News';

  // App
  String get appName =>
      isAr ? 'نيوز لينجو' : isEs ? 'NewsLingo' : 'NewsLingo';

  // Bottom Nav
  String get navHome =>
      isAr ? 'الرئيسية' : isEs ? 'Inicio' : 'Home';
  String get navVocabulary =>
      isAr ? 'مفرداتي' : isEs ? 'Vocabulario' : 'Vocabulary';
  String get navProfile =>
      isAr ? 'حسابي' : isEs ? 'Perfil' : 'Profile';

  // Onboarding
  String get obTitle1 =>
      isAr ? 'اقرأ أخبار حقيقية' : isEs ? 'Lee Noticias Reales' : 'Read Real News';
  String get obSub1 => isAr
      ? 'نخبة من الأخبار اليومية\nمصممة خصيصاً لمستواك'
      : isEs ? 'Noticias diarias seleccionadas\ndiseñadas para tu nivel'
      : 'Curated daily news\ndesigned for your level';
  String get obTitle2 =>
      isAr ? 'اضغط وتعلم' : isEs ? 'Toca y Aprende' : 'Tap & Learn';
  String get obSub2 => isAr
      ? 'أي كلمة تضغط عليها\nتشوف معناها وترجمتها ونطقها'
      : isEs ? 'Toca cualquier palabra para ver\nsu significado, traducción y pronunciación'
      : 'Tap any word to see its\nmeaning, translation & pronunciation';
  String get obTitle3 =>
      isAr ? 'تتبع تقدمك' : isEs ? 'Sigue tu Progreso' : 'Track Your Progress';
  String get obSub3 => isAr
      ? 'كلمات تحفظها، شارات تجمعها\nوتسلسل يومي يخليك مستمر'
      : isEs ? 'Guarda palabras, gana insignias\ny mantén tu racha diaria'
      : 'Save words, earn badges\nand keep your streak going';
  String get obSkip =>
      isAr ? 'تخطي' : isEs ? 'Saltar' : 'Skip';
  String get obNext =>
      isAr ? 'التالي' : isEs ? 'Siguiente' : 'Next';
  String get obStart =>
      isAr ? 'خلنا نبدأ!' : isEs ? '¡Empecemos!' : "Let's Start!";

  // Auth
  String get loginTitle =>
      isAr ? 'مرحباً\nبعودتك!' : isEs ? '¡Bienvenido\nde nuevo!' : 'Welcome\nBack!';
  String get loginSubtitle =>
      isAr ? 'سعداء برؤيتك مرة أخرى' : isEs ? 'Nos alegra verte de nuevo' : 'Happy to see you again';
  String get emailLabel =>
      isAr ? 'البريد الإلكتروني' : isEs ? 'Correo electrónico' : 'Email';
  String get emailHint =>
      isAr ? 'example@email.com' : isEs ? 'ejemplo@correo.com' : 'example@email.com';
  String get emailRequired =>
      isAr ? 'يرجى إدخال البريد الإلكتروني'
          : isEs ? 'Por favor ingresa tu correo electrónico'
          : 'Please enter your email';
  String get emailInvalid =>
      isAr ? 'البريد الإلكتروني غير صحيح'
          : isEs ? 'Correo electrónico no válido'
          : 'Invalid email address';
  String get passwordLabel =>
      isAr ? 'كلمة المرور' : isEs ? 'Contraseña' : 'Password';
  String get passwordHint =>
      isAr ? 'أدخل كلمة المرور' : isEs ? 'Ingresa tu contraseña' : 'Enter your password';
  String get passwordRequired =>
      isAr ? 'يرجى إدخال كلمة المرور'
          : isEs ? 'Por favor ingresa tu contraseña'
          : 'Please enter your password';
  String get forgotPassword =>
      isAr ? 'نسيت كلمة المرور؟' : isEs ? '¿Olvidaste tu contraseña?' : 'Forgot password?';
  String get login =>
      isAr ? 'تسجيل الدخول' : isEs ? 'Iniciar sesión' : 'Log In';
  String get noAccount =>
      isAr ? 'ليس لديك حساب؟'
          : isEs ? '¿No tienes cuenta?'
          : "Don't have an account?";
  String get signUp =>
      isAr ? 'إنشاء حساب' : isEs ? 'Registrarse' : 'Sign Up';
  String get errorRateLimit => isAr
      ? 'طلبات كثيرة جداً! انتظر دقيقة وحاول مرة أخرى ⏳'
      : isEs ? '¡Demasiadas solicitudes! Espera un minuto e inténtalo de nuevo ⏳'
      : 'Too many requests! Wait a minute and try again ⏳';
  String get errorEmailNotConfirmed => isAr
      ? 'البريد الإلكتروني غير مفعل. تحقق من بريدك الوارد'
      : isEs ? 'Correo no confirmado. Revisa tu bandeja de entrada'
      : 'Email not confirmed. Check your inbox';
  String get errorInvalidCredentials => isAr
      ? 'البريد الإلكتروني أو كلمة المرور غير صحيحة'
      : isEs ? 'Correo o contraseña no válidos'
      : 'Invalid email or password';
  String get errorGeneric => isAr
      ? 'خطأ: تأكد من اتصال الإنترنت وحاول مرة أخرى'
      : isEs ? 'Error: Verifica tu conexión a internet e inténtalo de nuevo'
      : 'Error: Check your internet and try again';

  String get signUpTitle =>
      isAr ? 'إنشاء حساب' : isEs ? 'Crear cuenta' : 'Create Account';
  String get signUpSubtitle => isAr
      ? 'ابدأ رحلة تعلم الإنجليزية الآن'
      : isEs ? 'Comienza tu viaje de aprendizaje de inglés ahora'
      : 'Start your English learning journey now';
  String get getNameLabel =>
      isAr ? 'الاسم' : isEs ? 'Nombre' : 'Name';
  String get getNameHint =>
      isAr ? 'أدخل اسمك' : isEs ? 'Ingresa tu nombre' : 'Enter your name';
  String get getNameRequired =>
      isAr ? 'يرجى إدخال الاسم' : isEs ? 'Por favor ingresa tu nombre' : 'Please enter your name';
  String get passwordMin =>
      isAr ? '6 أحرف على الأقل' : isEs ? 'Al menos 6 caracteres' : 'At least 6 characters';
  String get passwordLengthError => isAr
      ? 'كلمة المرور يجب أن تكون 6 أحرف على الأقل'
      : isEs ? 'La contraseña debe tener al menos 6 caracteres'
      : 'Password must be at least 6 characters';
  String get confirmPasswordLabel =>
      isAr ? 'تأكيد كلمة المرور' : isEs ? 'Confirmar contraseña' : 'Confirm Password';
  String get confirmPasswordHint =>
      isAr ? 'أعد إدخال كلمة المرور' : isEs ? 'Vuelve a ingresar la contraseña' : 'Re-enter password';
  String get confirmPasswordRequired => isAr
      ? 'يرجى تأكيد كلمة المرور'
      : isEs ? 'Por favor confirma tu contraseña'
      : 'Please confirm your password';
  String get passwordsMismatch => isAr
      ? 'كلمة المرور غير متطابقة'
      : isEs ? 'Las contraseñas no coinciden'
      : 'Passwords do not match';
  String get agreeTerms => isAr
      ? 'أوافق على الشروط والأحكام\nوسياسة الخصوصية'
      : isEs ? 'Acepto los Términos y Condiciones\ny la Política de Privacidad'
      : 'I agree to the Terms of Service\nand Privacy Policy';
  String get createAccount =>
      isAr ? 'إنشاء الحساب' : isEs ? 'Crear cuenta' : 'Create Account';
  String get haveAccount =>
      isAr ? 'لديك حساب بالفعل؟' : isEs ? '¿Ya tienes una cuenta?' : 'Already have an account?';
  String get accountCreated =>
      isAr ? 'تم إنشاء الحساب!' : isEs ? '¡Cuenta creada!' : 'Account Created!';
  String get checkEmail => isAr
      ? 'تحقق من بريدك الإلكتروني لتفعيل الحساب'
      : isEs ? 'Revisa tu correo para activar tu cuenta'
      : 'Check your email to activate your account';
  String get verificationSent => isAr
      ? 'تم إرسال رابط التفعيل إلى بريدك'
      : isEs ? 'Enlace de verificación enviado a tu correo'
      : 'Verification link sent to your email';
  String get verificationDetail => isAr
      ? 'يرجى التحقق من بريدك الوارد والنقر على الرابط لتفعيل حسابك، ثم تسجيل الدخول'
      : isEs ? 'Por favor revisa tu bandeja de entrada y haz clic en el enlace para activar tu cuenta, luego inicia sesión'
      : 'Please check your inbox and click the link to activate your account, then log in';
  String get errorAlreadyRegistered => isAr
      ? 'هذا البريد مسجل بالفعل. سجل دخول بدلاً من ذلك'
      : isEs ? 'Este correo ya está registrado. Inicia sesión en su lugar'
      : 'This email is already registered. Log in instead';
  String get errorWeakPassword => isAr
      ? 'كلمة المرور ضعيفة جداً'
      : isEs ? 'La contraseña es demasiado débil'
      : 'Password is too weak';

  // Forgot Password
  String get forgotTitle => isAr
      ? 'نسيت كلمة\nالمرور؟'
      : isEs ? '¿Olvidaste tu\ncontraseña?'
      : 'Forgot\nPassword?';
  String get forgotSubtitle => isAr
      ? 'لا تقلق! أدخل بريدك الإلكتروني\nوسنرسل لك رمز التأكيد'
      : isEs ? '¡No te preocupes! Ingresa tu correo\ny te enviaremos un código'
      : "Don't worry! Enter your email\nand we'll send you a code";
  String get sendCode =>
      isAr ? 'إرسال رمز التأكيد' : isEs ? 'Enviar código' : 'Send Code';
  String get rememberedPassword => isAr
      ? 'تذكرت كلمة المرور؟'
      : isEs ? '¿Recordaste tu contraseña?'
      : 'Remembered your password?';
  String get codeSent => isAr
      ? 'تم إرسال الرمز إلى بريدك الإلكتروني'
      : isEs ? 'Código enviado a tu correo electrónico'
      : 'Code sent to your email';
  String get checkInbox => isAr
      ? 'تحقق من بريدك الوارد واتبع الرابط\nلتأكيد العملية'
      : isEs ? 'Revisa tu bandeja de entrada y sigue el enlace\npara confirmar'
      : 'Check your inbox and follow the link\nto confirm';
  String get enterCode =>
      isAr ? 'إدخال الرمز' : isEs ? 'Ingresar código' : 'Enter Code';

  // OTP
  String get otpTitle => isAr
      ? 'تأكيد\nالبريد الإلكتروني'
      : isEs ? 'Confirmar\ncorreo electrónico'
      : 'Confirm\nEmail';
  String get otpSubtitle => isAr
      ? 'أدخل رمز التأكيد المكون من 6 أرقام\nالذي أرسلناه إلى بريدك'
      : isEs ? 'Ingresa el código de 6 dígitos\nenviado a tu correo'
      : 'Enter the 6-digit code\nsent to your email';
  String get otpIncorrect => isAr
      ? 'رمز التأكيد غير صحيح. حاول مرة أخرى.'
      : isEs ? 'Código incorrecto. Inténtalo de nuevo.'
      : 'Incorrect code. Try again.';
  String get otpNotReceived => isAr
      ? 'لم يصلك الرمز؟'
      : isEs ? '¿No recibiste el código?'
      : "Didn't receive the code?";
  String get otpResend =>
      isAr ? 'إعادة إرسال الرمز' : isEs ? 'Reenviar código' : 'Resend Code';
  String get otpConfirm =>
      isAr ? 'تأكيد' : isEs ? 'Confirmar' : 'Confirm';
  String get otpSuccess =>
      isAr ? 'تم التحقق بنجاح!' : isEs ? '¡Verificado con éxito!' : 'Verified Successfully!';
  String get otpSuccessDetail => isAr
      ? 'يمكنك الآن تغيير كلمة المرور الخاصة بك'
      : isEs ? 'Ahora puedes cambiar tu contraseña'
      : 'You can now change your password';
  String get backToLogin =>
      isAr ? 'العودة لتسجيل الدخول' : isEs ? 'Volver al inicio de sesión' : 'Back to Login';
  String seconds(int s) =>
      isAr ? '$s ثانية' : isEs ? '$s s' : '$s s';

  // Language Level
  String get levelTitle => isAr
      ? 'ما هو مستواك\nفي الإنجليزية؟'
      : isEs ? '¿Cuál es tu\nnivel de inglés?'
      : "What's Your\nEnglish Level?";
  String get levelSubtitle => isAr
      ? 'حدد مستواك لنخصص لك الأخبار المناسبة\nونقدم لك المحتوى بمستوى يتناسب معك'
      : isEs ? 'Establece tu nivel para recibir noticias personalizadas\ny contenido que se adapte a ti'
      : 'Set your level for personalized news\nand content that fits you';
  String get levelContinue =>
      isAr ? 'استمر' : isEs ? 'Continuar' : 'Continue';
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
      : 'What Topics\nInterest You?';
  String get interestSubtitle => isAr
      ? 'اختر موضوعاً أو أكثر لنخصص لك\nالأخبار التي تناسب اهتماماتك'
      : isEs ? 'Elige uno o más temas para recibir\nnoticias que se ajusten a tus intereses'
      : 'Pick one or more topics to get\nnews that matches your interests';
  String get interestSelected =>
      isAr ? 'تم الاختيار: {n}' : isEs ? 'Seleccionado: {n}' : 'Selected: {n}';
  String get interestMin =>
      isAr ? 'اختر موضوعاً على الأقل' : isEs ? 'Selecciona al menos un tema' : 'Select at least one topic';
  String get interestNext =>
      isAr ? 'التالي' : isEs ? 'Siguiente' : 'Next';
  String get interestGeneral =>
      isAr ? 'عام' : isEs ? 'General' : 'General';
  String get interestSports =>
      isAr ? 'رياضة' : isEs ? 'Deportes' : 'Sports';
  String get interestTechnology =>
      isAr ? 'تكنولوجيا' : isEs ? 'Tecnología' : 'Technology';
  String get interestBusiness =>
      isAr ? 'اقتصاد' : isEs ? 'Negocios' : 'Business';
  String get interestScience =>
      isAr ? 'علوم' : isEs ? 'Ciencia' : 'Science';
  String get interestEntertainment =>
      isAr ? 'ترفيه' : isEs ? 'Entretenimiento' : 'Entertainment';
  String get interestHealth =>
      isAr ? 'صحة' : isEs ? 'Salud' : 'Health';
  String get interestWorld =>
      isAr ? 'عالمية' : isEs ? 'Mundo' : 'World';

  // Home
  String get homeTodayTitle =>
      isAr ? 'أخبار اليوم لمستواك 🎯' : isEs ? 'Noticias de hoy para tu nivel 🎯' : "Today's News for Your Level 🎯";
  String get homeError =>
      isAr ? 'عذراً، حدث خطأ' : isEs ? 'Lo sentimos, algo salió mal' : 'Sorry, something went wrong';
  String get homeErrorDetail =>
      isAr ? 'تحقق من اتصالك بالإنترنت' : isEs ? 'Verifica tu conexión a internet' : 'Check your internet connection';
  String get homeRetry =>
      isAr ? 'حاول مرة ثانية' : isEs ? 'Reintentar' : 'Retry';
  String get homeEmpty =>
      isAr ? 'ما في أخبار هلأ' : isEs ? 'No hay noticias ahora' : 'No news right now';
  String get homeEmptyDetail =>
      isAr ? 'جرب تغير التصنيف أو ارجع بعدين'
          : isEs ? 'Prueba una categoría diferente o vuelve más tarde'
          : 'Try a different category or come back later';
  String get searchHint =>
      isAr ? '🔍  ابحث عن كلمة...' : isEs ? '🔍  Busca una palabra...' : '🔍  Search for a word...';
  String get searchArticlesHint =>
      isAr ? '🔍 بحث عن مقالات...' : isEs ? '🔍 Buscar artículos...' : '🔍 Search articles...';
  String get searchEmptyTitle =>
      isAr ? 'ابحث عن مقالات' : isEs ? 'Buscar artículos' : 'Search Articles';
  String get searchEmptySub =>
      isAr ? 'ابدأ بالبحث لاكتشاف مقالات جديدة' : isEs ? 'Empieza a buscar para descubrir nuevos artículos' : 'Start searching to discover new articles';
  String get searchRecent =>
      isAr ? 'عمليات البحث الأخيرة' : isEs ? 'Búsquedas recientes' : 'Recent Searches';
  String searchResults(int n, String q) =>
      isAr ? '$n نتيجة لـ "$q"' : isEs ? '$n resultados para "$q"' : '$n results for "$q"';
  String get searchNoResults =>
      isAr ? 'ما في نتائج' : isEs ? 'Sin resultados' : 'No results found';
  String get searchNoResultsDetail =>
      isAr ? 'جرب كلمات بحث مختلفة' : isEs ? 'Prueba diferentes términos de búsqueda' : 'Try different search terms';

  // Article
  String get articleListen =>
      isAr ? '🔊 استمع' : isEs ? '🔊 Escuchar' : '🔊 Listen';
  String get articleLoading =>
      isAr ? 'جاري التحميل...' : isEs ? 'Cargando...' : 'Loading...';
  String get articlePlaying =>
      isAr ? 'الاستماع الآن' : isEs ? 'Reproduciendo ahora' : 'Now Playing';
  String get articleNoAudio =>
      isAr ? 'لا يوجد ملف صوتي لهذا المقال' : isEs ? 'No hay audio disponible para este artículo' : 'No audio available for this article';
  String get articleNotFound =>
      isAr ? 'المقال غير موجود' : isEs ? 'Artículo no encontrado' : 'Article not found';
  String get articleError =>
      isAr ? 'فشل تحميل المقالات. تحقق من اتصالك بالإنترنت.'
          : isEs ? 'Error al cargar artículos. Verifica tu conexión.'
          : 'Failed to load articles. Check your connection.';
  String get articleQuizError =>
      isAr ? 'فشل تحميل الاختبار. تحقق من اتصالك بالإنترنت.'
          : isEs ? 'Error al cargar el cuestionario. Verifica tu conexión.'
          : 'Failed to load quiz. Check your connection.';
  String get articleNoQuiz =>
      isAr ? 'لا توجد أسئلة لهذا المقال'
          : isEs ? 'No hay preguntas para este artículo'
          : 'No questions for this article';
  String get vocabBookmarked =>
      isAr ? 'تم حفظ الكلمات 💾' : isEs ? 'Palabras guardadas 💾' : 'Words saved 💾';
  String get articleBookmarked =>
      isAr ? 'تمت الإضافة إلى المحفوظات 🔖' : isEs ? 'Añadido a marcadores 🔖' : 'Added to bookmarks 🔖';
  String get articleUnbookmarked =>
      isAr ? 'تمت الإزالة من المحفوظات' : isEs ? 'Eliminado de marcadores' : 'Removed from bookmarks';

  // Category Labels
  String get categoryGeneral =>
      isAr ? 'عام' : isEs ? 'General' : 'General';
  String get categorySports =>
      isAr ? 'رياضة' : isEs ? 'Deportes' : 'Sports';
  String get categoryTechnology =>
      isAr ? 'تكنولوجيا' : isEs ? 'Tecnología' : 'Technology';
  String get categoryBusiness =>
      isAr ? 'أعمال' : isEs ? 'Negocios' : 'Business';
  String get categoryScience =>
      isAr ? 'علوم' : isEs ? 'Ciencia' : 'Science';
  String get categoryEntertainment =>
      isAr ? 'ترفيه' : isEs ? 'Entretenimiento' : 'Entertainment';

  // Relative Time
  String relativeTimeMinutes(int n) =>
      isAr ? 'منذ $n دقيقة' : isEs ? 'hace $n minutos' : '$n minutes ago';
  String relativeTimeHours(int n) =>
      isAr ? 'منذ $n ساعات' : isEs ? 'hace $n horas' : '$n hours ago';
  String relativeTimeDays(int n) =>
      isAr ? 'منذ $n أيام' : isEs ? 'hace $n días' : '$n days ago';

  // Word Definition Sheet
  String get wordDefinition =>
      isAr ? '📖 التعريف' : isEs ? '📖 Definición' : '📖 Definition';
  String get wordExamples =>
      isAr ? '💬 أمثلة' : isEs ? '💬 Ejemplos' : '💬 Examples';
  String get wordSynonyms =>
      isAr ? '🔗 مرادفات' : isEs ? '🔗 Sinónimos' : '🔗 Synonyms';
  String get wordSave =>
      isAr ? 'احفظ الكلمة' : isEs ? 'Guardar palabra' : 'Save Word';
  String get wordListen =>
      isAr ? 'استمع للنطق' : isEs ? 'Escuchar pronunciación' : 'Listen to Pronunciation';
  String get wordSaved =>
      isAr ? 'تم حفظ الكلمة ✅' : isEs ? 'Palabra guardada ✅' : 'Word Saved ✅';

  // Vocabulary Detail
  String get vocabDetailTitle =>
      isAr ? 'تفاصيل الكلمة' : isEs ? 'Detalles de la palabra' : 'Word Details';
  String get vocabReview =>
      isAr ? 'مراجعة' : isEs ? 'Revisar' : 'Review';
  String get vocabShare =>
      isAr ? 'مشاركة' : isEs ? 'Compartir' : 'Share';
  String get vocabListen =>
      isAr ? 'استمع للنطق' : isEs ? 'Escuchar pronunciación' : 'Listen to Pronunciation';
  String get vocabExamples =>
      isAr ? '💬 أمثلة' : isEs ? '💬 Ejemplos' : '💬 Examples';
  String get vocabSynonyms =>
      isAr ? '🔗 مرادفات' : isEs ? '🔗 Sinónimos' : '🔗 Synonyms';
  String get vocabSimilar =>
      isAr ? '📚 كلمات مشابهة' : isEs ? '📚 Palabras similares' : '📚 Similar Words';

  // Flashcards
  String get flashcardTitle =>
      isAr ? '📇 بطاقات' : isEs ? '📇 Tarjetas' : '📇 Flashcards';
  String flashcardRemaining(int n) =>
      isAr ? '$n متبقي' : isEs ? '$n restantes' : '$n remaining';
  String get flashcardNeedReview =>
      isAr ? 'أحتاج مراجعة' : isEs ? 'Necesito repasar' : 'Need Review';
  String get flashcardKnown =>
      isAr ? 'أعرفها' : isEs ? 'Lo sé' : 'I Know It';
  String get flashcardTapToFlip =>
      isAr ? 'اضغط للقلب' : isEs ? 'Toca para girar' : 'Tap to flip';
  String get flashcardError =>
      isAr ? 'فشل تحميل الكلمات المحفوظة.'
          : isEs ? 'Error al cargar las palabras guardadas.'
          : 'Failed to load saved words.';
  String get flashcardEmpty =>
      isAr ? 'لا توجد كلمات محفوظة.\nاحفظ كلمات من المقالات أولاً.'
          : isEs ? 'No hay palabras guardadas.\nGuarda palabras de los artículos primero.'
          : 'No saved words.\nSave words from articles first.';
  String get flashcardBrowse =>
      isAr ? 'استعرض المقالات' : isEs ? 'Explorar artículos' : 'Browse Articles';
  String get flashcardWellDone =>
      isAr ? 'أحسنت! 🎊' : isEs ? '¡Bien hecho! 🎊' : 'Well Done! 🎊';
  String get flashcardComplete =>
      isAr ? 'لقد أكملت جميع البطاقات'
          : isEs ? 'Completaste todas las tarjetas'
          : 'You completed all cards';
  String get flashcardBackHome =>
      isAr ? 'العودة للرئيسية' : isEs ? 'Volver al inicio' : 'Back to Home';
  String get flashcardRestart =>
      isAr ? 'أعد الكرة' : isEs ? 'Reiniciar' : 'Restart';
  String get flashcardForReview =>
      isAr ? 'للمراجعة' : isEs ? 'Para repasar' : 'For Review';

  // Quiz
  String quizProgress(int current, int total) =>
      isAr ? 'سؤال $current من $total' : isEs ? 'Pregunta $current de $total' : 'Question $current of $total';
  String get quizShowResults =>
      isAr ? 'عرض النتائج 🎉' : isEs ? 'Mostrar resultados 🎉' : 'Show Results 🎉';
  String get quizNext =>
      isAr ? 'السؤال التالي ⬅️' : isEs ? 'Siguiente pregunta ⬅️' : 'Next Question ⬅️';
  String get quizTryAgain =>
      isAr ? 'حاول مرة ثانية' : isEs ? 'Intentar de nuevo' : 'Try Again';
  String resultsTimeFormat(int minutes, int seconds) {
    if (minutes > 0) {
      return isAr ? '$minutesد $secondsث' : isEs ? '$minutes min $seconds s' : '$minutes min $seconds s';
    }
    return isAr ? '$secondsث' : isEs ? '$seconds s' : '$seconds s';
  }

  // Quiz Results
  String get resultsTitle =>
      isAr ? 'النتائج' : isEs ? 'Resultados' : 'Results';
  String get resultsExcellent =>
      isAr ? 'ممتاز! 🎉' : isEs ? '¡Excelente! 🎉' : 'Excellent! 🎉';
  String get resultsGood =>
      isAr ? 'جيد 👍' : isEs ? 'Bien 👍' : 'Good 👍';
  String get resultsTryAgain =>
      isAr ? 'حاول مرة 💪' : isEs ? 'Inténtalo de nuevo 💪' : 'Try Again 💪';
  String get resultsNewAchievement =>
      isAr ? 'إنجاز جديد!' : isEs ? '¡Nuevo logro!' : 'New Achievement!';
  String get resultsAchievementDesc =>
      isAr ? 'حصلت على 80% أو أكثر في هذا الاختبار 🎊'
          : isEs ? 'Obtuviste un 80% o más en este cuestionario 🎊'
          : 'You scored 80% or more on this quiz 🎊';
  String get resultsCorrect =>
      isAr ? 'صحيح' : isEs ? 'Correcto' : 'Correct';
  String get resultsWrong =>
      isAr ? 'خطأ' : isEs ? 'Incorrecto' : 'Wrong';
  String get resultsTime =>
      isAr ? 'الوقت' : isEs ? 'Tiempo' : 'Time';
  String get resultsDetails =>
      isAr ? '📋 تفاصيل الأسئلة' : isEs ? '📋 Detalles de preguntas' : '📋 Question Details';
  String resultsQuestionNum(int n) =>
      isAr ? 'سؤال $n' : isEs ? 'Pregunta $n' : 'Question $n';
  String resultsAnswer(String answer) =>
      isAr ? 'الإجابة: $answer' : isEs ? 'Respuesta: $answer' : 'Answer: $answer';
  String get resultsBackToArticle =>
      isAr ? 'العودة للخبر' : isEs ? 'Volver al artículo' : 'Back to Article';
  String get resultsReviewWords =>
      isAr ? 'مراجعة الكلمات' : isEs ? 'Repasar palabras' : 'Review Words';
  String get resultsShare =>
      isAr ? 'مشاركة النتيجة' : isEs ? 'Compartir resultado' : 'Share Result';

  // Pronunciation
  String get pronunciationTitle =>
      isAr ? 'تدرب على النطق' : isEs ? 'Práctica de pronunciación' : 'Pronunciation Practice';
  String get pronunciationHint =>
      isAr ? 'قل الكلمة بصوت عالٍ 🗣️' : isEs ? 'Di la palabra en voz alta 🗣️' : 'Say the word aloud 🗣️';
  String get pronunciationStop =>
      isAr ? 'اضغط للإيقاف' : isEs ? 'Toca para detener' : 'Tap to Stop';
  String get pronunciationRecord =>
      isAr ? 'اضغط للتسجيل' : isEs ? 'Toca para grabar' : 'Tap to Record';
  String get pronunciationTryAgain =>
      isAr ? 'حاول مرة' : isEs ? 'Intentar de nuevo' : 'Try Again';
  String get pronunciationNext =>
      isAr ? 'كلمة تالية' : isEs ? 'Siguiente palabra' : 'Next Word';
  String get pronunciationExcellent =>
      isAr ? 'نطق رائع! حافظ على هذا المستوى 💪'
          : isEs ? '¡Excelente pronunciación! Sigue así 💪'
          : 'Great pronunciation! Keep it up 💪';
  String get pronunciationGood =>
      isAr ? 'انتبه للمقطع المشدد في الكلمة'
          : isEs ? 'Presta atención a la sílaba tónica'
          : 'Pay attention to the stressed syllable';
  String get pronunciationKeepTrying =>
      isAr ? 'حاول تقليد النطق ببطء، مقطع مقطع'
          : isEs ? 'Intenta imitar lentamente, sílaba por sílaba'
          : 'Try imitating slowly, syllable by syllable';
  String get pronunciationAnalyzing =>
      isAr ? 'يتم التحليل...' : isEs ? 'Analizando...' : 'Analyzing...';

  // Vocabulary Page
  String get vocabTodayTab =>
      isAr ? '🌟 كلمات اليوم' : isEs ? '🌟 Palabras de hoy' : "🌟 Today's Words";
  String get vocabMyWordsTab =>
      isAr ? '📚 كلماتي' : isEs ? '📚 Mis palabras' : '📚 My Words';
  String get vocabTitle =>
      isAr ? 'مفرداتي' : isEs ? 'Mi vocabulario' : 'My Vocabulary';
  String get vocabError =>
      isAr ? 'حدث خطأ في تحميل الكلمات'
          : isEs ? 'Error al cargar las palabras'
          : 'Error loading words';
  String get vocabRetry =>
      isAr ? 'إعادة المحاولة' : isEs ? 'Reintentar' : 'Retry';
  String get vocabEmpty =>
      isAr ? 'ما في كلمات محفوظة' : isEs ? 'No hay palabras guardadas' : 'No saved words';
  String get vocabNoResults =>
      isAr ? 'ما في نتائج للبحث' : isEs ? 'Sin resultados de búsqueda' : 'No search results';

  // Dashboard
  String get dashboardTitle =>
      isAr ? '📊 تقدمك' : isEs ? '📊 Tu progreso' : '📊 Your Progress';
  String get dashboardStats =>
      isAr ? '📈 إحصائيات سريعة' : isEs ? '📈 Estadísticas rápidas' : '📈 Quick Stats';
  String get dashboardWeekly =>
      isAr ? '📅 النشاط الأسبوعي' : isEs ? '📅 Actividad semanal' : '📅 Weekly Activity';
  String get dashboardToday =>
      isAr ? '✅ نشاط اليوم' : isEs ? '✅ Actividad de hoy' : "✅ Today's Activity";
  String get dashboardComparison =>
      isAr ? '📊 مقارنة الأسبوع' : isEs ? '📊 Comparación semanal' : '📊 Week Comparison';
  String get dashboardLevelProgress =>
      isAr ? '⭐ التقدم للمستوى التالي' : isEs ? '⭐ Progreso al siguiente nivel' : '⭐ Next Level Progress';
  String get dashboardLearningTime =>
      isAr ? '⏱ وقت التعلم' : isEs ? '⏱ Tiempo de aprendizaje' : '⏱ Learning Time';
  String points(int n) =>
      isAr ? '$n نقطة' : isEs ? '$n pts' : '$n pts';
  List<String> get weekDaysAbbr => isAr
      ? ['س', 'ن', 'ث', 'ر', 'خ', 'ج', 'س']
      : isEs ? ['D', 'L', 'M', 'M', 'J', 'V', 'S']
      : ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  String get streakDays =>
      isAr ? 'أيام متتالية' : isEs ? 'Días consecutivos' : 'Days Streak';
  String get articlesRead =>
      isAr ? 'مقالات مقروءة' : isEs ? 'Artículos leídos' : 'Articles Read';
  String get wordsSaved =>
      isAr ? 'كلمات محفوظة' : isEs ? 'Palabras guardadas' : 'Words Saved';
  String get quizzesPassed =>
      isAr ? 'اختبارات ناجحة' : isEs ? 'Cuestionarios aprobados' : 'Quizzes Passed';
  String get thisWeek =>
      isAr ? 'هذا الأسبوع' : isEs ? 'Esta semana' : 'This Week';
  String get lastWeek =>
      isAr ? 'الأسبوع الماضي' : isEs ? 'La semana pasada' : 'Last Week';
  String get thisMonth =>
      isAr ? 'هذا الشهر' : isEs ? 'Este mes' : 'This Month';
  String get total =>
      isAr ? 'الإجمالي' : isEs ? 'Total' : 'Total';
  String get hour =>
      isAr ? 'ساعة' : isEs ? 'h' : 'hr';
  String get hourLabel =>
      isAr ? 'ساعات التعلم' : isEs ? 'Horas de aprendizaje' : 'Learning Hours';
  String remainingPoints(int n) =>
      isAr ? '$n نقطة متبقية للترقية'
          : isEs ? '$n pts restantes para el siguiente nivel'
          : '$n pts remaining for next level';
  String levelLabel(String level) =>
      isAr ? 'مستوى $level' : isEs ? 'Nivel $level' : 'Level $level';
  String levelName(String level) {
    const ar = ['مبتدئ', 'أساسي', 'متوسط', 'فوق المتوسط', 'متقدم', 'خبير'];
    const es = ['Principiante', 'Elemental', 'Intermedio', 'Intermedio alto', 'Avanzado', 'Experto'];
    const en = ['Beginner', 'Elementary', 'Intermediate', 'Upper Intermediate', 'Advanced', 'Proficient'];
    final levels = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];
    final i = levels.indexOf(level);
    return i >= 0 ? (isAr ? ar[i] : isEs ? es[i] : en[i]) : level;
  }
  String get activityReadArticle =>
      isAr ? 'قراءة مقال' : isEs ? 'Leer artículo' : 'Read Article';
  String get activityReadDetail =>
      isAr ? 'تابع القراءة لتحسين مستواك'
          : isEs ? 'Sigue leyendo para mejorar'
          : 'Keep reading to improve';
  String get activityQuiz =>
      isAr ? 'اختبار مفردات' : isEs ? 'Cuestionario de vocabulario' : 'Vocabulary Quiz';
  String get activityQuizDetail =>
      isAr ? 'اختبر معرفتك' : isEs ? 'Pon a prueba tu conocimiento' : 'Test your knowledge';
  String get activityFlashcards =>
      isAr ? 'مراجعة بطاقات' : isEs ? 'Repaso con tarjetas' : 'Flashcard Review';
  String get activityFlashcardDetail =>
      isAr ? 'راجع الكلمات المحفوظة' : isEs ? 'Repasa las palabras guardadas' : 'Review saved words';
  String get activityPronunciation =>
      isAr ? 'تدريب نطق' : isEs ? 'Práctica de pronunciación' : 'Pronunciation Practice';
  String get activityPronunciationDetail =>
      isAr ? 'حسن نطقك للكلمات' : isEs ? 'Mejora tu pronunciación' : 'Improve your pronunciation';

  // Streak
  String get streakTitle =>
      isAr ? '🔥 التسلسل' : isEs ? '🔥 Racha' : '🔥 Streak';
  String get streakStart =>
      isAr ? 'ابدأ رحلتك اليوم!' : isEs ? '¡Comienza tu viaje hoy!' : 'Start Your Journey Today!';
  String get streakPrompt =>
      isAr ? 'اقرأ أول خبر وابدأ تسلسلك 🔥' : isEs ? 'Lee tu primera noticia y comienza tu racha 🔥' : 'Read your first news and start your streak 🔥';
  String get streakReadNow =>
      isAr ? 'اقرأ خبر الآن' : isEs ? 'Leer una noticia ahora' : 'Read a News Now';
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
      isAr ? '🏆 الأفضل: ' : isEs ? '🏆 Mejor: ' : '🏆 Best: ';
  String streakDaysCount(int n) =>
      isAr ? '$n يوم' : isEs ? '$n días' : '$n days';
  String streakNextMilestone(String label) =>
      isAr ? 'الهدف التالي: $label' : isEs ? 'Siguiente meta: $label' : 'Next Goal: $label';
  String get streakLast30 =>
      isAr ? '📅 آخر 30 يوم' : isEs ? '📅 Últimos 30 días' : '📅 Last 30 Days';
  String get streakUpcoming =>
      isAr ? '🏅 الإنجازات القادمة' : isEs ? '🏅 Próximos logros' : '🏅 Upcoming Achievements';
  String streakMilestone(int n) =>
      isAr ? '$n يوم' : isEs ? '$n días' : '$n Days';
  String consecutiveDays(int n) =>
      isAr ? '$n يوم متتالي' : isEs ? '$n días consecutivos' : '$n consecutive days';
  String get consecutiveDaysLabel =>
      isAr ? 'يوم متتالي' : isEs ? 'Días consecutivos' : 'Consecutive Days';

  // Leaderboard
  String get leaderboardTitle =>
      isAr ? '🏆 لوحة المتصدرين' : isEs ? '🏆 Tabla de clasificación' : '🏆 Leaderboard';
  String get leaderboardWeek =>
      isAr ? 'هذا الأسبوع' : isEs ? 'Esta semana' : 'This Week';
  String get leaderboardMonth =>
      isAr ? 'هذا الشهر' : isEs ? 'Este mes' : 'This Month';
  String get leaderboardAll =>
      isAr ? 'كل الوقت' : isEs ? 'Todo el tiempo' : 'All Time';
  String get leaderboardError =>
      isAr ? 'فشل تحميل لوحة المتصدرين'
          : isEs ? 'Error al cargar la tabla de clasificación'
          : 'Failed to load leaderboard';
  String get leaderboardRetry =>
      isAr ? 'حاول مرة ثانية' : isEs ? 'Reintentar' : 'Retry';
  String get leaderboardDefaultName =>
      isAr ? 'مستخدم' : isEs ? 'Usuario' : 'User';
  String leaderboardLevel(String l) =>
      isAr ? 'مستوى $l' : isEs ? 'Nivel $l' : 'Level $l';

  // Achievements
  String get achievementsTitle =>
      isAr ? '🏆 الإنجازات' : isEs ? '🏆 Logros' : '🏆 Achievements';
  String get achievementsUnlockedLabel =>
      isAr ? 'مفتوح' : isEs ? 'Desbloqueado' : 'Unlocked';
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
      isAr ? '⚙️ الإعدادات' : isEs ? '⚙️ Ajustes' : '⚙️ Settings';
  String get settingsApp =>
      isAr ? '🎨 التطبيق' : isEs ? '🎨 App' : '🎨 App';
  String get settingsLanguage =>
      isAr ? 'لغة التطبيق' : isEs ? 'Idioma de la app' : 'App Language';
  String get settingsArabic =>
      isAr ? 'العربية' : isEs ? 'Árabe' : 'Arabic';
  String get settingsNotifications =>
      isAr ? '🔔 الإشعارات' : isEs ? '🔔 Notificaciones' : '🔔 Notifications';
  String get settingsNotifTitle =>
      isAr ? 'الإشعارات' : isEs ? 'Notificaciones' : 'Notifications';
  String get settingsNotifSub =>
      isAr ? 'إشعارات عامة' : isEs ? 'Notificaciones generales' : 'General notifications';
  String get settingsDailyNewsTitle =>
      isAr ? 'خبر اليوم' : isEs ? 'Noticia diaria' : 'Daily News';
  String get settingsDailyNewsSub =>
      isAr ? 'إشعار يومي بأهم خبر' : isEs ? 'Notificación diaria con la noticia principal' : 'Daily notification with top news';
  String get settingsVocabRemindTitle =>
      isAr ? 'تذكير المفردات' : isEs ? 'Recordatorio de vocabulario' : 'Vocabulary Reminder';
  String get settingsVocabRemindSub =>
      isAr ? 'ذكرني أراجع الكلمات' : isEs ? 'Recuérdame repasar palabras' : 'Remind me to review words';
  String get settingsRemindTime =>
      isAr ? 'وقت التذكير' : isEs ? 'Hora del recordatorio' : 'Reminder Time';
  String get settingsAccount =>
      isAr ? '⭐ الحساب' : isEs ? '⭐ Cuenta' : '⭐ Account';
  String get settingsProfileTitle =>
      isAr ? 'الملف الشخصي' : isEs ? 'Perfil' : 'Profile';
  String get settingsProfileSub =>
      isAr ? 'تعديل الاسم والصورة' : isEs ? 'Editar nombre y foto' : 'Edit name & photo';
  String get settingsSubscription =>
      isAr ? 'الاشتراك المميز' : isEs ? 'Suscripción premium' : 'Premium Subscription';
  String get settingsSubscriptionSub =>
      isAr ? 'فتح كل الميزات الحصرية' : isEs ? 'Desbloquea todas las funciones exclusivas' : 'Unlock all exclusive features';
  String get settingsSupport =>
      isAr ? '❓ الدعم' : isEs ? '❓ Soporte' : '❓ Support';
  String get settingsHelp =>
      isAr ? 'المساعدة والدعم' : isEs ? 'Ayuda y soporte' : 'Help & Support';
  String get settingsAbout =>
      isAr ? 'حول التطبيق' : isEs ? 'Acerca de' : 'About';
  String get settingsPrivacy =>
      isAr ? 'سياسة الخصوصية' : isEs ? 'Política de privacidad' : 'Privacy Policy';
  String get settingsTerms =>
      isAr ? 'شروط الاستخدام' : isEs ? 'Términos de uso' : 'Terms of Use';
  String get settingsLogout =>
      isAr ? 'تسجيل الخروج' : isEs ? 'Cerrar sesión' : 'Log Out';
  String get settingsLogoutConfirm =>
      isAr ? 'هل أنت متأكد من تسجيل الخروج؟'
          : isEs ? '¿Estás seguro de que quieres cerrar sesión?'
          : 'Are you sure you want to log out?';
  String get settingsDeleteAccount =>
      isAr ? 'حذف الحساب' : isEs ? 'Eliminar cuenta' : 'Delete Account';
  String get settingsDeleteConfirm => isAr
      ? 'هل أنت متأكد؟ هذا الإجراء لا يمكن التراجع عنه.\nسيتم حذف جميع بياناتك نهائياً.'
      : isEs ? '¿Estás seguro? Esta acción no se puede deshacer.\nTodos tus datos serán eliminados permanentemente.'
      : 'Are you sure? This cannot be undone.\nAll your data will be permanently deleted.';
  String get settingsDeleteError => isAr
      ? 'حدث خطأ أثناء حذف الحساب'
      : isEs ? 'Ocurrió un error al eliminar la cuenta'
      : 'An error occurred while deleting your account';
  String get cancel =>
      isAr ? 'إلغاء' : isEs ? 'Cancelar' : 'Cancel';
  String get settingsNotifManage =>
      isAr ? 'إدارة إشعارات التطبيق' : isEs ? 'Gestionar notificaciones de la app' : 'Manage App Notifications';
  String get settingsNotifAchieveTitle =>
      isAr ? 'إنجازات جديدة' : isEs ? 'Nuevos logros' : 'New Achievements';
  String get settingsNotifAchieveSub =>
      isAr ? 'إشعار عند تحقيق إنجاز جديد'
          : isEs ? 'Notificación cuando obtengas un nuevo logro'
          : 'Notification when you earn a new achievement';
  String get settingsNotifWeeklyTitle =>
      isAr ? 'تقرير أسبوعي' : isEs ? 'Informe semanal' : 'Weekly Report';
  String get settingsNotifWeeklySub =>
      isAr ? 'ملخص تقدمك الأسبوعي كل يوم أحد'
          : isEs ? 'Resumen semanal de tu progreso cada domingo'
          : 'Your weekly progress summary every Sunday';
  String get settingsNotifTipsTitle =>
      isAr ? 'نصائح تعلم' : isEs ? 'Consejos de aprendizaje' : 'Learning Tips';
  String get settingsNotifTipsSub =>
      isAr ? 'نصائح وحيل لتحسين تعلمك للغة'
          : isEs ? 'Consejos y trucos para mejorar tu aprendizaje del idioma'
          : 'Tips and tricks to improve your language learning';

  // Language Settings
  String get langSettingsTitle =>
      isAr ? '🌐 لغة التطبيق' : isEs ? '🌐 Idioma de la app' : '🌐 App Language';
  String get langSettingsChoose =>
      isAr ? 'اختر لغة التطبيق' : isEs ? 'Elige el idioma de la app' : 'Choose App Language';
  String get langSettingsApply =>
      isAr ? 'تطبيق' : isEs ? 'Aplicar' : 'Apply';

  // Profile
  String get profileDefaultName =>
      isAr ? 'مستخدم' : isEs ? 'Usuario' : 'User';
  String get profileDefaultLevel =>
      isAr ? 'B1 - متوسط' : isEs ? 'B1 - Intermedio' : 'B1 - Intermediate';
  String get profileStatStreak =>
      isAr ? 'تسلسل' : isEs ? 'Racha' : 'Streak';
  String get profileStatArticles =>
      isAr ? 'مقالات' : isEs ? 'Artículos' : 'Articles';
  String get profileStatWords =>
      isAr ? 'كلمات' : isEs ? 'Palabras' : 'Words';
  String get profileStatQuizzes =>
      isAr ? 'اختبارات' : isEs ? 'Cuestionarios' : 'Quizzes';
  String get profileSavedArticles =>
      isAr ? 'المقالات المحفوظة' : isEs ? 'Artículos guardados' : 'Saved Articles';
  String get profileAchievements =>
      isAr ? 'الإنجازات' : isEs ? 'Logros' : 'Achievements';
  String get profileDashboard =>
      isAr ? 'لوحة التقدم' : isEs ? 'Panel de progreso' : 'Progress Dashboard';
  String get profileSettings =>
      isAr ? 'الإعدادات' : isEs ? 'Ajustes' : 'Settings';
  String get profileSubscription =>
      isAr ? 'الاشتراك المميز' : isEs ? 'Suscripción premium' : 'Premium Subscription';
  String get profileHelp =>
      isAr ? 'المساعدة والدعم' : isEs ? 'Ayuda y soporte' : 'Help & Support';
  String get profileAbout =>
      isAr ? 'حول التطبيق' : isEs ? 'Acerca de' : 'About';

  // Edit Profile
  String get editProfileTitle =>
      isAr ? '✏️ تعديل الملف' : isEs ? '✏️ Editar perfil' : '✏️ Edit Profile';
  String get editProfileBio =>
      isAr ? 'نبذة عني' : isEs ? 'Sobre mí' : 'About Me';
  String get editProfileBioHint =>
      isAr ? 'اكتب نبذة عن نفسك...' : isEs ? 'Escribe algo sobre ti...' : 'Write something about yourself...';
  String get editProfileSave =>
      isAr ? 'حفظ التغييرات' : isEs ? 'Guardar cambios' : 'Save Changes';
  String get editProfileCancel =>
      isAr ? 'إلغاء' : isEs ? 'Cancelar' : 'Cancel';
  String get editProfileLevel =>
      isAr ? 'المستوى' : isEs ? 'Nivel' : 'Level';
  String get editProfileInterests =>
      isAr ? 'الاهتمامات' : isEs ? 'Intereses' : 'Interests';
  String get editProfileLevelA1 =>
      isAr ? 'A1 - مبتدئ' : isEs ? 'A1 - Principiante' : 'A1 - Beginner';
  String get editProfileLevelA2 =>
      isAr ? 'A2 - مبتدئ متقدم' : isEs ? 'A2 - Principiante avanzado' : 'A2 - Advanced Beginner';
  String get editProfileLevelB1 =>
      isAr ? 'B1 - متوسط' : isEs ? 'B1 - Intermedio' : 'B1 - Intermediate';
  String get editProfileLevelB2 =>
      isAr ? 'B2 - فوق المتوسط' : isEs ? 'B2 - Intermedio alto' : 'B2 - Upper Intermediate';
  String get editProfileLevelC1 =>
      isAr ? 'C1 - متقدم' : isEs ? 'C1 - Avanzado' : 'C1 - Advanced';
  String get editProfileLevelC2 =>
      isAr ? 'C2 - محترف' : isEs ? 'C2 - Competente' : 'C2 - Proficient';
  String get editProfileInterestNews =>
      isAr ? 'أخبار' : isEs ? 'Noticias' : 'News';
  String get editProfileInterestTech =>
      isAr ? 'تكنولوجيا' : isEs ? 'Tecnología' : 'Technology';
  String get editProfileInterestSports =>
      isAr ? 'رياضة' : isEs ? 'Deportes' : 'Sports';
  String get editProfileInterestScience =>
      isAr ? 'علوم' : isEs ? 'Ciencia' : 'Science';
  String get editProfileInterestBusiness =>
      isAr ? 'اقتصاد' : isEs ? 'Negocios' : 'Business';
  String get editProfileInterestEntertainment =>
      isAr ? 'ترفيه' : isEs ? 'Entretenimiento' : 'Entertainment';
  String get editProfileInterestHealth =>
      isAr ? 'صحة' : isEs ? 'Salud' : 'Health';
  String get editProfileInterestWorld =>
      isAr ? 'عالم' : isEs ? 'Mundo' : 'World';
  String get editProfileSaveError =>
      isAr ? 'خطأ في حفظ التغييرات:' : isEs ? 'Error al guardar cambios:' : 'Error saving changes:';

  // Subscription
  String get subscriptionTitle =>
      isAr ? '⭐ الاشتراك المميز' : isEs ? '⭐ Suscripción premium' : '⭐ Premium Subscription';
  String get subscriptionChoose =>
      isAr ? 'اختر خطتك' : isEs ? 'Elige tu plan' : 'Choose Your Plan';
  String get subscriptionAutoRenew =>
      isAr ? 'سيتم تجديد الاشتراك تلقائياً. يمكنك الإلغاء في أي وقت.'
          : isEs ? 'Se renovará automáticamente. Puedes cancelar en cualquier momento.'
          : 'Auto-renews. Cancel anytime.';
  String get subscriptionNoAds =>
      isAr ? 'بدون إعلانات' : isEs ? 'Sin anuncios' : 'No Ads';
  String get subscriptionNoAdsDesc =>
      isAr ? 'تصفح بدون أي إعلانات مزعجة'
          : isEs ? 'Navega sin anuncios molestos'
          : 'Browse without annoying ads';
  String get subscriptionAllLessons =>
      isAr ? 'جميع الدروس' : isEs ? 'Todas las lecciones' : 'All Lessons';
  String get subscriptionAllLessonsDesc =>
      isAr ? 'وصول كامل لجميع الدروس والمقالات'
          : isEs ? 'Acceso completo a todas las lecciones y artículos'
          : 'Full access to all lessons & articles';
  String get subscriptionAdvancedAudio =>
      isAr ? 'نطق صوتي متقدم' : isEs ? 'Audio avanzado' : 'Advanced Audio';
  String get subscriptionAdvancedAudioDesc =>
      isAr ? 'استمع للنطق الصحيح للكلمات'
          : isEs ? 'Escucha la pronunciación correcta de las palabras'
          : 'Listen to correct pronunciation';
  String get subscriptionDownload =>
      isAr ? 'تحميل المقالات' : isEs ? 'Descargar artículos' : 'Download Articles';
  String get subscriptionDownloadDesc =>
      isAr ? 'احفظ المقالات للقراءة بدون إنترنت'
          : isEs ? 'Guarda artículos para leer sin conexión'
          : 'Save articles for offline reading';
  String get subscriptionChallenges =>
      isAr ? 'تحديات حصرية' : isEs ? 'Desafíos exclusivos' : 'Exclusive Challenges';
  String get subscriptionChallengesDesc =>
      isAr ? 'شارك في تحديات أسبوعية للمتفوقين'
          : isEs ? 'Participa en desafíos semanales para los mejores'
          : 'Join weekly challenges for top learners';
  String get subscriptionFeatures =>
      isAr ? 'مميزات الاشتراك' : isEs ? 'Funciones de la suscripción' : 'Subscription Features';
  String get subscriptionMonthly =>
      isAr ? 'شهري' : isEs ? 'Mensual' : 'Monthly';
  String get subscriptionYearly =>
      isAr ? 'سنوي' : isEs ? 'Anual' : 'Yearly';
  String get subscriptionLifetime =>
      isAr ? 'مدى الحياة' : isEs ? 'De por vida' : 'Lifetime';
  String get subscriptionBestValue =>
      isAr ? 'الأفضل' : isEs ? 'Mejor valor' : 'Best Value';
  String get subscriptionCurrent =>
      isAr ? 'حالي' : isEs ? 'Actual' : 'Current';
  String get subscriptionSubscribe =>
      isAr ? 'اشترك الآن' : isEs ? 'Suscribirse ahora' : 'Subscribe Now';
  String get subscriptionMonthlyCurrency =>
      isAr ? '\$/شهر' : isEs ? '\$/mes' : '\$/month';
  String get subscriptionYearlyCurrency =>
      isAr ? '\$/سنة' : isEs ? '\$/año' : '\$/year';
  String get subscriptionLifetimeCurrency =>
      isAr ? '\$ لمرة واحدة' : isEs ? '\$ único' : '\$ one-time';
  String get subscriptionMonthlyPrice =>
      isAr ? '٩٫٩٩' : isEs ? '9.99' : '9.99';
  String get subscriptionYearlyPrice =>
      isAr ? '٧٩٫٩٩' : isEs ? '79.99' : '79.99';
  String get subscriptionLifetimePrice =>
      isAr ? '١٤٩٫٩٩' : isEs ? '149.99' : '149.99';

  // Payment
  String get paymentTitle =>
      isAr ? '💳 الدفع' : isEs ? '💳 Pago' : '💳 Payment';
  String get paymentMethod =>
      isAr ? 'طريقة الدفع' : isEs ? 'Método de pago' : 'Payment Method';
  String get paymentCreditCard =>
      isAr ? 'بطاقة ائتمان' : isEs ? 'Tarjeta de crédito' : 'Credit Card';
  String get paymentCardHolder =>
      isAr ? 'اسم حامل البطاقة' : isEs ? 'Nombre del titular' : 'Cardholder Name';
  String get paymentCardHolderHint =>
      isAr ? 'الاسم على البطاقة' : isEs ? 'Nombre en la tarjeta' : 'Name on card';
  String get paymentCardNumber =>
      isAr ? 'رقم البطاقة' : isEs ? 'Número de tarjeta' : 'Card Number';
  String get paymentExpiry =>
      isAr ? 'تاريخ الانتهاء' : isEs ? 'Fecha de vencimiento' : 'Expiry Date';
  String get paymentDiscount =>
      isAr ? 'كود الخصم' : isEs ? 'Código de descuento' : 'Discount Code';
  String get paymentDiscountHint =>
      isAr ? 'أدخل كود الخصم' : isEs ? 'Ingresa el código de descuento' : 'Enter discount code';
  String get paymentApply =>
      isAr ? 'تطبيق' : isEs ? 'Aplicar' : 'Apply';
  String get paymentApplied =>
      isAr ? 'تم تطبيق الخصم بنجاح!' : isEs ? '¡Descuento aplicado con éxito!' : 'Discount applied successfully!';
  String get paymentSubtotal =>
      isAr ? 'المجموع الفرعي' : isEs ? 'Subtotal' : 'Subtotal';
  String get paymentDiscountLabel =>
      isAr ? 'الخصم' : isEs ? 'Descuento' : 'Discount';
  String get paymentTotal =>
      isAr ? 'المجموع' : isEs ? 'Total' : 'Total';
  String paymentPay(double amount) =>
      isAr ? 'ادفع \$$amount' : isEs ? 'Pagar \$$amount' : 'Pay \$$amount';
  String get paymentPlanAnnual =>
      isAr ? 'الخطة السنوية' : isEs ? 'Plan anual' : 'Annual Plan';
  String get paymentCardInfo =>
      isAr ? 'معلومات البطاقة' : isEs ? 'Información de la tarjeta' : 'Card Information';
  String get paymentCardHolderShort =>
      isAr ? 'حامل البطاقة' : isEs ? 'Titular' : 'Cardholder';
  String get paymentSuccess =>
      isAr ? '✅ تمت عملية الدفع بنجاح!' : isEs ? '✅ ¡Pago exitoso!' : '✅ Payment successful!';
  String get privacyTitle =>
      isAr ? '🔒 سياسة الخصوصية' : isEs ? '🔒 Política de privacidad' : '🔒 Privacy Policy';
  String get privacyLastUpdated =>
      isAr ? 'آخر تحديث: يونيو 2025' : isEs ? 'Última actualización: junio 2025' : 'Last updated: June 2025';
  String get privacySection1Title =>
      isAr ? 'المعلومات التي نجمعها' : isEs ? 'Información que recopilamos' : 'Information We Collect';
  String get privacySection1Body => isAr ? 'نقوم بجمع المعلومات التالية لتحسين تجربتك التعليمية:\n\n• معلومات الحساب: الاسم، البريد الإلكتروني، كلمة المرور المشفرة\n• بيانات التعلم: الكلمات المحفوظة، المقالات المقروءة، نتائج الاختبارات\n• معلومات الجهاز: نوع الجهاز، نظام التشغيل، إصدار التطبيق\n• بيانات الاستخدام: مدة الجلسات، الصفحات التي تزورها، تفضيلاتك\n\nلا نقوم بجمع أي معلومات حساسة دون موافقتك الصريحة.' : isEs ? 'Recopilamos la siguiente información para mejorar tu experiencia de aprendizaje:\n\n• Información de la cuenta: nombre, correo electrónico, contraseña encriptada\n• Datos de aprendizaje: palabras guardadas, artículos leídos, resultados de cuestionarios\n• Información del dispositivo: tipo de dispositivo, sistema operativo, versión de la app\n• Datos de uso: duración de sesiones, páginas visitadas, preferencias\n\nNo recopilamos información sensible sin tu consentimiento explícito.' : 'We collect the following information to improve your learning experience:\n\n• Account info: name, email, encrypted password\n• Learning data: saved words, read articles, quiz results\n• Device info: device type, OS, app version\n• Usage data: session duration, pages visited, preferences\n\nWe do not collect any sensitive information without your explicit consent.';
  String get privacySection2Title =>
      isAr ? 'كيفية استخدام المعلومات' : isEs ? 'Cómo usamos la información' : 'How We Use Information';
  String get privacySection2Body => isAr ? 'نستخدم معلوماتك للأغراض التالية:\n\n• تقديم محتوى تعليمي مخصص حسب مستواك واهتماماتك\n• تحسين وتطوير ميزات التطبيق بناءً على سلوك المستخدمين\n• إرسال إشعارات تذكيرية وتقارير أسبوعية (حسب إعداداتك)\n• التواصل معك بخصوص تحديثات التطبيق والدعم الفني\n\nلن نستخدم بياناتك لأغراض إعلانية دون موافقتك.' : isEs ? 'Usamos tu información para los siguientes fines:\n\n• Proporcionar contenido educativo personalizado según tu nivel e intereses\n• Mejorar y desarrollar funciones de la app basadas en el comportamiento de los usuarios\n• Enviar notificaciones de recordatorio e informes semanales (según tu configuración)\n• Comunicarnos contigo sobre actualizaciones de la app y soporte técnico\n\nNo usaremos tus datos para fines publicitarios sin tu consentimiento.' : 'We use your information for the following purposes:\n\n• Providing personalized educational content based on your level and interests\n• Improving and developing app features based on user behavior\n• Sending reminder notifications and weekly reports (per your settings)\n• Communicating with you regarding app updates and technical support\n\nWe will not use your data for advertising purposes without your consent.';
  String get privacySection3Title =>
      isAr ? 'حماية المعلومات' : isEs ? 'Protección de la información' : 'Information Protection';
  String get privacySection3Body => isAr ? 'نحن نأخذ أمن بياناتك على محمل الجد:\n\n• جميع البيانات مشفرة أثناء النقل (SSL/TLS)\n• كلمات المرور مشفرة باستخدام أحدث معايير التشفير\n• خوادمنا محمية بأحدث بروتوكولات الأمان\n• لا نشارك بياناتك مع أطراف ثالثة دون موافقتك\n• نراجع إجراءاتنا الأمنية بشكل دوري' : isEs ? 'Tomamos la seguridad de tus datos muy en serio:\n\n• Todos los datos están encriptados en tránsito (SSL/TLS)\n• Las contraseñas están encriptadas con los últimos estándares\n• Nuestros servidores están protegidos con los protocolos de seguridad más recientes\n• No compartimos tus datos con terceros sin tu consentimiento\n• Revisamos nuestros procedimientos de seguridad periódicamente' : 'We take your data security seriously:\n\n• All data is encrypted in transit (SSL/TLS)\n• Passwords are encrypted using the latest encryption standards\n• Our servers are protected by the latest security protocols\n• We do not share your data with third parties without your consent\n• We review our security procedures periodically';
  String get privacySection4Title =>
      isAr ? 'حقوقك' : isEs ? 'Tus derechos' : 'Your Rights';
  String get privacySection4Body => isAr ? 'لديك الحقوق التالية فيما يخص بياناتك:\n\n• الوصول إلى جميع بياناتك الشخصية في أي وقت\n• طلب تصحيح أو تحديث بياناتك\n• طلب حذف حسابك وجميع بياناتك المرتبطة به\n• سحب الموافقة على معالجة البيانات في أي وقت\n• تصدير بياناتك بصيغة قابلة للقراءة\n\nيمكنك ممارسة هذه الحقوق من خلال الإعدادات أو التواصل معنا.' : isEs ? 'Tienes los siguientes derechos con respecto a tus datos:\n\n• Acceder a todos tus datos personales en cualquier momento\n• Solicitar la corrección o actualización de tus datos\n• Solicitar la eliminación de tu cuenta y todos los datos asociados\n• Retirar el consentimiento para el procesamiento de datos en cualquier momento\n• Exportar tus datos en un formato legible\n\nPuedes ejercer estos derechos a través de Ajustes o contactándonos.' : 'You have the following rights regarding your data:\n\n• Access all your personal data at any time\n• Request correction or update of your data\n• Request deletion of your account and all associated data\n• Withdraw consent for data processing at any time\n• Export your data in a readable format\n\nYou can exercise these rights through Settings or by contacting us.';
  String get privacySection5Title =>
      isAr ? 'اتصل بنا' : isEs ? 'Contáctanos' : 'Contact Us';
  String get privacySection5Body => isAr ? 'إذا كان لديك أي استفسار حول سياسة الخصوصية أو كيفية معالجة بياناتك، لا تتردد في التواصل معنا:\n\n📧 البريد الإلكتروني: privacy@newslingo.app\n🌐 الموقع الرسمي: www.newslingo.app' : isEs ? 'Si tienes alguna pregunta sobre la política de privacidad o cómo procesamos tus datos, no dudes en contactarnos:\n\n📧 Correo electrónico: privacy@newslingo.app\n🌐 Sitio web: www.newslingo.app' : 'If you have any questions about the privacy policy or how your data is processed, please contact us:\n\n📧 Email: privacy@newslingo.app\n🌐 Website: www.newslingo.app';
  String get termsTitle =>
      isAr ? '📄 شروط الاستخدام' : isEs ? '📄 Términos de uso' : '📄 Terms of Use';
  String get termsLastUpdated =>
      isAr ? 'آخر تحديث: يونيو 2025' : isEs ? 'Última actualización: junio 2025' : 'Last updated: June 2025';
  String get termsSection1Title =>
      isAr ? 'قبول الشروط' : isEs ? 'Aceptación de los términos' : 'Acceptance of Terms';
  String get termsSection1Body => isAr ? 'باستخدامك لتطبيق NewsLingo، فإنك توافق على هذه الشروط والأحكام. إذا كنت لا توافق على أي جزء من هذه الشروط، يجب عليك التوقف عن استخدام التطبيق فوراً.\n\nنحتفظ بالحق في تعديل هذه الشروط في أي وقت. سيتم إعلامك بأي تغييرات جوهرية عبر البريد الإلكتروني أو من خلال التطبيق.' : isEs ? 'Al usar NewsLingo, aceptas estos términos y condiciones. Si no estás de acuerdo con alguna parte de estos términos, debes dejar de usar la aplicación inmediatamente.\n\nNos reservamos el derecho de modificar estos términos en cualquier momento. Te notificaremos cualquier cambio importante por correo electrónico o a través de la aplicación.' : 'By using NewsLingo, you agree to these terms and conditions. If you do not agree to any part of these terms, you must stop using the app immediately.\n\nWe reserve the right to modify these terms at any time. You will be notified of any material changes via email or through the app.';
  String get termsSection2Title =>
      isAr ? 'الحساب والتسجيل' : isEs ? 'Cuenta y registro' : 'Account & Registration';
  String get termsSection2Body => isAr ? 'للاستفادة من جميع ميزات التطبيق، يجب عليك إنشاء حساب:\n\n• يجب أن تكون المعلومات التي تقدمها صحيحة وكاملة\n• أنت المسؤول الوحيد عن الحفاظ على سرية كلمة المرور\n• يجب ألا يقل عمرك عن 13 عاماً لاستخدام التطبيق\n• يحق لنا تعليق أو إلغاء حسابات المخالفين للشروط\n\nحساب واحد لكل مستخدم. لا يسمح بإنشاء حسابات متعددة.' : isEs ? 'Para beneficiarte de todas las funciones de la aplicación, debes crear una cuenta:\n\n• La información que proporciones debe ser precisa y completa\n• Eres el único responsable de mantener la confidencialidad de tu contraseña\n• Debes tener al menos 13 años para usar la aplicación\n• Nos reservamos el derecho de suspender o cancelar cuentas que violen los términos\n\nUna cuenta por usuario. No se permiten cuentas múltiples.' : 'To benefit from all app features, you must create an account:\n\n• The information you provide must be accurate and complete\n• You are solely responsible for maintaining password confidentiality\n• You must be at least 13 years old to use the app\n• We reserve the right to suspend or cancel accounts that violate the terms\n\nOne account per user. Multiple accounts are not allowed.';
  String get termsSection3Title =>
      isAr ? 'المحتوى التعليمي' : isEs ? 'Contenido educativo' : 'Educational Content';
  String get termsSection3Body => isAr ? 'المحتوى المتاح على NewsLingo:\n\n• المقالات الإخبارية مستمدة من مصادر موثوقة مع إعادة صياغتها للأغراض التعليمية\n• المحتوى مخصص للأغراض التعليمية فقط ولا يعتبر نصيحة مهنية\n• جميع الحقوق الفكرية للمحتوى محفوظة لـ NewsLingo\n• قد تتم إزالة أو تحديث المحتوى في أي وقت دون إشعار مسبق\n\nنحن نبذل قصارى جهدنا لضمان دقة المحتوى، لكننا لا نضمن خلوه من الأخطاء.' : isEs ? 'Contenido disponible en NewsLingo:\n\n• Los artículos de noticias provienen de fuentes confiables y se reescriben con fines educativos\n• El contenido es solo para fines educativos y no constituye asesoramiento profesional\n• Todos los derechos de propiedad intelectual del contenido pertenecen a NewsLingo\n• El contenido puede ser eliminado o actualizado en cualquier momento sin previo aviso\n\nHacemos nuestro mejor esfuerzo para garantizar la precisión del contenido, pero no garantizamos que esté libre de errores.' : 'Content available on NewsLingo:\n\n• News articles are sourced from reliable outlets and rewritten for educational purposes\n• Content is for educational purposes only and does not constitute professional advice\n• All intellectual property rights to the content belong to NewsLingo\n• Content may be removed or updated at any time without prior notice\n\nWe do our best to ensure content accuracy, but we do not guarantee it is error-free.';
  String get termsSection4Title =>
      isAr ? 'الاستخدام المسموح' : isEs ? 'Uso permitido' : 'Permitted Use';
  String get termsSection4Body => isAr ? 'عند استخدام NewsLingo، أنت توافق على:\n\n• استخدام التطبيق للأغراض الشخصية والتعليمية فقط\n• عدم نسخ أو إعادة توزيع المحتوى لأغراض تجارية\n• عدم محاولة اختراق أمن التطبيق أو خوادمه\n• عدم استخدام التطبيق لنشر محتوى ضار أو مسيء\n• احترام حقوق الملكية الفكرية لـ NewsLingo والغير\n\nأي استخدام غير مصرح به يؤدي إلى إنهاء حسابك فوراً.' : isEs ? 'Al usar NewsLingo, aceptas:\n\n• Usar la aplicación solo para fines personales y educativos\n• No copiar ni redistribuir el contenido con fines comerciales\n• No intentar hackear la aplicación o sus servidores\n• No usar la aplicación para distribuir contenido dañino u ofensivo\n• Respetar los derechos de propiedad intelectual de NewsLingo y terceros\n\nCualquier uso no autorizado resultará en la terminación inmediata de tu cuenta.' : 'When using NewsLingo, you agree to:\n\n• Use the app for personal and educational purposes only\n• Not copy or redistribute content for commercial purposes\n• Not attempt to hack the app or its servers\n• Not use the app to distribute harmful or offensive content\n• Respect the intellectual property rights of NewsLingo and others\n\nAny unauthorized use will result in immediate termination of your account.';

  // Saved Articles
  String get savedArticlesTitle =>
      isAr ? '🔖 المحفوظات' : isEs ? '🔖 Artículos guardados' : '🔖 Saved Articles';
  String get savedArticlesError =>
      isAr ? 'فشل تحميل المقالات المحفوظة'
          : isEs ? 'Error al cargar los artículos guardados'
          : 'Failed to load saved articles';
  String get savedArticlesEmpty =>
      isAr ? 'ما في مقالات محفوظة' : isEs ? 'No hay artículos guardados' : 'No saved articles';
  String get savedArticlesEmptyDetail =>
      isAr ? 'احفظ المقالات اللي تعجبك عشان ترجع تقرأها لاحقاً'
          : isEs ? 'Guarda los artículos que te gusten para leerlos más tarde'
          : 'Save articles you like to read them later';

  // Info Pages
  String get aboutTitle =>
      isAr ? 'ℹ️ حول التطبيق' : isEs ? 'ℹ️ Acerca de' : 'ℹ️ About';
  String get aboutDescription => isAr
      ? 'نيوز لينجو هو تطبيق تعليمي مبتكر يهدف لمساعدتك على تحسين مهاراتك في اللغة الإنجليزية من خلال قراءة الأخبار اليومية. نقدم لك أخباراً من مصادر موثوقة مقسمة حسب مستواك اللغوي مع ترجمة فورية للكلمات الصعبة وتمارين تفاعلية.'
      : isEs ? 'NewsLingo es una aplicación educativa innovadora que te ayuda a mejorar tus habilidades de inglés a través de la lectura de noticias diarias. Te traemos noticias de fuentes confiables organizadas por tu nivel con traducciones instantáneas y ejercicios interactivos.'
      : 'NewsLingo is an innovative educational app that helps you improve your English skills through daily news reading. We bring you trusted news sources organized by your level with instant translations and interactive exercises.';
  String get aboutLinks =>
      isAr ? '🔗 روابط التواصل' : isEs ? '🔗 Enlaces sociales' : '🔗 Social Links';
  String get aboutWebsite =>
      isAr ? 'الموقع الرسمي' : isEs ? 'Sitio web' : 'Website';
  String get aboutTeam =>
      isAr ? '👨‍💻 الفريق' : isEs ? '👨‍💻 Equipo' : '👨‍💻 Team';
  String get aboutTeamDesc => isAr
      ? 'تم تطوير هذا التطبيق من قبل فريق نيوز لينجو\nبهدف نشر التعليم المجاني للجميع.'
      : isEs ? 'Esta aplicación fue desarrollada por el equipo de NewsLingo\ncon el objetivo de difundir educación gratuita para todos.'
      : 'This app was developed by the NewsLingo team\nwith the goal of spreading free education for all.';
  String get aboutRate =>
      isAr ? 'قيم التطبيق' : isEs ? 'Califica la app' : 'Rate the App';
  String get aboutVersion =>
      isAr ? 'الإصدار 1.0.0' : isEs ? 'Versión 1.0.0' : 'Version 1.0.0';
  String get aboutTwitter =>
      isAr ? 'تويتر' : isEs ? 'Twitter' : 'Twitter';
  String get aboutFacebook =>
      isAr ? 'فيسبوك' : isEs ? 'Facebook' : 'Facebook';
  String get aboutInstagram =>
      isAr ? 'إنستغرام' : isEs ? 'Instagram' : 'Instagram';

  String get helpTitle =>
      isAr ? '🎧 المساعدة' : isEs ? '🎧 Ayuda' : '🎧 Help';
  String get helpFAQ =>
      isAr ? 'الأسئلة الشائعة' : isEs ? 'Preguntas frecuentes' : 'FAQ';
  String get helpFaq1Q =>
      isAr ? 'كيف أحدد مستواي؟' : isEs ? '¿Cómo determino mi nivel?' : 'How do I determine my level?';
  String get helpFaq1A => isAr ? 'يمكنك تحديد مستواك من خلال اختبار تحديد المستوى أثناء التسجيل. سنعرض عليك أسئلة قصيرة ونحدد مستواك بين A1 و C1 بناءً على إجاباتك. يمكنك تغيير مستواك لاحقاً من صفحة الإعدادات.' : isEs ? 'Puedes determinar tu nivel a través de la prueba de nivel durante el registro. Te mostraremos preguntas cortas y determinaremos tu nivel entre A1 y C1 según tus respuestas. Puedes cambiar tu nivel más tarde desde la página de Ajustes.' : 'You can set your level through the placement test during sign-up. We will show you short questions and determine your level between A1 and C1 based on your answers. You can change your level later from Settings.';
  String get helpFaq2Q =>
      isAr ? 'كيف أحفظ الكلمات؟' : isEs ? '¿Cómo guardo palabras?' : 'How do I save words?';
  String get helpFaq2A => isAr ? 'أثناء قراءة المقالات، يمكنك الضغط على أي كلمة غير مفهومة لحفظها في قائمة المفردات. ستظهر لك الترجمة والمعنى في السياق. يمكنك مراجعة الكلمات المحفوظة في قسم "مفرداتي".' : isEs ? 'Mientras lees artículos, puedes tocar cualquier palabra desconocida para guardarla en tu lista de vocabulario. La traducción y el significado aparecerán en contexto. Puedes revisar las palabras guardadas en la sección "Mi vocabulario".' : 'While reading articles, you can tap any unfamiliar word to save it to your vocabulary list. The translation and meaning will appear in context. You can review saved words in the "My Vocabulary" section.';
  String get helpFaq3Q =>
      isAr ? 'كم مرة أراجع الكلمات؟' : isEs ? '¿Con qué frecuencia debo repasar las palabras?' : 'How often should I review words?';
  String get helpFaq3A => isAr ? 'نظام المراجعة الذكي يذكرك بمراجعة الكلمات بناءً على خوارزمية التكرار المتباعد. سترى الكلمات الجديدة كل يوم، ثم كل 3 أيام، ثم كل أسبوع، ثم كل شهر - لضمان تثبيتها في الذاكرة طويلة المدى.' : isEs ? 'El sistema de revisión inteligente te recuerda repasar palabras basado en un algoritmo de repetición espaciada. Verás palabras nuevas cada día, luego cada 3 días, luego cada semana, luego cada mes - para asegurar que se fijen en la memoria a largo plazo.' : 'The smart review system reminds you to review words based on a spaced repetition algorithm. You will see new words every day, then every 3 days, then every week, then every month - to ensure they stick in long-term memory.';
  String get helpFaq4Q =>
      isAr ? 'ماذا يعني التسلسل اليومي؟' : isEs ? '¿Qué significa la racha diaria?' : 'What does daily streak mean?';
  String get helpFaq4A => isAr ? 'التسلسل اليومي (Streak) هو عدد الأيام المتتالية التي تتعلم فيها في التطبيق. كل يوم تفتح التطبيق وتتعلم كلمة واحدة على الأقل، يزيد تسلسلك. الحفاظ على تسلسل طويل يمنحك مكافآت وإنجازات خاصة!' : isEs ? 'La racha diaria (Streak) es el número de días consecutivos que aprendes en la aplicación. Cada día que abres la aplicación y aprendes al menos una palabra, tu racha aumenta. ¡Mantener una racha larga te da recompensas y logros especiales!' : 'The daily streak is the number of consecutive days you learn in the app. Every day you open the app and learn at least one word, your streak increases. Maintaining a long streak gives you rewards and special achievements!';
  String get helpFaq5Q =>
      isAr ? 'كيف أستخدم البطاقات التعليمية؟' : isEs ? '¿Cómo uso las tarjetas didácticas?' : 'How do I use flashcards?';
  String get helpFaq5A => isAr ? 'البطاقات التعليمية (Flashcards) تساعدك على مراجعة الكلمات بطريقة تفاعلية. اذهب إلى قسم "مفرداتي" واختر "البطاقات التعليمية". اقلب البطاقة لترى الترجمة، واضغط ✅ إذا عرفت الكلمة أو ❌ إذا تحتاج لمراجعتها مرة أخرى.' : isEs ? 'Las tarjetas didácticas (Flashcards) te ayudan a repasar palabras de forma interactiva. Ve a la sección "Mi vocabulario" y selecciona "Tarjetas". Voltea la tarjeta para ver la traducción, y presiona ✅ si sabes la palabra o ❌ si necesitas repasarla de nuevo.' : 'Flashcards help you review words interactively. Go to "My Vocabulary" and select "Flashcards". Flip the card to see the translation, and press ✅ if you know the word or ❌ if you need to review it again.';
  String get helpFaq6Q =>
      isAr ? 'هل التطبيق مجاني؟' : isEs ? '¿La aplicación es gratuita?' : 'Is the app free?';
  String get helpFaq6A => isAr ? 'نعم، التطبيق مجاني بالكامل مع ميزات أساسية ممتازة. يوجد اشتراك مميز (Premium) يفتح ميزات حصرية مثل تحليل النصوص المتقدم وإحصائيات مفصلة وبدون إعلانات.' : isEs ? 'Sí, la aplicación es completamente gratuita con excelentes funciones básicas. Hay una suscripción Premium que desbloquea funciones exclusivas como análisis de texto avanzado, estadísticas detalladas y sin anuncios.' : 'Yes, the app is completely free with excellent basic features. There is a Premium subscription that unlocks exclusive features like advanced text analysis, detailed statistics, and no ads.';
  String get helpContact =>
      isAr ? 'تواصل معنا' : isEs ? 'Contáctanos' : 'Contact Us';

  // Level Up
  String get levelUpCongrats =>
      isAr ? 'أحسنت! 🎉' : isEs ? '¡Bien hecho! 🎉' : 'Well Done! 🎉';
  String levelUpMessage(String level) =>
      isAr ? 'لقد انتقلت إلى المستوى $level' : isEs ? 'Has alcanzado el nivel $level' : 'You reached level $level';
  String get levelUpContinue =>
      isAr ? 'متابعة' : isEs ? 'Continuar' : 'Continue';
  String get levelUpFeatures =>
      isAr ? 'ميزات جديدة متاحة' : isEs ? 'Nuevas funciones disponibles' : 'New Features Available';
  String get levelUpFeature1Title =>
      isAr ? 'مقالات متقدمة' : isEs ? 'Artículos avanzados' : 'Advanced Articles';
  String get levelUpFeature1Sub =>
      isAr ? 'مقالات أطول بمفردات أكثر تعقيداً'
          : isEs ? 'Artículos más largos con vocabulario más complejo'
          : 'Longer articles with more complex vocabulary';
  String get levelUpFeature2Title =>
      isAr ? 'كتابة مقالات' : isEs ? 'Escribir artículos' : 'Write Articles';
  String get levelUpFeature2Sub =>
      isAr ? 'اكتب مقالاتك الخاصة باللغة الإنجليزية'
          : isEs ? 'Escribe tus propios artículos en inglés'
          : 'Write your own articles in English';
  String get levelUpFeature3Title =>
      isAr ? 'اختبارات أصعب' : isEs ? 'Cuestionarios más difíciles' : 'Harder Quizzes';
  String get levelUpFeature3Sub =>
      isAr ? 'أسئلة أكثر تحدياً لمستواك الجديد'
          : isEs ? 'Preguntas más desafiantes para tu nuevo nivel'
          : 'More challenging questions for your new level';
  String get levelUpFeature4Title =>
      isAr ? 'مناقشات' : isEs ? 'Discusiones' : 'Discussions';
  String get levelUpFeature4Sub =>
      isAr ? 'انضم لنقاشات مع متعلمين في مستواك'
          : isEs ? 'Únete a discusiones con estudiantes de tu nivel'
          : 'Join discussions with learners at your level';
  String get levelUpWordLearned =>
      isAr ? 'كلمة متعلمة' : isEs ? 'Palabras aprendidas' : 'Words Learned';
  String get levelUpArticleRead =>
      isAr ? 'مقال مقروء' : isEs ? 'Artículos leídos' : 'Articles Read';
  String get levelUpQuizPassed =>
      isAr ? 'اختبار ناجح' : isEs ? 'Cuestionarios aprobados' : 'Quizzes Passed';
  String get levelUpStreakDays =>
      isAr ? 'يوم تسلسل' : isEs ? 'Días de racha' : 'Streak Days';

  // Widgets
  String get errorTitle =>
      isAr ? 'عذراً، حدث خطأ' : isEs ? 'Lo sentimos, ocurrió un error' : 'Sorry, an error occurred';
  String get noInternetTitle =>
      isAr ? 'لا يوجد اتصال بالإنترنت' : isEs ? 'Sin conexión a internet' : 'No internet connection';
  String get noInternetDescription =>
      isAr ? 'تحقق من اتصالك بالشبكة وحاول مرة أخرى'
          : isEs ? 'Verifica tu conexión de red e inténtalo de nuevo'
          : 'Check your network connection and try again';
  String get cardListen =>
      isAr ? 'استمع' : isEs ? 'Escuchar' : 'Listen';
  String get cardTranslate =>
      isAr ? 'ترجمة' : isEs ? 'Traducir' : 'Translate';
  String get grammarRule =>
      isAr ? '📖 القاعدة' : isEs ? '📖 La regla' : '📖 The Rule';
  String get grammarExamples =>
      isAr ? '💬 أمثلة' : isEs ? '💬 Ejemplos' : '💬 Examples';
  String get grammarGotIt =>
      isAr ? 'فهمت ✅' : isEs ? 'Entendido ✅' : 'Got it ✅';
  String get grammarCategoryWriting =>
      isAr ? '✍️ كتابة' : isEs ? '✍️ Escritura' : '✍️ Writing';
  String get grammarCategorySpeaking =>
      isAr ? '🗣️ محادثة' : isEs ? '🗣️ Conversación' : '🗣️ Speaking';
  String get grammarCategoryGrammar =>
      isAr ? '📚 قواعد' : isEs ? '📚 Gramática' : '📚 Grammar';
  String get articleQuizButton =>
      isAr ? 'اختبار' : isEs ? 'Cuestionario' : 'Quiz';
  String get articleSaveWords =>
      isAr ? 'حفظ الكلمات' : isEs ? 'Guardar palabras' : 'Save Words';
  String get aboutBuiltWith =>
      isAr ? '🏗️ بني باستخدام Flutter' : isEs ? '🏗️ Construido con Flutter' : '🏗️ Built with Flutter';
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
