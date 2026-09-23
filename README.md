# 🏛️ Descubre Dolores Hidalgo

Aplicación multimedia interactiva desarrollada en **Flutter** siguiendo rigurosamente el patrón arquitectónico **Clean Architecture (Arquitectura Limpia)**.

---

## 📱 Descripción del Proyecto

**Descubre Dolores Hidalgo** es una guía turística multimedia sobre la Cuna de la Independencia Nacional en Guanajuato, México. Permite a los usuarios explorar lugares emblemáticos a través de:
* 📷 **Fotografías reales en alta resolución**.
* 🎧 **Audio-guías narradas interactivas** (`audioplayers`).
* 🎬 **Recorridos en video** (`video_player`).

---

## 🏗️ Arquitectura del Proyecto (Clean Architecture)

El proyecto está diseñado bajo la regla de dependencia estricta en 3 capas concéntricas:

$$\text{Presentación} \longrightarrow \text{Dominio} \longleftarrow \text{Datos}$$

```text
lib/
├── domain/                  # 1. Capa de Dominio (Dart puro, reglas de negocio)
│   ├── entities/
│   │   └── lugar_turistico.dart
│   ├── repositories/
│   │   └── lugares_repository.dart
│   └── usecases/
│       ├── obtener_lugares.dart
│       └── obtener_lugar_por_id.dart
│
├── data/                    # 2. Capa de Datos (Implementaciones de repositorios)
│   ├── datasources/
│   │   └── lugares_local_datasource.dart
│   └── repositories/
│       └── lugares_repository_impl.dart
│
├── presentation/            # 3. Capa de Presentación (MVVM + UI Flutter)
│   ├── viewmodels/
│   │   ├── lugares_view_model.dart
│   │   └── detalle_view_model.dart
│   └── views/
│       ├── lista_lugares_screen.dart
│       └── detalle_lugar_screen.dart
│
└── main.dart                # Composition Root (Inyección manual de dependencias)
```

---

## ✅ Checklist de Arquitectura Limpia

- [x] Ningún archivo en `domain/` importa `package:flutter/material.dart`
- [x] Las entidades del Dominio no tienen métodos `fromJson/toJson` (pertenece a la capa de Datos)
- [x] Cada caso de uso representa una sola acción del usuario (`call()`)
- [x] Los ViewModels reciben casos de uso por constructor (Inversión de dependencias)
- [x] `main.dart` es el único archivo que conoce las clases concretas de las 3 capas
- [x] Existe prueba unitaria del Dominio usando un Fake (`obtener_lugares_test.dart`)
- [x] Los controladores multimedia se liberan adecuadamente con `dispose()`

---

## 🧪 Pruebas Unitarias (TDD)

Para ejecutar las pruebas unitarias automatizadas:

```bash
flutter test
```

Resultado:
```text
00:00 +1: All tests passed!
```

---

## 🚀 Cómo Ejecutar la Aplicación

1. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/omarsalinas3/descubre_dolores.git
   cd descubre_dolores
   ```

2. **Obtener dependencias**:
   ```bash
   flutter pub get
   ```

3. **Ejecutar la app**:
   ```bash
   flutter run
   ```
