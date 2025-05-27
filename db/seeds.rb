# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

languages = [
  "Afrikaans", "Shqip (Albanian)", "አማርኛ (Amharic)", "العربية (Arabic)", "Հայերեն (Armenian)",
  "অসমীয়া (Assamese)", "अवधी (Awadhi)", "Azərbaycanca (Azerbaijani)", "Башҡортса (Bashkir)",
  "Euskara (Basque)", "Беларуская (Belarusian)", "বাংলা (Bengali)", "भोजपुरी (Bhojpuri)",
  "Bosanski (Bosnian)", "български (Bulgarian)", "မြန်မာဘာသာ (Burmese)", "廣東話 (Cantonese)",
  "Català (Catalan)", "ᏣᎳᎩ (Cherokee)", "छत्तीसगढ़ी (Chhattisgarhi)", "中文 (Chinese)",
  "普通话 (Chinese (Simplified))", "Hrvatski (Croatian)", "Čeština (Czech)", "Dansk (Danish)",
  "डोगरी (Dogri)", "Nederlands (Dutch)", "English", "эрзянь кель (Erzya)", "Esperanto",
  "Eesti (Estonian)", "Føroyskt (Faroese)", "Filipino", "Suomi (Finnish)", "Français (French)",
  "Fulfulde (Fula)", "Galego (Galician)", "ქართული (Georgian)", "Deutsch (German)",
  "Ελληνικά (Greek)", "ગુજરાતી (Gujarati)", "Kreyòl ayisyen (Haitian Creole)", "हरियाणवी (Haryanvi)",
  "Hausa", "עברית (Hebrew)", "हिन्दी (Hindi)", "Magyar (Hungarian)", "Íslenska (Icelandic)",
  "Igbo", "Bahasa Indonesia (Indonesian)", "ᐃᓄᒃᑎᑐᑦ (Inuktitut)", "Gaeilge (Irish)",
  "Italiano (Italian)", "日本語 (Japanese)", "Basa Jawa (Javanese)", "ಕನ್ನಡ (Kannada)",
  "کشمیری (Kashmiri)", "Қазақ тілі (Kazakh)", "ខ្មែរ (Khmer)", "कोंकणी (Konkani)",
  "한국어 (Korean)", "Кыргызча (Kyrgyz)", "ລາວ (Lao)", "Latviešu (Latvian)", "Lietuvių (Lithuanian)",
  "Lëtzebuergesch (Luxembourgish)", "македонски (Macedonian)", "मैथिली (Maithili)", "Malagasy",
  "Bahasa Melayu (Malay)", "മലയാളം (Malayalam)", "Malti (Maltese)", "मराठी (Marathi)",
  "मारवाड़ी (Marwari)", "閩南語 (Min Nan)", "Moldovenească (Moldovan)", "Монгол (Mongolian)",
  "Crnogorski (Montenegrin)", "नेपाली (Nepali)", "Norsk (Norwegian)", "Norsk bokmål (Norwegian (Bokmål))",
  "ଓଡ଼ିଆ (Oriya)", "پښتو (Pashto)", "فارسی (Persian)", "Polski (Polish)", "Português (Portuguese)",
  "ਪੰਜਾਬੀ (Punjabi)", "राजस्थानी (Rajasthani)", "Română (Romanian)", "Русский (Russian)",
  "संस्कृतम् (Sanskrit)", "ᱥᱟᱱᱛᱟᱲᱤ (Santali)", "Српски (Serbian)", "سنڌي (Sindhi)",
  "සිංහල (Sinhala)", "Slovenčina (Slovak)", "Slovenščina (Slovenian)", "Soomaali (Somali)",
  "Español (Spanish)", "Kiswahili (Swahili)", "Svenska (Swedish)", "Tagalog", "தமிழ் (Tamil)",
  "తెలుగు (Telugu)", "ไทย (Thai)", "ትግርኛ (Tigrinya)", "Türkçe (Turkish)", "Українська (Ukrainian)",
  "اردو (Urdu)", "Oʻzbekcha (Uzbek)", "Tiếng Việt (Vietnamese)", "Cymraeg (Welsh)", "吴语 (Wu)",
  "isiXhosa (Xhosa)", "Yorùbá (Yoruba)", "isiZulu (Zulu)"
]

languages.each do |name|
  Language.find_or_create_by!(name: name)
end
