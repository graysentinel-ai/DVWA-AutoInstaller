#!/bin/bash
# ======================================================================
#  GRAYSENTINEL CYBER DEFENCE LAB – DVWA Auto-Installer for Kali Linux
#  Developer : Ritik Shrivas (Founder & Chief Mentor)
#  Purpose   : Fully automated, one‑click DVWA installation
#  License   : GraySentinel Commissioned Officers Only
# ======================================================================

set -e
# ─── Colours & Visuals ───────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'
BLUE='\033[0;34m'; MAGENTA='\033[0;35m'; CYAN='\033[0;36m'
WHITE='\033[1;37m'; BOLD='\033[1m'; DIM='\033[2m'; NC='\033[0m'

# Spinner characters
SPINNER=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
# Progress bar width
BAR_WIDTH=50

# ─── Helper Functions ──────────────────────────────────────
spinner() {
    local pid=$1; local msg="$2"; local i=0
    tput civis
    while kill -0 "$pid" 2>/dev/null; do
        printf "\r${CYAN}%s${NC} %s" "${SPINNER[$i]}" "$msg"
        i=$(( (i+1) % ${#SPINNER[@]} ))
        sleep 0.15
    done
    wait "$pid"
    local ret=$?
    tput cnorm
    printf "\r%-100s\r" " "
    return $ret
}

progress_bar() {
    local current=$1 total=$2 desc="$3"
    local filled=$(( current * BAR_WIDTH / total ))
    printf "\r${GREEN}[%-${BAR_WIDTH}s] %d/%d %s${NC}" \
           "$(printf '#%.0s' $(seq 1 $filled))" "$current" "$total" "$desc"
}

echo_step() { echo -e "${BLUE}[STEP]${NC} $1"; }
echo_ok()   { echo -e "${GREEN}[  ✔  ]${NC} $1"; }
echo_warn() { echo -e "${YELLOW}[  ⚠  ]${NC} $1"; }
echo_err()  { echo -e "${RED}[  ✘  ]${NC} $1"; }

# ─── Branding ─────────────────────────────────────────────
brand_banner() {
    clear
    echo -e "${MAGENTA}${BOLD}"
    echo "  ╔══════════════════════════════════════════════════════╗"
    echo "  ║       GRAYSENTINEL CYBER DEFENCE LAB                 ║"
    echo "  ║       DVWA Automated Deployment System               ║"
    echo "  ║       Developer: Ritik Shrivas                       ║"
    echo "  ╚══════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# ─── Check Privileges ────────────────────────────────────
if [[ $EUID -ne 0 ]]; then
    echo_err "This script must be run as root. Use sudo."
    exit 1
fi

# ─── Start ────────────────────────────────────────────────
brand_banner
echo -e "${DIM}Starting DVWA installation at $(date)${NC}\n"

# 1. Update package lists
echo_step "Updating package lists..."
(apt update -y 2>&1 | tail -5) &
spinner $! "Refreshing repositories..."
echo_ok "Package lists updated."

# 2. Install prerequisites with progress simulation
echo_step "Installing required packages..."
REQUIRED_PKGS=(apache2 mariadb-server php php-mysqli php-gd php-xml php-mbstring libapache2-mod-php)
total=${#REQUIRED_PKGS[@]}
for i in "${!REQUIRED_PKGS[@]}"; do
    pkg=${REQUIRED_PKGS[$i]}
    progress_bar $((i+1)) $total "Installing $pkg"
    apt install -y "$pkg" > /dev/null 2>&1
done
echo ""
echo_ok "All packages installed."

# 3. Start services
echo_step "Starting Apache & MariaDB..."
(systemctl start apache2 mariadb) &
spinner $! "Booting services..."
systemctl enable apache2 mariadb > /dev/null 2>&1
echo_ok "Services up and enabled."

# 4. Database setup
echo_step "Creating DVWA database and user..."
mysql -u root <<SQL > /dev/null 2>&1
CREATE DATABASE IF NOT EXISTS dvwa;
CREATE USER IF NOT EXISTS 'dvwa'@'localhost' IDENTIFIED BY 'p@ssw0rd';
GRANT ALL PRIVILEGES ON dvwa.* TO 'dvwa'@'localhost';
FLUSH PRIVILEGES;
SQL
echo_ok "Database configured."

# 5. Clone DVWA from GitHub
echo_step "Downloading DVWA source code..."
cd /var/www/html
if [ -d DVWA ]; then
    echo_warn "Existing DVWA folder found. Removing..."
    rm -rf DVWA
fi
(git clone https://github.com/digininja/DVWA.git 2>&1 | tail -3) &
spinner $! "Cloning repository..."
chown -R www-data:www-data DVWA/
chmod -R 755 DVWA/
echo_ok "DVWA downloaded and permissions set."

# 6. Configure DVWA config
echo_step "Setting up DVWA configuration..."
cd /var/www/html/DVWA/config
cp config.inc.php.dist config.inc.php
sed -i "s/\$_DVWA\[ 'db_user' \]     = .*/\$_DVWA\[ 'db_user' \]     = 'dvwa';/" config.inc.php
sed -i "s/\$_DVWA\[ 'db_password' \] = .*/\$_DVWA\[ 'db_password' \] = 'p@ssw0rd';/" config.inc.php
sed -i "s/\$_DVWA\[ 'db_database' \] = .*/\$_DVWA\[ 'db_database' \] = 'dvwa';/" config.inc.php
sed -i "s/\$_DVWA\[ 'default_security_level' \] = .*/\$_DVWA\[ 'default_security_level' \] = 'low';/" config.inc.php
echo_ok "DVWA configured (default security: low)."

# 7. Enable PHP allow_url_include
echo_step "Enabling PHP allow_url_include..."
PHP_VERSION=$(php -r 'echo PHP_MAJOR_VERSION . "." . PHP_MINOR_VERSION;')
PHP_INI="/etc/php/$PHP_VERSION/apache2/php.ini"
if [ -f "$PHP_INI" ]; then
    sed -i 's/allow_url_include = Off/allow_url_include = On/' "$PHP_INI"
    sed -i 's/allow_url_fopen = Off/allow_url_fopen = On/' "$PHP_INI"
    sed -i 's/;allow_url_include = Off/allow_url_include = On/' "$PHP_INI"
    sed -i 's/;allow_url_fopen = Off/allow_url_fopen = On/' "$PHP_INI"
fi
echo_ok "PHP configuration updated."

# 8. Restart Apache
echo_step "Restarting Apache..."
(systemctl restart apache2) &
spinner $! "Rebooting web server..."
echo_ok "Apache restarted."

# 9. Auto‑trigger DVWA setup to create tables
echo_step "Finalising DVWA database setup..."
sleep 2
curl -s "http://127.0.0.1/DVWA/setup.php?create_db=Create+%2F+Reset+Database" > /dev/null
echo_ok "DVWA database tables created."

# ─── Final Banner ─────────────────────────────────────────
echo ""
echo -e "${GREEN}${BOLD}"
echo "  ╔══════════════════════════════════════════════════════╗"
echo "  ║          🎉  DVWA INSTALLATION COMPLETE  🎉         ║"
echo "  ╚══════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo -e "${CYAN}  ➤  URL:      ${WHITE}http://127.0.0.1/DVWA/login.php${NC}"
echo -e "${CYAN}  ➤  Username: ${WHITE}admin${NC}"
echo -e "${CYAN}  ➤  Password: ${WHITE}password${NC}"
echo -e "${YELLOW}  ➤  Security level set to ${WHITE}LOW${YELLOW} (change in DVWA Security)${NC}"
echo ""
echo -e "${DIM}  Developer: Ritik Shrivas – GraySentinel Cyber Defence Lab${NC}"
echo -e "${DIM}  Remember: This is a vulnerable application – use only in isolated lab.${NC}"
echo ""

exit 0
