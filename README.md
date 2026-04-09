# ascii-animated

`ascii-animated` es un instalador interactivo multi-distro (Fedora/RHEL, Debian/Ubuntu y Arch Linux) que te permite instalar fácilmente las animaciones y utilidades ASCII más conocidas para la terminal de Linux.

## Características

El script autodetecta tu distribución de Linux y su gestor de paquetes (`dnf`, `apt`, o `pacman`), instala las dependencias base necesarias (como `gcc`, `make`, `git`, `ncurses`, etc.) y te permite seleccionar qué programas deseas instalar mediante un menú interactivo.

### Herramientas incluidas

El script incluye la opción de instalar:

1.  **cmatrix**: Lluvia de caracteres estilo Matrix cayendo en pantalla.
2.  **cbonsai**: Un bonsai que crece en tiempo real con ramas y hojas ASCII.
3.  **sl**: Tren ASCII que cruza la pantalla si escribís 'sl' en vez de 'ls'.
4.  **lolcat**: Colorea cualquier output en degradado arcoíris.
5.  **cowsay + cowthink**: Vaca (cowsay) o globo de pensamiento (cowthink) con tu texto.
6.  **fortune**: Frases y citas aleatorias (ideal para usar junto con cowsay y lolcat).
7.  **nyancat**: El famoso gato Nyan corriendo con su arcoíris a toda velocidad.
8.  **asciiquarium**: Acuario animado con peces, tiburones y burbujas ASCII.
9.  **ascii-rain**: Lluvia suave de gotas ASCII con efecto ncurses (comando: `rain`).
10. **lavat**: Lava lamp animada con burbujas que suben y bajan.
11. **pipes.sh**: Tuberías que se van dibujando solas en todas direcciones.
12. **cava**: Visualizador de audio — barras que bailan con la música.

## Uso

1. Dale permisos de ejecución al script:
   ```bash
   chmod +x ascii-animated.sh
   ```

2. Ejecuta el script:
   ```bash
   ./ascii-animated.sh
   ```

3. Sigue las instrucciones del menú en pantalla para elegir tu distribución y seleccionar las animaciones que quieras instalar.

## Combos recomendados
¡Prueba combinar algunas de las herramientas instaladas!
```bash
fortune | cowsay | lolcat
```
