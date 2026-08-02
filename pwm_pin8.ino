/*
 * ESP32-S3 — PWM on GPIO8, 50% duty cycle
 * Compatible with ESP32 Arduino core v3.x+
 *
 * Settings:
 *   Pin       : GPIO 8
 *   Frequency : 5000 Hz  (change PWM_FREQ to whatever you need)
 *   Duty cycle: 50%
 *   Resolution: 8-bit (0-255), so 50% = 127
 */

#define PWM_PIN        8
#define PWM_FREQ       5000   // Hz
#define PWM_RESOLUTION 8      // bits (0-255)
#define PWM_DUTY_50    127    // 50% of 255

void setup() {
  // v3.x API: attach pin, frequency, and resolution in one call
  ledcAttach(PWM_PIN, PWM_FREQ, PWM_RESOLUTION);

  // Set 50% duty cycle
  ledcWrite(PWM_PIN, PWM_DUTY_50);
}

void loop() {
  // Nothing needed — PWM runs in hardware
}
