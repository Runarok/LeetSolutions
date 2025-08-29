public class Solution
{
    /// <summary>
    /// Calculates the number of ways to choose one flower from each row (n and m)
    /// such that the sum of their positions is odd.
    /// A sum is odd only when one number is even and the other is odd.
    /// </summary>
    public long FlowerGame(int n, int m)
    {
        long oddN = (n + 1) / 2;
        long evenN = n / 2;
        long oddM = (m + 1) / 2;
        long evenM = m / 2;

        return oddN * evenM + evenN * oddM;
    }
}
