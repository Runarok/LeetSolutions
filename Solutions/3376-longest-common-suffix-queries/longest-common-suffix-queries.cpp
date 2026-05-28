class Solution {
public:

    // Trie node structure
    struct TrieNode {

        // child[i] stores the index of next node
        // corresponding to character ('a' + i)
        int child[26];

        // bestIdx stores the index of the best word
        // for the suffix represented by this node
        int bestIdx;

        TrieNode() {

            // initialize all children as absent
            memset(child, -1, sizeof(child));

            // initially no word assigned
            bestIdx = -1;
        }
    };

    // trie storage
    vector<TrieNode> trie;

    // pointer to original wordsContainer
    vector<string>* wordsPtr;

    // function to determine whether idx1 is a better answer than idx2
    bool better(int idx1, int idx2) {

        // if idx2 does not exist
        // idx1 is automatically better
        if (idx2 == -1)
            return true;

        string &a = (*wordsPtr)[idx1];
        string &b = (*wordsPtr)[idx2];

        // smaller length is preferred
        if (a.size() != b.size())
            return a.size() < b.size();

        // if lengths are same
        // smaller index is preferred
        return idx1 < idx2;
    }

    // insert a word into reversed trie
    void insert(string &word, int idx) {

        // start from root
        int node = 0;

        // update root best answer
        // this handles empty suffix case
        if (better(idx, trie[node].bestIdx))
            trie[node].bestIdx = idx;

        // insert characters in reverse order
        // because we care about suffixes
        for (int i = word.size() - 1; i >= 0; i--) {

            int c = word[i] - 'a';

            // create new node if needed
            if (trie[node].child[c] == -1) {

                trie[node].child[c] = trie.size();

                trie.push_back(TrieNode());
            }

            // move to next node
            node = trie[node].child[c];

            // update best index at this node
            if (better(idx, trie[node].bestIdx))
                trie[node].bestIdx = idx;
        }
    }

    // query the trie to find best matching suffix
    int query(string &word) {

        // start from root
        int node = 0;

        // traverse in reverse order
        for (int i = word.size() - 1; i >= 0; i--) {

            int c = word[i] - 'a';

            // if path breaks
            // longest common suffix ends here
            if (trie[node].child[c] == -1)
                break;

            // move deeper
            node = trie[node].child[c];
        }

        // return best candidate for deepest matched suffix
        return trie[node].bestIdx;
    }

    vector<int> stringIndices(vector<string>& wordsContainer,
                              vector<string>& wordsQuery) {

        // save pointer to container words
        wordsPtr = &wordsContainer;

        // create root node
        trie.push_back(TrieNode());

        // insert all words into trie
        for (int i = 0; i < wordsContainer.size(); i++) {

            insert(wordsContainer[i], i);
        }

        vector<int> ans;

        // answer each query
        for (string &q : wordsQuery) {

            ans.push_back(query(q));
        }

        return ans;
    }
};