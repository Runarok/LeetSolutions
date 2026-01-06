defmodule Solution do
  @spec exclusive_time(n :: integer, logs :: [String.t]) :: [integer]
  def exclusive_time(n, logs) do
    # Initialize exclusive times array with zeros
    times = Enum.map(0..(n-1), fn _ -> 0 end)

    # Use Enum.reduce to process logs while maintaining:
    # {current stack, exclusive_times_list, previous_timestamp}
    {_, result, _} =
      Enum.reduce(logs, {[], times, 0}, fn log, {stack, times_acc, prev_time} ->
        # Split the log string into [id, type, timestamp]
        [id_str, type, ts_str] = String.split(log, ":")
        id = String.to_integer(id_str)
        timestamp = String.to_integer(ts_str)

        case type do
          "start" ->
            # If there is a function running, increment its exclusive time
            times_acc =
              if stack == [] do
                times_acc
              else
                # Add time from prev_time to current start timestamp
                [current | rest] = stack
                List.update_at(times_acc, current, fn t -> t + (timestamp - prev_time) end)
              end

            # Push new function onto the stack
            {[id | stack], times_acc, timestamp}

          "end" ->
            # Pop the function from the stack
            [current | rest_stack] = stack

            # Increment its exclusive time including the end timestamp
            times_acc = List.update_at(times_acc, current, fn t -> t + (timestamp - prev_time + 1) end)

            # Update prev_time to the moment right after the current end
            {rest_stack, times_acc, timestamp + 1}
        end
      end)

    result
  end
end
