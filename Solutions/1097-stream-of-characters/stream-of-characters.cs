using System;
using System.Collections.Generic;

public class StreamChecker {
    // Nested class for Trie nodes
    private class TrieNode {
        // Each node stores children nodes for each character
        public Dictionary<char, TrieNode> children = new Dictionary<char, TrieNode>();
        // Flag to indicate if this node represents the end of a word
        public bool isWord = false;
    }

    private TrieNode root;         // Root of the reversed trie
    private List<char> stream;     // Stores all characters from the input stream
    private int maxWordLength = 0; // Keep track of the length of the longest word in 'words'

    // Constructor: build the trie from the list of words
    public StreamChecker(string[] words) {
        root = new TrieNode();      // Initialize the trie root
        stream = new List<char>();  // Initialize the stream

        // Loop over all words to build the trie
        foreach (var word in words) {
            maxWordLength = Math.Max(maxWordLength, word.Length); // Update longest word
            TrieNode node = root;  // Start at the root of the trie

            // Insert the word in reversed order
            for (int i = word.Length - 1; i >= 0; i--) {
                char c = word[i]; // Current character
                if (!node.children.ContainsKey(c)) {
                    node.children[c] = new TrieNode(); // Create new node if it doesn't exist
                }
                node = node.children[c]; // Move to the child node
            }

            node.isWord = true; // Mark the last node as end of a word
        }
    }

    // Query function: add a new letter and check if a suffix matches any word
    public bool Query(char letter) {
        stream.Add(letter); // Add the letter to the stream

        TrieNode node = root; // Start checking from the root of the trie

        // Traverse the stream in reverse (most recent letters first)
        // Only go back as far as the longest word
        for (int i = stream.Count - 1; i >= 0 && i >= stream.Count - maxWordLength; i--) {
            char c = stream[i]; // Get current character from the stream
            if (!node.children.ContainsKey(c)) {
                return false; // No matching child in trie, so no suffix match
            }
            node = node.children[c]; // Move to the next trie node

            if (node.isWord) {
                return true; // Found a suffix that matches a word in 'words'
            }
        }

        return false; // No suffix matched any word
    }
}

/*
Example usage:

StreamChecker streamChecker = new StreamChecker(new string[] { "cd", "f", "kl" });

Console.WriteLine(streamChecker.Query('a')); // false
Console.WriteLine(streamChecker.Query('b')); // false
Console.WriteLine(streamChecker.Query('c')); // false
Console.WriteLine(streamChecker.Query('d')); // true, "cd" is matched
Console.WriteLine(streamChecker.Query('e')); // false
Console.WriteLine(streamChecker.Query('f')); // true, "f" is matched
Console.WriteLine(streamChecker.Query('g')); // false
Console.WriteLine(streamChecker.Query('h')); // false
Console.WriteLine(streamChecker.Query('i')); // false
Console.WriteLine(streamChecker.Query('j')); // false
Console.WriteLine(streamChecker.Query('k')); // false
Console.WriteLine(streamChecker.Query('l')); // true, "kl" is matched

*/ // <-- make sure this closing block comment is here
