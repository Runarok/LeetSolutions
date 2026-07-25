class Solution {
    // Store the radius of the circle.
    private radius: number;

    // Store the x-coordinate of the center.
    private x: number;

    // Store the y-coordinate of the center.
    private y: number;

    constructor(radius: number, x_center: number, y_center: number) {
        // Save the given values so randPoint() can use them later.
        this.radius = radius;
        this.x = x_center;
        this.y = y_center;
    }

    randPoint(): number[] {
        // Generate a random angle between 0 and 2π.
        const angle = Math.random() * 2 * Math.PI;

        // Generate a random distance from the center.
        //
        // We use sqrt(random) instead of just random.
        // If we used:
        //     Math.random() * radius
        // then too many points would appear near the center.
        //
        // Taking the square root makes every location inside
        // the circle equally likely.
        const distance = Math.sqrt(Math.random()) * this.radius;

        // Convert the polar coordinates (distance, angle)
        // into Cartesian coordinates (x, y).
        const pointX = this.x + distance * Math.cos(angle);
        const pointY = this.y + distance * Math.sin(angle);

        // Return the generated point.
        return [pointX, pointY];
    }
}

/**
 * Your Solution object will be instantiated and called as such:
 * var obj = new Solution(radius, x_center, y_center)
 * var param_1 = obj.randPoint()
 */