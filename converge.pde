import peasy.*;
import rekishi.Universe;
/*************************
*meta:  this needs to be split into two projects.  giving the user agency over
*the multiple-histories idea is more nuanced than seed selection.  also, the
*search space for histories is exponential in live state neigborhood size.
*
*the idea of historical 3D rendered conways is sweet, and the user agency over
*seed can be used to give feedback that it is a large and critically sensitive
*space with which they are interacting.
*
*the renderer can be used for convergent history display, but the user agency
*is essentially meaningless.  maybe just setting one of my computers to work
*for a week or two to find a few trajectories to the end state of the
*R-Pentomino methusela, then rendering only that to the user.  even giving them
*control over the camera might be silly - it might be better to record a video
*of me controlling the camera so I can show the viewer what I think is pretty.
*************************/

// SEED GRID AND TRANSPARENT "press SPACE for mathemagics"
// user draws a seed
// user says go
// 3d evolution with camera control
// USER CAMERA CONTROL W/ "press SPACE to try another seed"

// USER CAMERA CONTROL
// camera target fixed along vertical time axis, camera angle with
// vertical axis is fixed
// user controls rotation about axis with horizontal mouse dragging
// user controls zoom with vertical mouse dragging
Universe universe;
int currGen;
int lifespan;
int cellSize;
int cellPad;
int mid;

PeasyCam cam;

void setup() {
  size(800,600,P3D);
  background(0xFFDDDDDD);
  frameRate(30);
  noStroke();
  fill(0xFF333333);
  
  currGen = 0;
  lifespan = 200;
  cellSize = 5;
  cellPad = 2;
  
  boolean[][] seed = new boolean[][]{{false,true,true,false},
                                     {false,false,true,true},
                                     {false,false,true,false}};
  universe = new Universe(seed, lifespan);
  
  
  mid = (cellSize*lifespan) / 2;
  cam = new PeasyCam(this, mid);
  cam.lookAt(mid,mid,0);
  cam.setRotations(5*PI/6,0,0);
  cam.setSuppressRollRotationMode();
}

void draw() {
  background(0xFFDDDDDD);
  cam.lookAt(mid,mid,currGen*cellSize);
  int depth = 0;
  for (boolean[][] generation : universe) {
    if (depth > currGen) {
      currGen++;
      break;
    }
    for (int i = 0; i < generation.length; i++) {
      for (int j = 0; j < generation[0].length; j++) {
        if (generation[i][j]) {
          pushMatrix();
          translate(i*cellSize, j*cellSize, depth*cellSize);
          box(cellSize - cellPad);
          popMatrix();
        }
      }
    }
    depth++;
  }
}
