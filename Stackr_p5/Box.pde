// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2010
// Box2DProcessing example

// A rectangular box
class Box extends PhysicsObject {

  float mW;
  float mH;

  // Constructor
  Box(float x, float y, float _w, float _h, float density) {
    mW=_w;
    mH=_h;
    // Add the box to the box2d world
    makeBody(new Vec2(x, y), mW, mH, density);
  }

  // Constructor
  Box(float x, float y, float density) {
    mW = random(4, 16);
    mH = random(4, 16);
    // Add the box to the box2d world
    makeBody(new Vec2(x, y), mW, mH, density);
  }

  // Drawing the box
  void display() {
    // We look at each mBody and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(mBody);
    // Get its angle of rotation
    float a = mBody.getAngle();

    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(175);
    stroke(0);
    rect(0, 0, mW, mH);
    popMatrix();
  }

  // This function adds the rectangle to the box2d world
  void makeBody(Vec2 center, float w_, float h_, float density) {

    // Define a polygon (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    println("width: "+box2dW+" height: "+box2dH+" from "+w_+","+h_);
    sd.setAsBox(box2dW, box2dH);

    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = density;
    fd.friction = 0.3;
    fd.restitution = 0.5;

    // create actual body
    makeBody(center, fd);
  }

}


