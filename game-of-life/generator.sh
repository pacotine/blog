rm -f gen-gif/*.png
typst compile --root "../" -f png $1 "gen-gif/frame-{0p}.png"

FPS=$(awk "BEGIN {print 100 / $3}")

ffmpeg -y -framerate "$FPS" -pattern_type glob -i "gen-gif/frame-*.png" \
  -vf "split[s0][s1];[s0]palettegen=reserve_transparent=1[p];[s1][p]paletteuse" \
  "$2"
  
rm -f gen-gif/*.png
