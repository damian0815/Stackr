// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2011
// Box2DProcessing example

// Basic example of falling rectangles

import shiffman.box2d.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

// A reference to our box2d world
Box2DProcessing box2d;

// A list we'll use to track fixed objects
ArrayList<Boundary> mBoundaries;
ArrayList<PhysicsObject> mObjects;

MouseGrabber mMouseGrabber;
PhysicsObject mMouseObject;

void setup() {

  size(400,300);

  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -10);

  // create the mouse joint
  mMouseGrabber = new MouseGrabber();

  // create array lists
  mObjects = new ArrayList<PhysicsObject>();
  mBoundaries = new ArrayList<Boundary>();

  // make the dishrack
  
  makeRack( width*0.5, height*0.8, width*0.5, width*0.05, 14, 12 );

  // make world boundaries

  // bottom
  mBoundaries.add(new Boundary(width/2,height+2,width+4,4));
  // top
 // mBoundaries.add(new Boundary(width/2,-2,width+4,4));
  // left
 // mBoundaries.add(new Boundary(-2,height/2,4,height+4));
  // right
//  mBoundaries.add(new Boundary(width+2,height/2,4,height+4));

}

void makeRack( float cx, float cy, float w, float h, int numTines, float tineHeight )
{
  // bottom
  float edgeOffset = h*0.25;
  mBoundaries.add(new Boundary(cx,cy+h/2,w-edgeOffset*2,2));

  // left
  mBoundaries.add(new Boundary( new Vec2(cx-w/2+edgeOffset/2,cy-h/2), new Vec2(cx-w/2,cy+h/2), 2));
  // right
  mBoundaries.add(new Boundary( new Vec2(cx+w/2-edgeOffset/2,cy-h/2), new Vec2(cx+w/2,cy+h/2), 2));

  // tines
 
  float leftEdge = cx-w/2+edgeOffset;
  float bottomEdge = cy+h/2;
  float tineSpan = w-2*edgeOffset;
  float tineGap = tineSpan/(numTines);
  leftEdge += tineGap*0.5;
  float tineSlantOffset = -tineHeight*0.25;
  for ( int i=0; i<numTines; i++ ) {
    Vec2 start = new Vec2(leftEdge+i*tineGap,bottomEdge);
    Vec2 end = new Vec2( start.x+tineSlantOffset, start.y-tineHeight );
    mBoundaries.add(new Boundary( start, end, 2 ) );
  }


}

void draw() {

  background(255);

  box2d.step(1.0f/60.0f,10,10);

  for ( Boundary wall: mBoundaries ) {
    wall.display();
  }

  for ( PhysicsObject b: mObjects ) {
    b.display();
  }

  if ( null != mMouseObject ) {
    mMouseObject.display();
  }

}

void keyPressed()
{
  if ( null != mMouseGrabber ) {
    if ( keyCode==UP ) {
      mMouseGrabber.rotate(-0.05);
    } else if ( keyCode==DOWN ) {
      mMouseGrabber.rotate(0.05);
    } else if ( keyCode==LEFT ) {
      mMouseGrabber.rotate((float)Math.PI*0.25);
    } else if ( keyCode==RIGHT ) {
      mMouseGrabber.rotate((float)-Math.PI*0.25);
    }
  }
}

void mousePressed()
{
  float angle = 0;
  if ( random(1)>0.7 ) {
    float[] heights = { 50, 40, 15 };
    float[] widths = { 30, 20, 8 };
    int which = (int)random(0, 2.99999);
    mMouseObject = addCup(mouseX,mouseY,widths[which],heights[which]);
  } else {
    mMouseObject = addPlate(mouseX, mouseY, (random(1)>0.5)?100:60, 5);
    angle = (float)Math.PI*0.45f;
  }
  mMouseGrabber.grab(mouseX,mouseY,mMouseObject.getBody());
  // give a small default rotation
  mMouseGrabber.rotate(angle);
}

void mouseReleased()
{
  mMouseGrabber.release();
  mMouseObject = null;
}

void mouseDragged()
{
  mMouseGrabber.update(mouseX,mouseY);
}

Plate addPlate(float x, float y, float w, float depth)
{
  Plate p = new Plate(x,y,w,depth);
  mObjects.add(p);
  return p;
}

Cup addCup(float x, float y, float w, float depth)
{
  Cup c = new Cup(x,y,w,depth);
  mObjects.add(c);
  return c;
}

Box addBox(float x,float y) {
  float w = 20;
  float h = 20;
  float density = 1.0;
  Box b = new Box(x,y,w,h,density);
  mObjects.add(b);
  return b;
}



