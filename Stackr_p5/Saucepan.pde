// A saucepan
class Saucepan extends PhysicsObject {
  
  Saucepan( float x, float y, float w, float depth, float handleLength ) {
    
    makeBody( new Vec2(x,y ) );

    // some constants 
    // wall thickness
    float thickness = 2.0f;
    // vertical position of the COM as a pctage of depth
    float comPosPct = 0.5;
    // how far inwards the bottom of the glass slopes, pct
    float density = 1.0;

    // define the positions
    Vec2 topLeft = new Vec2(-w*0.5, -depth*0.5);
    Vec2 topRight = new Vec2(w*0.5, -depth*0.5);
    Vec2 bottomLeft = new Vec2(-w*0.5, depth*0.5);
    Vec2 bottomRight = new Vec2(w*0.5, depth*0.5);

    // handle
    Vec2 handleStart = new Vec2(w*0.5, -depth*0.3);
    Vec2 handleEnd = new Vec2(w*0.5+handleLength, -depth*0.4);

    // create fixtures
    Vec2[] defs = { topLeft, bottomLeft, bottomLeft, bottomRight, bottomRight, topRight, handleStart, handleEnd };
    float[] thicknesses = { thickness, thickness, thickness, thickness };
    for ( int i=0; i<defs.length/2; i++ ) {
      makeLongSkinnyBoxFixture( defs[i*2], defs[i*2+1], thicknesses[i], density );
    }
  }


};


