# Buscaminas Pro

Aplicación móvil desarrollada en Flutter para jugar Buscaminas, con selección de dificultad, tablero dinámico, temporizador, persistencia local, efectos de sonido, acelerómetro e interoperabilidad con el sistema operativo.

## Características principales

- Juego Buscaminas con tablero dinámico según dificultad.
- Dificultades: Fácil, Medio y Difícil.
- Temporizador de partida.
- Persistencia local de configuración e historial usando `shared_preferences`.
- Identidad digital configurada con package name propio.
- Ícono personalizado de aplicación.
- Efectos de sonido para selección de celda y derrota.
- Reinicio del tablero al agitar el dispositivo usando acelerómetro.
- Opción para compartir el resultado del juego mediante el menú nativo del sistema.

## Paquetes utilizados

- `provider`: gestión de estado.
- `shared_preferences`: almacenamiento local.
- `logger`: registro de eventos en consola.
- `audioplayers`: reproducción de efectos de sonido.
- `sensors_plus`: lectura del acelerómetro.
- `share_plus`: integración con el menú nativo de compartir.
- `flutter_launcher_icons`: generación de íconos de la aplicación.
- `change_app_package_name`: cambio del identificador del paquete.

## Identidad digital

El proyecto fue configurado con un identificador único de paquete:

```text
cl.valdeshernandez.buscaminas
```
Además, se generaron los íconos nativos de Android e iOS usando una imagen personalizada ubicada en:
```text
assets/icons/app_icon.png
```
## Recursos multimedia
Los efectos de sonido se encuentran en:
```text
assets/audio/
```
Archivos utilizados:
`click.mp3`: sonido al seleccionar una celda segura.
`explosion.mp3`: sonido al perder la partida.
`victory.mp3`: sonido reservado para victoria.
## Pruebas de validación
Para validar el proyecto se ejecutaron pruebas de análisis estático con:
```powershell
flutter analyze
```
También se realizaron pruebas manuales de ejecución para verificar:

- Carga correcta de íconos y assets.
- Reproducción de efectos de sonido.
- Reinicio del juego mediante acelerómetro en dispositivo físico.
- Visualización condicional del botón compartir al finalizar la partida.
- Apertura del menú nativo de compartir.
## Trabajos futuros
- Implementar detección explícita de victoria y reproducir `victory.mp3`.
- Agregar contador de minas restantes.
- Permitir marcar celdas con bandera mediante pulsación larga.
- Mejorar el historial con fecha, dificultad y resultado de cada partida.
- Incorporar ranking local de mejores tiempos.