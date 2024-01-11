import UIKit

class TodoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadAsyncImage()
    }
    
    @IBOutlet weak var imageView: UIImageView!
    func loadAsyncImage() {
            URLSession.shared.dataTask(with: URL(string: "https://spartacodingclub.kr/css/images/scc-og.jpg")!) { [weak self] data, response, error in
                guard let self,
                      let data = data,
                      response != nil,
                      error == nil else { return }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data) ?? UIImage()
                }
            }.resume()
        }
}
