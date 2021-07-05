import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase
class UserHomePage: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    
  
    @IBOutlet weak var userLogoImage: UIImageView!
    @IBOutlet weak var riddlesCreated: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var signoutButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        userLogoImage.isUserInteractionEnabled = true
        userLogoImage.addGestureRecognizer(tapGestureRecognizer)
        
        
     
        
    }
    //MARK: opens gallery when we click the image icon
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")

            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = true

            present(imagePicker, animated: true, completion: nil)
        }
    }
    //MARK: Function works after we chose a pic from the gallery
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userLogoImage.contentMode = .scaleAspectFit
            userLogoImage.image = pickedImage
            saveStorage()
        }

        dismiss(animated: true, completion: nil)
    }
    //MARK: load user raw data
    func  loadUserData(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        
        let userID = Auth.auth().currentUser?.uid
        print(userID!)

        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
          let value = snapshot.value as? NSDictionary
            self.score.text = String(value?["score"] as? Int ?? -1)
            self.riddlesCreated.text = String(value?["riddlesSolved"] as? Int ?? -1)
            self.nameLabel.text = "Welcome \(value?["name"] as? String ?? "error")"
          // ...
          }) { (error) in
            print(error.localizedDescription)
        }
    }
    

    //MARK: Load user stroage data - profile pic in this case
    func loadUserStorage(){
        // Get a reference to the storage service using the default Firebase App
        let storageRef = Storage.storage().reference()
        
        // Create a reference to the file you want to download
        storageRef.child("images").child(Auth.auth().currentUser!.uid).downloadURL { (url,err) in
            if err != nil
            {
                print((err?.localizedDescription)!)
                return
            }
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            self.userLogoImage.image = UIImage(data: data!)
        }
    }
    //MARK: save the image we pick in firebase storage
    func saveStorage(){
        let image = userLogoImage.image
        let data = image?.jpegData(compressionQuality: 1.0)
        
        
        let storageReference = Storage.storage().reference().child("images").child(Auth.auth().currentUser!.uid)
        storageReference.putData(data!, metadata: nil) { (metadata, error) in
          if let error = error {
            print(error.localizedDescription)
            return
          }
        }

        
    }
    //MARK: reload data everytime user visits his home screen
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(true)
            print("reloading home page")
            loadUserData()
            loadUserStorage()
    }
    @IBAction func signOutButtonClicked(_ sender: Any) {
        do { try Auth.auth().signOut() }
        catch { print("already logged out") }
        
        let popOutStory = UIStoryboard(name: "Main", bundle: nil)
        let controller = popOutStory.instantiateViewController(identifier: "firstPage")
        self.addChild(controller)
        controller.view.frame = self.view.frame
        self.view.addSubview(controller.view)
        controller.didMove(toParent: self)
        
    }
}
