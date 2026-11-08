# ⚡ CFSSH Cyberdeck Android Launcher

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Riverpod](https://img.shields.io/badge/State-Riverpod_3.x-blueviolet)](https://riverpod.dev)
[![Android](https://img.shields.io/badge/Platform-Android_11--15+-3DDC84?logo=android&logoColor=white)](https://developer.android.com)
[![Architecture](https://img.shields.io/badge/Architecture-Clean_%26_Modular-teal)]()
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

Un launcher profesional, minimalista y de alto rendimiento para Android, diseñado con la sobriedad estética de macOS / iOS y la potencia operativa de una terminal **Cyberdeck**. 

Construido en **Flutter + Kotlin**, abandona el glassmorphism recargado y los efectos superfluos para ofrecer **superficies sólidas, legibilidad instantánea, telemetría en tiempo real, videovigilancia RTSP integrada, monitor de red Sentinel Live y compatibilidad universal con paquetes de iconos Android**.

---

## 📸 Captura de Pantalla

![Cyberdeck Dashboard](https://raw.githubusercontent.com/vC3sar/cfssh_launcher/main/assets/images/wallpaper.png)

*(O consulta las capturas en la interfaz de la tableta con el Hero Clock, Sentinel Health Live, dock minimalista y cuadrícula de aplicaciones).*

---

## 🎯 Filosofía de Diseño

- **Cero Glassmorphism y Blur Innecesario**: Superficies sólidas, contrastes calibrados, bordes discretos de 1px y espaciado generoso.
- **Doble Modo Adaptativo**: Soporte completo para Modo Claro (superficies neutras, grises claros, acentos discretos) y Modo Oscuro (negros profundos y grises grafito), adaptando dinámicamente fondos, paneles y bordes.
- **Telemetría Útil en Primer Plano**: Hardware, memoria, batería, conectividad de red y estado de servicios accesibles en un solo vistazo sin capas intermedias.
- **Rendimiento Nativo**: Caché inteligente de drawables en memoria, sincronización reactiva de paquetes sin reinicios y aceleración por hardware.

---

## ✨ Características Principales

### 1. 🕒 Módulo Hero Clock & Calendario Táctico
- **Dígitos de Alta Visibilidad (78px)** con espaciado tabular (`FontFeature.tabularFigures()`) para lectura inmediata a distancia.
- **Selector de Formato**: Conmutación instantánea entre `24H` y `12H AM/PM`.
- **Segundero en Vivo y Zona Horaria**: Indicador en tiempo real (`:SS · CST/UTC`).
- **Tira Semanal Interactiva**: Visualización de los 7 días de la semana con resaltado del día actual (`HOY`) mediante el color de destacado puntual.

### 2. 🎨 Motor de Temas, Fuentes y Destacados Puntuales
- **4 Presets Temáticos**:
  - `Plataforma Esmeralda` (Phosphor Matrix)
  - `Azul Cupertino` (Tactical Cyan / Apple Accent)
  - `Ámbar Cálido` (Amber Terminal)
  - `Grafito Puro` (Stealth Graphite)
- **Color de Destacado Puntual (`highlightAccent`)**: Permite asignar un color focal (dorado ámbar, azul eléctrico, magenta, etc.) para resaltar elementos clave (día actual, badges favoritos, píldoras de segundos) sin saturar la pantalla.
- **8 Familias Tipográficas Seleccionables con Previsualización en Vivo**:
  1. **Inter** (UI Pro limpia y moderna)
  2. **Nothing Dot** (Estilo matricial de puntos inspirado en Nothing OS)
  3. **TT Hoves Pro** (Geométrica técnica de alta precisión)
  4. **TT Bluescreens** (Display condensada de alto impacto)
  5. **Open Sans** (Humanista clásica de gran legibilidad)
  6. **Nunito** (Redondeada y suave)
  7. **Minecraft Pixel** (Estilo retro arcade 8-bit)
  8. **JetBrains Mono** (Monoespaciada técnica para código)

### 3. 📦 Compatibilidad Universal con Icon Packs
- **Detección Automática**: Reconoce cualquier paquete de iconos estándar de Android instalado (compatible con *iWhite OS Icon Pack*, paquetes de Nova Launcher, LineX, etc.).
- **Parseo de `appfilter.xml`**: Resuelve mapeos por `ComponentName` (`package/activity`) en drawables y mipmaps del APK del icon pack.
- **Icon Masking & Fallback**: Aplica máscaras y fondos a aplicaciones sin icono personalizado, o recurre al icono original del sistema con alta fidelidad.
- **Selector de Iconos Alternativos**: Mantén pulsada cualquier aplicación en el cajón para elegir iconos variantes del paquete activo o restaurar el predeterminado.
- **Caché en Memoria**: Evita descompresiones repetitivas de bitmaps para una navegación ultrafluida a 60/120 FPS.

### 4. 🔄 Sincronización Inteligente de Aplicaciones (`PackageManager`)
- **BroadcastReceiver Nativo**: Detecta en tiempo real eventos del sistema sin requerir reinicio del launcher:
  - `ACTION_PACKAGE_ADDED`
  - `ACTION_PACKAGE_REMOVED`
  - `ACTION_PACKAGE_REPLACED`
  - `ACTION_PACKAGE_CHANGED`
- **Cero Aplicaciones Fantasma**: Invalida cachés inmediatamente tras una desinstalación o actualización.
- **Buscador Tipo Spotlight**: Filtrado instantáneo por nombre y paquete con soporte de aplicaciones favoritas fijadas.

### 5. 🩺 Sentinel Live Health Checker
- **Monitor de Salud y Latencia Multi-Protocolo**:
  - **TCP**: Sondeo de puertos y sockets (SSH, bases de datos, pasarelas).
  - **HTTP / HTTPS**: Verificación de códigos de respuesta HTTP (`200 OK`, `301`, etc.) y tiempo de respuesta web.
  - **UDP**: Pruebas de resolución DNS y datagramas.
- **Identidad Visual Propia (`sentinelAccent`)**: Paleta cromática dedicada con badges semánticos (`ONLINE` verde esmeralda, `DEGRADADO` ámbar, `OFFLINE` rojo coral, `SONDEANDO` cian) y etiquetas por protocolo (`TCP` azul, `HTTP` violeta, `UDP` verde azulado).
- **Intervalo Automático de Sondeo**: Configurable en 5s, 10s, 30s, 60s o manual desde el panel.
- **Historial de Latencia**: Sparklines con los últimos chequeos y cálculo de uptime porcentual.
- **Plantillas Rápidas**: Gateway local, Cloudflare DNS, Google HTTPS, Servidor SSH y Cámaras RTSP con prueba de conexión previa en modal.

### 6. 📹 Videovigilancia CCTV RTSP Integrada
- **Malla de Cámaras en Vivo**: Visualización fluida de múltiples streams RTSP (`rtsp://user:pass@ip:port/live/ch00_0`).
- **Transporte RTP-over-TCP Forzado**: Parche automático en ExoPlayer (`RtspMediaSource.Factory().setForceUseRtpTcp(true)`) para eliminar cuelgues o desconexiones tras el primer segundo provocadas por pérdida de paquetes UDP en Wi-Fi.
- **Reconexión Automática**: Algoritmo de reintento inteligente ante caídas de red o reinicios de cámaras.
- **Escáner de Subred Local**: Detección automática de dispositivos y cámaras IP abiertas en puertos 554, 8554 y 8000 en el rango `/24`.
- **Controles de Audio y Pantalla Completa**: Silenciamiento/activación de audio por stream y vista expandida inmersiva.

### 7. 🚀 Accesos Directos & Terminal Runner
- **Accesos Rápidos**:
  - `SSH`: Integración directa con clientes SSH o emuladores de terminal (Termux, CFSSH).
  - `Web`: Lanzamiento de URLs en navegadores instalados.
  - `CMD`: Ejecutor de comandos de consola del sistema (`sh -c`) con visualizador modal de salida estándar (`stdout`) y errores (`stderr`).

---

## 🏗️ Arquitectura del Proyecto

El proyecto sigue una arquitectura modular y desacoplada basada en capas:

```
lib/
├── core/
│   ├── config/              # CyberdeckConfigProvider (Temas, fuentes, highlights, persistencia)
│   ├── theme/               # AppTheme, paletas semánticas, generadores de fuentes de Google Fonts
│   ├── utils/               # Formateadores, helpers y constantes
│   └── widgets/             # Componentes reusables (CyberTapTarget, CyberdeckPanel, etc.)
├── features/
│   ├── apps/                # Cajón de aplicaciones, AppsProvider, selector de favoritos
│   ├── cameras/             # Sistema RTSP (Paneles, modales, escáner de red, ExoPlayer controller)
│   ├── dashboard/           # Pantalla principal, Hero Clock, módulo de estado y dock
│   ├── health_checker/      # Sentinel Live (Modelos, servicios TCP/HTTP/UDP, HealthCheckerPanel)
│   ├── monitor/             # Monitor de sistema y telemetría avanzada
│   ├── network/             # Detección de interfaces, IP, Wi-Fi y Bluetooth
│   ├── settings/            # Pantalla de ajustes, selector de fuentes e icon packs
│   └── shortcuts/           # Gestor de accesos directos (SQLite + modal CMD)
├── services/
│   ├── database_service.dart# Persistencia SQLite local
│   └── device_service.dart  # MethodChannel nativo con Android (Apps, Icon Packs, Stats)
└── main.dart                # Punto de entrada de la aplicación
```

### Capa Nativa Android (`android/app/src/main/kotlin/`)
- `MainActivity.kt`:
  - **MethodChannel `com.cfssh.launcher/device`**: Gestión de aplicaciones instaladas, lectura de icon packs, parseo de recursos drawables, métricas de hardware (RAM/batería/almacenamiento) y lanzamiento de intents.
  - **BroadcastReceiver**: Escucha pasiva de cambios en paquetes del sistema.
  - **Patch Gradle**: `patchRtspTcpTransport` inyecta parámetros TCP en el pipeline de `video_player_android` durante la fase de pre-compilación.

---

## 📋 Requisitos del Sistema

- **Flutter SDK**: 3.13.4 o superior (canal estable)
- **Dart SDK**: ^3.13.4
- **Java**: OpenJDK 17
- **Android SDK**:
  - `compileSdkVersion`: 34+
  - `minSdkVersion`: 21 (Android 5.0 Lollipop)
  - `targetSdkVersion`: 34 (Android 14)
- **Dispositivo de Destino**: Compatible con smartphones, tabletas y SBCs con Android 11, 12, 13, 14 y 15 (probado y optimizado en Samsung Galaxy Tab A7 Lite).

---

## 🛠️ Instalación y Compilación

### 1. Clonar el Repositorio

```bash
git clone https://github.com/vC3sar/cfssh_launcher.git
cd cfssh_launcher
```

### 2. Obtener Dependencias de Flutter

```bash
flutter pub get
```

### 3. Verificar Análisis Estático

Asegúrate de que no existan errores ni advertencias de análisis:

```bash
flutter analyze
```

### 4. Compilar en Modo Desarrollo (Debug)

Conecta tu dispositivo Android con depuración USB habilitada:

```bash
flutter run
```

### 5. Compilar APK Release Optimizado

Para evitar problemas de snapshot AOT en entornos de compilación de 64 bits en Windows/Linux, compila especificando la arquitectura de destino:

```bash
# Para dispositivos ARM64 modernos (Recomendado):
flutter build apk --release --target-platform android-arm64

# O para generar un Fat APK universal:
flutter build apk --release
```

El binario resultante se encontrará en:
`build/app/outputs/flutter-apk/app-release.apk`

### 6. Instalar mediante ADB en el Dispositivo

```bash
adb install -r build/app/outputs/flutter-apk/app-release.apk
```

Para iniciar la aplicación inmediatamente desde la consola:

```bash
adb shell am start -n com.cfssh.launcher/.MainActivity
```

---

## 📱 Configuración como Launcher Predeterminado

1. Abre los **Ajustes de Android** en tu dispositivo.
2. Navega a **Aplicaciones** > **Aplicaciones predeterminadas** > **Aplicación de inicio** (o *Home App*).
3. Selecciona **CFSSH Cyberdeck**.
4. Presiona el botón de Inicio o realiza el gesto de regreso para comprobar la experiencia integrada.

---

## 📖 Manual de Uso Rápido

### Personalizar Temas y Fuentes
1. En el dock inferior, pulsa en **Ajustes** (icono de engranaje).
2. **Preset de Color**: Elige entre Plataforma Esmeralda, Azul Cupertino, Ámbar Cálido o Grafito Puro.
3. **Modo Claro / Oscuro**: Alterna el interruptor; los contrastes y superficies se adaptarán automáticamente sin elementos oscuros forzados.
4. **Color de Destacado Puntual**: Elige el color con el que deseas acentuar el día actual, los badges y las selecciones.
5. **Tipografía del Sistema y Reloj**: Explora la sección de fuentes y selecciona cualquiera de las 8 opciones disponibles (Inter, Nothing Dot, TT Hoves Pro, Minecraft, etc.) para ver el cambio reflejado en todo el sistema.

### Configurar Paquetes de Iconos
1. Instala tu paquete de iconos favorito desde Google Play (ej. *iWhite OS Icon Pack*).
2. En el launcher, dirígete a **Ajustes** > **Paquetes de Iconos (Icon Packs)**.
3. Selecciona el paquete detectado en la lista y presiona **Aplicar**. Los iconos se actualizarán al instante sin reiniciar.
4. Para cambiar el icono de una aplicación específica, mantén presionada la app en el cajón y selecciona **Elegir icono alternativo del paquete**.

### Monitoreo con Sentinel Live Health Checker
1. En el dock, pulsa en **Ping / Red** o accede al panel de Sentinel.
2. Pulsa en **+ Añadir** para registrar un nuevo endpoint.
3. Puedes utilizar las **Plantillas Rápidas** (Gateway, DNS, SSH, etc.) o introducir un host manual, seleccionando protocolo `TCP`, `HTTP` o `UDP`.
4. Pulsa en **Probar Conexión** para validar la respuesta antes de guardarlo.
5. Haz clic en el icono de engranaje/paleta en Sentinel para ajustar el color de marca de Sentinel o cambiar el intervalo de auto-sondeo (5s, 10s, 30s, etc.).

### Añadir Cámaras RTSP
1. En el dock, abre el panel de **Cámaras**.
2. Pulsa en **Añadir Cámara** o utiliza el **Escáner de Red** para encontrar dispositivos en tu red local.
3. Ingresa la URL RTSP completa (ej. `rtsp://admin:password@192.168.1.176:554/live/ch00_0`).
4. La transmisión se reproducirá con transporte TCP forzado para evitar congelamientos.

---

## 🔒 Permisos Declarados y Justificación

| Permiso | Justificación |
|---|---|
| `QUERY_ALL_PACKAGES` | Requerido para listar y sincronizar todas las aplicaciones instaladas en Android 11+ como launcher del sistema. |
| `REQUEST_DELETE_PACKAGES` | Permite solicitar la desinstalación limpia de aplicaciones desde el menú contextual. |
| `INTERNET` | Requerido para transmisiones RTSP, monitoreo Sentinel (HTTP/TCP/UDP) y consultas de red. |
| `ACCESS_NETWORK_STATE` & `ACCESS_WIFI_STATE` | Telemetría de interfaces de red, IP local y estado de conectividad en tiempo real. |
| `BLUETOOTH` & `BLUETOOTH_CONNECT` | Consulta del estado de radio Bluetooth para el widget de cabecera. |

---

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Si deseas colaborar:
1. Haz un Fork del proyecto.
2. Crea una rama para tu función (`git checkout -b feature/nueva-funcion`).
3. Confirma tus cambios (`git commit -m 'Añadir nueva función'`).
4. Haz push a la rama (`git push origin feature/nueva-funcion`).
5. Abre un Pull Request.

---

## 📄 Licencia

Este proyecto está bajo la Licencia **MIT**. Consulta el archivo `LICENSE` para más detalles.

---

Desarrollado con dedicación para los entusiastas de las estaciones de trabajo Cyberdeck, la ingeniería de sistemas y el diseño UI/UX de alta precisión. 💻🛡️
