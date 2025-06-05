function smallestEquivalentString(s1: string, s2: string, baseStr: string): string {
    // 1. Create a parent array representing each character from 'a' to 'z'
    // 2. Initially, each character is its own parent (self root)
    const parent = new Array(26).fill(0).map((_, i) => i);

    // 3. Define a function to find the root parent of a character index
    // 4. This uses path compression to speed up future queries
    function find(x: number): number {
        // 5. If x is not its own parent, recursively find the root
        if (parent[x] !== x) {
            // 6. Path compression: attach x directly to its root parent
            parent[x] = find(parent[x]);
        }
        // 7. Return the root parent
        return parent[x];
    }

    // 8. Define a function to union two characters' sets
    // 9. The root with the lex smaller character becomes the parent
    function union(a: number, b: number) {
        // 10. Find roots of both characters
        let rootA = find(a);
        let rootB = find(b);

        // 11. Only union if they have different roots
        if (rootA !== rootB) {
            // 12. If rootA is lex smaller, make it the parent
            if (rootA < rootB) {
                parent[rootB] = rootA;
            } else {
                // 13. Otherwise, rootB is parent
                parent[rootA] = rootB;
            }
        }
    }

    // 14. Iterate over all characters in s1 and s2
    for (let i = 0; i < s1.length; i++) {
        // 15. Convert characters to integer indices (0 for 'a', 1 for 'b', etc.)
        let charIndex1 = s1.charCodeAt(i) - 97;
        let charIndex2 = s2.charCodeAt(i) - 97;

        // 16. Union their sets since they are equivalent
        union(charIndex1, charIndex2);
    }

    // 17. Initialize an empty string for the result
    let result = "";

    // 18. Iterate over each character in baseStr
    for (const ch of baseStr) {
        // 19. Convert the character to an index
        let charIndex = ch.charCodeAt(0) - 97;

        // 20. Find the root parent (smallest equivalent character)
        let rootIndex = find(charIndex);

        // 21. Convert rootIndex back to a character
        let smallestChar = String.fromCharCode(rootIndex + 97);

        // 22. Append the smallest equivalent character to result
        result += smallestChar;
    }

    // 23. Return the fully transformed string
    return result;
}
