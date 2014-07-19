class MouseGrabber
{
  MouseJoint mMouseJoint = null;

  MouseGrabber()
  {
  }

  /// x and y are the current mouse position
  void update(float x, float y)
  {
    if ( null != mMouseJoint ) {
      Vec2 mouseWorld = box2d.coordPixelsToWorld(x,y);
      mMouseJoint.setTarget(mouseWorld);
    }
  }

  void grab(float x, float y, Body body)
  {
    MouseJointDef md = new MouseJointDef();
    // bodyA is the world
    md.bodyA = box2d.getGroundBody();
    // bodyB is the passed-in body
    md.bodyB = body;
    body.setFixedRotation(true);

    Vec2 mouseWorld = box2d.coordPixelsToWorld(x,y);
    md.target.set(mouseWorld);

    // spring force
    md.maxForce = 10000.0f*body.m_mass;
    md.frequencyHz = 5.0f;
    md.dampingRatio = 0.9f;

    // wake up the body
    //body.wakeUp();

    // make the joint
    mMouseJoint = (MouseJoint)box2d.world.createJoint(md);
  }

  void release()
  {
    if ( null != mMouseJoint ) {
      mMouseJoint.getBodyB().setFixedRotation(false);
      box2d.world.destroyJoint(mMouseJoint);
      mMouseJoint = null;
    }
  }

  void rotate(float amount)
  {
    if ( null != mMouseJoint ) {
      Body body = mMouseJoint.getBodyB();
      float angle = body.getAngle();
      angle += amount;
      body.setTransform(body.getPosition(), angle);
    }
  }


};
