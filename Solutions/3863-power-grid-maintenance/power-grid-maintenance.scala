import scala.collection.mutable

object Solution {

  /*
   * ================================================================
   *  CLASS: UnionFind (Disjoint Set Union - DSU)
   * ================================================================
   * This structure partitions elements into disjoint sets and supports:
   *   - find(x): returns the representative (root) of the set containing x
   *   - union(x, y): merges two sets if they are different
   *
   * Optimizations used:
   *   - Path compression (flattens tree on find)
   *   - Union by rank (attaches smaller tree to larger tree)
   *
   * All operations are effectively O(α(N)) (inverse Ackermann function),
   * which is almost constant in practice.
   */
  class UnionFind(n: Int) {
    private val parent = (0 to n).toArray       // parent(i): parent of node i
    private val rank = Array.fill(n + 1)(1)     // rank(i): tree height approximation

    // Find with path compression
    def find(x: Int): Int = {
      if (parent(x) != x)
        parent(x) = find(parent(x))             // recursively find root and compress path
      parent(x)
    }

    // Union by rank
    def union(x: Int, y: Int): Unit = {
      val rx = find(x)
      val ry = find(y)
      if (rx == ry) return                      // already in same component

      if (rank(rx) > rank(ry)) {
        parent(ry) = rx                         // attach y's root to x's root
      } else if (rank(rx) < rank(ry)) {
        parent(rx) = ry                         // attach x's root to y's root
      } else {
        parent(ry) = rx                         // attach arbitrarily and increment rank
        rank(rx) += 1
      }
    }
  }

  /*
   * ================================================================
   *  FUNCTION: processQueries
   * ================================================================
   * Arguments:
   *   c            - number of power stations (1-indexed)
   *   connections  - list of bidirectional cables (edges)
   *   queries      - list of operations of two types:
   *                    [1, x]  -> maintenance check
   *                    [2, x]  -> station goes offline
   *
   * Behavior:
   *   - Initially all stations are online.
   *   - Stations connected directly or indirectly form a power grid.
   *   - Going offline does not change grid membership.
   *
   * Approach:
   *   1. Build connected components with Union-Find.
   *   2. For each component, store its online stations in a TreeSet.
   *   3. Process queries in order:
   *        - [2, x]: remove x from its component’s TreeSet.
   *        - [1, x]: if x online → return x,
   *                   else → return min(TreeSet) or -1 if empty.
   *
   * Complexity:
   *   Time  : O((n + q) log c)
   *   Space : O(c)
   */
  def processQueries(
      c: Int,
      connections: Array[Array[Int]],
      queries: Array[Array[Int]]
  ): Array[Int] = {

    // --------------------------------------------------------------
    // 1️⃣ STEP 1: Build Union-Find for all power stations
    // --------------------------------------------------------------
    val uf = new UnionFind(c)
    for (Array(u, v) <- connections)
      uf.union(u, v)                            // merge grids connected by cables

    // --------------------------------------------------------------
    // 2️⃣ STEP 2: Create a TreeSet for each component
    // --------------------------------------------------------------
    // Each TreeSet holds all *currently online* stations for that grid.
    // We use TreeSet so we can efficiently retrieve the smallest ID.
    val comp = Array.fill[mutable.TreeSet[Int]](c + 1)(null)
    for (i <- 1 to c) {
      val root = uf.find(i)                     // find which grid this station belongs to
      if (comp(root) == null)
        comp(root) = mutable.TreeSet[Int]()     // initialize TreeSet if not already created
      comp(root).add(i)                         // add station to its component’s online list
    }

    // --------------------------------------------------------------
    // 3️⃣ STEP 3: Process each query in the order given
    // --------------------------------------------------------------
    val results = mutable.ArrayBuffer[Int]()     // to store results of maintenance checks

    for (q <- queries) {
      val t = q(0)                               // query type: 1 = maintenance, 2 = offline
      val x = q(1)                               // station ID
      val root = uf.find(x)                      // component root
      val stations = comp(root)                  // corresponding TreeSet of online stations

      if (t == 2) {
        // ----------------------------------------------------------
        // Type [2, x]: Station x goes offline
        // ----------------------------------------------------------
        // Simply remove it from the component’s TreeSet.
        // If station is already offline (not present), nothing happens.
        if (stations != null)
          stations.remove(x)

      } else {
        // ----------------------------------------------------------
        // Type [1, x]: Maintenance check
        // ----------------------------------------------------------
        // Rules:
        //   - If x is online → answer x
        //   - If x is offline → answer smallest online ID in its grid
        //   - If grid has no online stations → answer -1

        if (stations == null || stations.isEmpty) {
          // Entire component offline
          results += -1
        } else if (stations.contains(x)) {
          // x itself is online
          results += x
        } else {
          // Return the smallest online ID (TreeSet.min)
          results += stations.head
        }
      }
    }

    // --------------------------------------------------------------
    // 4️⃣ STEP 4: Return results for all maintenance queries
    // --------------------------------------------------------------
    results.toArray
  }
}
