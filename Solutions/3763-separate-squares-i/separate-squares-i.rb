# We are given axis-aligned squares.
# Each square: [x, y, l]
#   x → irrelevant (horizontal position does NOT matter)
#   y → bottom edge
#   l → side length
#
# Overlapping areas count MULTIPLE times.
#
# Goal:
# Find the minimum y such that:
#   area below y == area above y
#
# That means:
#   area below y == total_area / 2
#
# --------------------------------------------
# KEY OBSERVATION (SWEEP LINE):
# --------------------------------------------
# If we move a horizontal line upward:
#   the rate at which area increases is equal to
#   the sum of side lengths of all squares intersecting that y.
#
# So:
#   d(area)/dy = active_width
#
# active_width only changes at square start/end y-values.
#
# We sweep vertically, accumulating area until we hit half.
# --------------------------------------------

def separate_squares(squares)

  # --------------------------------------------
  # STEP 1: Build sweep-line events
  # --------------------------------------------

  # Each square contributes two events:
  #   +l at y       → square starts
  #   -l at y + l   → square ends
  #
  # Between events, active_width is constant.
  events = []

  # Total area of all squares
  total_area = 0.0

  squares.each do |square|
    _, y, l = square

    # Add start event
    events << [y, l]

    # Add end event
    events << [y + l, -l]

    # Accumulate total area
    total_area += l.to_f * l
  end

  # --------------------------------------------
  # STEP 2: Sort events by y-coordinate
  # --------------------------------------------

  # This is the ONLY O(n log n) operation
  events.sort_by! { |e| e[0] }

  # Target area we want below the line
  half_area = total_area / 2.0

  # --------------------------------------------
  # STEP 3: Sweep upward and accumulate area
  # --------------------------------------------

  # Sum of side lengths of squares currently intersecting y
  active_width = 0.0

  # Area accumulated so far
  accumulated_area = 0.0

  # Previous y-position in the sweep
  prev_y = events[0][0]

  events.each do |y, delta_width|

    # Vertical distance since last event
    height = y - prev_y

    # Area added in this vertical slice
    # area = width × height
    slice_area = active_width * height

    # If the target area is within this slice,
    # we can compute the exact y by interpolation
    if accumulated_area + slice_area >= half_area

      # Remaining area needed to reach half
      remaining = half_area - accumulated_area

      # Solve:
      #   remaining = active_width * dy
      #   dy = remaining / active_width
      return prev_y + remaining / active_width
    end

    # Otherwise, consume entire slice
    accumulated_area += slice_area

    # Update active width at this event
    active_width += delta_width

    # Move sweep position
    prev_y = y
  end

  # Fallback (should never be reached)
  prev_y
end
