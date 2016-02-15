//
//  DetailsViewController.swift
//  Tutorial
//
//  Created by student on 15.02.2016.
//  Copyright © 2016 PWr. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var photos : [UIImage?]? //tablica zawierająca wszystkie wyświetlane zdjęcia
    var parentIndex : Int!
    var pageVC : UIPageViewController?
    @IBOutlet weak var bodyText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //wczytanie zdjec
        getPhotos(parentIndex)
        
        //inicjalizacja UIPageViewController wraz ze stylem i kierunkiem nawigacji
        self.pageVC = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        self.pageVC?.dataSource = self
        self.pageVC?.delegate = self
        
        //ustawienie zawartości UIPageViewController
        self.pageVC?.setViewControllers([self.viewController(0)], direction: .Forward, animated: false, completion: nil)
        
        //ustawienie ramki dla UIPageViewController
        var pageFrame = self.view.bounds
        pageFrame.size.height = 300
        self.pageVC?.view.frame = pageFrame
        
        //dodanie UIPageViewController do istniejącego szczegółowego view controllera
        self.addChildViewController(self.pageVC!)
        self.view.addSubview(self.pageVC!.view)
        self.pageVC?.didMoveToParentViewController(self)
        
        //poprawienie wyświetlania tekstu w UITextView
        self.automaticallyAdjustsScrollViewInsets = false
        //ustawienie zawartości opisu pierwszego wyświetlanego zdjęcia
        self.bodyText.text = viewDescription(0)
        
    }
    
    override func didReceiveMemoryWarning() {
        // Dispose of any resources that can be recreated.
    }
    
    //metoda zwracająca wszystkie zdjęcia dla wybranego obiektu z poprzedniego widoku
    func getPhotos(index: Int!)
    {
        var i  : Int=1
        var hasNext : Bool = true
        var adress : String
        photos = [UIImage]()                                                                            //utworzenie pustej tablicy
        self.photos?.append(UIImage(named: parentIndex.description+".jpeg"))                            //dodanie zdjęcia z poprzedniej listy do galerii
        
        while(hasNext){
            adress=parentIndex.description+"_"+i.description
            let fileLocation = NSBundle.mainBundle().pathForResource(adress, ofType: "jpeg")                //sprawdzenie czy plik ze zdjęciem o zadanej lokalizacji istnieje
            if(!(fileLocation ?? "").isEmpty){                                                              //jeżeli nie istnieje to kończymy sprawdzanie
                self.photos?.append(UIImage(contentsOfFile: fileLocation!))                                 //dodanie zdjęcia o zadanej lokalizacji do galerii
                i++
            }
            else {
                hasNext = false
            }
        }
    }
    
    //metoda która zwracja view controller ze zdjęciem o podanej pozycji
    func viewController(index: Int!) -> PhotoViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let photoVC = storyboard.instantiateViewControllerWithIdentifier("PhotoViewController") as! PhotoViewController
        photoVC.index = index
        photoVC.photo = self.photos?[index]
        return photoVC
    }
    
    //metoda zwracająca zawartość opisu z pliku dla okreslonego obrazka jako String
    func viewDescription(index: Int!) -> String
    {
        let description : String!
        let fileLocation = NSBundle.mainBundle().pathForResource(parentIndex.description+"_"+index.description, ofType: "txt")
        if(!(fileLocation ?? "").isEmpty){
            do
            {
                description = try String(contentsOfFile: fileLocation!, encoding: NSUTF8StringEncoding)
            }
            catch
            {
                description = "Problem z odczytaniem pliku z opisem zdjęcia"
            }
        }
        else {
            description = "Brak opisu"
        }
        return description
    }
    
    //dwie metody z protokołu UIPageViewControllerDataSource, pobieraja i wyświetlaja odpowiedni vc o zadanej pozycji
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! PhotoViewController
        var index = vc.index!                       //pobranie indeksu aktualnie wyświetlanego zdjęcia
        bodyText.text = viewDescription(index)      //ustawienie opisu wyświetlanego zdjęcia
        
        if (index == self.photos!.count-1) {        //jeżeli aktualne zdjęcie jest ostatnie w galerii, to pozostajemy na tej samej pozycji(nie zwracamy nic)
            return nil;
        }
        
        index++                                     //indeks następnego zdjęcia
        return self.viewController(index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! PhotoViewController
        var index = vc.index!
        bodyText.text = viewDescription(index)
        
        if (index == 0) {
            return nil;
        }
        
        index--                                     //indeks poprzedniego zdjęcia
        return self.viewController(index)
        
    }

}
