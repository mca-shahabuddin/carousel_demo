//
//  CarouselListVC.swift
//  CarouselDemo
//
//  Created by Shahabuddin Vansiwala on 20/07/22.
//

import UIKit

class CarouselListVC: UIViewController {
    
    //MARK: - Outlet -
    @IBOutlet weak var CVCarousel: UICollectionView!
    @IBOutlet weak var carouselPageControl: UIPageControl!
    
    @IBOutlet weak var TBLProductList: UITableView!
    
    //MARK: - Class Variables -
    var arrBanner: [String] = []
    var promoTimer = Timer()
    
    var modelProductList: [ModelProductList] = []
    var modelFilterProductList: [ModelProductList] = []
    var isSearchProduct = false

    //MARK: - Life cycle methods -
    override func viewDidLoad() {
        super.viewDidLoad()

        CVCarousel.register(UINib(nibName: "BannerViewCell", bundle: nil), forCellWithReuseIdentifier: "BannerViewCell")
        TBLProductList.register(UINib(nibName: "ListViewCell", bundle: nil), forCellReuseIdentifier: "ListViewCell")
        TBLProductList.register(UINib(nibName: "SearchBarView", bundle: nil), forHeaderFooterViewReuseIdentifier: "SearchBarView")
        if #available(iOS 15.0, *) {
            TBLProductList.sectionHeaderTopPadding = 0.0
        }
        setupCarouselView()
    
        
        //Uncomment below method to get local Product list
        setupLocalProductList()
        
        //---- OR -----
        
        //Uncomment below method to get Product list from the API
        //setupAPIProductList()
    }
    
    //MARK - Other Methods -
    func setupLocalProductList() {
        modelProductList.append(ModelProductList(title: "Test1", image: "https://i.picsum.photos/id/642/400/400.jpg?hmac=sG4X2WYFYYL4pk1n8IfjEmiR5VoJtefJfzjhdTpaLeA"))
        modelProductList.append(ModelProductList(title: "Test2", image: "https://i.picsum.photos/id/474/400/400.jpg?hmac=tjAD3rNUljDmOO9ihQkc-BrmKqc9MTuf6M39cBPC0T8"))
        modelProductList.append(ModelProductList(title: "Test3", image: "https://i.picsum.photos/id/1079/400/400.jpg?hmac=RfZgWBKb85PRCcEHzpxgi14pZJJQh0IU1CF4TOTUIlY"))
        modelProductList.append(ModelProductList(title: "Test4", image: "https://i.picsum.photos/id/128/400/400.jpg?hmac=k_1ZotpiF-ueHvENZfEaz0S9lDng3_g_Noe6gNEywDQ"))
        modelProductList.append(ModelProductList(title: "Test5", image: "https://i.picsum.photos/id/642/400/400.jpg?hmac=sG4X2WYFYYL4pk1n8IfjEmiR5VoJtefJfzjhdTpaLeA"))
        modelProductList.append(ModelProductList(title: "Test6", image: "https://i.picsum.photos/id/474/400/400.jpg?hmac=tjAD3rNUljDmOO9ihQkc-BrmKqc9MTuf6M39cBPC0T8"))
        modelProductList.append(ModelProductList(title: "Test7", image: "https://i.picsum.photos/id/1079/400/400.jpg?hmac=RfZgWBKb85PRCcEHzpxgi14pZJJQh0IU1CF4TOTUIlY"))
        modelProductList.append(ModelProductList(title: "Test8", image: "https://i.picsum.photos/id/128/400/400.jpg?hmac=k_1ZotpiF-ueHvENZfEaz0S9lDng3_g_Noe6gNEywDQ"))
        modelProductList.append(ModelProductList(title: "Test9", image: "https://i.picsum.photos/id/642/400/400.jpg?hmac=sG4X2WYFYYL4pk1n8IfjEmiR5VoJtefJfzjhdTpaLeA"))
        modelProductList.append(ModelProductList(title: "Test10", image: "https://i.picsum.photos/id/474/400/400.jpg?hmac=tjAD3rNUljDmOO9ihQkc-BrmKqc9MTuf6M39cBPC0T8"))
        modelProductList.append(ModelProductList(title: "Test11", image: "https://i.picsum.photos/id/1079/400/400.jpg?hmac=RfZgWBKb85PRCcEHzpxgi14pZJJQh0IU1CF4TOTUIlY"))
        modelProductList.append(ModelProductList(title: "Test12", image: "https://i.picsum.photos/id/128/400/400.jpg?hmac=k_1ZotpiF-ueHvENZfEaz0S9lDng3_g_Noe6gNEywDQ"))
        
        TBLProductList.reloadData()
    }

    //MARK: - Promotion Banner Configuration -
    func setupCarouselView() {
        
        //Added some static image url to load image in carousel view
        arrBanner = [
            "https://i.picsum.photos/id/45/1000/500.jpg?hmac=46CV7w7uFg2Z9X5B-mp9-MaAKs_CXqjc6nBgAbqVVW8",
            "https://i.picsum.photos/id/1037/1000/500.jpg?hmac=SZvfGkkgKB5QxEx_YJpK3DPMJc338vtCrtfxsGxPcn8",
            "https://i.picsum.photos/id/803/1000/500.jpg?hmac=CO5Zbn-O065gi_tSZv4nOx33dPqW8-zWHpgdta43e3Y"
        ]
        
        if self.arrBanner.count == 0 {
            promoTimer.invalidate()
        } else {
            if !promoTimer.isValid && self.arrBanner.count >= 2 {
                promoTimer = Timer.scheduledTimer(timeInterval: TimeInterval(7.0), target: self, selector: #selector(autoScrollPromotionBanner), userInfo: nil, repeats: true)
            }
            
            carouselPageControl.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            carouselPageControl.numberOfPages = self.arrBanner.count
            carouselPageControl.pageIndicatorTintColor = AppColor.appIndicatorColor
            carouselPageControl.currentPageIndicatorTintColor = AppColor.appCurrentIndicatorColor
            
            self.CVCarousel.reloadData()
        }
    }
    @objc func autoScrollPromotionBanner() {
        self.CVCarousel.isPagingEnabled = false
        if self.carouselPageControl.currentPage == self.arrBanner.count - 1 {
            self.CVCarousel.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
            self.carouselPageControl.currentPage = 0
        } else {
            self.carouselPageControl.currentPage = self.carouselPageControl.currentPage + 1
            self.CVCarousel.scrollToItem(at: IndexPath(row: self.carouselPageControl.currentPage, section: 0), at: .centeredHorizontally, animated: true)
        }
        self.CVCarousel.isPagingEnabled = true
    }
    
    //MARK: - API Call methods -
    func setupAPIProductList() {
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard data != nil else {
                print("data is nil")
                return
            }
            
            let decoder = JSONDecoder()
            let decodedData = try? decoder.decode([ModelProductList].self, from: data!)
            self.modelProductList = decodedData ?? []
            DispatchQueue.main.async {
                self.TBLProductList.reloadData()
            }
            
        }.resume()
    }

}
//MARK: - Collectionview Delegate Methods -
extension CarouselListVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrBanner.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerViewCell", for: indexPath) as! BannerViewCell
        if self.arrBanner.count > 0 {
            let imageUrl: String = self.arrBanner[indexPath.row]
            
            cell.imageViewBanner.loadImage(imageUrl: imageUrl, Placeholder: placeHolderImage)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ScreenSize.width
        return CGSize(width: width, height: 150)
    }
}
//MARK: - Scrollview Delegate Methods -
extension CarouselListVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        if scrollView == CVCarousel {
            carouselPageControl.currentPage = Int(pageNumber)
        }
    }
}
//MARK: - Tableview Delegate Methods -
extension CarouselListVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: SearchBarView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SearchBarView") as! SearchBarView
        view.frame = CGRect(x: 0, y: 0, width: ScreenSize.screenWidth, height: view.frame.size.height)
        view.searchbar.placeholder = "Search"
        view.searchbar.delegate = self
        return view
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchProduct {
            if modelFilterProductList.count == 0 {
                tableView.showNoDataMessage(message: "No search record found!")
            } else {
                tableView.hideNoDataMessage()
            }
            return modelFilterProductList.count
        }
        if modelProductList.count == 0 {
            tableView.showNoDataMessage(message: "No data found!")
        } else {
            tableView.hideNoDataMessage()
        }
        return modelProductList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListViewCell", for: indexPath) as! ListViewCell
        
        let objProduct = isSearchProduct ? self.modelFilterProductList[indexPath.row] : self.modelProductList[indexPath.row]
        if let _image = objProduct.image {
            cell.imageViewProduct.loadImage(imageUrl: _image, Placeholder: placeHolderImage)
        }
        if let _title = objProduct.title {
            cell.lblTitle.text = _title
        }
        
        return cell
    }
}
//MARK: - UISearchBar Delegate Methods -
extension CarouselListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            isSearchProduct = true
            
            let filterArray = modelProductList.filter{$0.title.toString.lowercased().contains(searchText.lowercased())}
            modelFilterProductList = []
            modelFilterProductList = filterArray
            TBLProductList.reloadData()
        } else {
            isSearchProduct = false
            TBLProductList.reloadData()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
