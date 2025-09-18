# Your TaskManager object will be instantiated and called as such:
# obj = TaskManager(tasks)
# obj.add(userId,taskId,priority)
# obj.edit(taskId,newPriority)
# obj.rmv(taskId)
# param_4 = obj.execTop()

import heapq

class TaskManager:
    def __init__(self, tasks):
        """
        Initializes the TaskManager with a list of tasks in the form [userId, taskId, priority].
        Handles LeetCode-style triple-nested input.
        """
        self.task_map = {}  # Maps taskId -> (userId, priority)
        self.heap = []      # Max-heap of (-priority, -taskId, taskId)
        self.deleted = set()  # Set of taskIds that are outdated (lazy deleted)

        # Handle LeetCode-style [[[...]]] input
        if len(tasks) == 1 and isinstance(tasks[0], list) and isinstance(tasks[0][0], list):
            tasks = tasks[0]

        for userId, taskId, priority in tasks:
            self.task_map[taskId] = (userId, priority)
            heapq.heappush(self.heap, (-priority, -taskId, taskId))

    def add(self, userId, taskId, priority):
        """
        Adds a new task.
        """
        self.task_map[taskId] = (userId, priority)
        heapq.heappush(self.heap, (-priority, -taskId, taskId))

    def edit(self, taskId, newPriority):
        """
        Edits the priority of an existing task.
        Uses lazy deletion: old task is marked deleted and new version is pushed.
        """
        if taskId in self.task_map:
            userId, _ = self.task_map[taskId]
            self.deleted.add(taskId)  # Mark current task as deleted
            self.task_map[taskId] = (userId, newPriority)
            heapq.heappush(self.heap, (-newPriority, -taskId, taskId))

    def rmv(self, taskId):
        """
        Removes a task from the system.
        """
        if taskId in self.task_map:
            self.deleted.add(taskId)
            del self.task_map[taskId]

    def execTop(self):
        """
        Executes the task with the highest priority.
        If multiple tasks have same priority, one with higher taskId wins.
        """
        while self.heap:
            neg_priority, neg_taskId, taskId = heapq.heappop(self.heap)

            # If taskId is deleted or outdated, skip it
            if taskId not in self.task_map:
                continue
            userId, current_priority = self.task_map[taskId]

            # If the priority doesn't match, it's an outdated version
            if -neg_priority != current_priority:
                continue

            # Valid task: remove it and return userId
            del self.task_map[taskId]
            return userId

        return -1  # No valid tasks
