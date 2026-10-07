#!/bin/sh

notification() {
  notify-send "Now Playing" "${1} ☕️🎶"
}

menu() {
  printf "1. News89.4\n"
  printf "2. Chillhop\n"
  printf "3. Box Lofi\n"
  printf "4. The Bootleg Boy\n"
  printf "5. Radio Spinner\n"
  printf "6. Deep Space One\n"
  printf "7. SpaceStation\n"
  printf "8. GrooveSalad\n"
  printf "9. Tilderadio\n"
}

main() {
  choice=$(menu | wofi --dmenu --prompt "Radio Station" | cut -d. -f1)

  case "$choice" in
  1)
    notification "News89.4"
    mpv --volume=70 "https://mp3.news894.c.nmdn.net/news894/livestream.mp3"
    ;;
  2)
    notification "Chillhop"
    mpv --volume=50 "https://stream.zeno.fm/fyn8eh3h5f8uv"
    ;;
  3)
    notification "Box Lofi"
    mpv --volume=50 "https://stream.zeno.fm/f3wvbbqmdg8uv"
    ;;
  4)
    notification "The Bootleg Boy"
    mpv --volume=50 "https://stream.zeno.fm/0r0xa792kwzuv"
    ;;
  5)
    notification "Radio Spinner"
    mpv --volume=50 "https://live.radiospinner.com/lofi-hip-hop-64"
    ;;
  6)
    notification "Deep Space One"
    mpv --volume=70 "https://ice3.somafm.com/deepspaceone-128-aac"
    ;;
  7)
    notification "SpaceStation SOMA"
    mpv --volume=70 "https://ice6.somafm.com/spacestation-128-mp3"
    ;;
  8)
    notification "Groove Salad"
    mpv --volume=70 "https://ice4.somafm.com/groovesalad-128-mp3"
    ;;
  9)
    notification "Tilderadio.org"
    mpv --volume=70 "https://azuracast.tilderadio.org/radio/8000/radio.ogg"
    ;;
  esac
}

pkill -f 'mpv.*volume.*http' || main
