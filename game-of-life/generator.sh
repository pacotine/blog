rm gen-gif/*.png
typst compile --root "../" -f png $1 "gen-gif/frame-{0p}.png"
magick -delay $3 -loop 0 gen-gif/frame-*.png $2
rm gen-gif/*.png