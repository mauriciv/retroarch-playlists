#! /usr/bin/sh

# Usage: retroarch-add-to-playlist.sh path/to/rom path/to/playlist path/to/system/thumbnails

ROM_PATH="$1"
ROM_NAME=$(basename "$ROM_PATH")
LABEL=${ROM_NAME%%.*}
PLAYLIST_PATH=$2
PLAYLIST_NAME=$(basename "$PLAYLIST_PATH")
PLAYLIST_LABEL=${PLAYLIST_NAME%%.*}
SYSTEM_THUMBNAILS=$3

# Add game to playlist
jq ".items += [
    {
      \"path\": \"$ROM_PATH\",
      \"label\": \"$LABEL\",
      \"core_path\": \"DETECT\",
      \"core_name\": \"DETECT\",
      \"db_name\": \"$PLAYLIST_NAME\"
    }
]" "$PLAYLIST_PATH" | sponge "$PLAYLIST_PATH"



# Copy thumbnails
mkdir -p thumbnails/"$PLAYLIST_LABEL"/Named_Boxarts thumbnails/"$PLAYLIST_LABEL"/Named_Snaps thumbnails/"$PLAYLIST_LABEL"/Named_Titles
cp -v "$SYSTEM_THUMBNAILS"/Named_Boxarts/"$LABEL".png thumbnails/"$PLAYLIST_LABEL"/Named_Boxarts/
cp -v "$SYSTEM_THUMBNAILS"/Named_Snaps/"$LABEL".png thumbnails/"$PLAYLIST_LABEL"/Named_Snaps/
cp -v "$SYSTEM_THUMBNAILS"/Named_Titles/"$LABEL".png thumbnails/"$PLAYLIST_LABEL"/Named_Titles/

