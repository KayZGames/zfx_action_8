part of client;

class RectangleRenderingSystem extends WebGlRenderingSystem {
  Mapper<Position> pm;
  Mapper<Size> sm;
  Mapper<Orientation> om;

  Float32List items;

  List<Attrib> attribs = [new Attrib('aPos', 2), new Attrib('aOffset', 2), new Attrib('aAngle', 1)];

  Uint16List indices;

  List<List<int>> posneg = [[-1, -1], [1, -1], [1, 1], [-1, 1]];

  RectangleRenderingSystem(RenderingContext gl)
      : super(gl, Aspect.getAspectForAllOf([Position, Size, Renderable, Orientation]));

  @override
  void processEntity(int index, Entity entity) {
    var p = pm[entity];
    var s = sm[entity];
    var o = om[entity];

    var itemOffset = index * 5 * 4;
    var itemIndexOffset = index * 4;
    var indexOffset = index * 6;

    for (int i = 0; i < 4; i++) {
      items[itemOffset + i * 5] =  p.value.x ;
      items[itemOffset + i * 5 + 1] = p.value.y ;
      items[itemOffset + i * 5 + 2] = posneg[i][0] * s.width / 2;
      items[itemOffset + i * 5 + 3] = posneg[i][1] * s.height / 2;
      items[itemOffset + i * 5 + 4] = o.angle;
    }

    indices[indexOffset] = itemIndexOffset;
    indices[indexOffset + 1] = itemIndexOffset + 1;
    indices[indexOffset + 2] = itemIndexOffset + 2;
    indices[indexOffset + 3] = itemIndexOffset;
    indices[indexOffset + 4] = itemIndexOffset + 2;
    indices[indexOffset + 5] = itemIndexOffset + 3;
  }

  @override
  void render(int length) {
    bufferElements(attribs, items, indices);

    gl.drawElements(TRIANGLES, indices.length, UNSIGNED_SHORT, 0);
  }

  @override
  void updateLength(int length) {
    items = new Float32List(length * 5 * 4);
    indices = new Uint16List(length * 6);
  }

  @override
  String get vShaderFile => 'RectangleRenderingSystem';
  @override
  String get fShaderFile => 'RectangleRenderingSystem';
}
