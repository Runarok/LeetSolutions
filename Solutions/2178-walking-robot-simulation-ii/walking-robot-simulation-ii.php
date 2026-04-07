class Robot {
    private $width;
    private $height;
    
    private $x = 0;   // current x position
    private $y = 0;   // current y position
    
    private $dir = 0; // 0=East, 1=North, 2=West, 3=South
    
    private $cycle;   // total perimeter steps
    
    /**
     * Initialize robot
     */
    function __construct($width, $height) {
        $this->width = $width;
        $this->height = $height;
        
        // perimeter cycle length
        $this->cycle = 2 * ($width + $height - 2);
    }
  
    /**
     * Move robot by num steps
     */
    function step($num) {
        // Reduce unnecessary full loops
        $num %= $this->cycle;
        
        // Special case:
        // If num == 0, robot still needs to possibly update direction
        // when sitting at (0,0) after full cycle
        if ($num == 0) {
            // If at origin, direction should be South after full loop
            if ($this->x == 0 && $this->y == 0) {
                $this->dir = 3; // South
            }
            return;
        }
        
        // Move step by step
        while ($num > 0) {
            // Try moving in current direction
            if ($this->dir == 0) { // East
                if ($this->x + 1 < $this->width) {
                    $this->x++;
                    $num--;
                } else {
                    // Turn counterclockwise
                    $this->dir = 1;
                }
            }
            else if ($this->dir == 1) { // North
                if ($this->y + 1 < $this->height) {
                    $this->y++;
                    $num--;
                } else {
                    $this->dir = 2;
                }
            }
            else if ($this->dir == 2) { // West
                if ($this->x - 1 >= 0) {
                    $this->x--;
                    $num--;
                } else {
                    $this->dir = 3;
                }
            }
            else { // South
                if ($this->y - 1 >= 0) {
                    $this->y--;
                    $num--;
                } else {
                    $this->dir = 0;
                }
            }
        }
    }
  
    /**
     * Get current position
     */
    function getPos() {
        return [$this->x, $this->y];
    }
  
    /**
     * Get current direction
     */
    function getDir() {
        $dirs = ["East", "North", "West", "South"];
        return $dirs[$this->dir];
    }
}