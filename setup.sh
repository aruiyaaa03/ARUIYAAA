#!/bin/bash
clear
mkdir -p "$HOME/.ARUIYAAA"
mkdir -p "$HOME/.Aruiyaaa-simu"
mkdir -p "$HOME/.toolx"

# dx color
r='\033[1;91m'
p='\033[1;95m'
y='\033[1;93m'
g='\033[1;92m'
n='\033[1;0m'
b='\033[1;94m'
c='\033[1;96m'

# dx Symbol
X='\033[1;92m[\033[1;00m⎯꯭̽𓆩\033[1;92m]\033[1;96m'
D='\033[1;92m[\033[1;00m〄\033[1;92m]\033[1;93m'
E='\033[1;92m[\033[1;00m×\033[1;92m]\033[1;91m'
A='\033[1;92m[\033[1;00m+\033[1;92m]\033[1;92m'
C='\033[1;92m[\033[1;00m</>\033[1;92m]\033[92m'
lm='\033[96m▱▱▱▱▱▱▱▱▱▱▱▱\033[0m〄\033[96m▱▱▱▱▱▱▱▱▱▱▱▱\033[1;00m'
dm='\033[93m▱▱▱▱▱▱▱▱▱▱▱▱\033[0m〄\033[93m▱▱▱▱▱▱▱▱▱▱▱▱\033[1;00m'

# dx icon (Nerd Font Fallbacks Included)
OS="󰣇"
HOST="󰒋"
KER="󰌢"
UPT="󱎫"
PKGS="󰏖"
SH="󰞀"
TERMINAL="󰆍"
CHIP="󰘚"
CPUI="󰻠"
HOMES="󱂵"

ARUIYAAA="${ARUIYAAA:-https://github.com}"

if command -v getprop &>/dev/null; then
    MODEL=$(getprop ro.product.model)
    VENDOR=$(getprop ro.product.manufacturer)
else
    MODEL=$(uname -n)
    VENDOR=$(uname -s)
fi
devicename="${VENDOR} ${MODEL}"
THRESHOLD=100
random_number=$(( RANDOM % 2 ))

exit_script() {
    clear
    echo -e "\n${c}              (\_/)"
    echo -e "              (${y}^_^${c})     ${A} ${g}Hey dear${c}"
    echo -e "              ⊂(___)づ  ⋅˚₊‧ ଳ ‧₊˚ ⋅"              
    echo -e "\n ${g}[${n}${KER}${g}] ${c}Exiting ${g}ARUIYAAA Banner \033[1;36m\n"
    cd "$HOME" || exit
    rm -rf "$HOME/ARUIYAAA"
    kill -9 $PPID 2>/dev/null
    exit 0
}

trap exit_script SIGINT SIGTSTP

if ! command -v tput &>/dev/null; then
    echo -e " ${C} ${g}Waiting for setup Screen!¡${n}"
    if [ -d "/data/data/com.termux/files/usr/" ]; then
        pkg install ncurses-utils -y >/dev/null 2>&1
    else
        sudo apt install ncurses-bin -y >/dev/null 2>&1 || true
    fi
    clear
fi

if ! command -v curl &>/dev/null; then
    if [ -d "/data/data/com.termux/files/usr/" ]; then
        pkg install curl -y >/dev/null 2>&1
    else
        sudo apt install curl -y >/dev/null 2>&1 || true
    fi
    clear
fi

check_disk_usage() {
    local threshold=${1:-$THRESHOLD}
    local total_size=$(df -h "$HOME" | awk 'NR==2 {print $2}')
    local used_size=$(df -h "$HOME" | awk 'NR==2 {print $3}')
    local disk_usage=$(df "$HOME" | awk 'NR==2 {print $5}' | sed 's/%//g')

    if [ "$disk_usage" -ge "$threshold" ] 2>/dev/null; then
        echo -e "${g}[${n}󰋊${g}] ${r}WARN: ${y}Disk Full ${g}${disk_usage}% ${c}| ${c}U${g}${used_size} ${c}of ${c}T${g}${total_size}"
    else
        echo -e "${y}Disk usage: ${g}${disk_usage}% ${c}| ${g}${used_size}"
    fi
}
data=$(check_disk_usage)

start() {
    clear
    tput civis
    LIME='\e[38;5;154m'
    C='\e[38;5;51m'
    BLINK='\e[5m'
    N='\e[0m'
    TOTAL_CHARS=0
    texts=(
        "「 ARUIYAAA STARTED 」"
        "「 HELLO DEAR USER I'M  ARIYAN MUNNA 」"
        "「 ARUIYAAA WILL PROTECT YOU 」"
        "「 GOODBYE 」"
        "「 ENJOY OUR ARU.CZ 」"
        "「............... 」"
    )
    for t in "${texts[@]}"; do
        TOTAL_CHARS=$((TOTAL_CHARS + ${#t}))
    done
    CURRENT_CHAR=0
    update_progress() {
        local percentage=$(( CURRENT_CHAR * 100 / TOTAL_CHARS ))
        if [ "$percentage" -gt 100 ]; then percentage=100; fi
        local term_width=$(tput cols)
        local bar_width=$((term_width - 20))
        if [ "$bar_width" -gt 50 ]; then bar_width=50; fi
        local padding=$(( (term_width - bar_width - 10) / 2 ))
        local filled=$(( percentage * bar_width / 100 ))
        local empty=$(( bar_width - filled ))
        local f_bar=$(printf "%${filled}s" "")
        local e_bar=$(printf "%${empty}s" "")
        tput sc
        tput cup 2 0
        tput el
        printf "%${padding}s${LIME}[\e[48;5;154m%s\e[0m\e[48;5;236m%s\e[0m${LIME}] ${C}%3d%%${N}" "" "$f_bar" "$e_bar" "$percentage"
        tput rc
    }
    type_effect() {
        local text="$1"
        local delay="$2"
        local term_width=$(tput cols)
        local text_length=${#text}
        local padding=$(( (term_width - text_length) / 2 ))
        printf "%${padding}s" ""
        for ((i=0; i<${#text}; i++)); do
            CURRENT_CHAR=$((CURRENT_CHAR + 1))
            update_progress
            printf "${LIME}${BLINK}${text:$i:1}${N}"
            if (( RANDOM % 1 == 0 )); then
                printf "\e[48;5;51m \e[0m"
                printf "\b \b"
            fi
            sleep "$delay"
        done
        echo -e "\n"
    }
    tput cup 5 0
    type_effect "${texts[0]}" 0.01
    sleep 0.1
    type_effect "${texts[1]}" 0.02
    sleep 0.1
    type_effect "${texts[2]}" 0.02
    sleep 0.1
    type_effect "${texts[3]}" 0.02
    sleep 0.1
    type_effect "${texts[4]}" 0.02
    sleep 0.1
    type_effect "${texts[5]}" 0.02
    sleep 1
    tput cnorm
    clear 
}
start

show_spinner() {
    local pid=$1
    local task_name=$2
    local delay=0.15
    local spinner=('█■■■■' '■█■■■' '■■█■■' '■■■█■' '■■■■█')
    tput civis
    while ps -p "$pid" > /dev/null 2>&1; do
        for i in "${spinner[@]}"; do
            echo -ne "\033[1;96m\r [+] Installing $task_name please wait \e[33m[\033[1;92m$i\033[1;93m]\033[1;0m   "
            sleep $delay
        done
    done
    printf "\r\e[1;93m [Done $task_name]\e[0m\n\n"
    tput cnorm
}

spin() {
    echo
    apt update >/dev/null 2>&1
    packages=("git" "python" "ncurses-utils" "jq" "figlet" "termux-api" "lsd" "zsh" "ruby" "exa")

    for package in "${packages[@]}"; do
        if ! dpkg-query -W -f='${Status}' "$package" 2>/dev/null | grep -q "ok installed"; then
            pkg install "$package" -y >/dev/null 2>&1 &
            show_spinner $! "$package"
        fi
    done

    if ! command -v lolcat >/dev/null 2>&1; then
        pip install lolcat >/dev/null 2>&1 &
        show_spinner $! "lolcat(pip)"
    fi
    
    rm -rf /data/data/com.termux/files/usr/bin/chat >/dev/null 2>&1
    
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh >/dev/null 2>&1 &
        show_spinner $! "oh-my-zsh"
    fi
    
    if [ "$SHELL" != "/data/data/com.termux/files/usr/bin/zsh" ]; then
        chsh -s zsh >/dev/null 2>&1
    fi
    
    if [ ! -f "$HOME/.zshrc" ]; then
        cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc >/dev/null 2>&1
    fi
    
    if [ ! -d "$HOME/.oh-my-zsh/plugins/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/plugins/zsh-autosuggestions >/dev/null 2>&1 &
        show_spinner $! "zsh-autosuggestions"
    fi
    
    if [ ! -d "$HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting >/dev/null 2>&1 &
        show_spinner $! "zsh-syntax"
    fi
}

linux_spin() {
    echo
    if command -v apt >/dev/null 2>&1; then
        sudo apt update >/dev/null 2>&1
        packages=("git" "python3" "python3-pip" "jq" "figlet" "zsh" "ruby" "exa")
        for package in "${packages[@]}"; do
            if ! command -v "$package" >/dev/null 2>&1; then
                sudo apt install "$package" -y >/dev/null 2>&1 &
                show_spinner $! "$package"
            fi
        done
    fi

    if ! command -v lolcat >/dev/null 2>&1; then
        sudo pip3 install lolcat --break-system-packages >/dev/null 2>&1 &
        show_spinner $! "lolcat(pip)"
    fi
    
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh >/dev/null 2>&1 &
        show_spinner $! "oh-my-zsh"
    fi
    
    if [ "$SHELL" != "$(command -v zsh)" ]; then
        sudo chsh -s "$(command -v zsh)" "$USER" >/dev/null 2>&1
    fi
    
    if [ ! -f "$HOME/.zshrc" ]; then
        cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc >/dev/null 2>&1
    fi
}

setup_termux_paths() {
    local ds="$HOME/.termux"
    mkdir -p "$ds"
    [ -f "$HOME/ARUIYAAA/files/font.ttf" ] && cp "$HOME/ARUIYAAA/files/font.ttf" "$ds/"
    [ -f "$HOME/ARUIYAAA/files/colors.properties" ] && cp "$HOME/ARUIYAAA/files/colors.properties" "$ds/"
    
    # Safe move template checks
    if [ -d "$HOME/ARUIYAAA/files" ]; then
        find "$HOME/ARUIYAAA/files/" -maxdepth 1 -type f -exec chmod +x {} \;
        mv "$HOME/ARUIYAAA/files/simu" "$PREFIX/bin/" 2>/dev/null
        mv "$HOME/ARUIYAAA/files/code" "$PREFIX/bin/" 2>/dev/null
        mv "$HOME/ARUIYAAA/files/"* "$HOME/.toolx/" 2>/dev/null
    fi
    termux-reload-settings
}

setup_linux_paths() {
    mkdir -p ~/.local/share/fonts
    [ -f "$HOME/ARUIYAAA/files/font.ttf" ] && cp "$HOME/ARUIYAAA/files/font.ttf" ~/.local/share/fonts/ && fc-cache -fv > /dev/null
    if [ -d "$HOME/ARUIYAAA/files" ]; then
        find "$HOME/ARUIYAAA/files/" -maxdepth 1 -type f -exec chmod +x {} \;
        sudo mv "$HOME/ARUIYAAA/files/simu" /usr/local/bin/ 2>/dev/null
        sudo mv "$HOME/ARUIYAAA/files/code" /usr/local/bin/ 2>/dev/null
        mv "$HOME/ARUIYAAA/files/"* "$HOME/.toolx/" 2>/dev/null
    fi
}

dxnetcheck() {
    clear
    echo -e "\n\t\t\t\t         ${g}Uhu"
    echo -e "${c}                        (\_/)"
    echo -e "                        (${y}^_^${c})"
    echo -e "                        ⊂(___)づ\n"
    echo -e "                 ${g}╔════════════════╗"
    echo -e "                 ${g}║ ${n}</>  ${c}ARUIYAAA-X${g}   ║"
    echo -e "                 ${g}╚════════════════╝"
    echo -e "  ${g}╔════════════════════════════════════════════╗"
    echo -e "  ${g}║   ${y} Checking Your Internet Connection¡ ${g}       ║"
    echo -e "  ${g}╚════════════════════════════════════════════╝${n}"
    while true; do
        if curl --silent --head --fail https://github.com > /dev/null; then
            break
        else
            echo -e "                ${g}╔══════════════════╗"
            echo -e "                ${g}║${C} ${r}No Internet ${g}║"
            echo -e "                ${g}╚══════════════════╝"
            sleep 2.5
        fi
    done
    clear
}

sync_id() {
    UPDATE_LOG="$HOME/.aruiyaaa_update_id.txt"
    if command -v jq >/dev/null 2>&1; then
        local sid
        sid=$(curl -s --connect-timeout 5 "$ARUIYAAA/update" 2>/dev/null | jq -r '.id' 2>/dev/null | tr -d '[:space:]')
        [ -n "$sid" ] && [ "$sid" != "null" ] && echo "$sid" > "$UPDATE_LOG"
    fi
}

donotchange() {
    clear
    echo -e "\n\n${c}              (\_/)"
    echo -e "              (${y}^_^${c})     ${A} ${g}Hey dear${c}"
    echo -e "              ⊂(___)づ  ⋅˚₊‧ ଳ ‧₊˚ ⋅\n"
    echo -e " ${A} ${c}Please Enter Your ${g}Banner Name${c}\n"
    while true; do
        read -p "$(echo -e "${c}${A}──[Enter Your Name]────► ${n}")" name
        echo
        if [[ -z "$name" ]]; then
            echo -e " ${E} ${r}Name cannot be empty!${c}\n"
            continue
        fi
        if [[ ! "$name" =~ ^[a-zA-Z0-9[:space:]-]+$ ]]; then
            echo -e " ${E} ${r}Invalid Input! No fancy fonts or symbols.\n ${E} ${r}Use letters, numbers, hyphens & spaces only.${c}\n"
            continue
        fi

        name="${name^^}"
        name="${name// /-}"
        len=${#name}

        if [[ $len -ge 1 && $len -le 8 ]]; then
            break
        else
            echo -e " ${E} ${r}Name must be between ${g}1 and 8${r} characters.\n ${y}Current length is: ${g}$len${c}\n"
        fi
    done

    D1="$HOME/.ARUIYAAA"
    [ -d "/data/data/com.termux/files/usr/" ] && D1="$HOME/.termux"
    mkdir -p "$D1"
    
    INPUT_FILE="$HOME/ARUIYAAA/files/.zshrc"
    THEME_INPUT="$HOME/ARUIYAAA/files/.aruiyaaa.zsh-theme"
    OUTPUT_ZSHRC="$HOME/.zshrc"
    OUTPUT_THEME="$HOME/.oh-my-zsh/themes/aruiyaaa.zsh-theme"
    TEMP_FILE="$HOME/temp.zshrc"
    
    if [ -f "$INPUT_FILE" ] && [ -f "$THEME_INPUT" ]; then
        sed "s/DX-SIMU/$name/g" "$INPUT_FILE" > "$TEMP_FILE"
        sed "s/DX-SIMU/$name/g" "$THEME_INPUT" > "$OUTPUT_THEME"
        mv "$TEMP_FILE" "$OUTPUT_ZSHRC"
        clear
        echo -e "\n\n\t\t\t\t         ${g}Hey ${y}$name"
        echo -e "${c}              (\_/)"
        echo -e "              (${y}^ω^${c})     ${g}I'm Dx-Simu${c}"
        echo -e "              ⊂(___)づ  ⋅˚₊‧ ଳ ‧₊˚ ⋅\n"
        echo -e " ${A} ${c}Your Banner created ${g}Successfully¡${c}\n"
        sleep 1
        sync_id
    else
        echo -e "\n ${E} ${r}Required core template files missing from source repository."
        sleep 2
    fi
    clear
}

banner() {
    clear
    echo -e "${y}     _____                                                                                 _____ "
    echo -e "${y}    ( ___ )--------------------------------------------------------------------------------( ___ )"
    echo -e "${y}     |   |                                                                                  |   | "
    echo -e "${y}     |   |    ____    _    ____  _____    __    _  _     _  ____        ___   _ _   _ _____    |   | "
    echo -e "${y}     |   |   | __ )  / \  / ___|| ____|  / /_  | || |   | |/ /\ \      / / | | | | | |_   _|   |   | "
    echo -e "${c}     |   |   |  _ \ / _ \ \___ \|  _|    | '_ \| || |_  | ' /  \ \ /\ / /| |_| | |_| | | |     |   | "
    echo -e "${c}     |   |   | |_) / ___ \ ___) | |___   | (_) |__   _| | . \   \ V  V / |  _  |  _  | | |     |   | "
    echo -e "${c}     |   |   |____/_/   \_\____/|_____|  \___/    |_|   |_|\_\   \_/\_/  |_| |_|_| |_| |_|     |   | "
    echo -e "${c}     |___|                                                                                  |___| "
    echo -e "${c}    (_____)--------------------------------------------------------------------------------(_____)${n}"
    echo -e "${y}                        +-+-+-+-+-+-+-+-+"
    echo -e "${c}                        |A|R|U|I|Y|A|A|A|"
    echo -e "${y}                        +-+-+-+-+-+-+-+-+${n}\n"
    if [ $random_number -eq 0 ]; then
        echo -e "${b}╭════════════════════════⊷\n┃ ${g}[${n}ム${g}] ᴛɢ: ${y}t.me/Aruiyaaa03\n╰════════════════════════⊷"
    else
        echo -e "${b}╭══════════════════════════⊷\n┃ ${g}[${n}ム${g}] ᴛɢ: ${y}t.me/khanwhitehathackerteam\n╰══════════════════════════⊷"
    fi
    echo -e "\n${b}╭══ ${g}〄 ${y}ᴀʀᴜɪʏᴀᴀᴀ ${g}〄\n┃❁ ${g}ᴄʀᴇᴀᴛᴏʀ: ${y}ᴀʀᴜɪʏᴀᴀᴀ\n┃❁ ${g}Host OS: ${y}${VENDOR}\n╰┈➤ ${g}Hey ${y}Dear\n"
}

banner2() {
    banner
    echo -e "${c}╭════════════════════════════════════════════════⊷"
    echo -e "${c}┃ ${p}❏ ${g}Choose what you want to use. then Click Enter${n}"
    echo -e "${c}╰════════════════════════════════════════════════⊷"
}

setupx() {
    dxnetcheck
    banner
    
    if [ -d "/data/data/com.termux/files/usr/" ]; then
        echo -e " ${C} ${y}Detected Termux on Android¡\n ${lm}\n ${A} ${g}Updating Package..¡\n ${dm}\n ${A} ${g}Wait a few minutes.${n}\n ${lm}"
        spin
    else
        echo -e " ${C} ${y}Detected Linux System¡\n ${lm}\n ${A} ${g}Updating Package..¡\n ${dm}\n ${A} ${g}Wait a few minutes.${n}\n ${lm}"
        linux_spin
    fi

    if [ -d "$HOME/ARUIYAAA" ]; then
        sleep 1
        clear
        banner
        echo -e " ${A} ${p}Updating Completed...!¡\n ${dm}"
        clear
        banner
        echo -e " ${C} ${c}Package Setup Your System..${n}\n\n ${A} ${g}Wait a few minutes.${n}"
        
        if [ -d "/data/data/com.termux/files/usr/" ]; then
            setup_termux_paths
        else
            setup_linux_paths
        fi
        
        donotchange
        clear
        banner
        echo -e " ${C} ${c}Type ${g}exit ${c} then ${g}enter ${c}Now Open Your Terminal¡¡ ${g}[${n}${HOMES}${g}]${n}\n"
        sleep 3
        cd "$HOME" || exit
        rm -rf "$HOME/ARUIYAAA"
        kill -9 $PPID 2>/dev/null
        exit 0
    else
        clear
        banner
        echo -e " ${E} ${r}Tools Not Exits Your Terminal..\n\n"
        sleep 3
        exit 1
    fi
}

options=("Free Usage" "Premium")
selected=0

display_menu() {
    clear
    banner2
    echo -e "\n ${g}■ \e[4m${p}Select An Option\e[0m ${g}▪︎${n}\n"
    for i in "${!options[@]}"; do
        if [ $i -eq $selected ]; then
            echo -e " ${g}〄> ${c}${options[$i]} ${g}<〄${n}"
        else
            echo -e "     ${options[$i]}"
        fi
    done
}

if [ -d "/data/data/com.termux/files/usr/" ]; then
    clear
    echo -e "\n ${p}■ \e[4m${g}Use Button\e[4m ${p}▪︎${n}\n"
    echo -e " ${y}Termux: Use Extra key Button with move${n}\n"
    echo -e " UP        ↑"
    echo -e " DOWN      ↓\n"
    echo -e " ${g}Select option Click Enter button\n"
    echo -e " ${b}■ \e[4m${c}If you understand, click the Enter Button\e[4m ${b}▪︎${n}"
    read -r -p ""
    clear
        
    while true; do
        display_menu
        read -rsn1 input
        if [[ "$input" == $'\e' ]]; then
            read -rsn2 -t 0.1 input
            case "$input" in
                '[A') # Up arrow
                    ((selected--))
                    if [ $selected -lt 0 ]; then
                        selected=$((${#options[@]} - 1))
                    fi
                    ;;
                '[B') # Down arrow
                    ((selected++))
                    if [ $selected -ge ${#options[@]} ]; then
                        selected=0
                    fi
                    ;;
            esac
        elif [[ "$input" == "" ]]; then # Enter key
            case ${options[$selected]} in
                "Free Usage")
                    echo -e "\n ${g}[${n}${HOMES}${g}] ${c}Continue Free..!${n}"
                    sleep 1
                    setupx
                    break
                    ;;
                "Premium")
                    echo -e "\n ${g}[${n}${HOST}${g}] ${c}Wait for opening Telegram..!${n}"
                    sleep 1
                    termux-open "https://t.me/Aruiyaaa03" 2>/dev/null || xdg-open "https://t.me/Khanwhitehathackerteam" 2>/dev/null
                    echo -e "\n ${g}[${n}${HOMES}${g}] ${c}Switching to Free Usage to continue..!${n}"
                    sleep 2
                    setupx
                    break
                    ;;
            esac
        fi
    done
else
    while true; do
        clear
        banner2
        echo -e "\n ${g}■ \e[4m${p}Select An Option\e[0m ${g}▪︎${n}\n"
        echo -e " ${g}[${n}1${g}] ${c}Free Usage${n}"
        echo -e " ${g}[${n}2${g}] ${c}Premium${n}\n"
        read -r -p "$(echo -e "${A}${g}──[${n}Select Option${g}]────► ${n}")" choice
        
        if [ "$choice" == "1" ]; then
            echo -e "\n ${g}[${n}${HOMES}${g}] ${c}Continue Free..!${n}"
            sleep 1
            setupx
            break
        elif [ "$choice" == "2" ]; then
            echo -e "\n ${g}[${n}${HOST}${g}] ${c}Wait for opening Telegram..!${n}"
            sleep 1
            xdg-open "https://t.me/Aruiyaaa03" 2>/dev/null
            echo -e "\n ${g}[${n}${HOMES}${g}] ${c}Switching to Free Usage to continue..!${n}"
            sleep 2
            setupx
            break
        else
            echo -e "\n ${E} ${r}Invalid Choice! Please enter 1 or 2.${n}"
            sleep 1
        fi
    done
fi
