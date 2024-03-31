info_icon='\033[0;34mi\033[0m'
success_icon='\033[0;32m✔\033[0m'
warn_icon='\033[0;33m⚠️\033[0m'
error_icon='\033[0;31m✗\033[0m'

info() {
  echo -e "${info_icon} $*"
}

success() {
  echo -e "${success_icon} $*"
}

warn() {
  echo -e "${warn_icon}$*"
}

error() {
  echo -e "${error_icon} $*"
}
