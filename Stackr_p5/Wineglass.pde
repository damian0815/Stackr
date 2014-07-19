// A wine glass
class Wineglass extends PhysicsObject {
  
  Wineglass( float x, float y, float w, float depth, float stemHeight, float baseRadius ) {
    
    makeBody( new Vec2(x,y ) );

    // some constants 
    // wall thickness
    float wallThickness = 2.0f;
    // vertical position of the COM as a pctage of depth
    float comPosPct = 0.5;
    // how far inwards the bottom of the glass slopes, pct
    float curvature = 0.3;
    float density = 0.1;

    // define the positions
    
    Vec2 rimLeft = new Vec2(-w*0.4, -depth);
    Vec2 rimRight = new Vec2( w*0.4, -depth);
    Vec2 outerLeft = new Vec2(-w*0.5, -depth*0.3);
    Vec2 outerRight = new Vec2( w*0.5, -depth*0.3);
    Vec2 stemLeft = new Vec2(-w*0.3, 0);
    Vec2 stemRight = new Vec2( w*0.3, 0);
    Vec2 stemTop = new Vec2(0,0);
    Vec2 stemBottom = new Vec2(0,stemHeight);
    Vec2 baseLeft = new Vec2(-baseRadius,stemHeight);
    Vec2 baseRight = new Vec2( baseRadius,stemHeight);


    // create fixtures
    Vec2[] defs = { rimLeft, outerLeft, 
      outerLeft, stemLeft,
      stemLeft, stemRight,
      stemRight, outerRight,
      outerRight, rimRight,
      stemTop, stemBottom,
      baseLeft, baseRight };
    for ( int i=0; i<defs.length/2; i++ ) {
      makeLongSkinnyBoxFixture( defs[i*2], defs[i*2+1], wallThickness, density );
    }
  }


};


