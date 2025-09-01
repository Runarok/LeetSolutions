class Solution {
    fun maxAverageRatio(classes: Array<IntArray>, extraStudents: Int): Double {
        data class ClassInfo(val pass: Int, val total: Int) {
            fun gain(): Double {
                return (pass + 1).toDouble() / (total + 1) - pass.toDouble() / total
            }

            fun ratio(): Double {
                return pass.toDouble() / total
            }
        }

        // Use fully qualified name here to avoid ambiguity
        val pq = java.util.PriorityQueue<ClassInfo>(compareByDescending { it.gain() })

        for (clazz in classes) {
            pq.offer(ClassInfo(clazz[0], clazz[1]))
        }

        var remainingStudents = extraStudents

        while (remainingStudents-- > 0) {
            val top = pq.poll()!!
            val newClass = ClassInfo(top.pass + 1, top.total + 1)
            pq.offer(newClass)
        }

        var totalRatio = 0.0
        while (pq.isNotEmpty()) {
            totalRatio += pq.poll().ratio()
        }

        return totalRatio / classes.size
    }
}
