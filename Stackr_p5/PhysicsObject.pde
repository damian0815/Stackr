// base class for physics objects

class BoxDef
{
  Vec2 mCenter;
  float mW;
  float mH;
  float mAngle;
  BoxDef(Vec2 center, float w, float h, float angle) {
    mCenter = center;
    mW = w;
    mH = h;
    mAngle = angle;
  }

  void display() {
    rectMode(CENTER);
    pushMatrix();
    translate(mCenter.x,mCenter.y);
    rotate(-mAngle);
    fill(175);
    stroke(0);
    rect(0,0,mW,mH);
    popMatrix();
  }
}

abstract class PhysicsObject
{
  Body mBody = null;

  ArrayList<BoxDef> mBoxDefs;

  PhysicsObject() {
    mBoxDefs = new ArrayList<BoxDef>();
  }

  // create a 'long, skinny' box between the two points, which lie on the box boundary.
  // Must be called after mBody is created.
  // also create a BoxDef in mBoxDefs to get drawn automatically by display()
  void makeLongSkinnyBoxFixture( Vec2 startPoint, Vec2 endPoint, float w, float density ) {
    makeLongSkinnyBoxFixture(startPoint, endPoint, w, density, 0.02, 0.01 );
  }
  void makeLongSkinnyBoxFixture( Vec2 startPoint, Vec2 endPoint, float w, float density, float friction, float restitution )
  {
    Vec2 delta = startPoint.sub(endPoint);
    float length = delta.length()+w;
    float angle = -atan2(delta.y, delta.x) + (float)Math.PI*0.5;
    //float angle = (float)Math.PI*0.5;
    Vec2 center = (startPoint.add(endPoint)).mul(0.5);

    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(length/2);
    Vec2 box2dCenter = box2d.vectorPixelsToWorld(center);
    sd.setAsBox(box2dW, box2dH, box2dCenter, angle);
    // create the fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    fd.density = density;
    fd.friction = friction;
    fd.restitution = restitution;
    mBody.createFixture(fd);

    // create the BoxDef
    BoxDef def = new BoxDef(center, w, length, angle );
    mBoxDefs.add(def);
  } 

  void makeBody( Vec2 center ) {
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    mBody = box2d.createBody(bd);
  }

  void makeBody( Vec2 center, FixtureDef fd ) {
    makeBody( center );
    mBody.createFixture(fd);
  }

  void close() {
    if ( null != mBody ) {
      box2d.destroyBody(mBody);
    }
  }

  Body getBody() {
    return mBody;
  }

  void display() {
    pushMatrix();
    Vec2 pos = box2d.getBodyPixelCoord(mBody);
    translate(pos.x,pos.y);
    float a = mBody.getAngle();
    rotate(-a);

    for ( BoxDef bd: mBoxDefs ) {
      bd.display();
    }

    popMatrix();
  }

}

