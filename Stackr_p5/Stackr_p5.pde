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
import java.awt.event.KeyEvent.*;

// A reference to our box2d world
Box2DWorld box2d;

// A list we'll use to track fixed objects
ArrayList<Boundary> mBoundaries;
ArrayList<PhysicsObject> mObjects;

MouseGrabber mMouseGrabber;
PhysicsObject mMouseObject;
PickupArea mPickupArea;

void setup() {

  size(400,300);
  smooth(4);

  float box2dScale = 40; // 100=physically accurate but weird
  box2d = new Box2DWorld( box2dScale, new Vec2(width/2, height/2) );
  box2d.createWorld();
  box2d.setGravity(0, -10);

  // create the mouse joint
  mMouseGrabber = new MouseGrabber();

  // create array lists
  mObjects = new ArrayList<PhysicsObject>();
  mBoundaries = new ArrayList<Boundary>();

  // make the pickup area
  mPickupArea = new PickupArea( 0, 0, width*0.3, height*0.5 );
  mPickupArea.populate();

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

  mPickupArea.display();

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
    if ( keyCode==UP || key=='w' || key=='W' ) {
      mMouseGrabber.rotate(-0.05);
    } else if ( keyCode==DOWN || key=='s' || key=='S' ) {
      mMouseGrabber.rotate(0.05);
    } else if ( keyCode==LEFT || key=='a' || key=='A' ) {
      mMouseGrabber.rotate((float)Math.PI*0.25);
    } else if ( keyCode==RIGHT || key=='d' || key=='D'  ) {
      mMouseGrabber.rotate((float)-Math.PI*0.25);
    }
  }
}

void mousePressed()
{
  if ( mPickupArea.isInside( mouseX, mouseY ) ) {
    PhysicsObject nearest = mPickupArea.removeNearestObject(mouseX, mouseY);
    if ( nearest != null ) {
      mObjects.add(nearest);
      mMouseObject = nearest;
      mMouseGrabber.grab(mouseX,mouseY,mMouseObject.getBody());
    }
  }
}

void mouseReleased()
{
  if ( null != mMouseObject ) {
    // maybe we want to give the object back to the pickup area
    if ( mPickupArea.isInside(mouseX,mouseY) ) {
      mObjects.remove(mMouseObject);
      mPickupArea.giveBackObject(mMouseObject);
    } else {
      mPickupArea.populate();
    }
    mMouseGrabber.release(); 
    mMouseObject = null;
  }
}

void mouseDragged()
{
  if ( null != mMouseObject ) {
    mMouseGrabber.update(mouseX,mouseY);
  }
}

void mouseWheel(MouseEvent event)
{
  if ( null != mMouseObject ) {
    float amount = event.getCount();
    mMouseGrabber.rotate(amount*0.05);
  }

}


