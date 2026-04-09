<div align="center">
  <h1>🎨 ASCII Animated</h1>
  
  **El instalador definitivo de animaciones ASCII para tu terminal (v1.0)**  
  *Dale vida a tu consola con las mejores herramientas retro y visuales.*
  
  [![Bash](https://img.shields.io/badge/Bash-Script-4EAA25?style=flat-square&logo=gnu-bash&logoColor=white)](#)
  [![Linux](https://img.shields.io/badge/Linux-Supported-FCC624?style=flat-square&logo=linux&logoColor=black)](#)
  [![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square)](https://opensource.org/licenses/MIT)
  [![Version](https://img.shields.io/badge/version-1.0-orange.svg?style=flat-square)](#)

  [Características](#-características) • 
  [Instalación](#-instalación) • 
  [Herramientas Incluidas](#-herramientas-incluidas) • 
  [Combos Épicos](#-combos-épicos)
</div>

---

## 🌟 Características

- **Multi-Distribución**: Detección automática y soporte para *Fedora/RHEL/CentOS*, *Debian/Ubuntu/Mint*, y *Arch Linux/Manjaro*.
- **Gestor Interactivo**: Un menú TUI (Text User Interface) con casillas de verificación para que elijas exactamente qué querés instalar.
- **Instalación Transparente**: Se encarga de descargar las dependencias, clonar repositorios si no están en los repos oficiales y compilar todo en segundo plano.
- **Sin Bloatware**: Vos decidís qué programas se quedan en tu sistema.

---

## 🚀 Instalación

Instalar y ejecutar `ascii-animated` es tan simple como clonar este repositorio y ejecutar el script. 

Asegurate de tener `git` instalado en tu sistema.

```bash
# 1. Clonar el repositorio
git clone https://github.com/aporcelli/ascii-animated.git

# 2. Entrar al directorio
cd ascii-animated

# 3. Darle permisos de ejecución al script
chmod +x ascii-animated.sh

# 4. Ejecutar el instalador interactivo
./ascii-animated.sh
```

> **Nota:** El script te va a pedir permisos de `sudo` para instalar paquetes a través de tu gestor de paquetes (`apt`, `dnf` o `pacman/yay`).

---

## 🛠 Herramientas Incluidas

Con `ascii-animated` podés instalar la siguiente colección de arte y animación ASCII:

| Herramienta | Comando | Descripción |
| :--- | :--- | :--- |
| **Matrix** | `cmatrix` | 🌧 Lluvia de caracteres verdes estilo *The Matrix* cayendo en tu pantalla. |
| **Bonsai** | `cbonsai -l` | 🌳 Un árbol bonsai que crece de forma procesal, rama por rama, hoja por hoja. |
| **Locomotora** | `sl` | 🚂 Tren ASCII que cruza la pantalla si escribís mal `ls`. |
| **Lolcat** | `lolcat` | 🌈 Filtro que colorea cualquier output en un hermoso degradado arcoíris. |
| **Cowsay** | `cowsay` | 🐮 Una vaca (u otros animales) que repite el texto que le pases. |
| **Fortune** | `fortune` | 🥠 Imprime citas, frases célebres y bromas aleatorias. |
| **Nyan Cat** | `nyancat` | 🐱🌈 El gato Nyan corriendo con su arcoíris a toda velocidad. |
| **Asciiquarium**| `asciiquarium` | 🐠 Un acuario animado con peces, tiburones, barcos y burbujas. |
| **Rain** | `rain` | ☔ Lluvia suave de gotas ASCII con efecto ncurses. |
| **Lavat** | `lavat` | 🌋 Simulación de lámpara de lava con burbujas que suben y bajan. |
| **Pipes** | `pipes.sh` | 🪄 Tuberías tipo salvapantallas retro que se van dibujando solas. |
| **Cava** | `cava` | 🎵 Visualizador de audio que reacciona a los sonidos del sistema. |

---

## 🧙‍♂️ Combos Épicos

Una vez instaladas las herramientas, podés combinarlas mediante *pipes* (`|`) de bash para lograr efectos increíbles en tu terminal:

**1. Vaca filosófica arcoíris:**
```bash
fortune | cowsay | lolcat
```

**2. Vaca pensadora arcoíris:**
```bash
fortune | cowthink | lolcat
```

**3. Bonsai infinito y colorido:**
```bash
cbonsai -i -l -L 40 | lolcat
```

---

<div align="center">
  <p>Construido para hacer las terminales un poco más felices. 🤍</p>
</div>
