// SEED GRID AND TRANSPARENT "press SPACE for mathemagics"
// user draws a seed
// user says go
// PROCESSING/LOADING INDICATOR
// N generations run
// result is reverse-engineered along M alternate trajectories
// each of M trajectories' seeds and start generation are stored
// 3D EVOLUTION W/ USER CAMERA CONTROL
// user seed in dark grey, other M in colors run and rendered
// convergent point at N generations in black
// N * 1.6 generations rendered in total
// USER CAMERA CONTROL W/ "press SPACE to try another seed"

// TODO: an object that is a history of multiple trajectories
//       is necessary.  data members:
//       - array of environments

// REVERSE ENGINEERING

// reverse engineering is a stepwise exploration of a tree whose
// root is the desired end state and whose leaves are starting
// states

// for one step back in time, only previous states which differ in
// neighborhoods of current live cells are considered (live state
// is not introduced at distance >=2 from any current live state)
//   EX: current state --> cells to be permuted to previous states
//        _ _ _ _ _ _         _ _ _ _ _ _
//       |_|_|_|_|_|_|  -->  |_|O|O|O|O|_|
//       |_|_|X|X|_|_|  -->  |O|O|O|O|O|_|
//       |_|X|_|X|_|_|  -->  |O|O|O|O|O|_|
//       |_|_|_|X|_|_|  -->  |O|O|O|O|O|_|
//       |_|_|_|_|_|_|  -->  |_|_|O|O|O|_|

// each permutation of TODO

// 3D EVOLUTION

// environment is an array of length M boolean arrays so that each
// cell may hold up to M simultaneous trajectories

// environment history must be preserved so that each generation 
// can be rendered every frame

// renderer will be passed an environment history and a color map to
// render a frame

// USER CAMERA CONTROL

// camera target fixed along vertical time axis, camera angle with
// vertical axis is fixed

// user controls rotation about axis with horizontal mouse dragging

// user controls zoom with vertical mouse dragging
