#!/bin/bash

while ! awww query >/dev/null 2>&1; do sleep 0.05; done

awww img \
  --transition-type none \
  ~/.config/backgrounds/black.png

sleep 3.3

awww img \
  --transition-type wipe \
  --transition-fps 174 \
  --transition-duration 1.5 \
  ~/.config/backgrounds/background4.png