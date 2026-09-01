class Util {

    // Returned when there is no litter in the classroom.
    // In that case, the student does not need to make any move.
    static NO_MOVES_ARE_NEEDED = 0;

    // Returned when it is impossible to collect every piece of litter.
    static NOT_POSSIBLE_TO_CLEAN_THE_CLASSROOM = -1;


    // Different types of cells that can appear in the classroom.
    static EMPTY = '.';
    static START = 'S';
    static LITTER = 'L';
    static OBSTACLE = 'X';
    static CAN_RESTORE_ENERGY = 'R';


    // Possible movement directions.
    //
    // For example:
    // UP = [-1, 0]
    //
    // means:
    // row decreases by 1
    // column stays the same
    static UP = [-1, 0];

    static DOWN = [1, 0];

    static LEFT = [0, -1];

    static RIGHT = [0, 1];


    // Instead of writing the four directions every time,
    // keep them together in one array.
    static MOVES = [
        Util.UP,
        Util.DOWN,
        Util.LEFT,
        Util.RIGHT
    ];


    // Number of rows in the classroom.
    rows: number;

    // Number of columns in the classroom.
    columns: number;

    // The actual classroom grid.
    classroom: string[];

    // Maximum energy the student can have.
    maxEnergy: number;


    /*
        Every litter gets one unique bit.

        Example:

        Classroom:
        S L .
        . . L

        First L:
        0001

        Second L:
        0010

        If both are collected:
        0011

        This allows us to represent all collected litter
        using one integer.
    */
    bitstampForEachLitter: number[][];


    /*
        Bitstamp containing all litter.

        If there are 3 litter cells:

        litter 1 = 001
        litter 2 = 010
        litter 3 = 100

        Then:

        all litter = 111

        Once the student's collected bitstamp becomes
        equal to this value, every litter has been collected.
    */
    bitstampForAllLitter: number;


    constructor(classroom: string[], energy: number) {

        // Save the classroom dimensions.
        this.rows = classroom.length;
        this.columns = classroom[0].length;

        // Save the classroom itself.
        this.classroom = classroom;

        // Save the maximum energy.
        this.maxEnergy = energy;

        // These values will be initialized later.
        this.bitstampForEachLitter = null;
        this.bitstampForAllLitter = null;
    }
}


// Global utility object.
//
// All helper functions use this object instead of receiving
// rows, columns, classroom, energy, etc. as parameters.
let util;


function minMoves(classroom: string[], energy: number): number {

    // Create the utility object containing all classroom information.
    util = new Util(classroom, energy);


    /*
        Give every litter cell its own bit.

        For example, if there are 3 litter cells:

        L1 -> 001
        L2 -> 010
        L3 -> 100
    */
    util.bitstampForEachLitter = createBitstampForEachLitter();


    /*
        Create the bitstamp representing ALL litter.

        With 3 litter cells this would be:

        001
        010
        100
        ---
        111
    */
    util.bitstampForAllLitter = createBitstampForAllLitter();


    // Find the student's starting position.
    const start = findStartPoint();


    // Run BFS to find the minimum number of moves.
    return findMinMovesToCollectAllLitter(start);
}


class Point {

    // Row of the current position.
    row: number;

    // Column of the current position.
    column: number;

    // Energy remaining at this position.
    energy: number;

    /*
        Bitmask representing which litter has already
        been collected.

        Example:

        0101

        means litter #0 and litter #2 have been collected.
    */
    bitstampForCollectedLitter: number;


    constructor(
        row: number,
        column: number,
        energy: number,
        bitstampForCollectedLitter: number
    ) {
        this.row = row;
        this.column = column;
        this.energy = energy;
        this.bitstampForCollectedLitter = bitstampForCollectedLitter;
    }
}


function findMinMovesToCollectAllLitter(start: Point): number {

    /*
        If there is no litter at all, there is nothing to clean.

        Therefore the answer is immediately 0.
    */
    if (util.bitstampForAllLitter === 0) {
        return Util.NO_MOVES_ARE_NEEDED;
    }


    /*
        BFS is used because every movement costs exactly 1 move.

        BFS explores:

        0 moves away
        1 move away
        2 moves away
        3 moves away
        ...

        Therefore, the first time we collect all litter,
        we are guaranteed to have found the minimum number
        of moves.
    */

    /*
        Queue contains all states that still need to be processed.

        A Point contains:

        row
        column
        remaining energy
        collected litter bitmask
    */
    const queue = new Queue<Point>();


    // Initially, only the starting position is in the queue.
    queue.enqueue(start);


    /*
        This is the important optimization that prevents
        the solution from becoming too slow.

        For every:

            position + collected litter mask

        we store the MAXIMUM energy we have ever had.

        Why?

        Suppose we already reached:

            (2, 3)
            mask = 0101
            energy = 10

        Later we reach the exact same:

            (2, 3)
            mask = 0101

        but with:

            energy = 5

        The second state is useless.

        We are at the same position.
        We have collected the same litter.
        But we have less energy.

        So the state with energy 5 can be discarded.

        This dramatically reduces the number of states.
    */
    const bestEnergyPerBitstampForCollectedLitter =
        createBestEnergyPerBitstampForCollectedLitter();


    /*
        The starting state has:

            position = start
            collected litter = 0
            energy = maximum energy
    */
    bestEnergyPerBitstampForCollectedLitter
        [start.row]
        [start.column]
        .set(
            start.bitstampForCollectedLitter,
            start.energy
        );


    // Number of moves made from the starting position.
    let stepsFromStart = 0;


    /*
        Continue BFS until there are no more reachable states.
    */
    while (!queue.isEmpty()) {

        /*
            Move to the next BFS level.

            Every state currently in this round is exactly
            `stepsFromStart` moves away from the start.
        */
        ++stepsFromStart;


        /*
            Remember how many states belong to the current
            BFS level.

            We must process exactly this many states before
            increasing the number of steps again.
        */
        let sizeCurrentRoundOfSteps = queue.size();


        /*
            Process every state at the current distance.
        */
        while (sizeCurrentRoundOfSteps > 0) {

            // Take the next state from the queue.
            const current = queue.dequeue();


            /*
                Try all four possible movements:

                UP
                DOWN
                LEFT
                RIGHT
            */
            for (let move of Util.MOVES) {

                // Calculate the new row after making the move.
                const nextRow = current.row + move[0];

                // Calculate the new column after making the move.
                const nextColumn = current.column + move[1];


                /*
                    Ignore the move if:

                    1. It goes outside the classroom.
                    2. It goes into an obstacle.
                */
                if (
                    !isInClassroom(nextRow, nextColumn) ||
                    util.classroom[nextRow][nextColumn] === Util.OBSTACLE
                ) {
                    continue;
                }


                /*
                    Calculate the energy after moving.

                    Normally:

                        current energy - 1

                    But if we enter an R cell:

                        energy = maximum energy

                    So R completely restores the student's energy.
                */
                const nextEnergy = getNextEnergy(
                    current.energy,
                    util.classroom[nextRow][nextColumn]
                );


                /*
                    Calculate the new litter bitmask.

                    If the next cell is not litter,
                    the mask stays unchanged.

                    If the next cell contains litter,
                    its corresponding bit is turned on.
                */
                const nextBitstampCollectedLitter =
                    getNextBitstampForCollectedLitter(
                        current,
                        nextRow,
                        nextColumn
                    );


                /*
                    Check whether this move collected the final
                    piece of litter.

                    If yes, we can immediately return the number
                    of moves because BFS guarantees this is the
                    shortest possible solution.
                */
                if (
                    nextBitstampCollectedLitter ===
                    util.bitstampForAllLitter
                ) {
                    return stepsFromStart;
                }


                /*
                    If energy becomes 0, we cannot make another move.

                    Important:

                    We already handled R inside getNextEnergy().

                    So if the student moved onto R, the energy
                    becomes maxEnergy and will not be 0.

                    If the energy really is 0 here, there is
                    nowhere else the student can move from this state.
                */
                if (nextEnergy === 0) {
                    continue;
                }


                /*
                    Now comes the main optimization.

                    Check whether we have already reached this:

                        same row
                        same column
                        same collected litter

                    with MORE or EQUAL energy.

                    If yes, the current state is dominated and
                    there is no reason to explore it.
                */
                if (
                    bestEnergyPerBitstampForCollectedLitter
                        [nextRow]
                        [nextColumn]
                        .has(nextBitstampCollectedLitter)
                    &&
                    bestEnergyPerBitstampForCollectedLitter
                        [nextRow]
                        [nextColumn]
                        .get(nextBitstampCollectedLitter)
                        >= nextEnergy
                ) {
                    /*
                        We already have a better or equal state.

                        Therefore, skip this state.
                    */
                    continue;
                }


                /*
                    This is a better state.

                    Either:

                    - We have never visited this position + litter mask.
                    OR
                    - We visited it before but now have more energy.

                    Save the new maximum energy.
                */
                bestEnergyPerBitstampForCollectedLitter
                    [nextRow]
                    [nextColumn]
                    .set(
                        nextBitstampCollectedLitter,
                        nextEnergy
                    );


                /*
                    Add the new state to the BFS queue.

                    This state will be processed later.
                */
                queue.enqueue(
                    new Point(
                        nextRow,
                        nextColumn,
                        nextEnergy,
                        nextBitstampCollectedLitter
                    )
                );


            }

            /*
                One state from the current BFS level
                has now been processed.
            */
            --sizeCurrentRoundOfSteps;
        }
    }


    /*
        The BFS ended without finding a state containing
        all litter.

        Therefore, cleaning the entire classroom is impossible.
    */
    return Util.NOT_POSSIBLE_TO_CLEAN_THE_CLASSROOM;
}


function createBestEnergyPerBitstampForCollectedLitter(): Map<number, number>[][] {

    /*
        Create a 2D array:

            rows x columns

        Each cell contains a Map.

        The Map stores:

            collectedLitterMask -> maximumEnergy

        Example:

            map.set(5, 10)

        means:

            At this cell, when litter mask is 5,
            we have already reached here with 10 energy.
    */
    const bestEnergyPerBitstampForCollectedLitter =
        Array.from(
            new Array(util.rows),
            () => new Array(util.columns)
        );


    /*
        Initialize a Map for every classroom cell.

        Initially every Map is empty because we haven't
        visited any state yet.
    */
    for (let row = 0; row < util.rows; ++row) {

        for (let column = 0; column < util.columns; ++column) {

            bestEnergyPerBitstampForCollectedLitter[row][column] =
                new Map();
        }
    }


    return bestEnergyPerBitstampForCollectedLitter;
}


function findStartPoint(): Point {

    // Start is initially null until we find S.
    let start = null;


    /*
        Search through every cell in the classroom.
    */
    for (let row = 0; row < util.rows; ++row) {

        for (let column = 0; column < util.columns; ++column) {

            /*
                Once we find S, create the initial Point.

                At the beginning:

                    row = start row
                    column = start column
                    energy = maximum energy
                    collected litter = 0
            */
            if (util.classroom[row][column] === Util.START) {

                start = new Point(
                    row,
                    column,
                    util.maxEnergy,
                    0
                );

                /*
                    We found S in this row.

                    There is exactly one S, so there is no
                    need to continue searching this row.
                */
                break;
            }
        }
    }


    return start;
}


function createBitstampForAllLitter(): number {

    /*
        Start with no litter collected.

        Binary:

            0000000000
    */
    let bitstampForAllLitter = 0;


    /*
        Visit every classroom cell.
    */
    for (let row = 0; row < util.rows; ++row) {

        for (let column = 0; column < util.columns; ++column) {

            /*
                If this cell contains litter, its bit is
                already stored inside bitstampForEachLitter.

                OR (|) combines all litter bits together.

                Example:

                    001
                    010
                    100

                OR gives:

                    111
            */
            bitstampForAllLitter |=
                util.bitstampForEachLitter[row][column];
        }
    }


    return bitstampForAllLitter;
}


function createBitstampForEachLitter(): number[][] {

    /*
        This counter tells us which bit should be assigned
        to the next litter.

        First litter:

            1 << 0 = 0001

        Second litter:

            1 << 1 = 0010

        Third litter:

            1 << 2 = 0100
    */
    let counterLitter = 0;


    /*
        Create a 2D array matching the classroom.

        Each litter cell will eventually contain its bit.
        Other cells remain undefined.
    */
    const bitstamp = Array.from(
        new Array(util.rows),
        () => new Array(util.columns)
    );


    /*
        Visit every cell in the classroom.
    */
    for (let row = 0; row < util.rows; ++row) {

        for (let column = 0; column < util.columns; ++column) {

            /*
                Only litter cells need a bit.
            */
            if (util.classroom[row][column] === Util.LITTER) {

                /*
                    Assign a unique bit to this litter.

                    Example:

                    counterLitter = 0

                    1 << 0
                    = 0001
                */
                bitstamp[row][column] =
                    1 << counterLitter;


                // Move to the next bit for the next litter.
                ++counterLitter;
            }
        }
    }


    return bitstamp;
}


function getNextBitstampForCollectedLitter(
    current: Point,
    nextRow: number,
    nextColumn: number
): number {

    /*
        Start with the current collected-litter mask.

        If the next cell isn't litter,
        nothing changes.
    */
    let nextBitstampCollectedLitter =
        current.bitstampForCollectedLitter;


    /*
        Check whether the cell we are moving onto
        contains litter.
    */
    if (
        util.classroom[nextRow][nextColumn] ===
        Util.LITTER
    ) {

        /*
            Add this litter to the collected mask.

            The OR operation ensures the bit stays turned on.

            Example:

                current mask = 0101
                litter bit   = 0010

                result        = 0111
        */
        nextBitstampCollectedLitter |=
            util.bitstampForEachLitter[nextRow][nextColumn];
    }


    return nextBitstampCollectedLitter;
}


function getNextEnergy(
    currentEnergy: number,
    pointType: string
): number {

    /*
        R completely restores the energy.

        It does NOT just add energy.

        Example:

            maximum energy = 10
            current energy = 2

            entering R -> 10
    */
    if (pointType === Util.CAN_RESTORE_ENERGY) {
        return util.maxEnergy;
    }


    /*
        Every normal movement costs exactly 1 energy.
    */
    return currentEnergy - 1;
}


function isInClassroom(
    row: number,
    column: number
): boolean {

    /*
        A position is valid only when:

            row >= 0
            row < number of rows
            column >= 0
            column < number of columns
    */
    return (
        row >= 0 &&
        row < util.rows &&
        column >= 0 &&
        column < util.columns
    );
}
