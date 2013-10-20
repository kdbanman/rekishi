package rekishi;

import java.util.Iterator;

/**
 *
 * @author kdbanman
 */
public class Universe implements Iterable<boolean[][]> {
    private int lifespan;
    private int maxX;
    private int maxY;
    
    private boolean[][][] spacetime;
    
    public Universe() {
        // XX
        //  XX
        //  X
        this(new boolean[][]{{true,true,false},
                             {false,true,true},
                             {false,true,false}}, 1103);
    }
    
    /**
     * @param seed 2D boolean array indexed [x][y]
     * @param lifespan termination generation
     */
    public Universe(boolean[][] seed, int lifespan) {
        this.lifespan = lifespan;
        
        // live state can only propagate so far thanks to light speed.
        // universe is not toroidal, so add an (unreachable-by-light-speed) buffer
        maxX = seed.length + lifespan + 4;
        maxY = seed[0].length + lifespan + 4;
        
        spacetime = new boolean[lifespan][maxX][maxY];
        // center seed in first generation of spacetime
        for (int i = 0; i < seed.length; i++) {
            for (int j = 0; j < seed[0].length; j++) {
                spacetime[0][maxX/2 - seed.length/2 + i][maxY/2 - seed[0].length/2 + j] = seed[i][j];
            }
        }
        
        // gen 0 is already defined, so populate from 1 to end of time
        for (int gen = 1; gen < lifespan; gen++) {
            populate(gen);
        }
    }
    
    private void populate(int generation) {
        if (generation >= lifespan) {
            System.err.println("cannot populate outside universe lifespan: " + generation);
            System.exit(1);
        }
        System.out.println("Populating generation: " + generation);
        //don't look at boundary cells.  they are clamped at zero by virtue of
        //never being modified.
        for (int i = 1; i < maxX-1; i++) {
            for (int j = 1; j < maxY-1; j++) {
                int liveNbrs = 0;
                for (int a = -1; a <= 1; a++) {
                    for (int b = -1; b <= 1; b++) {
                        if (a != 0 || b != 0) {
                            if (spacetime[generation-1][i+a][j+b]) liveNbrs++;
                        }
                    }
                }
                if (liveNbrs == 3 || liveNbrs == 2 && spacetime[generation-1][i][j])
                    spacetime[generation][i][j] = true;
            }
        }
    }

    @Override
    public Iterator<boolean[][]> iterator() {
        return new UniverseIterator();
    }

    private class UniverseIterator implements Iterator<boolean[][]> {
        int generation = 0;
        public UniverseIterator() {
            
        }

        @Override
        public boolean hasNext() {
            return generation < lifespan;
        }

        @Override
        public boolean[][] next() {
            boolean[][] ret = spacetime[generation];
            generation++;
            return ret;
        }

        @Override
        public void remove() {
            throw new UnsupportedOperationException("Not supported.");
        }
    }

}