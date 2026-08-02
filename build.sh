#!/usr/bin/env bash
# -------------------------------------------------------
# Build ESP32-S3 PWM firmware using arduino-cli
# Run this script from the folder containing pwm_pin8.ino
# -------------------------------------------------------
set -e

SKETCH_DIR="$(cd "$(dirname "$0")" && pwd)"
FQBN="esp32:esp32:esp32s3"
BUILD_DIR="$SKETCH_DIR/build"

echo "==> Checking arduino-cli..."
if ! command -v arduino-cli &>/dev/null; then
  echo "ERROR: arduino-cli not found."
  echo "Install it from: https://arduino.github.io/arduino-cli/latest/installation/"
  exit 1
fi

echo "==> Installing ESP32 board package (first run only)..."
arduino-cli config init --overwrite
arduino-cli config add board_manager.additional_urls \
  https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json
arduino-cli core update-index
arduino-cli core install esp32:esp32

echo "==> Compiling..."
mkdir -p "$BUILD_DIR"
arduino-cli compile \
  --fqbn "$FQBN" \
  --build-path "$BUILD_DIR" \
  "$SKETCH_DIR"

echo ""
echo "==> Build complete! Flash with:"
echo ""
echo "    esptool.py --chip esp32s3 --port /dev/ttyUSB0 --baud 460800 \\"
echo "      write_flash -z 0x0 \"$BUILD_DIR/pwm_pin8.ino.bin\""
echo ""
echo "    (Replace /dev/ttyUSB0 with your port, e.g. COM3 on Windows)"
