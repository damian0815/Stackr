// A cup
class Cup extends PhysicsObject {
  
  Cup( float x, float y, float w, float depth ) {
    
    makeBody( new Vec2(x,y ) );

    // some constants 
    // wall thickness
    float wallThickness = 2.0f;
    // vertical position of the COM as a pctage of depth
    float comPosPct = 0.5;
    // how far inwards the bottom of the glass slopes, pct
    float curvature = 0.3;
    float density = 0.3;

    // define the positions
    Vec2 topLeft = new Vec2(-w*0.5, -depth*comPosPct);
    Vec2 topRight = new Vec2(w*0.5, -depth*comPosPct);
    Vec2 bottomLeft = new Vec2(-w*(1.0-curvature)*0.5, depth*(1.0-comPosPct));
    Vec2 bottomRight = new Vec2(w*(1.0-curvature)*0.5, depth*(1.0-comPosPct));

    // create fixtures
    Vec2[] defs = { topLeft, bottomLeft, bottomLeft, bottomRight, bottomRight, topRight };
    for ( int i=0; i<defs.length/2; i++ ) {
      makeLongSkinnyBoxFixture( defs[i*2], defs[i*2+1], wallThickness, density );
    }
  }


};


