part of shared;

class MovementSystem extends EntityProcessingSystem {
  Mapper<Position> pm;
  Mapper<Velocity> vm;

  MovementSystem() : super(Aspect.getAspectForAllOf([Position, Velocity]));

  @override
  void processEntity(Entity entity) {
    var p = pm[entity];
    var v = vm[entity];

    p.value = p.value + v.value * world.delta;
  }
}

class AccelerationSystem extends EntityProcessingSystem {
  Mapper<Acceleration> am;
  Mapper<Velocity> vm;


  AccelerationSystem() : super(Aspect.getAspectForAllOf([Acceleration, Velocity]));

  @override
  void processEntity(Entity entity) {
    var a = am[entity];
    var v = vm[entity];
    var friction = 500.0 * world.delta;

    var vDiffX = a.value * world.delta * cos(a.angle);
    var vDiffY = a.value * world.delta * sin(a.angle);
    v.value.x += vDiffX;
    v.value.y += vDiffY;

    var div = 1/100.0;
    if (a.angle.abs() % (PI/2) == PI/4) {
      div = 1/121;
    }
    var frictionX = friction + v.value.x.abs() * div;
    var frictionY = friction + v.value.y.abs() * div;
    if (frictionX < v.value.x.abs()) {
      v.value.x -= frictionX * v.value.x.sign;
    } else {
      v.value.x = 0.0;
    }
    if (frictionY < v.value.y.abs()) {
      v.value.y -= frictionY * v.value.y.sign;
    } else {
      v.value.y = 0.0;
    }
  }
}

class OrientationSystem extends EntityProcessingSystem {
  Mapper<Orientation> om;
  OrientationSystem() : super(Aspect.getAspectForAllOf([Orientation]));

  @override
  void processEntity(Entity entity) {
    var o = om[entity];
    var rot = 5.0 * world.delta;

    var diff = o.targetAngle - o.angle;
    if (diff.abs() > PI) {
      diff -= 2 * PI * diff.sign;
    }
    rot = rot * diff.sign;
    if (rot.abs() > diff.abs()) {
      o.angle = o.targetAngle;
    } else {
      o.angle += rot;
    }
  }
}

class PlayerLookingSystem extends EntityProcessingSystem {
  Mapper<Orientation> om;
  Mapper<Position> pm;
  TagManager tm;

  PlayerLookingSystem() : super(Aspect.getAspectForAllOf([Position, Orientation, LookAtPlayer]));

  @override
  void processEntity(Entity entity) {
    var player = tm.getEntity(tagPlayer);
    var o = om[entity];
    var p = pm[entity];
    var pp = pm[player];

    o.targetAngle = atan2(p.value.y - pp.value.y, p.value.x - pp.value.x);
  }
}