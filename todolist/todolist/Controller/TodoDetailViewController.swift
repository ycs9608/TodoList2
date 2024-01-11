import UIKit

class TodoDetailViewController: UIViewController {
    
    var task: Task?
    
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTitle.text = task?.title
        
        categorySegmentedControl.removeAllSegments()
        for (index, category) in TaskCategory.allCases.enumerated() {
            categorySegmentedControl.insertSegment(withTitle: category.rawValue, at: index, animated: false)
        }
        categorySegmentedControl.selectedSegmentIndex = task?.category.toIndex() ?? 0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let task,
              let taskTitle = taskTitle.text,
              let category = TaskCategory.category(from: categorySegmentedControl.selectedSegmentIndex)else { return }
        
        TaskList.editTitle(task: task, title: taskTitle)
        TaskList.editCategory(task: task, category: category)
    }
    
    @IBAction func didTapEditButton() {
        let alertController = UIAlertController(title: "수정하기", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in textField.placeholder = "수정할 내용을 입력해주세요"
        }
        let addAction = UIAlertAction(title: "수정", style: .default) { [weak self] _ in
            guard let self else { return }
            if let title = alertController.textFields?.first?.text, !title.isEmpty {
                self.taskTitle.text = title
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func didTapDeleteButton(_ sender: Any) {
        let alertController = UIAlertController(title: "삭제하기", message: "정말 삭제하시겠습니까?", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            guard let self, let task else { return }
            TaskList.deleteTask(task: task)
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
