#!/usr/bin/env bash
# 
# Install script for essential solutions in Linux-shell-base.
# 

# ======= CONFIGURATIONS ==============

# Directory where files will be downloaded
readonly DOWNLOAD_DIR="${HOME}"

# ======= ! CONFIGURATIONS ==============

readonly MASTER_URL='https://raw.githubusercontent.com/linux-shell-base/linux-shell-base/master'
readonly ESSNTLS_DIR="${DOWNLOAD_DIR}/linux-shell-base-essentials"

echo -e "::Downloading files to ${ESSNTLS_DIR}\n  Please wait"

[ -d "${ESSNTLS_DIR}" ] && rm -Rf "${ESSNTLS_DIR}"
mkdir -p "${ESSNTLS_DIR}"

exec 3>&1 4>&2; exec >/dev/null 2>&1 # redirect all output to /dev/null

# ============================================
#   Scripts
# ============================================

mkdir "${ESSNTLS_DIR}/bin"

path='/bin/bash'
wget -P "${ESSNTLS_DIR}${path}" -i - <<EOF
  ${MASTER_URL}${path}/arrayutils.bash
  ${MASTER_URL}${path}/coreutils.bash
  ${MASTER_URL}${path}/dateandtimeutils.bash
  ${MASTER_URL}${path}/fileanddirectoryutils.bash
  ${MASTER_URL}${path}/httputils.bash
  ${MASTER_URL}${path}/numberutils.bash
  ${MASTER_URL}${path}/stringutils.bash
EOF

path='/bin/modules/main/shell'
mkdir -p "${ESSNTLS_DIR}${path}" && cd "${ESSNTLS_DIR}${path}"
wget "${MASTER_URL}${path}/runinbg"
chmod +x runinbg

path='/bin/modules/utilities/file'
mkdir -p "${ESSNTLS_DIR}${path}" && cd "${ESSNTLS_DIR}${path}"
wget "${MASTER_URL}${path}/returnfileforcmd"
chmod +x returnfileforcmd

path='/bin/main-output_only/single-value/hardware'
mkdir -p "${ESSNTLS_DIR}${path}" && cd "${ESSNTLS_DIR}${path}"
wget -i - <<EOF
  ${MASTER_URL}${path}/issecondarywlanblocked
  ${MASTER_URL}${path}/iswlanblocked
EOF
chmod +x issecondarywlanblocked iswlanblocked

path='/bin/main-output_only/single-value/networking'
mkdir -p "${ESSNTLS_DIR}${path}" && cd "${ESSNTLS_DIR}${path}"
wget -i - <<EOF
  ${MASTER_URL}${path}/connectedtointernet
  ${MASTER_URL}${path}/connectedtonetwork
EOF
chmod +x connectedtointernet connectedtonetwork

path='/bin/main-output_only/single-value/x11'
mkdir -p "${ESSNTLS_DIR}${path}" && cd "${ESSNTLS_DIR}${path}"
wget -i - <<EOF
  ${MASTER_URL}${path}/getactvwindclass
  ${MASTER_URL}${path}/getactvwindid
  ${MASTER_URL}${path}/getactvwindname
  ${MASTER_URL}${path}/getactvwindpid
  ${MASTER_URL}${path}/getfirstwindidinclass
  ${MASTER_URL}${path}/getfirstwindnameinclass
  ${MASTER_URL}${path}/getnextwindidinactvclass
  ${MASTER_URL}${path}/getwindclassbyid
  ${MASTER_URL}${path}/getwindclassbyname
  ${MASTER_URL}${path}/getwindidbyname
  ${MASTER_URL}${path}/getwindidbypid
  ${MASTER_URL}${path}/getwindidsinclass
  ${MASTER_URL}${path}/getwindnamebyid
  ${MASTER_URL}${path}/getwindnamesinclass
  ${MASTER_URL}${path}/getwindpidbyid
  ${MASTER_URL}${path}/iswindopen
EOF
chmod +x *

path='/bin/utilities/general'
mkdir -p "${ESSNTLS_DIR}${path}" && cd "${ESSNTLS_DIR}${path}"
wget "${MASTER_URL}${path}/newterm"
chmod +x newterm

path='/bin/utilities/keybind'
mkdir -p "${ESSNTLS_DIR}${path}" && cd "${ESSNTLS_DIR}${path}"
wget "${MASTER_URL}${path}/termcommand"
chmod +x termcommand

# ============================================
#   Aliases and short functions
# ============================================

path='/aliases'
wget -P "${ESSNTLS_DIR}${path}" -i - <<EOF
  ${MASTER_URL}${path}/aliases-main.bash
  ${MASTER_URL}${path}/aliases-main-output_only.bash
  ${MASTER_URL}${path}/aliases-utilities.bash
EOF

# ============================================
#   One-liners
# ============================================

path='/one-liners'
wget -P "${ESSNTLS_DIR}${path}" "${MASTER_URL}${path}/one-liners-main-output_only.bash"


exec >&3 2>&4 # redirect all output back to /dev/tty
echo '::Finished'

