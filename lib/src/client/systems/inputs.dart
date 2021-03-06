part of client;

class MouseInputOrientationSystem extends EntityProcessingSystem {
  Mapper<Orientation> om;
  Mapper<Position> pm;

  CanvasElement canvas;

  Point<double> offset = new Point<double>(0.0, 0.0);

  MouseInputOrientationSystem(this.canvas)
      : super(Aspect.getAspectForAllOf([LookAtMouse, Orientation, Position]));

  @override
  void initialize() {
    canvas.onMouseMove.listen((event) {
      offset = event.offset;
    });
  }

  @override
  void processEntity(Entity entity) {
    var p = pm[entity];
    var o = om[entity];

    o.targetAngle = PI/2 + atan2(
        -p.value.y - (offset.y - 300.0), - p.value.x + (offset.x - 400.0));
  }
}

class MouseClickSystem extends EntityProcessingSystem {
  Mapper<Weapon> wm;

  CanvasElement canvas;

  bool activate = false;

  MouseClickSystem(this.canvas)
      : super(Aspect.getAspectForAllOf([Weapon, MouseClickTriggersWeapon]));

  @override
  void initialize() {
    canvas.onMouseDown.listen((event) => activate = true);
  }

  @override
  void processEntity(Entity entity) {
    var w = wm[entity];

    w.timer -= world.delta;
    if (w.timer <= 0.0 && activate) {
      w.timer = w.cooldown;
      entity
        ..addComponent(new TriggeredWeapon())
        ..changedInWorld();
    }
  }

  @override
  void end() {
    activate = false;
  }


}

class KeyboardInputSystem extends GenericInputHandlingSystem {
  Mapper<Acceleration> am;

  KeyboardInputSystem()
      : super(Aspect.getAspectForAllOf([LookAtMouse, Acceleration]));

  @override
  void processEntity(Entity entity) {
    var a = am[entity];
    a.value = 1500.0;
    if (left) {
      if (up) {
        a.angle = 3 / 4 * PI;
      } else if (down) {
        a.angle = -3 / 4 * PI;
      } else {
        a.angle = PI;
      }
    } else if (right) {
      if (up) {
        a.angle = 1 / 4 * PI;
      } else if (down) {
        a.angle = -1 / 4 * PI;
      } else {
        a.angle = 0.0;
      }
    } else if (up) {
      a.angle = 1 / 2 * PI;
    } else if (down) {
      a.angle = -1 / 2 * PI;
    } else {
      a.value = 0.0;
    }
  }
}
