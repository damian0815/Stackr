
class Boundary {

  // A boundary is a simple rectangle with x,y,width,and height
  float x;
  float y;
  float w;
  float h;
  float angle;
  
  // But we also have to make a body for box2d to know about it
  Body b;

  Boundary(Vec2 startPoint, Vec2 endPoint, float w_) {

    w = w_;

    Vec2 center = startPoint.add(endPoint).mul(0.5);
    Vec2 delta = startPoint.sub(endPoint);
    angle = atan2(delta.y, delta.x) + (float)Math.PI*0.5;
    float length = delta.length()+w;
    // store remaining properties
    x = center.x;
    y = center.y;
    h = length;
 
    // Define the polygon
    PolygonShape sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(length/2);
    // We're just a box
    sd.setAsBox(box2dW, box2dH, new Vec2(0,0), angle);

    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    Vec2 box2dCenter = box2d.coordPixelsToWorld(center.x,center.y);
    bd.position.set(box2dCenter);
    b = box2d.createBody(bd);
    
    // Attached the shape to the body using a Fixture
    b.createFixture(sd,1);
  }

  Boundary(float x_,float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    angle = 0;

    // Define the polygon
    PolygonShape sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    // We're just a box
    sd.setAsBox(box2dW, box2dH);


    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    b = box2d.createBody(bd);
    
    // Attached the shape to the body using a Fixture
    b.createFixture(sd,1);
  }

  // Draw the boundary, if it were at an angle we'd have to do something fancier
  void display() {
    fill(0);
    stroke(0);
    rectMode(CENTER);
    pushMatrix();
    translate(x,y);
    rotate(-angle);
    rect(0,0,w,h);
    popMatrix();
  }

}

