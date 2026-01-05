using System;
using System.Collections.Generic;

public class StockSpanner
{
    // Stack to store pairs: (price, span)
    private Stack<(int price, int span)> stack;

    // Constructor: initialize the stack
    public StockSpanner()
    {
        stack = new Stack<(int price, int span)>();
    }

    public int Next(int price)
    {
        int span = 1; // At minimum, the span is 1 (today itself)

        // While the top of the stack has a price <= current price
        // we can extend the span by adding the span of that day
        while (stack.Count > 0 && stack.Peek().price <= price)
        {
            span += stack.Pop().span;
        }

        // Push the current price and its computed span onto the stack
        stack.Push((price, span));

        return span;
    }
}

/**
 * Example usage:
 * StockSpanner stockSpanner = new StockSpanner();
 * Console.WriteLine(stockSpanner.Next(100)); // 1
 * Console.WriteLine(stockSpanner.Next(80));  // 1
 * Console.WriteLine(stockSpanner.Next(60));  // 1
 * Console.WriteLine(stockSpanner.Next(70));  // 2
 * Console.WriteLine(stockSpanner.Next(60));  // 1
 * Console.WriteLine(stockSpanner.Next(75));  // 4
 * Console.WriteLine(stockSpanner.Next(85));  // 6
 */
