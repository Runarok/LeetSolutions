impl Solution {
    pub fn angle_clock(hour: i32, minutes: i32) -> f64 {
        // ---------------------------------------------------------
        // Minute hand:
        // A full circle is 360 degrees.
        // The minute hand completes one full revolution in 60 minutes.
        //
        // Therefore:
        // 1 minute = 360 / 60 = 6 degrees.
        // ---------------------------------------------------------
        let minute_angle = minutes as f64 * 6.0;

        // ---------------------------------------------------------
        // Hour hand:
        // A full circle is 360 degrees.
        // The hour hand completes one full revolution in 12 hours.
        //
        // Therefore:
        // 1 hour = 360 / 12 = 30 degrees.
        //
        // However, the hour hand continuously moves as minutes pass.
        // In 60 minutes it moves 30 degrees,
        // so in 1 minute it moves:
        //
        // 30 / 60 = 0.5 degrees.
        //
        // Hour hand position:
        // (hour % 12) * 30 + minutes * 0.5
        //
        // We use hour % 12 because 12 o'clock corresponds to
        // 0 degrees on the clock face.
        // ---------------------------------------------------------
        let hour_angle =
            (hour % 12) as f64 * 30.0 + minutes as f64 * 0.5;

        // ---------------------------------------------------------
        // Find the absolute difference between the two angles.
        // This gives one of the two possible angles.
        // ---------------------------------------------------------
        let diff = (hour_angle - minute_angle).abs();

        // ---------------------------------------------------------
        // There are always two angles between the hands:
        //
        // diff
        // and
        // 360 - diff
        //
        // We need the smaller one.
        // ---------------------------------------------------------
        diff.min(360.0 - diff)
    }
}