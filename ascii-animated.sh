#!/bin/bash

# ─────────────────────────────────────────────────────────────────────────────
#  ascii-animated — Instalador multi-distro de animaciones ASCII
#  Soporta: Fedora/RHEL, Debian/Ubuntu, Arch Linux
# ─────────────────────────────────────────────────────────────────────────────

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

info()    { echo -e "${GREEN}[+]${NC} $1"; }
warning() { echo -e "${YELLOW}[!]${NC} $1"; }
error()   { echo -e "${RED}[-]${NC} $1"; }
step()    { echo -e "\n${CYAN}${BOLD}━━━ $1${NC}"; }

DISTRO=""
PKG_MANAGER=""

print_banner() {
    clear
    echo -e "${BOLD}"
    cat << 'EOF'
   █████╗ ███████╗ ██████╗██╗    █████╗ ███╗   ██╗██╗███╗   ███╗
  ██╔══██╗██╔════╝██╔════╝██║   ██╔══██╗████╗  ██║██║████╗ ████║
  ███████║███████╗██║     ██║   ███████║██╔██╗ ██║██║██╔████╔██║
  ██╔══██║╚════██║██║     ██║   ██╔══██║██║╚██╗██║██║██║╚██╔╝██║
  ██║  ██║███████║╚██████╗██║   ██║  ██║██║ ╚████║██║██║ ╚═╝ ██║
  ╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚═╝     ╚═╝
EOF
    echo -e "${NC}"
    echo -e "  ${DIM}Instalador multi-distro de animaciones ASCII para la terminal${NC}\n"
}

# ─── Detección automática de distro ──────────────────────────────────────────
detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case "$ID" in
            fedora|rhel|centos|rocky|almalinux)
                DISTRO="fedora"; PKG_MANAGER="dnf" ;;
            debian|ubuntu|linuxmint|pop|kali|elementary|zorin)
                DISTRO="debian"; PKG_MANAGER="apt" ;;
            arch|manjaro|endeavouros|garuda)
                DISTRO="arch"; PKG_MANAGER="pacman" ;;
            *) DISTRO="unknown" ;;
        esac
    fi
}

# ─── Selector de distro ───────────────────────────────────────────────────────
select_distro() {
    print_banner
    echo -e "  ${BOLD}Seleccioná tu distribución Linux:${NC}\n"
    if [ "$DISTRO" != "unknown" ] && [ -n "$DISTRO" ]; then
        echo -e "  ${GREEN}[auto-detectada: $DISTRO]${NC}\n"
    fi
    echo -e "  ${BOLD}1.${NC}  Fedora / RHEL / CentOS / Rocky / AlmaLinux  ${DIM}(dnf)${NC}"
    echo -e "  ${BOLD}2.${NC}  Debian / Ubuntu / Mint / Pop!_OS / Kali      ${DIM}(apt)${NC}"
    echo -e "  ${BOLD}3.${NC}  Arch Linux / Manjaro / EndeavourOS / Garuda  ${DIM}(pacman + yay)${NC}"
    echo -e "  ${BOLD}Q.${NC}  Salir\n"
    while true; do
        echo -ne "  ${BOLD}Opción:${NC} "
        read -r input
        case "$input" in
            1) DISTRO="fedora";  PKG_MANAGER="dnf";    break ;;
            2) DISTRO="debian";  PKG_MANAGER="apt";    break ;;
            3) DISTRO="arch";    PKG_MANAGER="pacman"; break ;;
            q|Q) echo -e "\n  ${DIM}Saliendo.${NC}\n"; exit 0 ;;
            *) warning "Opción inválida, ingresá 1, 2, 3 o Q." ;;
        esac
    done
}

# ─── Dependencias base ────────────────────────────────────────────────────────
install_base_deps() {
    step "Instalando dependencias base"
    case "$DISTRO" in
        fedora)
            sudo dnf install -y gcc ncurses-devel git make curl wget perl \
                perl-Curses perl-Term-Animation --skip-unavailable
            ;;
        debian)
            sudo apt update -y
            sudo apt install -y gcc libncurses-dev git make curl wget \
                build-essential perl libcurses-perl
            ;;
        arch)
            sudo pacman -Sy --noconfirm gcc ncurses git make curl wget \
                base-devel perl perl-curses
            if ! command -v yay &>/dev/null; then
                step "Instalando yay (AUR helper)"
                TMPDIR=$(mktemp -d)
                git clone https://aur.archlinux.org/yay.git "$TMPDIR/yay"
                cd "$TMPDIR/yay"
                makepkg -si --noconfirm
                cd ~
                rm -rf "$TMPDIR"
            fi
            ;;
    esac
}

# ─── Funciones de instalación ─────────────────────────────────────────────────

install_cmatrix() {
    step "Instalando cmatrix"
    # Lluvia de caracteres estilo Matrix
    case "$DISTRO" in
        fedora)  sudo dnf install -y cmatrix --skip-unavailable ;;
        debian)  sudo apt install -y cmatrix ;;
        arch)    sudo pacman -S --noconfirm cmatrix ;;
    esac
}

install_cbonsai() {
    step "Instalando cbonsai"
    # Bonsai animado que crece en tiempo real
    case "$DISTRO" in
        fedora)  sudo dnf install -y cbonsai --skip-unavailable ;;
        debian)
            TMPDIR=$(mktemp -d)
            git clone https://gitlab.com/jallbrit/cbonsai "$TMPDIR/cbonsai"
            cd "$TMPDIR/cbonsai"
            sudo make install
            cd ~; rm -rf "$TMPDIR"
            ;;
        arch)    sudo pacman -S --noconfirm cbonsai ;;
    esac
}

install_sl() {
    step "Instalando sl"
    # Tren ASCII que cruza la pantalla cuando escribís 'sl' en vez de 'ls'
    case "$DISTRO" in
        fedora)  sudo dnf install -y sl --skip-unavailable ;;
        debian)  sudo apt install -y sl ;;
        arch)    sudo pacman -S --noconfirm sl ;;
    esac
}

install_lolcat() {
    step "Instalando lolcat"
    # Colorea cualquier output en degradado arcoíris
    case "$DISTRO" in
        fedora)  sudo dnf install -y lolcat --skip-unavailable ;;
        debian)  sudo apt install -y lolcat ;;
        arch)    sudo pacman -S --noconfirm lolcat ;;
    esac
}

install_cowsay() {
    step "Instalando cowsay + cowthink"
    # cowsay: una vaca que dice lo que le pases | cowthink: igual pero con globo de pensamiento
    # Ambos vienen en el mismo paquete. Uso: cowsay "hola" / cowthink "hola"
    case "$DISTRO" in
        fedora)  sudo dnf install -y cowsay --skip-unavailable ;;
        debian)  sudo apt install -y cowsay ;;
        arch)    sudo pacman -S --noconfirm cowsay ;;
    esac
}

install_fortune() {
    step "Instalando fortune"
    # Muestra frases y citas aleatorias — ideal combinado con cowsay o cowthink
    case "$DISTRO" in
        fedora)  sudo dnf install -y fortune-mod --skip-unavailable ;;
        debian)  sudo apt install -y fortune ;;
        arch)    sudo pacman -S --noconfirm fortune-mod ;;
    esac
}

install_nyancat() {
    step "Instalando nyancat"
    # El gato Nyan corriendo con su arcoíris a toda velocidad
    case "$DISTRO" in
        fedora)  sudo dnf install -y nyancat --skip-unavailable ;;
        debian)
            TMPDIR=$(mktemp -d)
            git clone https://github.com/klange/nyancat "$TMPDIR/nyancat"
            cd "$TMPDIR/nyancat"
            make
            sudo cp src/nyancat /usr/local/bin/nyancat
            cd ~; rm -rf "$TMPDIR"
            ;;
        arch)    sudo pacman -S --noconfirm nyancat ;;
    esac
}

install_asciiquarium() {
    step "Instalando asciiquarium"
    # Acuario animado con peces, tiburones y burbujas en ASCII
    case "$DISTRO" in
        fedora)
            # Requiere perl y Term::Animation
            sudo dnf install -y perl perl-Term-Animation --skip-unavailable
            if ! cpan -i Term::Animation &>/dev/null 2>&1; then
                warning "Intentando instalar Term::Animation con cpan..."
                echo "yes" | cpan Term::Animation
            fi
            TMPDIR=$(mktemp -d)
            curl -sL https://robobunny.com/projects/asciiquarium/asciiquarium.tar.gz \
                -o "$TMPDIR/asciiquarium.tar.gz"
            tar -xzf "$TMPDIR/asciiquarium.tar.gz" -C "$TMPDIR"
            sudo cp "$TMPDIR"/asciiquarium_*/asciiquarium /usr/local/bin/asciiquarium
            sudo chmod +x /usr/local/bin/asciiquarium
            cd ~; rm -rf "$TMPDIR"
            ;;
        debian)
            sudo apt install -y libcurses-perl
            if ! dpkg -l | grep -q "asciiquarium"; then
                TMPDIR=$(mktemp -d)
                curl -sL https://robobunny.com/projects/asciiquarium/asciiquarium.tar.gz \
                    -o "$TMPDIR/asciiquarium.tar.gz"
                tar -xzf "$TMPDIR/asciiquarium.tar.gz" -C "$TMPDIR"
                sudo cp "$TMPDIR"/asciiquarium_*/asciiquarium /usr/local/bin/asciiquarium
                sudo chmod +x /usr/local/bin/asciiquarium
                cd ~; rm -rf "$TMPDIR"
            fi
            ;;
        arch)    sudo pacman -S --noconfirm asciiquarium ;;
    esac
}

install_ascii_rain() {
    step "Instalando ascii-rain"
    # Lluvia suave de gotas ASCII con efecto ncurses — comando: rain
    case "$DISTRO" in
        arch)    yay -S --noconfirm ascii-rain-git ;;
        *)
            TMPDIR=$(mktemp -d)
            git clone https://github.com/nkleemann/ascii-rain "$TMPDIR/ascii-rain"
            gcc -o "$TMPDIR/ascii-rain/rain" "$TMPDIR/ascii-rain/rain.c" -lncurses
            sudo cp "$TMPDIR/ascii-rain/rain" /usr/local/bin/rain
            rm -rf "$TMPDIR"
            info "ascii-rain → /usr/local/bin/rain"
            ;;
    esac
}

install_lavat() {
    step "Instalando lavat"
    # Lava lamp animada con burbujas que suben y bajan en la terminal
    TMPDIR=$(mktemp -d)
    git clone https://github.com/AngelJumbo/lavat "$TMPDIR/lavat"
    cd "$TMPDIR/lavat"
    make
    sudo make install
    cd ~; rm -rf "$TMPDIR"
    info "lavat instalado"
}

install_pipes() {
    step "Instalando pipes.sh"
    # Tuberías que se van dibujando solas en todas direcciones
    case "$DISTRO" in
        arch)    yay -S --noconfirm bash-pipes ;;
        *)
            TMPDIR=$(mktemp -d)
            git clone https://github.com/pipeseroni/pipes.sh "$TMPDIR/pipes.sh"
            cd "$TMPDIR/pipes.sh"
            sudo make install
            cd ~; rm -rf "$TMPDIR"
            info "pipes.sh instalado"
            ;;
    esac
}

install_cava() {
    step "Instalando cava"
    # Visualizador de audio en la terminal — barras que bailan con la música
    case "$DISTRO" in
        fedora)
            sudo dnf install -y cava --skip-unavailable
            if ! command -v cava &>/dev/null; then
                warning "cava no está en repos oficiales, instalando desde GitHub..."
                sudo dnf install -y autoconf automake libtool fftw-devel \
                    pulseaudio-libs-devel alsa-lib-devel --skip-unavailable
                TMPDIR=$(mktemp -d)
                git clone https://github.com/karlstav/cava "$TMPDIR/cava"
                cd "$TMPDIR/cava"
                ./autogen.sh
                ./configure
                make
                sudo make install
                cd ~; rm -rf "$TMPDIR"
            fi
            ;;
        debian)
            sudo apt install -y cava
            if ! command -v cava &>/dev/null; then
                warning "cava no está en repos, instalando desde GitHub..."
                sudo apt install -y libfftw3-dev libpulse-dev libasound2-dev \
                    autoconf automake libtool
                TMPDIR=$(mktemp -d)
                git clone https://github.com/karlstav/cava "$TMPDIR/cava"
                cd "$TMPDIR/cava"
                ./autogen.sh
                ./configure
                make
                sudo make install
                cd ~; rm -rf "$TMPDIR"
            fi
            ;;
        arch)    sudo pacman -S --noconfirm cava ;;
    esac
}

# ─── Definición de herramientas ───────────────────────────────────────────────
declare -A TOOLS
declare -A DESCRIPTIONS
declare -A SELECTED

TOOLS=(
    [1]="cmatrix"
    [2]="cbonsai"
    [3]="sl"
    [4]="lolcat"
    [5]="cowsay + cowthink"
    [6]="fortune"
    [7]="nyancat"
    [8]="asciiquarium"
    [9]="ascii-rain"
    [10]="lavat"
    [11]="pipes.sh"
    [12]="cava"
)

DESCRIPTIONS=(
    [1]="Lluvia de caracteres estilo Matrix cayendo en pantalla"
    [2]="Un bonsai que crece en tiempo real con ramas y hojas ASCII"
    [3]="Tren ASCII que cruza la pantalla si escribis 'sl' en vez de 'ls'"
    [4]="Colorea cualquier output en degradado arcoíris"
    [5]="Vaca (cowsay) o globo de pensamiento (cowthink) con tu texto"
    [6]="Frases y citas aleatorias — ideal con cowsay/cowthink | lolcat"
    [7]="El gato Nyan corriendo con su arcoíris a toda velocidad"
    [8]="Acuario animado con peces, tiburones y burbujas ASCII"
    [9]="Lluvia suave de gotas ASCII con efecto ncurses — comando: rain"
    [10]="Lava lamp animada con burbujas que suben y bajan"
    [11]="Tuberías que se van dibujando solas en todas direcciones"
    [12]="Visualizador de audio — barras que bailan con la música"
)

for i in "${!TOOLS[@]}"; do
    SELECTED[$i]=true
done

# ─── Menú checklist ───────────────────────────────────────────────────────────
print_menu() {
    echo -e "  ${BOLD}Seleccioná qué instalar${NC}  ${DIM}distro: ${DISTRO} (${PKG_MANAGER})${NC}\n"
    echo -e "  ${DIM}número=toggle  A=todo  N=ninguno  I=instalar  Q=salir${NC}\n"
    for i in $(seq 1 ${#TOOLS[@]}); do
        local check
        if [ "${SELECTED[$i]}" = true ]; then
            check="${GREEN}[✓]${NC}"
        else
            check="${DIM}[ ]${NC}"
        fi
        printf "  %b  %2d.  ${BOLD}%-20s${NC}  ${DIM}%s${NC}\n" \
            "$check" "$i" "${TOOLS[$i]}" "${DESCRIPTIONS[$i]}"
    done
    echo ""
}

checklist_menu() {
    while true; do
        print_banner
        print_menu
        echo -ne "  ${BOLD}Opción:${NC} "
        read -r input
        case "$input" in
            [1-9]|10|11|12)
                if [ "${SELECTED[$input]}" = true ]; then
                    SELECTED[$input]=false
                else
                    SELECTED[$input]=true
                fi
                ;;
            a|A) for i in "${!TOOLS[@]}"; do SELECTED[$i]=true;  done ;;
            n|N) for i in "${!TOOLS[@]}"; do SELECTED[$i]=false; done ;;
            i|I) break ;;
            q|Q) echo -e "\n  ${DIM}Saliendo.${NC}\n"; exit 0 ;;
        esac
    done
}

# ─── Main ─────────────────────────────────────────────────────────────────────
detect_distro
select_distro
checklist_menu

selected_count=0
for i in "${!SELECTED[@]}"; do
    [ "${SELECTED[$i]}" = true ] && ((selected_count++))
done

if [ "$selected_count" -eq 0 ]; then
    echo -e "\n  ${YELLOW}No seleccionaste nada. Saliendo.${NC}\n"
    exit 0
fi

echo ""
echo -e "  ${BOLD}Instalando $selected_count herramienta(s) en ${DISTRO}...${NC}"

install_base_deps

[ "${SELECTED[1]}"  = true ] && install_cmatrix
[ "${SELECTED[2]}"  = true ] && install_cbonsai
[ "${SELECTED[3]}"  = true ] && install_sl
[ "${SELECTED[4]}"  = true ] && install_lolcat
[ "${SELECTED[5]}"  = true ] && install_cowsay
[ "${SELECTED[6]}"  = true ] && install_fortune
[ "${SELECTED[7]}"  = true ] && install_nyancat
[ "${SELECTED[8]}"  = true ] && install_asciiquarium
[ "${SELECTED[9]}"  = true ] && install_ascii_rain
[ "${SELECTED[10]}" = true ] && install_lavat
[ "${SELECTED[11]}" = true ] && install_pipes
[ "${SELECTED[12]}" = true ] && install_cava

# ─── Resumen ──────────────────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}${BOLD}  ✓ Instalación completa en ${DISTRO}${NC}\n"
echo -e "  ${DIM}Herramientas instaladas:${NC}\n"
for i in $(seq 1 ${#TOOLS[@]}); do
    if [ "${SELECTED[$i]}" = true ]; then
        echo -e "    ${GREEN}▸${NC} ${BOLD}${TOOLS[$i]}${NC}  ${DIM}— ${DESCRIPTIONS[$i]}${NC}"
    fi
done
echo ""
echo -e "  ${DIM}Combos recomendados:${NC}"
echo -e "    fortune | cowsay | lolcat"
echo -e "    fortune | cowthink | lolcat"
echo ""
