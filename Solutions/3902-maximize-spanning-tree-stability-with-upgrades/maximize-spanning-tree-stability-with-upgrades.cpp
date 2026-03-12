// Disjoint Set Union (Union-Find) Data Structure
class DSU{
public:
    vector<int> par , sz;   // par -> parent of node, sz -> size of component

    // Constructor to initialize DSU for n nodes
    DSU(int n){
        par.resize(n);          // resize parent array
        sz.resize(n,1);         // initially every component has size 1
        iota(par.begin(),par.end(),0); // parent[i] = i (each node is its own parent)
    }

    // Find the ultimate parent (leader) of a node with path compression
    int findpar(int node){
        if(node == par[node]) 
            return node;        // if node is its own parent, it is the root

        // path compression: directly connect node to its root
        return par[node] = findpar(par[node]);
    }

    // Check whether two nodes belong to the same component
    bool merged(int a , int b){
        a = findpar(a);
        b = findpar(b);

        if(a == b) 
            return 1;           // already in the same set
        return 0;
    }

    // Union two components by size
    void join(int a , int b){
        a = findpar(a);
        b = findpar(b);

        // if already connected, do nothing
        if(merged(a,b)) return;

        // attach smaller tree under larger tree
        if(sz[a] >= sz[b]){
            sz[a] += sz[b];     // increase size of root a
            par[b] = a;         // make a the parent of b
        }
        else{
            sz[b] += sz[a];
            par[a] = b;
        }
    }
};


class Solution{
public:
    int maxStability(int n, vector<vector<int>>& edges, int k){

        // max heap storing edges in format {strength, node1, node2}
        priority_queue<vector<int>> pq;

        // variable to track minimum stability in the final network
        int mino = INT_MAX;

        // DSU instance to maintain connected components
        DSU d(n);

        // iterate through all edges
        for(auto z : edges){

            // z[3] == 1 means this edge is mandatory
            if(z[3]){

                // update minimum stability among mandatory edges
                mino = min(mino, z[2]);

                // if mandatory edge forms a cycle -> impossible
                if(d.merged(z[0],z[1])) 
                    return -1;

                // otherwise connect them
                d.join(z[0],z[1]);
            }
            else{
                // optional edges pushed into max heap by strength
                pq.push({z[2], z[0], z[1]});
            }
        }

        // stack to store chosen optional edges
        stack<int> st;

        // process optional edges from strongest to weakest
        while(!pq.empty()){

            int stren = pq.top()[0];  // edge strength
            int p = pq.top()[1];      // node u
            int q = pq.top()[2];      // node v
            pq.pop();

            // skip if already connected
            if(d.merged(p,q)) continue;

            // choose this edge
            st.push(stren);

            // union the nodes
            d.join(p,q);
        }

        // process chosen optional edges
        while(!st.empty()){

            // if upgrades left (k > 0), strength doubles (left shift)
            // otherwise remains same
            mino = min(mino , (st.top() << (k > 0)));

            st.pop();
            k--; // reduce remaining upgrades
        }

        // check if the entire graph is connected
        for(int i = 1 ; i < n ; i++){
            if(!d.merged(i,0)) 
                return -1; // graph not fully connected
        }

        // return minimum stability of all selected edges
        return mino;
    }
};