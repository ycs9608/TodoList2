import Foundation

struct TaskList {
    private static var database = UserDefaults.standard
    private static let key = "TaskList"
    
    static func filterByCategory(category: TaskCategory) -> [Task]{
        return Self.taskList().filter { $0.category == category }
    }
    static func completeList() -> [Task] {
        return Self.taskList().filter { $0.isCompleted == true }
    }
    static func taskList() -> [Task] {
        
        if let encodedTaskList = TaskList.database.object(forKey: TaskList.key) as? Data,
           let taskList = try? JSONDecoder().decode([Task].self, from: encodedTaskList) {
            return taskList
        }
        return []
    }
    static func addTask(_ task: Task) {
        var taskList = Self.taskList()
        taskList.append(task)
        Self.updateTaskList(taskList)
    }
    
    static func updateTaskList(_ taskList: [Task]) {
        if let encodedTaskList = try? JSONEncoder().encode(taskList) {
            TaskList.database.set(encodedTaskList, forKey: TaskList.key)
        }
    }
    static func completeTask(task: Task, isCompleted: Bool) {
        var list = Self.taskList()
        for index in 0 ..< list.count {
            if list[index].id == task.id {
                list[index].isCompleted = isCompleted
            }
        }
        updateTaskList(list)
    }
    static func editTitle(task: Task, title: String) {
        var list = Self.taskList()
        for index in 0 ..< list.count {
            if list[index].id == task.id {
                list[index].title = title
            }
        }
        updateTaskList(list)
    }
    static func editCategory(task: Task, category: TaskCategory) {
        var list = Self.taskList()
        for index in 0 ..< list.count {
            if list[index].id == task.id {
                list[index].category = category
            }
        }
        updateTaskList(list)
    }
    static func deleteTask(task: Task) {
        var list = Self.taskList()
        list.removeAll(where: {$0.id == task.id})
        updateTaskList(list)
    }
}
