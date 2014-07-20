
class PickupArea {

  Vec2 mOrigin;
  float mWidth;
  float mHeight;
  ArrayList<PhysicsObject> mObjects;

  PickupArea( float x, float y, float w, float h )
  {
    mOrigin = new Vec2(x,y);
    mWidth = w;
    mHeight = h;
    mObjects = new ArrayList<PhysicsObject>();
  }

  void populate()
  {
    while(mObjects.size()<1) {
      // Cup, Plate, Saucepan, Wineglass
      float[] probabilities = { 0.3, 0.35, 0.15, 0.2 };
      float totalProb = 0;
      for ( float p: probabilities ) {
        totalProb += p;
      }

      float target = random(totalProb);
      float current = 0;
      int which = 0;
      for ( int i=0; i<probabilities.length; i++ ) {
        if ( current+probabilities[i] > target ) {
          which = i;
          break;
        }
        current += probabilities[i];
      }

      Vec2 pos = mOrigin.add(new Vec2(mWidth/2,mHeight/2));
      PhysicsObject newObject = null;
      switch(which) {
        case 0:
          // Cup
          float[] heights = { 50, 40, 15 };
          float[] widths = { 30, 20, 8 };
          which = (int)random(0, 2.99999);
          newObject = new Cup(pos.x, pos.y, widths[which], heights[which]);
          break;

        case 1:
          // Plate
          float width = (random(1)>0.5)?100:60;
          float depth = 5;
          newObject = new Plate( pos.x, pos.y, width, depth );
          break;

        case 2:
          // Saucepan
          newObject = new Saucepan( pos.x, pos.y, 50, 50, 80);
          break;

        case 3:
          // Wineglass
          newObject = new Wineglass( pos.x, pos.y, 20, 30, 30, 10 );
          break;
      }

      newObject.getBody().setActive(false);
      mObjects.add(newObject);

    }
  }

  void display()
  {
    rectMode(CORNER);
    stroke(128);
    fill(225);
    rect(mOrigin.x,mOrigin.y,mWidth,mHeight);

    for ( PhysicsObject o: mObjects ) {
      o.display();
    }
  }

  boolean isInside( float x, float y )
  {
    if ( x<mOrigin.x || x>mOrigin.x+mWidth ) {
      return false;
    } else if ( y<mOrigin.y || y>mOrigin.y+mHeight ) {
      return false;
    }
    return true;
  }

  /// find the nearest object that we own to the mouse pos, remove it and return
  PhysicsObject removeNearestObject( float x, float y ) 
  {
    PhysicsObject nearest = null;
    float bestDistance = 0;
    float maxDistance = 50;
    for ( PhysicsObject object: mObjects ) {
      float distance = (new Vec2(x,y)).sub(object.getPosition()).length();
      if ( null==nearest || distance<bestDistance ) {
        nearest = object;
        bestDistance = distance;
      }
    }

    // if we found one, make it active and remove
    if ( null != nearest ) {
      nearest.getBody().setActive(true);
      mObjects.remove(nearest);
    }

    return nearest;
  }

  void giveBackObject( PhysicsObject o ) 
  {
    o.getBody().setActive(false);
    mObjects.add(o);
  }



}

