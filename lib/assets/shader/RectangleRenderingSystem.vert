attribute vec2 aPos;
attribute vec2 aOffset;
attribute float aAngle;

void main() {
  float sinA = sin(aAngle);
  float cosA = cos(aAngle);

	gl_Position = vec4((aPos.x + aOffset.x * cosA - aOffset.y * sinA) / 400.0, (aPos.y + aOffset.x * sinA + aOffset.y * cosA) / 300.0, 0.0, 1.0);
}
