class Solution {
    fun champagneTower(poured: Int, query_row: Int, query_glass: Int): Double {
        
        // Tableau 1D pour stocker la quantité de champagne dans chaque verre d'une ligne
        // Taille 100 car la contrainte max du problème est <= 100 lignes
        var dp = DoubleArray(100){0.0}
        
        // On verse tout le champagne dans le premier verre (ligne 0)
        dp[0] = poured.toDouble()
        
        // On parcourt chaque ligne jusqu'à celle demandée
        for (i in 1..query_row)
        {
            // On parcourt de droite à gauche pour éviter d'écraser
            // les valeurs encore nécessaires au calcul
            for (j in i-1 downTo 0 step 1)
            {
                // Si un verre contient plus de 1 unité,
                // l'excédent est réparti équitablement
                // entre les deux verres en dessous
                val remain: Double = (Math.max(dp[j], 1.0) - 1.0) / 2.0
                
                // Le verre en bas à droite reçoit la moitié de l'excédent
                dp[j+1] += remain
                
                // Le verre en bas à gauche reçoit aussi la moitié
                // (on remplace dp[j] car on avance ligne par ligne)
                dp[j] = remain
            }
        }
        
        // Un verre ne peut contenir au maximum que 1 unité
        return if (dp[query_glass] >= 1) 1.0 else dp[query_glass]
    }
}
