#!/bin/bash

# Stop on all errors
set -e


###############################################################################
#                            Default Parameters                               #
###############################################################################

# Static definitions; purpose of each variable as indicated by its name
# Set the default audio speed to 1 (equivalent to leaving the audio unchanged)
IS_GENERATING_QR_CODE_DEFAULT=true
# Name of the QR code file to be potentially generated
QR_CODE_FILE_NAME="webserver_url.jpg"




###############################################################################
#                              Helper Functions                               #
###############################################################################

# Helper function for displaying help text
function display_help {
  script_name=`basename "$0"`
  echo "Usage  : $script_name -p <port> -q [is-generating-qr-code]"
  echo "Example: $script_name -p 8000"
  echo "Example: $script_name -p 8000   -q"
}




###############################################################################
#                          Input Argument Handling                            #
###############################################################################

# Input argument parsing
while getopts ":hp:q:" option
do
  case "${option}" in
    p) port=${OPTARG};;
    q) is_generating_qr_code=$OPTARG;;
    h) display_help; exit -1;;
    :) echo "Missing option argument for -$OPTARG" >&2; exit 1;;
  esac
done

# Mandatory input arguments check
if [[ -z "${port}" ]]; then
    display_help
    exit -1
fi

# Handle optional parameter for generating QR code
is_generating_qr_code=${is_generating_qr_code:-$IS_GENERATING_QR_CODE_DEFAULT}
if ! hash qrencode 2>/dev/null && ${is_generating_qr_code}
then
        echo -e "This script requires 'qrencode' for generating QR codes but it cannot be detected. Disabling QR code generation."
        is_generating_qr_code=false
fi




###############################################################################
#                           Start Python Webserver                            #
###############################################################################

# Resolve the full URL (on macOS)
ip_address=$(ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2 | head -n 1)
url="http://${ip_address}:${port}"

# Echo the URL for easy user access
echo "Visit http://${ip_address}:${port} from your mobile or tablet to download files from this directory."


# Handle QR code generation
if $is_generating_qr_code
then
    # Encode URL as QR code
    qrencode "${url}" -o "${QR_CODE_FILE_NAME}"
    echo "Scan ${url}/${QR_CODE_FILE_NAME} from your phone or tablet for instant access"

    # Helper function for cleaning up temporary files
    function finish {
        rm "${QR_CODE_FILE_NAME}"
    }

    # Ensure proper cleanup, regardless of the exit status of the script
    trap finish EXIT
fi

# Start Python web server
echo "Press Ctrl-C to stop the web sever"
if hash python3 2>/dev/null
then
  python3 -m http.server "${port}"
else
  python -m SimpleHTTPServer "${port}"
fi
