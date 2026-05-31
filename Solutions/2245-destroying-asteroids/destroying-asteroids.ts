function asteroidsDestroyed(mass: number, asteroids: number[]): boolean {
    // Sort asteroids from smallest to largest.
    // This allows the planet to gain mass as early as possible.
    asteroids.sort((a, b) => a - b);

    // Use a larger numeric type conceptually.
    // JavaScript numbers can safely handle the values in this problem,
    // but we'll keep the variable separate for clarity.
    let currentMass = mass;

    // Try to destroy each asteroid in ascending order.
    for (const asteroid of asteroids) {
        // If the planet is smaller than the asteroid,
        // it gets destroyed and the process fails.
        if (currentMass < asteroid) {
            return false;
        }

        // Otherwise, destroy the asteroid and gain its mass.
        currentMass += asteroid;
    }

    // If we reach here, every asteroid was destroyed.
    return true;
}