/**
 * @param {string} str1
 * @param {string} str2
 * @return {string}
 */

var shortestCommonSupersequence = function(str1, str2) {
    const m = str1.length;
    const n = str2.length;
    
    // dp[i][j] will store the length of LCS of str1[0..i-1] and str2[0..j-1]
    let dp = Array(m + 1).fill(null).map(() => Array(n + 1).fill(0));
    
    // Fill the dp table
    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            if (str1[i - 1] === str2[j - 1]) {
                dp[i][j] = dp[i - 1][j - 1] + 1;
            } else {
                dp[i][j] = Math.max(dp[i - 1][j], dp[i][j - 1]);
            }
        }
    }

    // Reconstruct the shortest common supersequence
    let result = '';
    let i = m, j = n;
    while (i > 0 && j > 0) {
        if (str1[i - 1] === str2[j - 1]) {
            result = str1[i - 1] + result;
            i--;
            j--;
        } else if (dp[i - 1][j] > dp[i][j - 1]) {
            result = str1[i - 1] + result;
            i--;
        } else {
            result = str2[j - 1] + result;
            j--;
        }
    }

    // If any characters are left in str1 or str2, add them
    while (i > 0) {
        result = str1[i - 1] + result;
        i--;
    }
    while (j > 0) {
        result = str2[j - 1] + result;
        j--;
    }

    return result;
};
