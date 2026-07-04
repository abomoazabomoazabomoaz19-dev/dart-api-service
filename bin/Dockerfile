# استخدم صورة Dart الرسمية
FROM dart:stable AS build

# إعداد المجلد
WORKDIR /app

# نسخ ملفات الإعدادات وتثبيت الحزم
COPY pubspec.* ./
RUN dart pub get

# نسخ باقي الكود
COPY . .
RUN dart pub get --offline
RUN dart compile exe bin/main.dart -o /app/server

# تشغيل السيرفر
FROM debian:stable-slim
COPY --from=build /app/server /app/server
EXPOSE 8080
CMD ["/app/server"]
