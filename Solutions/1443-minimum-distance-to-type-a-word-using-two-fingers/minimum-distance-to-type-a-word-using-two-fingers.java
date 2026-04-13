class Solution {
    public int minimumDistance(String word) {
        int[] dp = new int[26];
        int max = 0, sum = 0;

        for (int i = 0; i < word.length() - 1; i++) {
            int p = word.charAt(i) - 65;
            int c = word.charAt(i + 1) - 65;
            int d = dist(p, c);

            sum += d;
            int cur = 0;

            for (int j = 0; j < 26; j++)
                cur = Math.max(cur, dp[j] + d - dist(j, c));

            dp[p] = Math.max(dp[p], cur);
            max = Math.max(max, dp[p]);
        }

        return sum - max;
    }

    private int dist(int a, int b) {
        return Math.abs(a / 6 - b / 6) + Math.abs(a % 6 - b % 6);
    }
}