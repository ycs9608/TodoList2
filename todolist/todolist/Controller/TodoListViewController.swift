import UIKit

class TodoListViewController: UIViewController {
    
    var task: Task?
    
    @IBOutlet weak var tableView: UITableView?
    
    @IBOutlet weak var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView?.reloadData()
        self.emptyView.isHidden = TaskList.taskList().count != 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? TodoListTableViewCell else { return }
        if let vc = segue.destination as? TodoDetailViewController {
            vc.task = cell.task
        }
    }
    
    @IBAction func didTapAdd(_ sender: Any) {
        let alertController = UIAlertController(title: "할 일 추가", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in textField.placeholder = "할 일을 입력해주세요"
        }
        let addAction = UIAlertAction(title: "추가", style: .default) { [weak self] _ in
            guard let self else { return }
            if let title = alertController.textFields?.first?.text, !title.isEmpty {
                let defaultCategory = TaskCategory.work
                let newItem = Task(id: (TaskList.taskList().last?.id ?? -1) + 1,
                                   title: title,
                                   isCompleted: false, category: defaultCategory)
                TaskList.addTask(newItem)
                self.tableView?.insertRows(at: [IndexPath(row:TaskList.filterByCategory(category: defaultCategory).count-1,                                                                                        section: defaultCategory.toIndex())],  with: .automatic)
                self.emptyView.isHidden = TaskList.taskList().count != 0
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension TodoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if section == TaskCategory.work.toIndex() {
            return TaskList.filterByCategory(category: .work).count
        } else if section == TaskCategory.life.toIndex() {
            return TaskList.filterByCategory(category: .life).count
        } else if section == TaskCategory.shopping.toIndex() {
            return TaskList.filterByCategory(category: .shopping).count
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt
                   indexPath: IndexPath) -> UITableViewCell {
        let cell =
        tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoListTableViewCell
        if indexPath.section == TaskCategory.work.toIndex() {
            cell.setTask(TaskList.filterByCategory(category: .work)[indexPath.row])
        } else if indexPath.section == TaskCategory.life.toIndex() {
            cell.setTask(TaskList.filterByCategory(category: .life)[indexPath.row])
        } else if indexPath.section == TaskCategory.shopping.toIndex() {
            cell.setTask(TaskList.filterByCategory(category: .shopping)[indexPath.row])
        } else {
            return UITableViewCell()
        }
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return TaskCategory.allCases.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard TaskList.taskList().count != 0 else { return nil }
        guard let category = TaskCategory.category(from: section) else { return nil }
        let titleHeader = category.rawValue
        return TaskList.filterByCategory(category: category).isEmpty ? nil : titleHeader
    }
}
extension TodoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt
                   indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
                                                
                                               
