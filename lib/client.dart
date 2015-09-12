library client;

import 'dart:html' hide Player, Timeline;
export 'dart:html' hide Player, Timeline;
import 'dart:web_gl';
import 'dart:typed_data';
import 'dart:web_audio';
import 'package:zfx_action_8/shared.dart';
import 'package:gamedev_helpers/gamedev_helpers.dart';
export 'package:gamedev_helpers/gamedev_helpers.dart';
//part 'src/client/systems/name.dart';
part 'src/client/systems/events.dart';
part 'src/client/systems/inputs.dart';
part 'src/client/systems/rendering.dart';

class Game extends GameBase {
  CanvasElement hudCanvas;
  CanvasRenderingContext2D hudCtx;

  Game() : super.noAssets('zfx_action_8', '#game', 800, 600, webgl: true) {
    hudCanvas = querySelector('#hud');
    hudCtx = hudCanvas.context2D;
    hudCtx
      ..textBaseline = 'top'
      ..font = '16px Verdana';
  }

  void createEntities() {
    addEntity([
      new Position(0, 0),
      new Size(32.0, 32.0),
      new Renderable(),
      new LookAtMouse(),
      new Orientation(0.0, 0.0),
      new Acceleration(0.0, 0.0),
      new Velocity(0.0, 0.0)
    ]);
  }

  Map<int, List<EntitySystem>> getSystems() {
    return {
      GameBase.rendering: [
        new KeyboardInputSystem(),
        new MouseInputOrientationSystem(hudCanvas),
        new OrientationSystem(),
        new WebGlCanvasCleaningSystem(ctx),
        new RectangleRenderingSystem(ctx),
        new CanvasCleaningSystem(hudCanvas),
        new FpsRenderingSystem(hudCtx, fillStyle: 'white'),
      ],
      GameBase.physics: [
        new AccelerationSystem(),
        new MovementSystem(),
        // add at least one
      ]
    };
  }
}
