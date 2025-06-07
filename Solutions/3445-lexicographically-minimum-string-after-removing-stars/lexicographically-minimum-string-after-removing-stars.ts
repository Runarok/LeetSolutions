function clearStars(s: string): string {
  // cnt[i] stores indices of letter (char code i + 'a') in ascending order
  const cnt: number[][] = Array.from({ length: 26 }, () => []);
  const arr = s.split("");

  for (let i = 0; i < arr.length; i++) {
    if (arr[i] !== "*") {
      // Store indices of each letter
      cnt[arr[i].charCodeAt(0) - 97].push(i);
    } else {
      // On '*', remove the rightmost occurrence of the lex smallest letter available
      for (let j = 0; j < 26; j++) {
        if (cnt[j].length > 0) {
          // Mark the letter at this index as removed by replacing with '*'
          arr[cnt[j].pop()!] = "*";
          break;
        }
      }
    }
  }

  // Filter out all '*' (both original and those we replaced) and return the result
  return arr.filter((c) => c !== "*").join("");
}
