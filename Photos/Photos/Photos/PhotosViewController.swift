//
//  PhotosViewController.swift
//  Photos
//
//  Created by 강희선 on 2021/11/29.
//

import UIKit

class PhotosViewController: UIViewController {
    let viewModel = PhotoViewModel.shared
    @IBOutlet weak var collectionView: UICollectionView!
    let itemCnt: CGFloat = 3
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension PhotosViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        cell.imageView.image = viewModel.photos[indexPath.item].thumbnail
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width / itemCnt)-20
        return CGSize(width: width, height: width)
    }
}

extension PhotosViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField.hasText, let text = textField.text else { return true }
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        textField.addSubview(activityIndicator)
        activityIndicator.frame = textField.bounds
        activityIndicator.startAnimating()
        self.viewModel.search(searchTerm: text, completion: { results in
            DispatchQueue.main.async {
                activityIndicator.removeFromSuperview()
                self.viewModel.photos = results
                self.collectionView.reloadData()
            }
        })
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
}
