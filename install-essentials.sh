#!/usr/bin/env bash
# 
# Install script for essential solutions from Linux-shell-base.
# 

# ======= CONFIGURATIONS ==============

# Directory where files will be downloaded
readonly DOWNLOAD_DIR="${HOME}"

# ======= ! CONFIGURATIONS ==============

readonly MASTER_URL='https://raw.githubusercontent.com/linux-shell-base/linux-shell-base/master'
readonly LSB_ESSNTLS_DIR="${DOWNLOAD_DIR}/linux-shell-base-essentials"

echo -e "::Downloading files to ${LSB_ESSNTLS_DIR}\n  Please wait"

[ -d "${LSB_ESSNTLS_DIR}" ] && rm -Rf "${LSB_ESSNTLS_DIR}"
mkdir -p "${LSB_ESSNTLS_DIR}"

exec 3>&1 4>&2; exec >/dev/null 2>&1 # redirect all output to /dev/null

# ============================================
#   Utility functions
# ============================================

# Run wget for the given files in the given URL and run necessary post-set-up.
# Usage:
#   mwget <directory> <file names for wget...>
mwget() {
  for fileNameArg in "${@: 2}"; do
    local filesList+="${fileNameArg} "
    local wgetFilesList+="${MASTER_URL}${1}/${fileNameArg}"$'\n'
  done
  wget -P "${LSB_ESSNTLS_DIR}${1}" -i - <<-EOF
    ${wgetFilesList}
	EOF
  cd "${LSB_ESSNTLS_DIR}${1}"
  for file in ${filesList}; do
    if [ -n "${file##*.*}" ]; then
      chmod +x "${file}"
    fi
  done
}

# ============================================
#   Solutions - Scripts
# ============================================

mwget '/scripts/linux-modules/shell_management' \
  'runinbg';

mwget '/scripts/linux-modules/file_management' \
  'returnfileforcmd';

mwget '/scripts/linux-output_only-single-value/hardware_management' \
  'issecondarywlanblocked' \
  'iswlanblocked';

mwget '/scripts/linux-output_only-single-value/network_management' \
  'connectedtointernet' \
  'connectedtonetwork';

mwget '/scripts/linux-output_only-single-value/x11' \
  'getactvwindclass' \
  'getactvwindid' \
  'getactvwindname' \
  'getactvwindpid' \
  'getfirstwindidinclass' \
  'getfirstwindnameinclass' \
  'getnextwindidinactvclass' \
  'getwindclassbyid' \
  'getwindclassbyname' \
  'getwindidbyname' \
  'getwindidbypid' \
  'getwindidsinclass' \
  'getwindnamebyid' \
  'getwindnamesinclass' \
  'getwindpidbyid' \
  'iswindopen';

mwget '/scripts/utilities-primary/program_management' \
  'newterm';

mwget '/scripts/utilities-primary/keybind' \
  'termcommand';

mwget '/scripts/utilities-primary/text_manipulation' \
  'reprec';

# ============================================
#   Solutions - Functions
# ============================================

mwget '/functions/programming_languages/bash' \
  'arrayutils.bash' \
  'coreutils.bash' \
  'dateandtimeutils.bash' \
  'fileanddirectoryutils.bash' \
  'httputils.bash' \
  'numberutils.bash' \
  'stringutils.bash';

# ============================================
#   Solutions - Aliases and short functions
# ============================================

mwget '/aliases' \
  'aliases-linux-with_output.bash' \
  'aliases-linux-without_output.bash' \
  'aliases-linux-output_only-multi-value.bash' \
  'aliases-linux-output_only-single-value.bash' \
  'aliases-utilities-primary.bash';

# ============================================
#   Solutions - One-liners
# ============================================

mwget '/one-liners' \
  'one-liners-linux-output_only-single-value.bash';

# ============================================
#   Finish
# ============================================

exec >&3 2>&4 # redirect all output back to /dev/tty
echo '::Finished'
