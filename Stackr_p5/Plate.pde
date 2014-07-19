// A plate
class Plate extends PhysicsObject {
  
  Plate( float x, float y, float w, float depth ) {
    
    makeBody( new Vec2(x,y ) );

    // some constants 
    // wall thickness
    float wallThickness = 2.0f;
    // how far inwards the bottom of the plate slopes, pct
    float curvature = 0.25;
    float density = 0.3;

    // define the positions
    Vec2 topLeft = new Vec2(-w*0.5, -depth*0.5);
    Vec2 topRight = new Vec2(w*0.5, -depth*0.5);
    Vec2 bottomLeft = new Vec2(-w*(1.0-curvature)*0.5, depth*0.2);
    Vec2 bottomRight = new Vec2(w*(1.0-curvature)*0.5, depth*0.2);

    /*
    Vec2 footTopLeft = new Vec2(-w*0.8*(1.0-curvature)*0.5, depth*0.2);
    Vec2 footTopRight = new Vec2(w*0.8*(1.0-curvature)*0.5, depth*0.2);
    Vec2 footBottomLeft = new Vec2(footTopLeft.x,depth*0.5);
    Vec2 footBottomRight = new Vec2(footTopRight.x,depth*0.5);
    */

    // create fixtures
    Vec2[] defs = { 
      topLeft, bottomLeft, // left rim
      bottomLeft, bottomRight, // base
      bottomRight, topRight, // right rim
/*      footBottomLeft, footBottomRight, // foot
      footTopLeft, footBottomLeft, // left foot
     footTopRight, footBottomRight, // right foot*/
    };
    for ( int i=0; i<defs.length/2; i++ ) {
      makeLongSkinnyBoxFixture( defs[i*2], defs[i*2+1], wallThickness, density );
    }
  }


};


