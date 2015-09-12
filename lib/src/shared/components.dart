part of shared;

class Position extends Component {
  Vector2 value;
  Position(num x, num y) : value = new Vector2(x.toDouble(), y.toDouble());
}

class Velocity extends Component {
  Vector2 value;
  Velocity(num x, num y) : value = new Vector2(x.toDouble(), y.toDouble());
}

class Acceleration extends Component {
  double value;
  double angle;
  Acceleration(this.value, this.angle);
}

class Size extends Component {
  double width, height;
  Size(this.width, this.height);
}

class Orientation extends Component {
  double angle;
  double targetAngle;
  Orientation(this.angle, this.targetAngle);
}

class Weapon extends Component {
  double cooldown;
  double timer;
  Weapon(this.cooldown) : this.timer = 0.0;
}

class Gun extends Component {
  double bulletSpeed;
  int bullets;
  double spread;
  double bulletWidth, bulletHeight;
  Gun(this.bulletSpeed, this.bullets, this.spread, this.bulletWidth, this.bulletHeight);
}

class Renderable extends Component {}
class LookAtMouse extends Component {}
class LookAtPlayer extends Component {}
class MouseClickTriggersWeapon extends Component {}
class TriggeredWeapon extends Component {}

class ExpirationTimer extends Component {
  double value;
  ExpirationTimer(this.value);
}